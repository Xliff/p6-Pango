use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Attr;
use Pango::Raw::Types;
use Pango::Raw::Utils;

class Pango::Attr {

  method background_alpha_new(Int() $alpha) {
    my guint16 $a = resolve-int16($alpha)
    pango_attr_background_alpha_new($a);
  }

  method background_new (Int() $red, Int() $green, Int() $blue) {
    my @u = ($red, $green, $blue)
    my guint16 ($r, $g, $b) = resolve-uint16(@u);
    pango_attr_background_new($r, $g, $b);
  }

  method fallback_new (Int() $enable-fallback) {
    my guint $ef = resolve-bool($enable-fallback);
    pango_attr_fallback_new($ef);
  }

  method family_new (Str() $family) {
    pango_attr_family_new($family);
  }

  method font_desc_new(PangoFontDescription() $desc) {
    pango_attr_font_desc_new($desc);
  }

  method font_features_new (Str() $features) {
    pango_attr_font_features_new($features);
  }

  method foreground_alpha_new (Int() $alpha) {
    my guint16 $a = resolve-uint16($alpha);
    pango_attr_foreground_alpha_new();
  }

  method foreground_new (Int() $red, Int() $green, Int() $blue) {
    my @u = ($red, $green, $blue);
    my guint16 ($r, $g, $b) = resolve-uint16(@u);
    pango_attr_foreground_new($!pa, $green, $blue);
  }

  method gravity_hint_new (Int() $hint) {
    my guint $h = resolve-uint($hint);
    pango_attr_gravity_hint_new($h);
  }

  method gravity_new (Int() $gravity) {
    my guint $g = resolve-uint($gravity);
    pango_attr_gravity_new($g);
  }

  method language_new (PangoLanguage() $lang) {
    pango_attr_language_new($lang);
  }

  method letter_spacing_new(Int() $spacing) {
    my gint $s = resolve-int($spacing);
    pango_attr_letter_spacing_new($s);
  }

  method copy($attr); {
    my $a;
    die "Cannot use attribute copy on incompatible object { .^name }"
      unless $attr.^can('attr').elems && ($a = $attr.attr) ~~ PangoAttribute;

    pango_attribute_copy($a);
  }

  method destroy ($a) {
    my $a;
    die "Cannot use attribute destroy on incompatible object { .^name }"
      unless $attr.^can('attr').elems && ($a = $attr.attr) ~~ PangoAttribute;

    pango_attribute_destroy($a);
  }

  method pango_attribute_equal ($attr1, $attr2) {
    my ($a, $b);
    die "Cannot use attribute equals (a) on incompatible object { .^name }"
      unless $attr.^can('attr').elems && ($a = $attr1.attr) ~~ PangoAttribute;
    die "Cannot use attribute equals (b) on incompatible object { .^name }"
      unless $attr.^can('attr').elems && ($b = $attr2.attr) ~~ PangoAttribute;
    pango_attribute_equal($!pa, $attr2);
  }

  method init (PangoAttribute $attr, PangoAttrClass $klass) {
    pango_attribute_init($attr, $klass);
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

  method shape_new_with_data (
    PangoRectangle $logical_rect,
    gpointer $data,
    &copy_func,
    &destroy_func
  ) {
    pango_attr_shape_new_with_data(
      $!pa, $logical_rect, $data, &copy_func, &destroy_func
    );
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

  method strikethrough_color_new (Int() $red, Int() $green, Int() $blue) {
    my @u = ($red, $green, $blue);
    my guint16 ($r, $g, $b) = resolve-uint16(@u);
    pango_attr_strikethrough_color_new($r, $g, $b);
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

  method underline_color_new (Int() $red, Int() $green, Int() $blue) {
    my @u = ($red, $green, $blue);
    my guint16 ($r, $g, $b) = resolve-uint16(@u);
    pango_attr_underline_color_new($r, $g, $b);
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
