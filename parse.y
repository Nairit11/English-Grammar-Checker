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
%token<ident> PREPOSITION  "preposition"

%%

Code        :   Code Statement
            |   Statement
            ;

Statement   :   EXPR NOUN   {cout << "Grammatically Correct\n";}
            |   NOUN AVERB ADJECTIVE    {cout << "Grammatically Correct\n";}
            |   NOUN AVERB VERB {cout << "Grammatically Correct\n";}
            |   NOUN AVERB VERB NOUN {cout << "Grammatically Correct\n";}  // Example : "Ayush is playing Football"
            |   PRONOUN AVERB VERB NOUN {cout << "Grammatically Correct\n";}  // Example : "He is playing Football"
            |   NOUN AVERB ARTICLE ADJECTIVE NOUN {cout << "Grammatically Correct\n";}  // Example : "Ayush is a good boy"
            |   PRONOUN AVERB ARTICLE ADJECTIVE NOUN {cout << "Grammatically Correct\n";}  // Example : "He is a good boy"
            |   NOUN AVERB ADJECTIVE CONJUNCTION ADJECTIVE {cout << "Grammatically Correct\n";}  // Example : "Ayush is intelligent and beautiful"
            |   NOUN VERB PREPOSITION NOUN {cout << "Grammatically Correct\n";}  // Example : "Ayush lives in Allahabad"
            |   ARTICLE NOUN VERB PREPOSITION ARTICLE NOUN {cout << "Grammatically Correct\n";}  // Example : "The cat jumped on the table"
            |   NOUN AVERB PREPOSITION NOUN {cout << "Grammatically Correct\n";}  // Example : "Ayush is in Ibiza"
            |   NOUN AVERB VERB ARTICLE NOUN {cout << "Grammatically Correct\n";}  // Example : "Ayush will become a scientist"
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