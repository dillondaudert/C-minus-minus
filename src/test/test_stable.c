/* This is a set of unit tests for the stable.c and stable.h files
 * The unit tests are implemented using the Unity C Unit testing tool
 * located at throwtheswitch.com/unity.
 *
 * Dillon Daudert 11/13/2015
 */ 

#include "stable.h"
#include "unity.h"
#include <stdlib.h>

#define set_up()  setUp(void)
#define tear_down()  tearDown(void)

/******************* external variable declarations ***************************/

/******************* Unity functions ******************************************/

//symb *s1, *s2;
//char *n1, *n2, *n3, *a1, *a2, *a3;

void set_up()
{
    TEST_ASSERT_EQUAL(0, st_init());
}

void tear_down()
{
    TEST_ASSERT_EQUAL(0,st_destroy());
}

/******************* st_init() tests ******************************************/

void test_st_init_success(void)
{
    TEST_ASSERT_EQUAL(st_size*sizeof(stable), st_size*sizeof(*st_table));
}

/******************* st_hash(const char *str) tests ***************************/

void test_st_hash_names_success(void)
{
    TEST_ASSERT_EQUAL_INT32(1824, st_hash("S1"));
    TEST_ASSERT_EQUAL_INT32(2166, st_hash("S2"));
    TEST_ASSERT_EQUAL_INT32(2052, st_hash("S3"));
}

void test_st_hash_names_fail(void)
{
    TEST_ASSERT_EQUAL_INT32(-1, st_hash(""));
}

/******************* st_create_symbol tests ***********************************/

void test_st_create_symbol_success(void)
{
    char *n1 = malloc(sizeof(char)*3);
    char *a1 = malloc(sizeof(char)*4);
    sprintf(n1, "S1");
    sprintf(a1, "gp_");
    
    symb *s1 = st_create_symbol(n1, a1, 4, VAR, 4, 0);
    TEST_ASSERT_NOT_NULL(s1);
    TEST_ASSERT_EQUAL_STRING(n1, s1->name);
    TEST_ASSERT_EQUAL_STRING(a1, s1->addr);
    TEST_ASSERT_EQUAL(0, st_destroy_helper(s1));
}

/******************* st_add_symbol tests **************************************/

void test_st_add_symbol_insert_success(void)
{
    
    char *n1 = malloc(sizeof(char)*3);
    char *a1 = malloc(sizeof(char)*4);
    sprintf(n1, "S1");
    sprintf(a1, "gp_");
 
    symb *s1 = st_add_symbol(n1, a1, 4, VAR, 4, 0);
    TEST_ASSERT_NOT_NULL(s1);
    TEST_ASSERT_EQUAL_STRING(n1, s1->name);
    TEST_ASSERT_EQUAL_STRING(a1, s1->addr);
}

void test_st_add_symbol_insert_fail_already_in_table(void)
{
    char *n1 = malloc(sizeof(char)*3);
    char *n3 = malloc(sizeof(char)*3);
    char *a1 = malloc(sizeof(char)*4);
    char *a3 = malloc(sizeof(char)*4);
    sprintf(n1, "S1");
    sprintf(n3, "S1");
    sprintf(a1, "gp_");
    sprintf(a3, "gp_");
    st_add_symbol(n1, a1, 4, VAR, 4, 0);
    symb *s2 = st_add_symbol(n3, a3, 4, VAR, 4, 0);
    TEST_ASSERT_NULL(s2);
    free(n3);
    free(a3);
}

void test_st_add_symbol_collision_success(void)
{
    char *n1 = malloc(sizeof(char)*2);
    char *n2 = malloc(sizeof(char)*3);
    sprintf(n1, "x");
    sprintf(n2, "zz");
    char *a1 = malloc(sizeof(char)*4);
    char *a2 = malloc(sizeof(char)*4);
    sprintf(a1, "gp_");
    sprintf(a2, "gp_");
    
    TEST_ASSERT_EQUAL(st_hash(n2)%512, st_hash(n1)%512);
    TEST_ASSERT_NOT_NULL(st_add_symbol(n1, a1, 4, VAR, 4, 0));
    TEST_ASSERT_NOT_NULL(st_add_symbol(n2, a2, 4, VAR, 4, 0));
}

/******************* st_get_symbol tests **************************************/

void test_st_get_symbol_success(void)
{
    char *n1 = malloc(sizeof(char)*3);
    char *a1 = malloc(sizeof(char)*4);
    sprintf(n1, "S1");
    sprintf(a1, "gp_");
    st_add_symbol(n1, a1, 4, VAR, 4, 0);
    symb *s2 = st_get_symbol(n1);
    TEST_ASSERT_NOT_NULL(s2);
    TEST_ASSERT_EQUAL_STRING(n1, s2->name);
}

void test_st_get_symbol_collision_success(void)
{
    char *n1 = malloc(sizeof(char)*2);
    char *n2 = malloc(sizeof(char)*3);
    sprintf(n1, "x");
    sprintf(n2, "zz");
    char *a1 = malloc(sizeof(char)*4);
    char *a2 = malloc(sizeof(char)*4);
    sprintf(a1, "gp_");
    sprintf(a2, "gp_");
    
    TEST_ASSERT_EQUAL(st_hash(n2)%512, st_hash(n1)%512);
    TEST_ASSERT_NOT_NULL(st_add_symbol(n1, a1, 4, VAR, 4, 0));
    TEST_ASSERT_NOT_NULL(st_add_symbol(n2, a2, 4, VAR, 4, 0));

    TEST_ASSERT_NOT_NULL(st_get_symbol(n1));
    TEST_ASSERT_NOT_NULL(st_get_symbol(n2));
  
}

void test_st_get_symbol_failure(void)
{
    TEST_ASSERT_NULL(st_get_symbol("void"));
}
