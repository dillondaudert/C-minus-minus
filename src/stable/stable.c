#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "stable.h"
#include "cmm.h"

int st_size = 512;
stable* st_table;

/*
 * st_hash return the hash key for the given string
 */
unsigned long int st_hash(const char *str)
{
    int i = strlen(str) - 1; //str[] 0-indexed
    unsigned long int hash = st_hash_helper(i, str);
    if(DEBUG) printf("st_hash for %s is %lu\n", str, hash);
    return hash;
}

/*
 * The hash function computes the key of the symbol recursively
 */
unsigned long int st_hash_helper(int i, const char *str)
{
    if(i < 0) return 1;
    int newi = i - 1;
    return st_hash_helper(newi, str) * (33 ^ str[i]);
}

/* st_add_symbol adds a new symbol struct to the symbol table (hash map)
 * On successful insertion or if symbol is already in table, return pointer to 
 * it.
 * If an error occurs, return NULL.
 */
symb* st_add_symbol(char *name, char *addr, int offset, int type, int size)
{
    //Find hash key for new struct
    unsigned long int hash = st_hash(name);    
    int key = hash % st_size;
    symb *new;

    //Allocate space for new symbol
    if( (new = malloc(sizeof(symb))) == NULL){
        fprintf(stderr, "Error 1 in st_add_symbol for value %s", name);
        return NULL;
    }
    new->name = name;
    new->addr = addr;
    new->offset = offset;
    new->type = type;
    new->size = size;

    //Put symbol in stable hash map
    if( st_table[key].value == NULL ){ 
        //No collision, insert
        st_table[key].value = new;
        if(DEBUG) printf("st_add added %s at position %d\n", name, key);
        return new;
    }else{
        //Collision, find next avail. and check for presence
        stable* curr = &st_table[key];
        stable* prev = curr;

        //While curr is not NULL
        for(; curr != NULL; prev = curr, curr = (stable *)curr->next){
            //If the symbol is already in the hash map
            if(strcmp(curr->value->name, new->name) == 0){
                if(DEBUG) printf("st_add, %s already located at %d:%s\n", name, 
                                                                          key,
                                                             curr->value->name);
                return curr->value;
            }
            //If symbol not yet found and collision LL is exhausted
        }

        //Collision but not found, add to LL
        //New link in stable chain
        struct _stable *new_l;
        if( (new_l = (struct _stable *)malloc(sizeof(struct _stable))) == NULL){
            fprintf(stderr, "Error 2 in st_add_symbol for value %s\n", name);
            return NULL;
        }
        //Add symbol to link
        new_l->value = new;
        prev->next = new_l;
        if(DEBUG) printf("st_add, added %s to collision LL at %d\n", 
                                                   name, key);
        return new;                

    }
}

/* st_get_symbol attempts to find the symbol with name str
 * If the symbol is found, a pointer to it is returned
 * else, NULL is returned
 */
symb* st_get_symbol(char *str)
{
    //Find hash and key of symbol
    unsigned long int hash = st_hash(str);
    int key = hash % st_size;
    
    if( st_table[key].value == NULL){
        //Table empty at this hash key, not found
        if(DEBUG) printf("Symbol %d:%s not in table\n", key, str);
        return NULL;

    }else if( strcmp(st_table[key].value->name, str) == 0){
        //If table[key] is this symbol
        if(DEBUG) printf("Symbol %d:%s found\n", key, str);
        return st_table[key].value;

    }else if(st_table[key].next == NULL){
        //Not found, no collision LL
        if(DEBUG) printf("Symbol %d:%s not in table; no LL\n", key, str);
        return NULL;

    }else{
        //Check collision LL for the symbol
        stable* curr = (stable *)st_table[key].next;
        for( ; curr != NULL; curr = (stable *)curr->next){
            //Check LL for symbol
            if(strcmp(curr->value->name, str) == 0){
                //Symbol found
                if(DEBUG) printf("Symbol %s found in collision LL\n", str);
                return curr->value;
            }
        }
    }
    return NULL;
}
/* st_init() initializes the stable at size st_size.
 * It returns a nonzero integer if an error is encountered
 * Error codes:
 * 	-1: malloc error
 */
int st_init()
{
    //The symbol table is called st_table
    if( (st_table = malloc(sizeof(stable) * st_size)) == NULL){
        return -1;
    }
    if(DEBUG) printf("st_init created the symbol table hash map\n");

    return 0;
    
}

/* st_expand() doubles the size of the hash map, doubling st_size
 * ~EXPENSIVE~ this calls st_add_symbol() for every symbol in the
 * old symbol table!
 * A nonzero is returned for any error encountered
 */
int st_expand()
{
    return 0;
}
/* st_destroy frees all memory associated with the structs in 
 * the symbol table.
 * A nonzero is returned for any error encountered.
 */
int st_destroy()
{
    int i;
    stable *curr, *prev;
    for(i = 0; i < st_size; i++){
        //For every array location, delete value and collision LL
        curr = &st_table[i];
        //If there are no symbols in this index
        if(curr->value == NULL) continue;
        //Free symbol here
        st_destroy_helper(curr->value);
        if(DEBUG) printf("Freed symbol at position %d\n", i);
        //Iterate over collision LL, free symbols and their LL node
        while((curr = (stable *)curr->next) != NULL){
            //Free symbol here
            st_destroy_helper(curr->value);
            if(DEBUG) printf("Freed symbol at position %d\n", i);
            prev = curr;
            curr = (stable *)curr->next;
            free(prev);
            if(DEBUG) printf("Freed link in collision LL at %d\n", i);
        }
    }

    //All symbols have been freed, all collision LLs have been freed
    free(st_table);
    if(DEBUG) printf("Freed symbol table\n");
    return 0;
}

/* st_destroy_helper frees all memory associated with a specified symbol
 * This is origin agnostic; any symbol may be freed using this function
 * Any errors are reported as nonzero error codes
 */
int st_destroy_helper(symb* symbol)
{
    free(symbol->name);
    free(symbol->addr);
    free(symbol);
    return 0;
}
