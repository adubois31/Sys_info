/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tMAIN = 258,
    tPO = 259,
    tPF = 260,
    tAO = 261,
    tAF = 262,
    tCONST = 263,
    tINT = 264,
    tEGAL = 265,
    tSOU = 266,
    tADD = 267,
    tMUL = 268,
    tDIV = 269,
    tNOT = 270,
    tSUP = 271,
    tINF = 272,
    tEQUAL = 273,
    tDIFF = 274,
    tSUPEQ = 275,
    tINFEQ = 276,
    tOR = 277,
    tAND = 278,
    tCOMA = 279,
    tSC = 280,
    tPRINT = 281,
    tBLANK = 282,
    tERROR = 283,
    tELSE = 284,
    tVARNAME = 285,
    tNB = 286,
    tWHILE = 287,
    tIF = 288
  };
#endif
/* Tokens.  */
#define tMAIN 258
#define tPO 259
#define tPF 260
#define tAO 261
#define tAF 262
#define tCONST 263
#define tINT 264
#define tEGAL 265
#define tSOU 266
#define tADD 267
#define tMUL 268
#define tDIV 269
#define tNOT 270
#define tSUP 271
#define tINF 272
#define tEQUAL 273
#define tDIFF 274
#define tSUPEQ 275
#define tINFEQ 276
#define tOR 277
#define tAND 278
#define tCOMA 279
#define tSC 280
#define tPRINT 281
#define tBLANK 282
#define tERROR 283
#define tELSE 284
#define tVARNAME 285
#define tNB 286
#define tWHILE 287
#define tIF 288

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 16 "comp.y"
 int nb; char * var; 

#line 126 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
