%error-verbose

%{
#include <iostream>
#include <string.h>

using std::cerr;
using std::endl;
using std::string;
using std::cout;

extern int yylex();
extern int yylineno;

bool error = false;

int parseResult = 1;
void yyerror(const char* s) {
   // bision seems to call both versions of yyerror, check a flag to supress the duplicate message
   if (!error) {
      cerr << "error (line " << yylineno << "): " << s << endl;
   }
}

void yyerror(const char* s, char c) {
   cerr << "error (line " << yylineno << "): " << s << " \"" << c << "\"" << endl;
   error = true;
}

%}

%union {
    char*                           ident;
}


%token<ident> NOUN  "noun"
%token<ident> EXPR  "expr"
%token<ident> VERB  "verb"
%token<ident> ADVERB "adverb"
%token<ident> ADJECTIVE  "adjective"
%token<ident> AVERB  "auxillary_verb"
%token<ident> CONJUNCTION "conjunction"
%token<ident> ARTICLE  "article"
%token<ident> PRONOUN  "pronoun"

%%

Code        :   Code Statement
            |   Statement
            ;

Statement   :   EXPR NOUN   {cout << "Grammatically Correct\n";}
            |   NOUN AVERB ADJECTIVE    {cout << "Grammatically Correct\n";}
            |   NOUN AVERB VERB {cout << "Grammatically Correct\n";}
            |   Invalid
            ;

Invalid     :   NOUN EXPR   {
                                std::string x = string($1);
                                cout << "Suggestsed Edit : Swap " << x << " and " << ($2) << endl;
                            }
            ;
%%

int main(){
    return yyparse();
}
int yywrap(){
    return(1);
}