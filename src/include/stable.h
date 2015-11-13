/*This header file will include all the struct definitions and function 
 * prototypes for working with the C-- symbol table, a hash map.
 */

#define VAR 0
#define PROC 1


typedef struct {
    char *name; //The identifier
    char *addr; //The name of the frame ptr
    int offset; //Offset from that frame ptr
    int type; //VAR or PROC
    int size; //in bytes
} symb;

typedef struct _stable{
    symb* value; //The symbol stored here
    struct _stable* next; //Linked list of collisions
} stable;

extern int st_size;
extern stable* st_table;

extern unsigned long int st_hash(const char *);
extern unsigned long int st_hash_helper(int, const char *);
extern symb* st_add_symbol(char *, char *, int, int, int);
extern symb* st_get_symbol(const char *);
extern int st_init();
extern int st_expand();
extern int st_destroy();
extern int st_destroy_helper(symb *);
