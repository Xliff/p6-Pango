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

  method get_name {
    pango_font_family_get_name($!pfd);
  }

  method is_monospace {
    pango_font_family_is_monospace($!pfd);
  }

  method list_faces (PangoFontFace $faces, int $n_faces) {
    pango_font_family_list_faces($!pfd, $faces, $n_faces);
  }

}
