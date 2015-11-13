//=======Test Runner Used To Run Each Test Below=====


//=======Files To Include=====
#include "unity.h"
#include <setjmp.h>
#include <stdio.h>
#include "stable.h"

//=======External Functions this Runner Calls====
extern void setUp(void);
extern void tearDown(void);
extern void test_st_init_success(void);
extern void test_st_hash_names_success(void);
extern void test_st_hash_names_fail(void);
extern void test_st_add_symbol_insert_success(void);
extern void test_st_add_symbol_insert_fail_already_in_table(void);
extern void test_st_get_symbol_success(void);
extern void test_st_get_symbol_failure(void);

//====Test reset option=====
void resetTest(void);
void resetTest(void)
{
    tearDown();
    setUp();
}


//=====MAIN=====
int main(void)
{
    UnityBegin("../test_stable.c");
    RUN_TEST(test_st_init_success);
    RUN_TEST(test_st_hash_names_success);
    RUN_TEST(test_st_hash_names_fail);
    RUN_TEST(test_st_add_symbol_insert_success);
    RUN_TEST(test_st_add_symbol_insert_fail_already_in_table);
    RUN_TEST(test_st_get_symbol_success);
    RUN_TEST(test_st_get_symbol_failure);

    return (UnityEnd());
}
