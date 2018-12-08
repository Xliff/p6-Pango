use v6.c;

use Pango::Compat::Types;
use Pango::Raw::FcFontMap;
use Pango::Raw::Types;

class Pango::FcFontKey {
  has PangoFcFontKey $!fcfk;

  method get_context_key {
    pango_fc_font_key_get_context_key($!fcfk);
  }

  method get_matrix {
    pango_fc_font_key_get_matrix($!fcfk);
  }

  method get_pattern {
    pango_fc_font_key_get_pattern($!fcfk);
  }

  method get_variations {
    pango_fc_font_key_get_variations($!fcfk);
  }
}
