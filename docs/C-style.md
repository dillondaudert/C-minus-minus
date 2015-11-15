<h1> Style Guide for C-- </h1>

<h3>C files</h3>

Preamble
```
/******************************************************************************
 * Filename.c 
 * Description: ...
 ******************************************************************************/
```

Includes, Defines, Externs
```
#include <>;
#include "";

#define ...;
#define ...;

//location.h
extern func(); 
//location2.h
extern var;
```

Globals, Prototypes
```
void *func();
char *var;
```

Functions
```
//Without prefix
unsigned long int funcName(int p1, char *p2)
{
    //Four space indents (no tabs)
    ...
}

//With prefix
unsigned double st_funcName(int p1, char *p2)
{
    ...
} 
```

Flow Control, Boolean Exprs, Arithmetic
```
if( this == that ){
    //Spaces separate inside of parentheses
}

for( i = 0; i < j; i++ ){
    //Spaces between arithmetic, boolean operators
}

while( expression != 0 ){
    ...
}
```

Comments
```
/* Function headers, name
 * Description: function purpose, input, output
 */
unsigned int funcName()
{
    //Internal comments on separate line
    ...
    /*Use double slash unless the comment would need to
     * take put two lines                             */
    ...
}
```

