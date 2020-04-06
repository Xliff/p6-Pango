use v6.c;

use Method::Also;
use NativeCall;


use Pango::Raw::Fontset;
use Pango::Raw::Types;

class Pango::Fontset {
  has PangoFontset $!pfs;

  # Used only when dealing with abstract forms of descendants.
  submethod BUILD (:$set) {
    self.setFontset($set);
  }

  method Pango::Raw::Definitions::PangoFontset
    is also<PangoFontset>
  { $!pfs }

  method setFontset($set) {
    $!pfs = do given $set {
      when PangoFontset { nativecast(PangoFontset, $_) }
      default {
        die q:to/D/;
Invalid type { .^name } passed to Pango::Fontset.setFontset
D

      }
    }
  }

  method new (PangoFontset $set) {
    my $o = self.bless($set);
    $o.upref;
    $o;
  }

  method foreach (&func, $data = Pointer) {
    die qq:to/D/ if $data.REPR ne <CStruct CPointer>.any;
\$data parameter must be of CStruct or CPointer representation.
D

    pango_fontset_foreach($!pfs, &func, $data);
  }

  method get_font (Int() $wc) is also<get-font> {
    my gint $wwc = $wc;
    
    pango_fontset_get_font($!pfs, $wwc);
  }

  method get_metrics is also<get-metrics> {
    pango_fontset_get_metrics($!pfs);
  }

}
