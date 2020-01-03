use v6.c;

use Method::Also;
use NativeCall;


use Pango::Raw::FcFontMap;
use Pango::Raw::Types;

use Pango::FontMap;

use Pango::Roles::Types;

class Pango::FontMap::FC is Pango::FontMap {
  also does Pango::Roles::Types;

  has PangoFcFontMap $!pfcfm;

  # Really should have some form of protection.
  method setFCFontMap($fontmap) {
    $!pfcfm = cast(PangoFcFontMap, $fontmap);
    self.setFontMap( cast(PangoFontMap, $fontmap) );
  }

  method add_decoder_find_func (
    &findfunc,
    $user_data,
    &dnotify
  ) 
    is also<add-decoder-find-func> 
  {
    die q:to/D/.chomp unless $user_data.REPR eq <CPointer CStruct>.any;
<user_data> parameter must be of CPointer or CStruct representation.
D

    pango_fc_font_map_add_decoder_find_func(
      $!pfcfm, &findfunc, cast(Pointer, $user_data), &dnotify
    );
  }

  method cache_clear is also<cache-clear> {
    pango_fc_font_map_cache_clear($!pfcfm);
  }

  method config_changed is also<config-changed> {
    pango_fc_font_map_config_changed($!pfcfm);
  }

  method find_decoder (FcPattern $pattern) is also<find-decoder> {
    pango_fc_font_map_find_decoder($!pfcfm, $pattern);
  }

  method get_type is also<get-type> {
    pango_fc_font_map_get_type();
  }

  method shutdown {
    pango_fc_font_map_shutdown($!pfcfm);
  }

}
