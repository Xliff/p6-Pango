use v6.c;

use Method::Also;
use NativeCall;


use Pango::Raw::Attr;
use Pango::Raw::Types;
use Pango::Raw::Utils;

# Catch-all class
class Pango::Attr {
  method background_alpha_new(Int() $alpha) 
    is also<background-alpha-new> 
  {
    my guint16 $a = resolve-int16($alpha);
    pango_attr_background_alpha_new($a);
  }

  method background_new (Int() $red, Int() $green, Int() $blue) 
    is also<background-new> 
  {
    my @u = ($red, $green, $blue);
    my guint16 ($r, $g, $b) = resolve-uint16(@u);
    pango_attr_background_new($r, $g, $b);
  }

  method fallback_new (Int() $enable-fallback) is also<fallback-new> {
    my guint $ef = resolve-bool($enable-fallback);
    pango_attr_fallback_new($ef);
  }

  method family_new (Str() $family) is also<family-new> {
    pango_attr_family_new($family);
  }

  method font_desc_new(PangoFontDescription() $desc) is also<font-desc-new> {
    pango_attr_font_desc_new($desc);
  }

  method font_features_new (Str() $features) is also<font-features-new> {
    pango_attr_font_features_new($features);
  }

  method foreground_alpha_new (Int() $alpha) is also<foreground-alpha-new> {
    my guint16 $a = resolve-uint16($alpha);
    pango_attr_foreground_alpha_new($a);
  }

  method foreground_new (Int() $red, Int() $green, Int() $blue) 
    is also<foreground-new> 
  {
    my @u = ($red, $green, $blue);
    my guint16 ($r, $g, $b) = resolve-uint16(@u);
    pango_attr_foreground_new($r, $g, $b);
  }

  method gravity_hint_new (Int() $hint) is also<gravity-hint-new> {
    my guint $h = resolve-uint($hint);
    pango_attr_gravity_hint_new($h);
  }

  method gravity_new (Int() $gravity) is also<gravity-new> {
    my guint $g = resolve-uint($gravity);
    pango_attr_gravity_new($g);
  }

  method language_new (PangoLanguage() $lang) is also<language-new> {
    pango_attr_language_new($lang);
  }

  method letter_spacing_new(Int() $spacing) is also<letter-spacing-new> {
    my gint $s = resolve-int($spacing);
    pango_attr_letter_spacing_new($s);
  }

  method copy($attr) {
    die "Cannot use attribute copy on incompatible object { .^name }"
      unless $attr.^can('attr').elems && $attr.attr ~~ PangoAttribute;

    pango_attribute_copy($attr.attr);
  }

  method destroy ($attr) {
    die "Cannot use attribute destroy on incompatible object { .^name }"
      unless $attr.^can('attr').elems && $attr.attr ~~ PangoAttribute;

    pango_attribute_destroy($attr.attr);
  }

  method pango_attribute_equal ($attr1, $attr2) 
    is also<pango-attribute-equal> 
  {
    die "Cannot use attribute equals (a) on incompatible object { .^name }"
      unless $attr1.^can('attr').elems && $attr1.attr ~~ PangoAttribute;
    die "Cannot use attribute equals (b) on incompatible object { .^name }"
      unless $attr2.^can('attr').elems && $attr2.attr ~~ PangoAttribute;
    pango_attribute_equal($attr1.attr, $attr2.attr);
  }

  method init (PangoAttribute $attr, PangoAttrClass $klass) {
    pango_attribute_init($attr, $klass);
  }

  method rise_new (Int() $rise) is also<rise-new> {
    my int32 $r = resolve-int($rise);
    pango_attr_rise_new($r);
  }

  method scale_new (Num() $scale) is also<scale-new> {
    pango_attr_scale_new($scale);
  }

  method shape_new (PangoRectangle $ink_rect, PangoRectangle $logical_rect) 
    is also<shape-new> 
  {
    pango_attr_shape_new($ink_rect, $logical_rect);
  }

  method shape_new_with_data (
    PangoRectangle $ink_rect,
    PangoRectangle $logical_rect,
    $data is copy = Pointer,
    &copy_func = Callable,
    &destroy_func = Callable
  ) 
    is also<shape-new-with-data> 
  {
    $data = do given $data.REPR {
      when 'CArray' | 'CStruct'  { nativecast(Pointer, $data) }
      when 'CPointer'            { $_ }
      default                    { $_ }
    }
    pango_attr_shape_new_with_data(
      $ink_rect, $logical_rect, $data, &copy_func, &destroy_func
    );
  }

  method size_new (Int() $size) is also<size-new> {
    my int32 $s = resolve-int($size);
    pango_attr_size_new($s);
  }

  method size_new_absolute (Int() $size) is also<size-new-absolute> {
    my int32 $s = resolve-int($size);
    pango_attr_size_new_absolute($s);
  }

  method stretch_new (PangoStretch $s) is also<stretch-new> {
    pango_attr_stretch_new($s);
  }

  method strikethrough_color_new (Int() $red, Int() $green, Int() $blue) 
    is also<strikethrough-color-new> 
  {
    my @u = ($red, $green, $blue);
    my guint16 ($r, $g, $b) = resolve-uint16(@u);
    pango_attr_strikethrough_color_new($r, $g, $b);
  }

  method strikethrough_new (Int() $strikethru) is also<strikethrough-new> {
    my gboolean $st = resolve-bool($strikethru);
    pango_attr_strikethrough_new($st);
  }

  method style_new (PangoStyle $s) is also<style-new> {
    pango_attr_style_new($s);
  }

  method type_get_name (Int() $type) is also<type-get-name> {
    my uint32 $t = resolve-uint($type);
    pango_attr_type_get_name($t);
  }

  method type_register (Str() $name) is also<type-register> {
    pango_attr_type_register($name);
  }

  method underline_color_new (Int() $red, Int() $green, Int() $blue) 
    is also<underline-color-new> 
  {
    my @u = ($red, $green, $blue);
    my guint16 ($r, $g, $b) = resolve-uint16(@u);
    pango_attr_underline_color_new($r, $g, $b);
  }

  method underline_new (Int() $underline) is also<underline-new> {
    my uint32 $u = resolve-uint($underline);
    pango_attr_underline_new($u);
  }

  method variant_new (Int() $variant) is also<variant-new> {
    my uint32 $v = resolve-uint($variant);
    pango_attr_variant_new($v);
  }

  method weight_new (Int() $weight) is also<weight-new> {
    my uint32 $w = resolve-uint($weight);
    pango_attr_weight_new($w);
  }

}
