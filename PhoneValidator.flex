%%

%class PhoneValidator
%unicode
%public
%standalone


/* Valid 8–9 digit number */
ValidNumber     = [0-9]{9,10}

/* ============================
   Cambodia Prefix Definitions
   ============================ */
SmartPrefix = (010|015|016|069|070|071|076|077|078|079|086|087|089|093|095|096|098|099)
MetfonePrefix = (031|060|061|066|067|068|071|088|089|090|097)
CellcardPrefix = (011|012|014|015|017|018|061|077|078|085|089|095|098|099)

SmartPrefixNo0 = (10|15|16|69|70|71|76|77|78|79|86|87|89|93|95|96|98|99)
MetfonePrefixNo0 = (31|60|61|66|67|68|71|88|89|90|97)
CellcardPrefixNo0 = (11|12|14|15|17|18|61|77|78|85|89|95|98|99)


/* ============================
   Other Countries Prefix
   ============================ */
VietnamNum      = \+84[0-9]{7,10}
LaosNum         = \+856[0-9]{6,10}
ChinaNum        = \+86[0-9]{6,11}
SingaporeNum    = \+65[0-9]{6,10}
JapanNum        = \+81[0-9]{6,10}

%%

/* ============================
   Cambodia (+855) - Smart
   ============================ */
^\+855({SmartPrefix}|{SmartPrefixNo0})[0-9]{6,7} {
    System.out.println(yytext()+" : Valid Cambodia Number is Smart");
}

/* ============================
   Cambodia (+855) - Metfone
   ============================ */
^\+855({MetfonePrefix}|{MetfonePrefixNo0})[0-9]{6,7} {
    System.out.println(yytext()+" : Valid Cambodia Number is Metfone");
}

/* ============================
   Cambodia (+855) - Cellcard
   ============================ */
^\+855({CellcardPrefix}|{CellcardPrefixNo0})[0-9]{6,7} {
    System.out.println(yytext()+" : Valid Cambodia Number is Cellcard");
}

/* ============================
   Cambodia (Local) - Smart
   ============================ */
^{SmartPrefix}[0-9]{6,7} {
    System.out.println(yytext()+" : Valid Cambodia Number is Smart");
}

/* ============================
   Cambodia (Local) - Metfone
   ============================ */
^{MetfonePrefix}[0-9]{6,7} {
    System.out.println(yytext()+" : Valid Cambodia Number is Metfone");
}

/* ============================
   Cambodia (Local) - Cellcard
   ============================ */
^{CellcardPrefix}[0-9]{6,7} {
    System.out.println(yytext()+" : Valid Cambodia Number is Cellcard");
}

/* ============================
   Other Countries (Your 5)
   ============================ */
^{VietnamNum}   { System.out.println(yytext()+" : Valid Number is Vietnam"); }
^{ChinaNum}     { System.out.println(yytext()+" : Valid Number is China"); }
^{SingaporeNum} { System.out.println(yytext()+" : Valid Number is Singapore"); }
^{JapanNum}     { System.out.println(yytext()+" : Valid Number is Japan"); }
^{LaosNum}      { System.out.println(yytext()+" : Valid Number is Laos"); }

/* ============================
   Valid but Unknown Country
   ============================ */
^{ValidNumber} {
    System.out.println(yytext()+" : Valid Number -> Unknown Country");
}

/* ============================
   Invalid Number
   ============================ */
.* {
    System.out.println(yytext()+" : Invalid Phone Number");
}