use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Misc;
use Pango::Raw::Types;
use Pango::Raw::Utils;

class Pango::Misc {

  method check (
    int $required_major,
    int $required_minor,
    int $required_micro
  ) {
    pango_version_check($required_major, $required_minor, $required_micro);
  }

  method pango_config_key_get (Str() $key) is DEPRECATED {
    pango_config_key_get($key);
  }

  method pango_config_key_get_system (Str() $key) is DEPRECATED {
    pango_config_key_get_system($key);
  }

  method pango_is_zero_width (gunichar $ch) {
    pango_is_zero_width($ch);
  }

  method pango_log2vis_get_embedding_levels (
    Str() $text,
    int $length,
    PangoDirection $pbase_dir
  ) {
    pango_log2vis_get_embedding_levels($text, $length, $pbase_dir);
  }

  method pango_lookup_aliases (
    Str() $fontname,
    Str() $families,
    int $n_families
  )
    is DEPRECATED
  {
    pango_lookup_aliases($fontname, $families, $n_families);
  }

  method pango_parse_stretch (
    Str() $str,
    PangoStretch $stretch is rw,
    gboolean $warn
  ) {
    pango_parse_stretch($str, $stretch, $warn);
  }

  method pango_parse_style (
    Str() $str,
    PangoStyle $style is rw,
    gboolean $warn
  ) {
    pango_parse_style($str, $style, $warn);
  }

  method pango_parse_variant (
    Str() $str,
    PangoVariant $variant is rw,
    gboolean $warn
  ) {
    pango_parse_variant($str, $variant, $warn);
  }

  method pango_parse_weight (
    Str() $str,
    PangoWeight $weight is rw,
    gboolean $warn
  ) {
    pango_parse_weight($str, $weight, $warn);
  }

  method pango_quantize_line_geometry (int $thickness, int $position) {
    pango_quantize_line_geometry($thickness, $position);
  }

  method pango_version {
    pango_version();
  }

  method string {
    pango_version_string();
  }

}
