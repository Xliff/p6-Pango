use v6.c;

use NativeCall;


use Pango::Raw::Types;

unit package Pango::Raw::Attr;

sub pango_attr_background_alpha_new (guint16 $alpha)
  returns PangoAttrInt
  is native(pango)
  is export
  { * }

sub pango_attr_background_new (guint16 $red, guint16 $green, guint16 $blue)
  returns PangoAttrColor
  is native(pango)
  is export
  { * }

sub pango_attr_fallback_new (gboolean $enable_fallback)
  returns PangoAttrInt
  is native(pango)
  is export
  { * }

sub pango_attr_family_new (Str $family)
  returns PangoAttrString
  is native(pango)
  is export
  { * }

sub pango_attr_font_desc_new (PangoFontDescription $desc)
  returns PangoAttrFontDesc
  is native(pango)
  is export
  { * }

sub pango_attr_font_features_new (Str $features)
  returns PangoAttrFontFeatures
  is native(pango)
  is export
  { * }

sub pango_attr_foreground_alpha_new (guint16 $alpha)
  returns PangoAttrInt
  is native(pango)
  is export
  { * }

sub pango_attr_foreground_new (guint16 $red, guint16 $green, guint16 $blue)
  returns PangoAttrColor
  is native(pango)
  is export
  { * }

sub pango_attr_gravity_hint_new (
  uint32 $hint                    # PangoGravityHint $hint
)
  returns PangoAttrInt
  is native(pango)
  is export
  { * }

sub pango_attr_gravity_new (
  uint32 $gravity                 # PangoGravity $gravity
)
  returns PangoAttrInt
  is native(pango)
  is export
  { * }

sub pango_attr_iterator_copy (PangoAttrIterator $iterator)
  returns PangoAttrIterator
  is native(pango)
  is export
  { * }

sub pango_attr_iterator_destroy (PangoAttrIterator $iterator)
  is native(pango)
  is export
  { * }

sub pango_attr_iterator_get (
  PangoAttrIterator $iterator,
  uint32 $type                    # PangoAttrType $type
)
  returns PangoAttribute
  is native(pango)
  is export
  { * }

sub pango_attr_iterator_get_attrs (PangoAttrIterator $iterator)
  returns GSList
  is native(pango)
  is export
  { * }

sub pango_attr_iterator_get_font (
  PangoAttrIterator $iterator,
  PangoFontDescription $desc,
  PangoLanguage $language,
  GSList $extra_attrs
)
  is native(pango)
  is export
  { * }

sub pango_attr_iterator_next (PangoAttrIterator $iterator)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_attr_iterator_range (
  PangoAttrIterator $iterator,
  gint $start,
  gint $end
)
  is native(pango)
  is export
  { * }

sub pango_attr_language_new (PangoLanguage $language)
  returns PangoAttrLanguage
  is native(pango)
  is export
  { * }

sub pango_attr_letter_spacing_new (gint $letter_spacing)
  returns PangoAttrInt
  is native(pango)
  is export
  { * }

sub pango_attr_list_change (PangoAttrList $list, PangoAttribute $attr)
  is native(pango)
  is export
  { * }

sub pango_attr_list_copy (PangoAttrList $list)
  returns PangoAttrList
  is native(pango)
  is export
  { * }

sub pango_attr_list_filter (
  PangoAttrList $list,
  &func (PangoAttribute, Pointer --> gboolean),
  gpointer $data
)
  returns PangoAttrList
  is native(pango)
  is export
  { * }

sub pango_attr_list_get_iterator (PangoAttrList $list)
  returns PangoAttrIterator
  is native(pango)
  is export
  { * }

sub pango_attr_list_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_attr_list_insert (PangoAttrList $list, PangoAttribute $attr)
  is native(pango)
  is export
  { * }

sub pango_attr_list_insert_before (PangoAttrList $list, PangoAttribute $attr)
  is native(pango)
  is export
  { * }

sub pango_attr_list_new ()
  returns PangoAttrList
  is native(pango)
  is export
  { * }

sub pango_attr_list_ref (PangoAttrList $list)
  returns PangoAttrList
  is native(pango)
  is export
  { * }

