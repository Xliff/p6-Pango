use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Attr;
use Pango::Raw::Types;

use Pango::Roles::Types;

class Pango::Attr {
  also does Pango::Roles::Types;

  has PangoAttribute $!pa;

  method background_alpha_new {
    pango_attr_background_alpha_new();
  }

  method background_new (guint16 $green, guint16 $blue) {
    pango_attr_background_new($!pa, $green, $blue);
  }

  method fallback_new {
    pango_attr_fallback_new();
  }

  method family_new {
    pango_attr_family_new();
  }

  method font_desc_new {
    pango_attr_font_desc_new();
  }

  method font_features_new {
    pango_attr_font_features_new();
  }

  method foreground_alpha_new {
    pango_attr_foreground_alpha_new();
  }

  method foreground_new (guint16 $green, guint16 $blue) {
    pango_attr_foreground_new($!pa, $green, $blue);
  }

  method gravity_hint_new {
    pango_attr_gravity_hint_new();
  }

  method gravity_new {
    pango_attr_gravity_new();
  }

  method iterator_copy {
    pango_attr_iterator_copy($!pa);
  }

  method iterator_destroy {
    pango_attr_iterator_destroy($!pa);
  }

  method iterator_get (PangoAttrType $type) {
    pango_attr_iterator_get($!pa, $type);
  }

  method iterator_get_attrs {
    pango_attr_iterator_get_attrs($!pa);
  }

  method iterator_get_font (PangoFontDescription $desc, PangoLanguage $language, GSList $extra_attrs) {
    pango_attr_iterator_get_font($!pa, $desc, $language, $extra_attrs);
  }

  method iterator_next {
    pango_attr_iterator_next($!pa);
  }

  method iterator_range (gint $start, gint $end) {
    pango_attr_iterator_range($!pa, $start, $end);
  }

  method language_new {
    pango_attr_language_new();
  }

  method letter_spacing_new {
    pango_attr_letter_spacing_new();
  }

  method pango_attribute_copy {
    pango_attribute_copy($!pa);
  }

  method pango_attribute_destroy {
    pango_attribute_destroy($!pa);
  }

  method pango_attribute_equal (PangoAttribute $attr2) {
    pango_attribute_equal($!pa, $attr2);
  }

  method pango_attribute_init (PangoAttrClass $klass) {
    pango_attribute_init($!pa, $klass);
  }

  method pango_color_copy {
    pango_color_copy($!pa);
  }

  method pango_color_free {
    pango_color_free($!pa);
  }

  method pango_color_parse (char $spec) {
    pango_color_parse($!pa, $spec);
  }

  method pango_color_to_string {
    pango_color_to_string($!pa);
  }

  method pango_markup_parser_finish (PangoAttrList $attr_list, char $text, gunichar $accel_char, GError $error) {
    pango_markup_parser_finish($!pa, $attr_list, $text, $accel_char, $error);
  }

  method pango_markup_parser_new {
    pango_markup_parser_new();
  }

  method pango_parse_markup (int $length, gunichar $accel_marker, PangoAttrList $attr_list, char $text, gunichar $accel_char, GError $error) {
    pango_parse_markup($!pa, $length, $accel_marker, $attr_list, $text, $accel_char, $error);
  }

  method rise_new {
    pango_attr_rise_new();
  }

  method scale_new {
    pango_attr_scale_new();
  }

  method shape_new (PangoRectangle $logical_rect) {
    pango_attr_shape_new($!pa, $logical_rect);
  }

  method shape_new_with_data (PangoRectangle $logical_rect, gpointer $data, PangoAttrDataCopyFunc $copy_func, GDestroyNotify $destroy_func) {
    pango_attr_shape_new_with_data($!pa, $logical_rect, $data, $copy_func, $destroy_func);
  }

  method size_new {
    pango_attr_size_new();
  }

  method size_new_absolute {
    pango_attr_size_new_absolute($!pa);
  }

  method stretch_new {
    pango_attr_stretch_new();
  }

  method strikethrough_color_new (guint16 $green, guint16 $blue) {
    pango_attr_strikethrough_color_new($!pa, $green, $blue);
  }

  method strikethrough_new {
    pango_attr_strikethrough_new();
  }

  method style_new {
    pango_attr_style_new();
  }

  method type_get_name {
    pango_attr_type_get_name($!pa);
  }

  method type_register {
    pango_attr_type_register($!pa);
  }

  method underline_color_new (guint16 $green, guint16 $blue) {
    pango_attr_underline_color_new($!pa, $green, $blue);
  }

  method underline_new {
    pango_attr_underline_new();
  }

  method variant_new {
    pango_attr_variant_new();
  }

  method weight_new {
    pango_attr_weight_new();
  }

}
