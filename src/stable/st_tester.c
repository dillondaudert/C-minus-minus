#include <stdio.h>
#include <string.h>
#include "stable.h"
#include "cmm.h"

int main(int argv, char **argc)
{
    st_init();

    st_add_symbol("S1", "gp_", 4, VAR, 4);
    st_add_symbol("S2", "gp_", 4, VAR, 4);
    st_add_symbol("S3", "gp_", 4, VAR, 4);

    st_get_symbol("S1");
    st_get_symbol("S4");

    st_destroy();
    return 0;
}
