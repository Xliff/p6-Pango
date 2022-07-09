use v6.c;

use Method::Also;


use Pango::Raw::FcFontMap;
use Pango::Raw::Types;

class Pango::FcFontKey {
  has PangoFcFontKey $!fcfk is implementor;

  method get_context_key is also<get-context-key> {
    pango_fc_font_key_get_context_key($!fcfk);
  }

  method get_matrix is also<get-matrix> {
    pango_fc_font_key_get_matrix($!fcfk);
  }

  method get_pattern is also<get-pattern> {
    pango_fc_font_key_get_pattern($!fcfk);
  }

  method get_variations is also<get-variations> {
    pango_fc_font_key_get_variations($!fcfk);
  }
}
