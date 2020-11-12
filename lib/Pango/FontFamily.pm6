use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;
use Pango::Raw::DescriptionMetrics;

use Pango::FontFace;

class Pango::FontFamily {
  has PangoFontFamily $!pff;

  submethod BUILD (:$face) {
    $!pff = $face;
  }

  method Pango::Raw::Definitions::PangoFontFamily
    is also<PangoFontFamily>
  { $!pff }

  method new (PangoFontFamily $face, :$ref = True) {
    return Nil unless $face;

    my $o = self.bless( :$face );
    $o.ref if $ref;
    $o;
  }

  method get_name
    is also<
      get-name
      name
    >
  {
    pango_font_family_get_name($!pff);
  }

  method is_monospace is also<is-monospace> {
    pango_font_family_is_monospace($!pff);
  }

  proto method list_faces (|)
    is also<list-faces>
  { * }

  multi method list_faces (:$raw = False) {
    samewith($, $, :$raw);
  }
  multi method list_faces (
    CArray[CArray[CArray[PangoFontFace]]] $faces,
                                          $n_faces is rw,
                                          :$raw    =  False
  ) {
    my gint $nf = 0;

    pango_font_family_list_faces($!pff, $faces, $nf);
    $n_faces = $nf;

    my @faces = CArrayToArray(PangoFontFace, $faces[0], $n_faces);
    # cw: an unpleasant performance hit!
    @faces.map({ Pango::FontFace.new($_) }) unless $raw;
    @faces;
  }

}
