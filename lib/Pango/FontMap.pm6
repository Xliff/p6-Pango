use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;
use Pango::Raw::FontMap;

use Pango::Context;

use GLib::Roles::Object;
use GIO::Roles::ListModel;

our subset PangoFontMapAncestry is export of Mu
  where PangoFontMap | GListModel | GObject;

class Pango::FontMap {
  also does GLib::Roles::Object;
  also does GIO::Roles::ListModel;

  has PangoFontMap $!fm is implementor;

  submethod BUILD ( :$pango-fontmap ) {
    self.setPangoFontMap($pango-fontmap) if $pango-fontmap;
  }

  method setPangoFontMap (PangoFontMapAncestry $_)
    is also<setFontMap>
  {
    my $to-parent;

    $!fm = do {
      when PangoFontMap {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GListModel {
        $to-parent = cast(GObject, $_);
        $!lm       = $_;
        cast(PangoFontMap, $_);
      }

      default {
        $to-parent = $_;
        cast(PangoFontMap, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GListModel;
  }

  method Pango::Raw::Definitions::PangoFontMap
    is also<
      PangoFontMap
      fontmap
    >
  { $!fm }

  multi method new (PangoFontMapAncestry $pango-fontmap, :$ref = True) {
    return Nil unless $pango-fontmap;

    my $o = self.bless( :$pango-fontmap );
    $o.ref if $ref;
    $o;
  }

  method changed {
    so pango_font_map_changed($!fm);
  }

  method create_context is also<create-context> {
    my $pc = Pango::Context.new;
    return Nil unless $pc;
    $pc.font_map = $!fm;
    $pc;
  }

  method get_serial is also<get-serial> {
    pango_font_map_get_serial($!fm);
  }

  method get_shape_engine_type
    is DEPRECATED
    is also<get-shape-engine-type>
  {
    pango_font_map_get_shape_engine_type($!fm);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &pango_font_map_get_type, $n, $t );
  }

  proto method list_families (|)
    is also<list-families>
  { * }

  multi method list_families (:$raw = False) {
    my $fl = newCArray( CArray[PangoFontFamily] );
    my $nf = 0;

    samewith($fl, $nf, :$raw);
  }
  multi method list_families (
    CArray[CArray[PangoFontFamily]] $families,
                                    $n_families is rw,
                                    :$raw              = False
  ) {
    my int32 $nf = 0;
    my       $rc = pango_font_map_list_families($!fm, $families, $nf);

    $n_families = $nf;
    my @a = CArrayToArray($rc[0], $n_families);
    return @a if $raw;

    @a.map({ Pango::FontFamily.new($_) });
  }

  method load_font (
    PangoContext()         $context,
    PangoFontDescription() $desc
  )
    is also<load-font>
  {
    pango_font_map_load_font($!fm, $context, $desc);
  }

  method load_fontset (
    PangoContext()         $context,
    PangoFontDescription() $desc,
    PangoLanguage()        $language
  )
    is also<load-fontset>
  {
    pango_font_map_load_fontset($!fm, $context, $desc, $language);
  }

}
