use v6.c;

use NativeCall;


use Pango::Raw::Types;

unit package Pango::Raw::DescriptionMetrics;

sub pango_font_description_better_match (
  PangoFontDescription $desc,
  PangoFontDescription $old_match,
  PangoFontDescription $new_match
)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_font_description_copy (PangoFontDescription $desc)
  returns PangoFontDescription
  is native(pango)
  is export
  { * }

sub pango_font_description_copy_static (PangoFontDescription $desc)
  returns PangoFontDescription
  is native(pango)
  is export
  { * }

sub pango_font_description_equal (
  PangoFontDescription $desc1,
  PangoFontDescription $desc2
)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_font_description_free (PangoFontDescription $desc)
  is native(pango)
  is export
  { * }

sub pango_font_description_from_string (gchar $str)
  returns PangoFontDescription
  is native(pango)
  is export
  { * }

sub pango_font_description_get_set_fields (PangoFontDescription $desc)
  returns uint32 # PangoFontMask
  is native(pango)
  is export
  { * }

sub pango_font_description_get_size_is_absolute (PangoFontDescription $desc)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_font_description_hash (PangoFontDescription $desc)
  returns guint
  is native(pango)
  is export
  { * }

sub pango_font_description_merge (
  PangoFontDescription $desc,
  PangoFontDescription $desc_to_merge,
  gboolean $replace_existing
)
  is native(pango)
  is export
  { * }

sub pango_font_description_merge_static (
  PangoFontDescription $desc,
  PangoFontDescription $desc_to_merge,
  gboolean $replace_existing
)
  is native(pango)
  is export
  { * }

sub pango_font_description_new ()
  returns PangoFontDescription
  is native(pango)
  is export
  { * }

sub pango_font_describe (PangoFont $font)
  returns PangoFontDescription
  is native(pango)
  is export
  { * }

sub pango_font_describe_with_absolute_size (PangoFont $font)
  returns PangoFontDescription
  is native(pango)
  is export
  { * }

sub pango_font_descriptions_free (
  CArray[Pointer[PangoFontDescription]] $descs,
  gint $n_descs
)
  is native(pango)
  is export
  { * }

sub pango_font_face_describe (PangoFontFace $face)
  returns PangoFontDescription
  is native(pango)
  is export
  { * }

sub pango_font_face_get_face_name (PangoFontFace $face)
  returns gchar
  is native(pango)
  is export
  { * }

sub pango_font_face_is_synthesized (PangoFontFace $face)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_font_face_list_sizes (
  PangoFontFace $face,
  gint $sizes,
  gint $n_sizes
)
  is native(pango)
  is export
  { * }

sub pango_font_family_get_name (PangoFontFamily $family)
  returns gchar
  is native(pango)
  is export
  { * }

sub pango_font_family_is_monospace (PangoFontFamily $family)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_font_family_list_faces (
  PangoFontFamily $family,
  CArray[CArray[CArray[PangoFontFace]]] $faces,
  gint $n_faces
)
  is native(pango)
  is export
  { * }

sub pango_font_find_shaper (
  PangoFont $font,
  PangoLanguage $language,
  guint32 $ch
)
  returns PangoEngineShape
  is native(pango)
  is export
  { * }

sub pango_font_get_coverage (PangoFont $font, PangoLanguage $language)
  returns PangoCoverage
  is native(pango)
  is export
  { * }

sub pango_font_get_font_map (PangoFont $font)
  returns PangoFontMap
  is native(pango)
  is export
  { * }

sub pango_font_get_glyph_extents (
  PangoFont $font,
  PangoGlyph $glyph,
  PangoRectangle $ink_rect,
  PangoRectangle $logical_rect
)
  is native(pango)
  is export
  { * }

sub pango_font_get_metrics (
  PangoFont $font,
  PangoLanguage $language
)
  returns PangoFontMetrics
  is native(pango)
  is export
  { * }

sub pango_font_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_font_metrics_get_approximate_char_width (PangoFontMetrics $metrics)
  returns gint
  is native(pango)
  is export
  { * }

sub pango_font_metrics_get_approximate_digit_width (PangoFontMetrics $metrics)
  returns gint
  is native(pango)
  is export
  { * }

sub pango_font_metrics_get_ascent (PangoFontMetrics $metrics)
  returns gint
  is native(pango)
  is export
  { * }

