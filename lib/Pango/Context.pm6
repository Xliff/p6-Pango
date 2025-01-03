use v6.c;

use Method::Also;
use NativeCall;

use GLib::GList;

use Pango::Raw::Types;
use Pango::Raw::Context;

use Pango::FontMetrics;

use GLib::Roles::ListData;
use GLib::Roles::Object;

class Pango::Context {
  also does GLib::Roles::Object;

  has PangoContext $!pc is implementor;

  submethod BUILD (:$context) {
    $!pc = $context;

    self.roleInit-Object;
  }
  submethod DESTROY {
    self.unref;
  }

  method Pango::Raw::Definitions::PangoContext
    is also<
      PangoContext
      context
    >
  { $!pc }

  multi method new (PangoContext $context, :$ref = True) {
    my $o = self.bless(:$context);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $context = pango_context_new();

    $context ?? self.bless(:$context) !! Nil;
  }

  method base_dir is rw is also<base-dir> {
    Proxy.new(
      FETCH => sub ($) {
        PangoDirectionEnum( pango_context_get_base_dir($!pc) );
      },
      STORE => sub ($, Int() $direction is copy) {
        my guint $d = $direction;

        pango_context_set_base_dir($!pc, $d);
      }
    );
  }

  method base_gravity is rw is also<base-gravity> {
    Proxy.new(
      FETCH => sub ($) {
        PangoGravityEnum( pango_context_get_base_gravity($!pc) );
      },
      STORE => sub ($, Int() $gravity is copy) {
        my guint $g = $gravity;

        pango_context_set_base_gravity($!pc, $g);
      }
    );
  }

  method font_description is rw is also<font-description> {
    Proxy.new(
      FETCH => sub ($) {
        Pango::FontDescription.new(
          pango_context_get_font_description($!pc);
        );
      },
      STORE => sub ($, PangoFontDescription() $desc is copy) {
        pango_context_set_font_description($!pc, $desc)
      }
    );
  }

  method font_map is rw is also<font-map> {
    Proxy.new(
      FETCH => sub ($) {
        Pango::FontMap.new( pango_context_get_font_map($!pc) );
      },
      STORE => sub ($, PangoFontMap() $font_map is copy) {
        pango_context_set_font_map($!pc, $font_map);
      }
    );
  }

  method gravity_hint is rw is also<gravity-hint> {
    Proxy.new(
      FETCH => sub ($) {
        PangoGravityHintEnum( pango_context_get_gravity_hint($!pc) );
      },
      STORE => sub ($, Int() $hint is copy) {
        my guint $h = $hint;
        pango_context_set_gravity_hint($!pc, $h);
      }
    );
  }

  method language is rw {
    Proxy.new(
      FETCH => sub ($) {
        Pango::Language.new( pango_context_get_language($!pc) );
      },
      STORE => sub ($, PangoLanguage() $language is copy) {
        pango_context_set_language($!pc, $language);
      }
    );
  }

  method matrix is rw {
    Proxy.new(
      FETCH => sub ($) {
         Pango::Matrix.new( pango_context_get_matrix($!pc) );
      },
      STORE => sub ($, PangoMatrix() $matrix is copy) {
        pango_context_set_matrix($!pc, $matrix);
      }
    );
  }

  method changed {
    pango_context_changed($!pc);
  }

  method get_gravity is also<get-gravity> {
    PangoGravityEnum( pango_context_get_gravity($!pc) );
  }

  method get_metrics (
    PangoFontDescription() $desc,
    Int() $language = self.language,
    :$raw = False
  )
    is also<get-metrics>
  {
    my uint32 $l = $language;
    my $m = pango_context_get_metrics($!pc, $desc, $l);

    $m ??
      ( $raw ?? $m !! Pango::FontMetrics.new($m) )
      !!
      Nil;
  }

  method get_serial is also<get-serial> {
    pango_context_get_serial($!pc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &pango_context_get_type, $n, $t );
  }

  proto method list_families (|)
    is also<list-families>
  { * }

  multi method list_families (:$raw = False) {
    samewith($, $, :$raw);
  }
  multi method list_families (
    $families   is rw,
    $n_families is rw,
    :$raw = False
  ) {
    my $f = CArray[CArray[Pointer[PangoFontFamily]]].new;
    $f[0] = CArray[Pointer[PangoFontFamily]];

    my gint $nf = 0;

    pango_context_list_families($!pc, $families, $nf);
    $n_families = $nf;
    $families = $families[0] ?? CArrayToArray($families[0], $families) !! Nil;
    $families .= map({ Pango::FontFamily.new($_) }) unless $raw;
    $families
  }

  method load_font (PangoFontDescription $desc) is also<load-font> {
    Pango::Font.new( pango_context_load_font($!pc, $desc) );
  }

  method load_fontset (PangoFontDescription $desc, PangoLanguage $language)
    is also<load-fontset>
  {
    Pango::Fontset.new( pango_context_load_fontset($!pc, $desc, $language) );
  }

  # Also destined for a catchall class or package.
  method pango_itemize (
    Str $text,
    Int() $start_index,
    Int() $length,
    PangoAttrList $attrs,
    PangoAttrIterator $cached_iter,
    :$glist = False
  )
    is also<pango-itemize>
  {
    my gint ($si, $l) = ($start_index, $length);
    my $pil = pango_itemize($!pc, $text, $si, $l, $attrs, $cached_iter);

    return Nil unless $pil;
    return $pil if $glist;

    $pil = GLib::GList.new($pil) but GLib::Roles::ListData[PangoItem];

    $pil.Array;
  }

  # Also destined for a catchall class or package.
  method pango_itemize_with_base_dir (
    Int() $base_dir,              # PangoDirection $base_dir,
    Str $text,
    Int() $start_index,
    Int() $length,
    PangoAttrList $attrs,
    PangoAttrIterator $cached_iter
  )
    is also<pango-itemize-with-base-dir>
  {
    my guint $bd = $base_dir;
    my @i = ($start_index, $length);
    my gint ($si, $l) = @i;

    GList.new(
      PangoItem,
      pango_itemize_with_base_dir(
        $!pc, $bd, $text, $si, $l, $attrs, $cached_iter
      )
    );
  }

}
