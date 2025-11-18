%%

%class PhoneValidator
%unicode
%public
%standalone

/* ============================
   Macro Definitions (must be before the second %%)
   ============================ */

CambodiaPrefixSmart     = (010|016|069|070|076|086|096)
CambodiaPrefixMetfone   = (031|060|066|067|068|090|097)
CambodiaPrefixCellcard  = (011|012|014|017|018|061|077|078)

CambodiaCode            = (0|\+?855)

CambodiaSmart      = {CambodiaCode}{CambodiaPrefixSmart}[0-9]{6,7}
CambodiaMetfone    = {CambodiaCode}{CambodiaPrefixMetfone}[0-9]{6,7}
CambodiaCellcard   = {CambodiaCode}{CambodiaPrefixCellcard}[0-9]{6,7}

%%

{CambodiaSmart} {
    System.out.println("Cambodia Number - Operator: SMART");
}

{CambodiaMetfone} {
    System.out.println("Cambodia Number - Operator: METFONE");
}

{CambodiaCellcard} {
    System.out.println("Cambodia Number - Operator: CELLCARD");
}

/* If not match -> other country */
[0-9\+\-]+ {
    System.out.println("Not Cambodia - Other Country");
}

.|\n { /* ignore */ }
