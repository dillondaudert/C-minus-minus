#Autoconf configure file

AC_PREREQ([2.69])
AC_INIT([C-Minus-Minus], [0.2B], [dillongdaudert@gmail.com])
AC_CONFIG_SRCDIR([src/parser/grammar.y])
AC_CONFIG_HEADERS([config.h])

#information on package

#Check for programs
AC_PROG_YACC
AC_PROG_CC
AC_PROG_LEX

#Check for libraries

#Checks for headers
AC_CHECK_HEADERS([limits.h stddef.h stdint.h stdlib.h string.h])

#Checks for types
AC_CHECK_HEADER_STDBOOL

#Checks for structures

#Checks for compiler characteristics

#Checks for library functions
AC_FUNC_MALLOC
AC_CHECK_FUNCS([memset strdup])

#Checks for system services

AC_CONFIG_FILES([Makefile src/Makefile src/parser/Makefile
                 src/stable/Makefile])
AC_OUTPUT
