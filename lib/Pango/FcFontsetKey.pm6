use v6.c;

use Method::Also;

use Pango::Compat::Types;
use Pango::Raw::FcFontMap;
use Pango::Raw::Types;

class Pango::FcFontsetKey {
  has PangoFcFontsetKey $!fcfsk;

  method get_absolute_size is also<get-absolute-size> {
    pango_fc_fontset_key_get_absolute_size($!fcfsk);
  }

  method get_context_key is also<get-context-key> {
    pango_fc_fontset_key_get_context_key($!fcfsk);
  }

  method get_description is also<get-description> {
    pango_fc_fontset_key_get_description($!fcfsk);
  }

  method get_language is also<get-language> {
    pango_fc_fontset_key_get_language($!fcfsk);
  }

  method get_matrix is also<get-matrix> {
    pango_fc_fontset_key_get_matrix($!fcfsk);
  }

  method get_resolution is also<get-resolution> {
    pango_fc_fontset_key_get_resolution($!fcfsk);
  }

}
