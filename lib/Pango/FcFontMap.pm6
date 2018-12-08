use v6.c;

use Pango::Compat::Types;
use Pango::Raw::FcFontMap;
use Pango::Raw::Types;
use Pango::Raw::Utils;

use Pango::FontMap;

class Pango::FcFontMap is Pango::FontMap {
  has PangoFcFontMap $!pfcfm;

  method add_decoder_find_func (
    &findfunc,
    gpointer $user_data,
    &dnotify
  ) {
    pango_fc_font_map_add_decoder_find_func(
      $!fcfm, &findfunc, $user_data, &dnotify
    );
  }

  method cache_clear {
    pango_fc_font_map_cache_clear($!fcfm);
  }

  method config_changed {
    pango_fc_font_map_config_changed($!fcfm);
  }

  method create_context {
    pango_fc_font_map_create_context($!fcfm);
  }

  method find_decoder (FcPattern $pattern) {
    pango_fc_font_map_find_decoder($!fcfm, $pattern);
  }

  method get_type {
    pango_fc_font_map_get_type();
  }

  method shutdown {
    pango_fc_font_map_shutdown($!fcfm);
  }

}
