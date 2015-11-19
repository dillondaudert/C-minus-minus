<h1> Style Guide for C-- Source Code</h1>

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
//
unsigned long int st_func_name(int p1, char *p2)
{
    //Four space indents (no tabs)
    ...
}

```

Flow Control, Boolean Exprs, Arithmetic
```
if( this == that ){
    //Spaces separate inside of flow parentheses
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
unsigned int func_name()
{
    //Internal comments on separate line
    ...
    /*Use double slash unless the comment would need to
     * take put two lines                             */
    ...
}
```

