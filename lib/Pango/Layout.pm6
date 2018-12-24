use v6.c;

use NativeCall;

use Pango::Compat::Types;

use Pango::Raw::Types;
use Pango::Raw::Layout;

use Pango::Roles::Types;
use Pango::Roles::References;

use Pango::FontDescription;
use Pango::LayoutIter;

class Pango::Layout {
  also does Pango::Roles::References;
  also does Pango::Roles::Types;

  has PangoLayout $!pl;

  submethod BUILD(:$layout) {
    $!pl = $layout;
    $!ref = $!pl.p;
  }

  method Pango::Raw::Types::PangoLayout {
    $!pl;
  }
  method layout {
    $!pl;
  }

  multi method new (PangoLayout $layout) {
    my $o = self.bless(:$layout);
    $o.upref;
    $o;
  }
  multi method new (PangoContext() $context) {
    my $layout = pango_layout_new($context);
    self.bless(:$layout);
  }

  method copy {
    my $layout = pango_layout_copy($!pl);
    self.bless(:$layout);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method alignment is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoAlignment( pango_layout_get_alignment($!pl) );
      },
      STORE => sub ($, Int() $alignment is copy) {
        my guint $a = self.RESOLVE-UINT($alignment);
        pango_layout_set_alignment($!pl, $a);
      }
    );
  }

  method attributes is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_attributes($!pl);
      },
      STORE => sub ($, PangoAttrList $attrs is copy) {
        pango_layout_set_attributes($!pl, $attrs);
      }
    );
  }

  method auto_dir is rw {
    Proxy.new(
      FETCH => sub ($) {
        so pango_layout_get_auto_dir($!pl);
      },
      STORE => sub ($, Int() $auto_dir is copy) {
        my gboolean $ad = self.RESOLVE-BOOL($auto_dir);
        pango_layout_set_auto_dir($!pl, $ad);
      }
    );
  }

  method ellipsize is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoEllipsizeMode( pango_layout_get_ellipsize($!pl) );
      },
      STORE => sub ($, Int() $ellipsize is copy) {
        my guint $e = self.RESOLVE-UINT($ellipsize);
        pango_layout_set_ellipsize($!pl, $e);
      }
    );
  }

  method font_description is rw {
    Proxy.new(
      FETCH => sub ($) {
        Pango::FontDescription.new( pango_layout_get_font_description($!pl) );
      },
      STORE => sub ($, PangoFontDescription() $desc is copy) {
        pango_layout_set_font_description($!pl, $desc);
      }
    );
  }

  method height is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_height($!pl);
      },
      STORE => sub ($, Int() $height is copy) {
        my gint $h = self.RESOLVE-INT($height);
        pango_layout_set_height($!pl, $h);
      }
    );
  }

  method indent is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_indent($!pl);
      },
      STORE => sub ($, Int() $indent is copy) {
        my gint $i = self.RESOLVE-INT($indent);
        pango_layout_set_indent($!pl, $i);
      }
    );
  }

  method justify is rw {
    Proxy.new(
      FETCH => sub ($) {
        so pango_layout_get_justify($!pl);
      },
      STORE => sub ($, Int() $justify is copy) {
        my gboolean $j = self.RESOLVE-BOOL($justify);
        pango_layout_set_justify($!pl, $j);
      }
    );
  }

  method single_paragraph_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        so pango_layout_get_single_paragraph_mode($!pl);
      },
      STORE => sub ($, $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        pango_layout_set_single_paragraph_mode($!pl, $s);
      }
    );
  }

  method spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_spacing($!pl);
      },
      STORE => sub ($, Int() $spacing is copy) {
        my gint $s = self.RESOLVE-INT($spacing);
        pango_layout_set_spacing($!pl, $s);
      }
    );
  }

  method tabs is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_tabs($!pl);
      },
      STORE => sub ($, $tabs is copy) {
        my $t = do given $tabs {
          when PangoTabArray { $_ }
          when Array {
            unless .all ~~ Int {
               proceed unless .grep( *.^can('Int').elems );
            }
            CArray[gint].new( .map( *.Int ) );
          }
          default {
            die q:to/D/.chomp;
Array assigned to PangoLayout.tabs must consist of integer compatible
elements!
D
          }
        }
        pango_layout_set_tabs($!pl, $t);
      }
    );
  }

  method text is rw {
    Proxy.new:
      FETCH => -> $              { self.get_text },
      STORE => -> $, Str() $text { self.set_text($text) }
  }

  method width is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_width($!pl);
      },
      STORE => sub ($, Int() $width is copy) {
        my gint $w = self.RESOLVE-INT($width);
        pango_layout_set_width($!pl, $w);
      }
    );
  }

  method wrap is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoWrapMode( pango_layout_get_wrap($!pl) );
      },
      STORE => sub ($, Int() $wrap is copy) {
        my uint32 $w = self.RESOLVE-UINT($wrap);
        pango_layout_set_wrap($!pl, $w);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method context_changed {
    pango_layout_context_changed($!pl);
  }

  method get_character_count {
    pango_layout_get_character_count($!pl);
  }

  method get_context {
    pango_layout_get_context($!pl);
  }

  method get_cursor_pos (
    Int() $index,
    PangoRectangle $strong_pos,
    PangoRectangle $weak_pos
  ) {
    my gint $i = self.RESOLVE-INT($index);
    pango_layout_get_cursor_pos($!pl, $i, $strong_pos, $weak_pos);
  }

  method get_iter {
    Pango::LayoutIter.new( pango_layout_get_iter($!pl) );
  }

  method get_line_count {
    pango_layout_get_line_count($!pl);
  }

  method get_line (Int() $line) {
    my $l = self.RESOLVE-INT($line);
    pango_layout_get_line($!pl, $l);
  }

  method get_line_readonly(Int() $line) {
    my $l = self.RESOLVE-INT($line);
    pango_layout_get_line_readonly($!pl, $l);
  }

  method get_lines {
    pango_layout_get_lines($!pl);
  }

  method get_lines_readonly {
    pango_layout_get_lines_readonly($!pl);
  }

  method get_log_attrs (PangoLogAttr $attrs, Int() $n_attrs) {
    my gint $na = self.RESOLVE-INT($n_attrs);
    pango_layout_get_log_attrs($!pl, $attrs, $na);
  }

  method get_log_attrs_readonly (Int() $n_attrs) {
    my gint $na = self.RESOLVE-INT($n_attrs);
    pango_layout_get_log_attrs_readonly($!pl, $na);
  }

  multi method get_pixel_size {
    my ($w, $h) = (0 xx 2);
    samewith($w, $h);
  }
  multi method get_pixel_size (Int() $width is rw, Int() $height is rw) {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    pango_layout_get_pixel_size($!pl, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_serial {
    pango_layout_get_serial($!pl);
  }

  multi method get_size {
    my ($w, $h) = (0 xx 2);
    samewith($w, $h);
  }
  multi method get_size (Int() $width is rw, Int() $height is rw) {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    pango_layout_get_size($!pl, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_text {
    pango_layout_get_text($!pl);
  }

  method get_unknown_glyphs_count {
    pango_layout_get_unknown_glyphs_count($!pl);
  }

  method index_to_line_x (
    Int() $index,
    Int() $trailing,
    Int() $line,
    Int() $x_pos
  ) {
    my gboolean $t = self.RESOLVE-BOOL($trailing);
    my @i = ($index, $line, $x_pos);
    my ($ii, $ll, $xp) = self.RESOLVE-INT(@i);
    pango_layout_index_to_line_x($!pl, $ii, $t, $ll, $xp);
  }

  method index_to_pos (Int() $index, PangoRectangle $pos) {
    my gint $i = self.RESOLVE-INT($index);
    pango_layout_index_to_pos($!pl, $i, $pos);
  }

  method is_ellipsized {
    pango_layout_is_ellipsized($!pl);
  }

  method is_wrapped {
    pango_layout_is_wrapped($!pl);
  }

  method move_cursor_visually (
    Int() $strong,
    Int() $old_index,
    Int() $old_trailing,
    Int() $direction,
    Int() $new_index,
    Int() $new_trailing
  ) {
    my gboolean $s = self.RESOLVE-BOOL($strong);
    my @i = ($old_index, $old_trailing, $direction, $new_index, $new_trailing);
    my int32 ($oi, $ot, $d, $ni, $nt) = self.RESOLVE-INT(@i);
    pango_layout_move_cursor_visually($!pl, $s, $oi, $ot, $d, $ni, $nt);
  }

  multi method set_markup (Str() $markup) {
    samewith($markup, -1);
  }
  multi method set_markup (Str() $markup, Int() $length) {
    $length = -1 without $length;
    my int32 $l = self.RESOLVE-INT($length);
    pango_layout_set_markup($!pl, $markup, $l);
  }

  method set_markup_with_accel (
    Str() $markup,
    Int() $length,
    Int() $accel_marker,
    Int() $accel_char
  ) {
    my int32 $l = self.RESOLVE-INT($length);
    my @u = ($accel_marker, $accel_char);
    my gunichar ($am, $ac) = self.RESOLVE-UINT(@u);
    pango_layout_set_markup_with_accel($!pl, $markup, $l, $am, $ac);
  }

  method set_text (Str() $text, Int() $length = $text.chars) {
    my int32 $l = self.RESOLVE-INT($length);
    pango_layout_set_text($!pl, $text, $length);
  }

  method xy_to_index (
    Int() $x,
    Int() $y,
    Int() $index,
    Int() $trailing
  ) {
    my @i = ($x, $y, $index, $trailing);
    my int32 ($xx, $yy, $i, $t) = self.RESOLVE-INT(@i);
    pango_layout_xy_to_index($!pl, $xx, $yy, $i, $t);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
