use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Types;
use Pango::Raw::DescriptionMetrics;

use Pango::Roles::Types;

class Pango::FontFace {
  also does Panto::Roles::Types;

  has PangoFontFace $!pff;

  submethod BUILD (:$face) {
    $!pff = $face;
  }

  method describe {
    pango_font_face_describe($!pfd);
  }

  method get_face_name {
    pango_font_face_get_face_name($!pfd);
  }

  method is_synthesized {
    pango_font_face_is_synthesized($!pfd);
  }

  method list_sizes (Int() $sizes, Int() $n_sizes) {
    my @i = ($sizes, $n_sizes);
    my gint ($s, $ns) = self.RESOLVE-INT(@i);
    pango_font_face_list_sizes($!pfd, $s, $ns);
  }
}
