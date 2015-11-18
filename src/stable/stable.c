#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "stable.h"
#include "cmm.h"

int st_size = 512;
stable* st_table = NULL;

/*
 * st_hash return the hash key for the given string
 * If the length of the input string is 0, -1 is returned
 */
unsigned long int st_hash(const char *str)
{
    //str[] is 0-indexed
    int i = strlen(str) - 1;
    //if the input string is length 0
    if(i < 0) return -1;
    unsigned long int hash = st_hash_helper(i, str);
    if(DEBUG) printf("st_hash for %s is %lu\n", str, hash);
    return hash;
}

/*
 * The hash function computes the key of the symbol recursively
 * The hash function was provided by Dan Berstein.
 */
unsigned long int st_hash_helper(int i, const char *str)
{
    if(i < 0) return 1;
    int newi = i - 1;
    return st_hash_helper(newi, str) * (33 ^ str[i]);
}

/* st_create_symbol creates a symbol from the input parameters
 * A pointer to this symbol is returned
 */
symb* st_create_symbol(char *name, char *addr, int offset, int type, int size, int arrsize)
{
    symb *new;
    
    if( (new = calloc(1, sizeof(symb))) == NULL){
        fprintf(stderr, "Error in st_create_symbol for symb %s\n", name);
        return NULL;
    }

    new->name = name;
    new->addr = addr;
    new->offset = offset;
    new->type = type;
    new->size = size;
    new->arrsize = arrsize;

    return new;
}

/* st_add_symbol adds a new symbol struct to the symbol table (hash map)
 * On successful insertion or if symbol is already in table, return pointer to 
 * it.
 * If an error occurs, return NULL.
 */
symb* st_add_symbol(char *name, char *addr, int offset, int type, int size, int arrsize)
{
    //Find hash key for new struct
    unsigned long int hash = st_hash(name);    
    int key = hash % st_size;
    symb *new;
    if(DEBUG) printf("Adding new symbol: %s, %s, offset: %d, type: %d, size: %d, arr: %d\n",
                     name, addr, offset, type, size, arrsize);
    //Put symbol in stable hash map
    if( st_table[key].value == NULL ){ 
        //No collision, make new symbol
        new = st_create_symbol(name, addr, offset, type, size, arrsize);

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
            if(strcmp(curr->value->name, name) == 0){
                if(DEBUG) printf("st_add, %s already located at %d:%s\n", name, 
                                                                          key,
                                                             curr->value->name);
                return NULL;
            }
            //If symbol not yet found and collision LL is exhausted
        }

        //Collision but not found, add to LL
        //New link in stable chain
        struct _stable *new_l;
        if( (new_l = (struct _stable *)calloc(1, sizeof(struct _stable))) == NULL){
            fprintf(stderr, "Error 2 in st_add_symbol for value %s\n", name);
            return NULL;
        }
        //Create new symbol to add
        new = st_create_symbol(name, addr, offset, type, size, arrsize);

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
symb* st_get_symbol(const char *str)
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
    if( (st_table = calloc(st_size, sizeof(stable))) == NULL){
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
 * A zero is returned for successful execution
 */
int st_destroy()
{
    
    if(st_table == NULL) return -1; //table not initialised
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
        curr = (stable *)curr->next;
        while(curr != NULL){
            //Free symbol here; there will always be one if a LL exists
            st_destroy_helper(curr->value);
            if(DEBUG) printf("Freed LL symbol at position %d\n", i);
            prev = curr; 
            curr = (stable *)curr->next;
            free(prev);
            if(DEBUG) printf("Freed link in collision LL at %d\n", i);
        }
    }

    //All symbols have been freed, all collision LLs have been freed
    free(st_table);
    st_table = NULL;
    if(DEBUG) printf("Freed symbol table\n");
    return 0;
}

/* st_destroy_helper frees all memory associated with a specified symbol
 * This is origin agnostic; any symbol may be freed using this function
 * No error is returned; must check for invalid frees somehow
 */
int st_destroy_helper(symb* symbol)
{
    free(symbol->name);
    free(symbol->addr);
    free(symbol);
    return 0;
}
