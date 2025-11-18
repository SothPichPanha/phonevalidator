%%

%class PhoneValidator
%unicode
%public
%standalone

%{

private String operator = "OTHER_COUNTRY";

public String getOperator() {
    return operator;
}

%}

%%

/* Cambodian number formats */
CambodiaPrefixSmart     = (010|016|069|070|076|086|096)
CambodiaPrefixMetfone   = (031|060|066|067|068|090|097)
CambodiaPrefixCellcard  = (011|012|014|017|018|061|077|078)

/* Cambodia country code formats */
CambodiaCode = (0|\+?855)

/* Full Cambodian phone patterns */
CambodiaSmart      = {CambodiaCode}?{CambodiaPrefixSmart}[0-9]{6,7}
CambodiaMetfone    = {CambodiaCode}?{CambodiaPrefixMetfone}[0-9]{6,7}
CambodiaCellcard   = {CambodiaCode}?{CambodiaPrefixCellcard}[0-9]{6,7}

%%

{CambodiaSmart} {
    operator = "SMART";
    System.out.println("Cambodia Number - Operator: " + operator);
}

{CambodiaMetfone} {
    operator = "METFONE";
    System.out.println("Cambodia Number - Operator: " + operator);
}

{CambodiaCellcard} {
    operator = "CELLCARD";
    System.out.println("Cambodia Number - Operator: " + operator);
}

/* If it doesn't match Cambodia -> Other country */
[0-9\+\-]+ {
    operator = "OTHER_COUNTRY";
    System.out.println("Not Cambodia - Other Country");
}

.|\n { /* ignore other characters */ }
