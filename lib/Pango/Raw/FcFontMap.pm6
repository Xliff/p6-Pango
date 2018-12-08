use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Types;

unit package Pango::Raw::FCFontMap;

sub pango_fc_font_description_from_pattern (
  FcPattern $pattern,
  gboolean $include_size
)
  returns PangoFontDescription
  is native(pango)
  is export
  { * }

sub pango_fc_font_key_get_context_key (PangoFcFontKey $key)
  returns Pointer
  is native(pango)
  is export
  { * }

sub pango_fc_font_key_get_matrix (PangoFcFontKey $key)
  returns PangoMatrix
  is native(pango)
  is export
  { * }

sub pango_fc_font_key_get_pattern (PangoFcFontKey $key)
  returns FcPattern
  is native(pango)
  is export
  { * }

sub pango_fc_font_key_get_variations (PangoFcFontKey $key)
  returns Str
  is native(pango)
  is export
  { * }

sub pango_fc_font_map_add_decoder_find_func (
  PangoFcFontMap $fcfontmap,
  &findfunc (FcPattern, Pointer --> PangoFcDecoder),
  gpointer $user_data,
  &dnotify (Pointer)
)
  is native(pango)
  is export
  { * }

sub pango_fc_font_map_cache_clear (PangoFcFontMap $fcfontmap)
  is native(pango)
  is export
  { * }

sub pango_fc_font_map_config_changed (PangoFcFontMap $fcfontmap)
  is native(pango)
  is export
  { * }

sub pango_fc_font_map_create_context (PangoFcFontMap $fcfontmap)
  returns PangoContext
  is native(pango)
  is export
  { * }

sub pango_fc_font_map_find_decoder (
  PangoFcFontMap $fcfontmap,
  FcPattern $pattern
)
  returns PangoFcDecoder
  is native(pango)
  is export
  { * }

sub pango_fc_font_map_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_fc_font_map_shutdown (PangoFcFontMap $fcfontmap)
  is native(pango)
  is export
  { * }

sub pango_fc_fontset_key_get_absolute_size (PangoFcFontsetKey $key)
  returns gdouble
  is native(pango)
  is export
  { * }

sub pango_fc_fontset_key_get_context_key (PangoFcFontsetKey $key)
  returns Pointer
  is native(pango)
  is export
  { * }

sub pango_fc_fontset_key_get_description (PangoFcFontsetKey $key)
  returns PangoFontDescription
  is native(pango)
  is export
  { * }

sub pango_fc_fontset_key_get_language (PangoFcFontsetKey $key)
  returns PangoLanguage
  is native(pango)
  is export
  { * }

sub pango_fc_fontset_key_get_matrix (PangoFcFontsetKey $key)
  returns PangoMatrix
  is native(pango)
  is export
  { * }

sub pango_fc_fontset_key_get_resolution (PangoFcFontsetKey $key)
  returns double
  is native(pango)
  is export
  { * }

sub pango_fc_font_map_get_config (PangoFcFontMap $fcfontmap)
  returns FcConfig
  is native(pango)
  is export
  { * }

sub pango_fc_font_map_set_config (
  PangoFcFontMap $fcfontmap,
  FcConfig $fcconfig
)
  is native(pango)
  is export
  { * }
