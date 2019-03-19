use v6.c;

use Method::Also;
use NativeCall;

use Pango::Compat::Types;
use Pango::Raw::Types;
use Pango::Raw::DescriptionMetrics;

use Pango::Roles::Types;

class Pango::FontFamily {
  also does Pango::Roles::Types;

  has PangoFontFamily $!pff;

  submethod BUILD (:$face) {
    $!pff = $face;
  }

  method get_name is also<get-name> {
    pango_font_family_get_name($!pff);
  }

  method is_monospace is also<is-monospace> {
    pango_font_family_is_monospace($!pff);
  }

  method list_faces (CArray[CArray[CArray[PangoFontFace]]] $faces, Int() $n_faces) is also<list-faces> {
    my gint $nf = self.RESOLVE-INT($n_faces);
    pango_font_family_list_faces($!pff, $faces, $nf);
  }

}

