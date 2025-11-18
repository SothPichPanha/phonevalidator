%%

%class PhoneValidator
%unicode
%public
%standalone

/* ============================
   Cambodia Prefix Definitions
   ============================ */

SmartPrefix     = (010|016|069|070|076|086|096|093)
MetfonePrefix   = (031|060|066|067|068|090|097)
CellcardPrefix  = (011|012|014|017|018|061|077|078|095)

CambodiaPrefix  = ({SmartPrefix}|{MetfonePrefix}|{CellcardPrefix})

/* Local Cambodia numbers: prefix + 5 or 6 digits */
LocalCambodia   = {CambodiaPrefix}[0-9]{5,6}

/* International Cambodia numbers (+855) */
IntlCambodia    = \+855{CambodiaPrefix}[0-9]{5,6}

/* ============================
   Other Countries Prefix
   ============================ */

VietnamNum      = \+84[0-9]{7,10}
LaosNum         = \+856[0-9]{6,10}
ChinaNum        = \+86[0-9]{6,11}
SingaporeNum    = \+65[0-9]{6,10}
JapanNum        = \+81[0-9]{6,10}

/* Valid 8–9 digit number */
ValidNumber     = [0-9]{8,9}

%%

/* ============================
   Cambodia (+855)
   ============================ */
^{IntlCambodia}$ {
    String prefix = yytext().substring(4, 7);

    if (prefix.matches("010|016|069|070|076|086|096|093"))
        System.out.println("Valid Cambodia Number → Smart");
    else if (prefix.matches("031|060|066|067|068|090|097"))
        System.out.println("Valid Cambodia Number → Metfone");
    else
        System.out.println("Valid Cambodia Number → Cellcard");
}

/* ============================
   Cambodia (Local)
   ============================ */
^{LocalCambodia}$ {
    String prefix = yytext().substring(0,3);

    if (prefix.matches("010|016|069|070|076|086|096|093"))
        System.out.println("Valid Cambodia Number → Smart");
    else if (prefix.matches("031|060|066|067|068|090|097"))
        System.out.println("Valid Cambodia Number → Metfone");
    else
        System.out.println("Valid Cambodia Number → Cellcard");
}

/* ============================
   Other Countries (Your 5)
   ============================ */

^{VietnamNum}$    { System.out.println("Valid Number → Vietnam"); }
^{LaosNum}$       { System.out.println("Valid Number → Laos"); }
^{ChinaNum}$      { System.out.println("Valid Number → China"); }
^{SingaporeNum}$  { System.out.println("Valid Number → Singapore"); }
^{JapanNum}$      { System.out.println("Valid Number → Japan"); }

/* ============================
   Valid but Unknown Country
   ============================ */
^{ValidNumber}$ {
    System.out.println("Valid Number → Unknown Country");
}

/* ============================
   Invalid Number
   ============================ */
.* {
    System.out.println("Invalid Phone Number");
}
