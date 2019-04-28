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
"He"|"he"|"She"|"she"|"it"|"It"|"They"|"they"|"I" {     
                                yylval.ident = new char[strlen(yytext)+1];
                                strcpy(yylval.ident, yytext);
                                return PRONOUN;     
                            }
"Beautiful"|"beautiful"|"Good"|"good"|"Bad"|"bad"|"intelligent" {     
                                yylval.ident = new char[strlen(yytext)+1];
                                strcpy(yylval.ident, yytext);
                                return ADJECTIVE;    
                            }
"Slowly"|"slowly"|"Fastly"|"fastly"|"fast"|"not" {        
                                yylval.ident = new char[strlen(yytext)+1];
                                strcpy(yylval.ident, yytext);
                                return ADVERB;      
                            }
"Running"|"running"|"Keeping"|"keeping"|"Playing"|"playing"|"Coding"|"coding"|"lives"|"jumped"|"become" {       
                            yylval.ident = new char[strlen(yytext)+1];
                            strcpy(yylval.ident, yytext);
                            return VERB;        
                        }
"is"|"Is"|"was"|"Was"|"will" {       
                        yylval.ident = new char[strlen(yytext)+1];
                        strcpy(yylval.ident, yytext);
                        return AVERB;        
                        }
"and"|"And"|"But"|"but"|"or"|"because" {
                        yylval.ident = new char[strlen(yytext)+1];
                        strcpy(yylval.ident, yytext);  
                        return CONJUNCTION;     
                    }
"in"|"with"|"on" {
                        yylval.ident = new char[strlen(yytext)+1];
                        strcpy(yylval.ident, yytext);  
                        return PREPOSITION;     
                    }

[A-Z][a-z]*   {   
                    yylval.ident = new char[strlen(yytext)+1];
                    strcpy(yylval.ident, yytext);
                    return NOUN;    
                }

.        { yyerror("undefined token", yytext[0]); yyterminate(); }
%%