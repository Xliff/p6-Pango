use v6.c;

use NativeCall;


use Pango::Raw::Types;

unit package Pango::Raw::Misc;

sub pango_version_check (
  int32 $required_major,
  int32 $required_minor,
  int32 $required_micro
)
  returns Str
  is native(pango)
  is export
  { * }

sub pango_config_key_get (Str $key)
  returns Str
  is native(pango)
  is export
  { * }

sub pango_config_key_get_system (Str $key)
  returns Str
  is native(pango)
  is export
  { * }

sub pango_is_zero_width (gunichar $ch)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_log2vis_get_embedding_levels (
  Str $text,
  int32 $length,
  uint32 $pbase_dir is rw             # PangoDirection $pbase_dir
)
  returns guint8
  is native(pango)
  is export
  { * }

sub pango_lookup_aliases (Str $fontname, Str $families, int32 $n_families)
  is native(pango)
  is export
  { * }

sub pango_parse_stretch (
  Str $str,
  uint32 $stretch is rw,              # PangoStretch $stretch,
  gboolean $warn
)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_parse_style (
  Str $str,
  uint32 $style is rw,                # PangoStyle $style,
  gboolean $warn
)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_parse_variant (
  Str $str,
  uint32 $variant is rw,              # PangoVariant $variant,
  gboolean $warn
)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_parse_weight (
  Str $str,
  uint32 $weight is rw,               # PangoWeight $weight,
  gboolean $warn
)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_quantize_line_geometry (
  int32 $thickness is rw,
  int32 $position is rw
)
  is native(pango)
  is export
  { * }

sub pango_version ()
  returns int32
  is native(pango)
  is export
  { * }

sub pango_version_string ()
  returns Str
  is native(pango)
  is export
  { * }
