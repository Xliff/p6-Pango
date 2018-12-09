use v6.c;

use Pango::Compat::Types;
use Pango::Raw::FCFont;
use Pango::Raw::Types;

use Pango::Roles::Types;

class Pango::FCFont {
  has PangoFCFont $!pfcf;

  submethod BUILD (:$font) {
    selt.setFCFont($font);
  }

  method setFCFont ($font) {
    $!pfcf = do given $font {
      when PangoFCFont { $_ }
      default {
        die q:to/D/;
Invalid type { .^name } passed to Pango::FCFont.setFCFont
D

      }
    }
  }

  method get_glyph (Int() $wc) {
    my guint32 $wwc = self.RESOLVE-UINT($wc);
    pango_fc_font_get_glyph($!pfcf, $wwc);
  }

  method get_type {
    pango_fc_font_get_type();
  }

  method get_unknown_glyph (Int() $wc) {
    my guint32 $wwc = self.RESOLVE-UINT($wc);
    pango_fc_font_get_unknown_glyph($!pfcf, $wwc);
  }

  method has_char (Int() $wc) {
    my guint32 $wwc = self.RESOLVE-UINT($wc);
    pango_fc_font_has_char($!pfcf, $wc);
  }

  method kern_glyphs (PangoGlyphString() $glyphs) {
    pango_fc_font_kern_glyphs($!pfcf, $glyphs);
  }

  method lock_face {
    pango_fc_font_lock_face($!pfcf);
  }

  method unlock_face {
    pango_fc_font_unlock_face($!pfcf);
  }

}