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
%token<ident> PMARK  "pmark"
%token<ident> END  "end"


%%

Code        :   Code Statement
            |   Statement
            ;

Statement   :  EXPR NOUN END   {cout << "Grammatically Correct\n";} // Example: "Hey Baba."
            |  NOUN AVERB ADJECTIVE END   {cout << "Grammatically Correct\n";} // Example: "Baba is beautiful."
            |  NOUN AVERB VERB END {cout << "Grammatically Correct\n";} // Example: "Baba is playing."
            |  NOUN AVERB VERB NOUN END {cout << "Grammatically Correct\n";}  // Example : "Baba is playing Football."
            |  PRONOUN AVERB VERB END {cout << "Grammatically Correct\n";} // Example: "We are playing."
            |  PRONOUN AVERB VERB NOUN END {cout << "Grammatically Correct\n";}  // Example : "He is playing Football."
            |  NOUN AVERB ARTICLE ADJECTIVE NOUN END {cout << "Grammatically Correct\n";}  // Example : "Baba is a good boy."
            |  PRONOUN AVERB ARTICLE ADJECTIVE NOUN END {cout << "Grammatically Correct\n";}  // Example : "He is a good boy."
            |  NOUN AVERB ADJECTIVE CONJUNCTION ADJECTIVE END {cout << "Grammatically Correct\n";}  // Example : "Baba is intelligent and beautiful."
            |  NOUN VERB PREPOSITION NOUN END {cout << "Grammatically Correct\n";}  // Example : "Baba lives in Allahabad."
            |  ARTICLE NOUN VERB PREPOSITION ARTICLE NOUN END {cout << "Grammatically Correct\n";}  // Example : "The cat jumped on the table."
            |  NOUN AVERB PREPOSITION NOUN END {cout << "Grammatically Correct\n";}  // Example : "Baba is in Ibiza."
            |  NOUN AVERB VERB ARTICLE NOUN END {cout << "Grammatically Correct\n";}  // Example : "Baba will become a scientist."
            |  AVERB NOUN VERB PMARK { cout << "Grammatically Correct\n";  } // Example: "Is Baba playing?"
            |  AVERB NOUN ADJECTIVE PMARK { cout << "Grammatically Correct\n";  } // Example: "Is Baba playing?"
            |  Invalid
            ;

Invalid     :  NOUN EXPR END   {
                                std::string x = string($1);
                                cout << "Suggestsed Edit : Swap " << x << " and " << ($2) << endl;
                           }
            |  NOUN ADJECTIVE AVERB END   {
                                          cout << "Suggestsed Edit : Swap " << ($2) << " and " << ($3) << endl;
                                       }
            |  AVERB NOUN ADJECTIVE END  {
                                          cout << "Suggestsed Edit : Question Mark missing " << endl;
                                       }
            |  ADJECTIVE AVERB NOUN END   {
                                          cout << "Suggestsed Edit : Swap " << ($1) << " and " << ($3) << endl;
                                       }
            |  VERB AVERB NOUN END   {
                                          cout << "Suggestsed Edit : Swap " << ($1) << " and " << ($3) << endl;
                                       }
            |  NOUN VERB AVERB END   {
                                          cout << "Suggestsed Edit : Swap " << ($2) << " and " << ($3) << endl;
                                       }
            |  AVERB NOUN VERB END  {
                                          cout << "Suggestsed Edit : Question Mark missing " << endl;
                                       }
            |  NOUN VERB AVERB NOUN END   {
                                          cout << "Suggestsed Edit : Swap " << ($2) << " and " << ($3) << endl;
                                       }
            |  NOUN VERB NOUN END   {
                                          cout << "Suggestsed Edit : Adverb missing" << endl;
                                       }
                           
            ;
%%

int main(){
    return yyparse();
}
int yywrap(){
    return(1);
}