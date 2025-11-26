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

CambodiaPrefix  = ({SmartPrefix}|{MetfonePrefix}|{CellcardPrefix})

/* Local Cambodia numbers: prefix + 5 or 6 digits */
LocalCambodia   = {CambodiaPrefix}[0-9]{6,7}

/* International Cambodia numbers (+855) */
IntlCambodia    = \+855{CambodiaPrefix}[0-9]{6,7}

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
   Cambodia (+855)
   ============================ */
^{IntlCambodia} {
    String prefix = yytext().substring(5, 8);

    if (prefix.matches("010|016|069|070|076|086|096|093"))
        System.out.println(yytext()+" : Valid Cambodia Number is Smart");
    else if (prefix.matches("031|060|066|067|068|090|097"))
        System.out.println(yytext()+": Valid Cambodia Number is Metfone");
    else
        System.out.println(yytext()+": Valid Cambodia Number is Cellcard");
}

/* ============================
   Cambodia (Local)
   ============================ */
^{LocalCambodia} {
    String prefix = yytext().substring(0,3);

    if (prefix.matches("010|016|069|070|076|086|096|093"))
        System.out.println(yytext()+" :Valid Cambodia Number is Smart");
    else if (prefix.matches("031|060|066|067|068|090|097"))
        System.out.println(yytext()+":Valid Cambodia Number is Metfone");
    else
        System.out.println(yytext()+":Valid Cambodia Number is Cellcard");
}

/* ============================
   Other Countries (Your 5)
   ============================ */

^{VietnamNum}   { System.out.println(yytext()+":Valid Number is Vietnam"); }
^{ChinaNum}     { System.out.println(yytext()+": Valid Number is China"); }
^{SingaporeNum} { System.out.println(yytext()+": Valid Number is Singapore"); }
^{JapanNum}     { System.out.println(yytext()+": Valid Number is Japan"); }
^{LaosNum}     { System.out.println(yytext()+": Valid Number is Laos"); }

/* ============================
   Valid but Unknown Country
   ============================ */
^{ValidNumber} {
    System.out.println(yytext()+": Valid Number -> Unknown Country");
}

/* ============================
   Invalid Number
   ============================ */

.* {
    System.out.println(yytext()+": Invalid Phone Number");
}
