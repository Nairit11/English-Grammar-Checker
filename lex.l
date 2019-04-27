%option noyywrap
%option yylineno

%{
#include <bits/stdc++.h>
#include "parse.tab.h"

using namespace std;

extern void yyerror(const char*, char);
%}


%%
[ \t\n]         {   }
"Hi"|"hi"|"hey"|"Hey"|"Hello"|"hello"   {   
                                            yylval.ident = new char[strlen(yytext)+1];
                                            strcpy(yylval.ident, yytext);
                                            return EXPR;    
                                }
"A"|"a"|"An"|"an"|"The"|"the" {     
                                yylval.ident = new char[strlen(yytext)+1];
                                strcpy(yylval.ident, yytext);
                                return ARTICLE;     
                            }
"He"|"he"|"She"|"she"|"it"|"It"|"They"|"they" {     
                                yylval.ident = new char[strlen(yytext)+1];
                                strcpy(yylval.ident, yytext);
                                return PRONOUN;     
                            }
"Beautiful"|"beautiful"|"Good"|"good"|"Bad"|"bad" {     
                                yylval.ident = new char[strlen(yytext)+1];
                                strcpy(yylval.ident, yytext);
                                return ADJECTIVE;    
                            }
"Slowly"|"slowly"|"Fastly"|"fastly"|"fast" {        
                                yylval.ident = new char[strlen(yytext)+1];
                                strcpy(yylval.ident, yytext);
                                return ADVERB;      
                            }
"Running"|"running"|"Keeping"|"keeping"|"Playing"|"playing"|"Coding"|"coding" {       
                            yylval.ident = new char[strlen(yytext)+1];
                            strcpy(yylval.ident, yytext);
                            return VERB;        
                        }
"is"|"Is"|"was"|"Was" {       
                        yylval.ident = new char[strlen(yytext)+1];
                        strcpy(yylval.ident, yytext);
                        return AVERB;        
                        }
"and"|"And"|"But"|"but" {
                        yylval.ident = new char[strlen(yytext)+1];
                        strcpy(yylval.ident, yytext);  
                        return CONJUNCTION;     
                    }
[A-Z][a-z]*   {   
                    yylval.ident = new char[strlen(yytext)+1];
                    strcpy(yylval.ident, yytext);
                    return NOUN;    
                }

.        { yyerror("undefined token", yytext[0]); yyterminate(); }
%%