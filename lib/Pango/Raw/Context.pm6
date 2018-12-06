use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Types;

unit package Pango::Raw::Context;

sub pango_context_changed (PangoContext $context)
  is native(pango)
  is export
  { * }

sub pango_context_get_gravity (PangoContext $context)
  returns PangoGravity
  is native(pango)
  is export
  { * }

sub pango_context_get_metrics (
  PangoContext $context,
  PangoFontDescription $desc,
  PangoLanguage $language
)
  returns PangoFontMetrics
  is native(pango)
  is export
  { * }

sub pango_context_get_serial (PangoContext $context)
  returns guint
  is native(pango)
  is export
  { * }

sub pango_context_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_context_list_families (
  PangoContext $context,
  PangoFontFamily $families,
  int32 $n_families
)
  is native(pango)
  is export
  { * }

sub pango_context_load_font (
  PangoContext $context,
  PangoFontDescription $desc
)
  returns PangoFont
  is native(pango)
  is export
  { * }

sub pango_context_load_fontset (
  PangoContext $context,
  PangoFontDescription $desc,
  PangoLanguage $language
)
  returns PangoFontset
  is native(pango)
  is export
  { * }

sub pango_context_new ()
  returns PangoContext
  is native(pango)
  is export
  { * }

sub pango_itemize (
  PangoContext $context,
  Str $text,
  int32 $start_index,
  int32 $length,
  PangoAttrList $attrs,
  PangoAttrIterator $cached_iter
)
  returns GList
  is native(pango)
  is export
  { * }

sub pango_itemize_with_base_dir (
  PangoContext $context,
  PangoDirection $base_dir,
  Str $text,
  int32 $start_index,
  int32 $length,
  PangoAttrList $attrs,
  PangoAttrIterator $cached_iter
)
  returns GList
  is native(pango)
  is export
  { * }

sub pango_context_get_matrix (PangoContext $context)
  returns PangoMatrix
  is native(pango)
  is export
  { * }

sub pango_context_get_base_dir (PangoContext $context)
  returns PangoDirection
  is native(pango)
  is export
  { * }

sub pango_context_get_base_gravity (PangoContext $context)
  returns PangoGravity
  is native(pango)
  is export
  { * }

sub pango_context_get_font_map (PangoContext $context)
  returns PangoFontMap
  is native(pango)
  is export
  { * }

sub pango_context_get_language (PangoContext $context)
  returns PangoLanguage
  is native(pango)
  is export
  { * }

sub pango_context_get_gravity_hint (PangoContext $context)
  returns PangoGravityHint
  is native(pango)
  is export
  { * }

sub pango_context_get_font_description (PangoContext $context)
  returns PangoFontDescription
  is native(pango)
  is export
  { * }

sub pango_context_set_matrix (PangoContext $context, PangoMatrix $matrix)
  is native(pango)
  is export
  { * }

sub pango_context_set_base_dir (
  PangoContext $context,
  PangoDirection $direction
)
  is native(pango)
  is export
  { * }

sub pango_context_set_base_gravity (
  PangoContext $context,
  PangoGravity $gravity
)
  is native(pango)
  is export
  { * }

sub pango_context_set_font_map (
  PangoContext $context,
  PangoFontMap $font_map
)
  is native(pango)
  is export
  { * }

sub pango_context_set_language (
  PangoContext $context,
  PangoLanguage $language
)
  is native(pango)
  is export
  { * }

sub pango_context_set_gravity_hint (
  PangoContext $context,
  PangoGravityHint $hint
)
  is native(pango)
  is export
  { * }

sub pango_context_set_font_description (
  PangoContext $context,
  PangoFontDescription $desc
)
  is native(pango)
  is export
  { * }