sub pango_attr_list_splice (
  PangoAttrList $list,
  PangoAttrList $other,
  gint $pos,
  gint $len
)
  is native(pango)
  is export
  { * }

sub pango_attr_list_unref (PangoAttrList $list)
  is native(pango)
  is export
  { * }

sub pango_attribute_copy (PangoAttribute $attr)
  returns PangoAttribute
  is native(pango)
  is export
  { * }

sub pango_attribute_destroy (PangoAttribute $attr)
  is native(pango)
  is export
  { * }

sub pango_attribute_equal (PangoAttribute $attr1, PangoAttribute $attr2)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_attribute_init (PangoAttribute $attr, PangoAttrClass $klass)
  is native(pango)
  is export
  { * }

sub pango_color_copy (PangoColor $src)
  returns PangoColor
  is native(pango)
  is export
  { * }

sub pango_color_free (PangoColor $color)
  is native(pango)
  is export
  { * }

sub pango_color_parse (PangoColor $color, Str $spec)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_color_to_string (PangoColor $color)
  returns Str
  is native(pango)
  is export
  { * }

sub pango_markup_parser_finish (
  GMarkupParseContext $context,
  PangoAttrList $attr_list,
  Str $text,
  gunichar $accel_char,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_markup_parser_new (gunichar $accel_marker)
  returns GMarkupParseContext
  is native(pango)
  is export
  { * }

sub pango_parse_markup (
  Str $markup_text,
  gint $length,
  gunichar $accel_marker,
  PangoAttrList $attr_list,
  Str $text,
  gunichar $accel_char,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_attr_rise_new (gint $rise)
  returns PangoAttrInt
  is native(pango)
  is export
  { * }

sub pango_attr_scale_new (gdouble $scale_factor)
  returns PangoAttrFloat
  is native(pango)
  is export
  { * }

sub pango_attr_shape_new (
  PangoRectangle $ink_rect,
  PangoRectangle $logical_rect
)
  returns PangoAttrShape
  is native(pango)
  is export
  { * }

sub pango_attr_shape_new_with_data (
  PangoRectangle $ink_rect,
  PangoRectangle $logical_rect,
  gpointer $data,
  &copy_func (Pointer --> Pointer),
  &destroy_func (Pointer)
)
  returns PangoAttrShape
  is native(pango)
  is export
  { * }

sub pango_attr_size_new (gint $size)
  returns PangoAttrSize
  is native(pango)
  is export
  { * }

sub pango_attr_size_new_absolute (gint $size)
  returns PangoAttrSize
  is native(pango)
  is export
  { * }

sub pango_attr_stretch_new (
  uint32 $stretch                 # PangoStretch $stretch
)
  returns PangoAttrInt
  is native(pango)
  is export
  { * }

sub pango_attr_strikethrough_color_new (
  guint16 $red,
  guint16 $green,
  guint16 $blue
)
  returns PangoAttrColor
  is native(pango)
  is export
  { * }

sub pango_attr_strikethrough_new (gboolean $strikethrough)
  returns PangoAttrInt
  is native(pango)
  is export
  { * }

sub pango_attr_style_new (
  uint32 $style                   # PangoStyle $style
)
  returns PangoAttrInt
  is native(pango)
  is export
  { * }

sub pango_attr_type_get_name (
  uint32 $type                    # PangoAttrType $type
)
  returns Str
  is native(pango)
  is export
  { * }

sub pango_attr_type_register (Str $name)
  returns uint32 # PangoAttrType
  is native(pango)
  is export
  { * }

sub pango_attr_underline_color_new (
  guint16 $red,
  guint16 $green,
  guint16 $blue
)
  returns PangoAttrColor
  is native(pango)
  is export
  { * }

sub pango_attr_underline_new (
  uint32 $underline               # PangoUnderline $underline
)
  returns PangoAttrInt
  is native(pango)
  is export
  { * }

sub pango_attr_variant_new (
  uint32 $variant                 # PangoVariant $variant
)
  returns PangoAttrInt
  is native(pango)
  is export
  { * }

sub pango_attr_weight_new (
  uint32 $weight                  # PangoWeight $weight
)
  returns PangoAttrInt
  is native(pango)
  is export
  { * }