sub pango_font_metrics_get_descent (PangoFontMetrics $metrics)
  returns gint
  is native(pango)
  is export
  { * }

sub pango_font_metrics_get_strikethrough_position (PangoFontMetrics $metrics)
  returns gint
  is native(pango)
  is export
  { * }

sub pango_font_metrics_get_strikethrough_thickness (PangoFontMetrics $metrics)
  returns gint
  is native(pango)
  is export
  { * }

sub pango_font_metrics_get_underline_position (PangoFontMetrics $metrics)
  returns gint
  is native(pango)
  is export
  { * }

sub pango_font_metrics_get_underline_thickness (PangoFontMetrics $metrics)
  returns gint
  is native(pango)
  is export
  { * }

sub pango_font_metrics_new ()
  returns PangoFontMetrics
  is native(pango)
  is export
  { * }

sub pango_font_metrics_ref (PangoFontMetrics $metrics)
  returns PangoFontMetrics
  is native(pango)
  is export
  { * }

sub pango_font_metrics_unref (PangoFontMetrics $metrics)
  is native(pango)
  is export
  { * }

sub pango_font_description_set_absolute_size (
  PangoFontDescription $desc,
  gdouble $size
)
  is native(pango)
  is export
  { * }

sub pango_font_description_set_family_static (
  PangoFontDescription $desc,
  Str $family
)
  is native(pango)
  is export
  { * }

sub pango_font_description_set_variations_static (
  PangoFontDescription $desc,
  Str $settings
)
  is native(pango)
  is export
  { * }

sub pango_font_description_to_filename (PangoFontDescription $desc)
  returns gchar
  is native(pango)
  is export
  { * }

sub pango_font_description_to_string (PangoFontDescription $desc)
  returns gchar
  is native(pango)
  is export
  { * }

sub pango_font_description_unset_fields (
  PangoFontDescription $desc,
  uint32 $to_unset                # PangoFontMask $to_unset
)
  is native(pango)
  is export
  { * }

sub pango_font_description_get_family (PangoFontDescription $desc)
  returns gchar
  is native(pango)
  is export
  { * }

sub pango_font_description_get_variations (PangoFontDescription $desc)
  returns gchar
  is native(pango)
  is export
  { * }

sub pango_font_description_get_size (PangoFontDescription $desc)
  returns gint
  is native(pango)
  is export
  { * }

sub pango_font_description_get_style (PangoFontDescription $desc)
  returns uint32 # PangoStyle
  is native(pango)
  is export
  { * }

sub pango_font_description_get_gravity (PangoFontDescription $desc)
  returns uint32 # PangoGravity
  is native(pango)
  is export
  { * }

sub pango_font_description_get_weight (PangoFontDescription $desc)
  returns uint32 # PangoWeight
  is native(pango)
  is export
  { * }

sub pango_font_description_get_stretch (PangoFontDescription $desc)
  returns uint32 # PangoStretch
  is native(pango)
  is export
  { * }

sub pango_font_description_get_variant (PangoFontDescription $desc)
  returns uint32 # PangoVariant
  is native(pango)
  is export
  { * }

sub pango_font_description_set_family (
  PangoFontDescription $desc,
  Str $family
)
  is native(pango)
  is export
  { * }

sub pango_font_description_set_variations (
  PangoFontDescription $desc,
  Str $settings
)
  is native(pango)
  is export
  { * }

sub pango_font_description_set_size (PangoFontDescription $desc, gint $size)
  is native(pango)
  is export
  { * }

sub pango_font_description_set_style (
  PangoFontDescription $desc,
  uint32 $style                   # PangoStyle $style
)
  is native(pango)
  is export
  { * }

sub pango_font_description_set_gravity (
  PangoFontDescription $desc,
  uint32 $gravity                 # PangoGravity $gravity
)
  is native(pango)
  is export
  { * }

sub pango_font_description_set_weight (
  PangoFontDescription $desc,
  uint32 $weight                  # PangoWeight $weight
)
  is native(pango)
  is export
  { * }

sub pango_font_description_set_stretch (
  PangoFontDescription $desc,
  uint32 $stratch                 # PangoStretch $stretch
)
  is native(pango)
  is export
  { * }

sub pango_font_description_set_variant (
  PangoFontDescription $desc,
  uint32                          # PangoVariant $variant
)
  is native(pango)
  is export
  { * }
