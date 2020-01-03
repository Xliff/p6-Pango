use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;
use Pango::Raw::DescriptionMetrics;

class Pango::FontFamily {
  has PangoFontFamily $!pff;

  submethod BUILD (:$face) {
    $!pff = $face;
  }

  method new (PangoFontFamily $face) {
    $face ?? self.bless(:$face) !! Nil;
  }

  method get_name is also<get-name> {
    pango_font_family_get_name($!pff);
  }

  method is_monospace is also<is-monospace> {
    pango_font_family_is_monospace($!pff);
  }

  proto method list_faces (|)
  { * }

  multi method list_faces {
    samewith($, $);
  }
  multi method list_faces (
    CArray[CArray[CArray[PangoFontFace]]] $faces,
    $n_faces is rw
  )
    is also<list-faces>
  {
    my gint $nf = 0

    pango_font_family_list_faces($!pff, $faces, $nf);
    $n_faces = $nf;
    $faces;
  }

}
