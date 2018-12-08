use v6.c;

use Pango::Compat::Types;
use Pango::Raw::FcFontMap;
use Pango::Raw::Types;

class Pango::FcFontsetKey {
  has PangoFcFontsetKey $!fcfsk;

  method get_absolute_size {
    pango_fc_fontset_key_get_absolute_size($!fcfsk);
  }

  method get_context_key {
    pango_fc_fontset_key_get_context_key($!fcfsk);
  }

  method get_description {
    pango_fc_fontset_key_get_description($!fcfsk);
  }

  method get_language {
    pango_fc_fontset_key_get_language($!fcfsk);
  }

  method get_matrix {
    pango_fc_fontset_key_get_matrix($!fcfsk);
  }

  method get_resolution {
    pango_fc_fontset_key_get_resolution($!fcfsk);
  }

}
