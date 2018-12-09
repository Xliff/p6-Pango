use v6.c;

use Pango::Compat::Types;
use Pango::Raw::FcFontMap;
use Pango::Raw::Types;

use Pango::FontMap;

use Pango::Roles::Types;

class Pango::FcFontMap is Pango::FontMap {
  also does Pango::Roles::Types;

  has PangoFcFontMap $!pfcfm;

  # Really should have some form of protection.
  method setFCFontMap($fontmap) {
    $!pfcfm = cast(PangoFcFontMap, $fontmap);
  }

  method add_decoder_find_func (
    &findfunc,
    $user_data,
    &dnotify
  ) {
    die q:to/D/.chomp unless $user_data.REPR eq <CPointer CStruct>.any;
<user_data> parameter must be of CPointer or CStruct representation.
D

    pango_fc_font_map_add_decoder_find_func(
      $!pfcfm, &findfunc, cast(Pointer, $user_data), &dnotify
    );
  }

  method cache_clear {
    pango_fc_font_map_cache_clear($!pfcfm);
  }

  method config_changed {
    pango_fc_font_map_config_changed($!pfcfm);
  }

  method create_context {
    pango_fc_font_map_create_context($!pfcfm);
  }

  method find_decoder (FcPattern $pattern) {
    pango_fc_font_map_find_decoder($!pfcfm, $pattern);
  }

  method get_type {
    pango_fc_font_map_get_type();
  }

  method shutdown {
    pango_fc_font_map_shutdown($!pfcfm);
  }

}
