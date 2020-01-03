use v6.c;

use Method::Also;

use Pango::Raw::Types;
use Pango::Raw::Misc;
use Pango::Raw::Utils;

use GLib::Roles::StaticClass;

class Pango::Misc {
  use GLib::Roles::StaticClass;

  method check (
    Int() $required_major,
    Int() $required_minor,
    Int() $required_micro
  ) {
    my gint ($mj, $mn, $mc) =
      ($required_major, $required_minorm $required_micro);

    so pango_version_check($mj, $mn, $mc);
  }

  method pango_is_zero_width (Int() $ch) is also<pango-is-zero-width> {
    my gunichar $c = $ch;

    so pango_is_zero_width($c);
  }

  method pango_log2vis_get_embedding_levels (
    Str() $text,
    int $length,
    PangoDirection $pbase_dir
  )
    is also<pango-log2vis-get-embedding-levels>
  {
    pango_log2vis_get_embedding_levels($text, $length, $pbase_dir);
  }

  method pango_parse_stretch (
    Str() $str,
    PangoStretch $stretch is rw,
    gboolean $warn
  )
    is also<pango-parse-stretch>
  {
    pango_parse_stretch($str, $stretch, $warn);
  }

  method pango_parse_style (
    Str() $str,
    PangoStyle $style is rw,
    gboolean $warn
  )
    is also<pango-parse-style>
  {
    pango_parse_style($str, $style, $warn);
  }

  method pango_parse_variant (
    Str() $str,
    PangoVariant $variant is rw,
    gboolean $warn
  )
    is also<pango-parse-variant>
  {
    pango_parse_variant($str, $variant, $warn);
  }

  method pango_parse_weight (
    Str() $str,
    PangoWeight $weight is rw,
    gboolean $warn
  )
    is also<pango-parse-weight>
  {
    pango_parse_weight($str, $weight, $warn);
  }

  method pango_quantize_line_geometry (Int() $thickness, Int() $position)
    is also<pango-quantize-line-geometry>
  {
    my gint ($t, $p) = ($thickness, $position);

    pango_quantize_line_geometry($t, $p);
  }

  method pango_version is also<pango-version> {
    pango_version();
  }

  method string {
    pango_version_string();
  }

}
