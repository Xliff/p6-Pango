use v6.c;

use NativeCall;

use Pango::Compat::GList;
use Pango::Compat::Types;
use Pango::Raw::Types;
use Pango::Raw::Context;

use Pango::Roles::References;
use Pango::Roles::Types;

use Pango::Metrics;

class Pango::Context {
  also does Pango::Roles::References;
  also does Pango::Roles::Types;

  has PangoContext $!pc;

  submethod BUILD (:$context) {
    $!pc = $context;
    $!ref = $!pc.p;
  }
  submethod DESTROY {
    self.downref;
  }

  method Pango::Raw::Types::PangoContext {
    $!pc;
  }
  method context {
    $!pc;
  }

  multi method new (PangoContext $context) {
    my $o = self.bless(:$context);
    $o.upref;
    $o;
  }
  multi method new {
    my $context = pango_context_new();
    self.bless(:$context);
  }

  method base_dir is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoDirection( pango_context_get_base_dir($!pc) );
      },
      STORE => sub ($, Int() $direction is copy) {
        my guint $d = self.RESOLVE-UINT($direction);
        pango_context_set_base_dir($!pc, $d);
      }
    );
  }

  method base_gravity is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoGravity( pango_context_get_base_gravity($!pc) );
      },
      STORE => sub ($, Int() $gravity is copy) {
        my guint $g = self.RESOLVE-UINT($gravity);
        pango_context_set_base_gravity($!pc, $g);
      }
    );
  }

  method font_description is rw {
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

  method font_map is rw {
    Proxy.new(
      FETCH => sub ($) {
        Pango::FontMap.new( pango_context_get_font_map($!pc) );
      },
      STORE => sub ($, PangoFontMap() $font_map is copy) {
        pango_context_set_font_map($!pc, $font_map);
      }
    );
  }

  method gravity_hint is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoGravityHint( pango_context_get_gravity_hint($!pc) );
      },
      STORE => sub ($, Int() $hint is copy) {
        my guint $h = self.RESOLVE-UINT($hint);
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

  method get_gravity {
    PangoGravity( pango_context_get_gravity($!pc) );
  }

  method get_metrics (
    PangoFontDescription() $desc,
    Int() $language = self.language
  ) {
    my uint32 $l = self.RESOLVE-UINT($language);
    Pango::FontMetrics.new( pango_context_get_metrics($!pc, $desc, $l) );
  }

  method get_serial {
    pango_context_get_serial($!pc);
  }

  method get_type {
    pango_context_get_type();
  }

  multi method list_families {
    my $f = CArray[CArray[Pointer[PangoFontFamily]]].new;
    my $nf = 0;
    my @families;

    samewith($f, $nf);
    @families.push: Pango::FontFamily.new( $f[0][$_].deref ) for ^$nf;
    @families;
  }
  multi method list_families (
    CArray[CArray[Pointer[PangoFontFamily]]] $families,
    Int $n_families is rw
  ) {
    my gint $nf = self.RESOLVE-INT($n_families);
    pango_context_list_families($!pc, $families, $nf);
    $n_families = $nf;
  }

  method load_font (PangoFontDescription $desc) {
    Pango::Font.new( pango_context_load_font($!pc, $desc) );
  }

  method load_fontset (PangoFontDescription $desc, PangoLanguage $language) {
    Pango::Fontset.new( pango_context_load_fontset($!pc, $desc, $language) );
  }

  # Also destined for a catchall class or package.
  method pango_itemize (
    Str $text,
    Int() $start_index,
    Int() $length,
    PangoAttrList $attrs,
    PangoAttrIterator $cached_iter
  ) {
    my @i = ($start_index, $length);
    my gint ($si, $l) = self.RESOLVE-INT(@i);
    GList.new(
      PangoItem,
      pango_itemize($!pc, $text, $si, $l, $attrs, $cached_iter)
    );
  }

  # Also destined for a catchall class or package.
  method pango_itemize_with_base_dir (
    Int() $base_dir,              # PangoDirection $base_dir,
    Str $text,
    Int() $start_index,
    Int() $length,
    PangoAttrList $attrs,
    PangoAttrIterator $cached_iter
  ) {
    my guint $bd = self.RESOLVE-UINT($base_dir);
    my @i = ($start_index, $length);
    my gint ($si, $l) = self.RESOLVE-INT(@i);
    GList.new(
      PangoItem,
      pango_itemize_with_base_dir(
        $!pc, $bd, $text, $si, $l, $attrs, $cached_iter
      )
    );
  }

}
