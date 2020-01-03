use v6.c;

use Method::Also;

use Pango::Raw::FCFont;
use Pango::Raw::Types;

class Pango::Font::FC {
  has PangoFcFont $!pfcf;

  submethod BUILD (:$font) {
    self.setFCFont($font);
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

  method get_glyph (Int() $wc) is also<get-glyph> {
    my guint32 $wwc = $wc;

    pango_fc_font_get_glyph($!pfcf, $wwc);
  }

  method get_type is also<get-type> {
    pango_fc_font_get_type();
  }

  method get_unknown_glyph (Int() $wc) is also<get-unknown-glyph> {
    my guint32 $wwc = $wc;

    pango_fc_font_get_unknown_glyph($!pfcf, $wwc);
  }

  method has_char (Int() $wc) is also<has-char> {
    my guint32 $wwc = $wc;

    pango_fc_font_has_char($!pfcf, $wc);
  }

  method kern_glyphs (PangoGlyphString() $glyphs) is also<kern-glyphs> {
    pango_fc_font_kern_glyphs($!pfcf, $glyphs);
  }

  method lock_face is also<lock-face> {
    pango_fc_font_lock_face($!pfcf);
  }

  method unlock_face is also<unlock-face> {
    pango_fc_font_unlock_face($!pfcf);
  }

}
