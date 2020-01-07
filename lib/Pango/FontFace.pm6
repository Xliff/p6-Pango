use v6.c;

use Method::Also;

use Pango::Raw::Types;
use Pango::Raw::DescriptionMetrics;

class Pango::FontFace {
  has PangoFontFace $!pff;

  submethod BUILD (:$face) {
    $!pff = $face;
  }

  method Pango::Raw::Definitions::PangoFontFace
    is also<PangoFontFace>
  { $!pff }

  method describe {
    pango_font_face_describe($!pff);
  }

  method get_face_name is also<get-face-name> {
    pango_font_face_get_face_name($!pff);
  }

  method is_synthesized is also<is-synthesized> {
    pango_font_face_is_synthesized($!pff);
  }

  method list_sizes (Int() $sizes, Int() $n_sizes) is also<list-sizes> {
    my gint ($s, $ns) = ($sizes, $n_sizes);

    pango_font_face_list_sizes($!pff, $s, $ns);
  }
}
