use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Types;

unit package Pango::Raw::Language;

sub pango_language_from_string (Str $language)
  returns PangoLanguage
  is native(pango)
  is export
  { * }

sub pango_language_get_default ()
  returns PangoLanguage
  is native(pango)
  is export
  { * }

sub pango_language_get_sample_string (PangoLanguage $language)
  returns Str
  is native(pango)
  is export
  { * }

sub pango_language_get_scripts (PangoLanguage $language, int32 $num_scripts)
  returns PangoScript
  is native(pango)
  is export
  { * }

sub pango_language_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_language_includes_script (
  PangoLanguage $language,
  uint32 $script                  # PangoScript $script
)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_language_matches (PangoLanguage $language, Str $range_list)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_language_to_string (PangoLanguage $language)
  returns Str
  is native(pango)
  is export
  { * }
