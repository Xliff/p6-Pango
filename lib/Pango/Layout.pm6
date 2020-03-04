use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;
use Pango::Raw::Layout;

use Pango::Context;
use Pango::FontDescription;
use Pango::LayoutIter;
use Pango::LayoutLine;

use GLib::Roles::Object;

class Pango::Layout {
  also does GLib::Roles::Object;

  has PangoLayout $!pl is implementor;

  submethod BUILD(:$layout) {
    $!pl = $layout;

    self.roleInit-Object;
  }

  method Pango::Raw::Definitions::PangoLayout
    is also<
      PangoLayout
      layout
    >
  { $!pl; }

  proto method new(|)
  { * }

  multi method new (PangoLayout $layout, :$ref = True) {
    return Nil unless $layout;

    my $o = self.bless(:$layout);
    $o.ref if $ref;
    $o;
  }
  multi method new ($context is copy) {
    my $compatible = $context ~~ (Pango::Context, PangoContext).any;
    my $coercible  = $context.^can('PangoContext').elems;

    die qq:to/DIE/ unless $compatible || $coercible;
      \$context must be PangoContext-compatible value. A {
      $context.^name } does not appear to be so.
      DIE

    $context .= PangoContext if $coercible;

    my $layout = pango_layout_new($context);

    $layout ?? self.bless(:$layout) !! Nil;
  }
  multi method new (Mu $p) {
    die "Cannot create Pango::Layout from { $p.^name }";
  }
  multi method new {
    die 'Must pass a parameter to Pango::Layout.new';
  }

  method copy {
    my $layout = pango_layout_copy($!pl);

    $layout ?? Pango::Layout.new($layout, :!ref) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method alignment is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoAlignmentEnum( pango_layout_get_alignment($!pl) );
      },
      STORE => sub ($, Int() $alignment is copy) {
        my guint $a = $alignment;

        pango_layout_set_alignment($!pl, $a);
      }
    );
  }

  method attributes is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_attributes($!pl);
      },
      STORE => sub ($, PangoAttrList() $attrs is copy) {
        pango_layout_set_attributes($!pl, $attrs);
      }
    );
  }

  method auto_dir is rw is also<auto-dir> {
    Proxy.new(
      FETCH => sub ($) {
        so pango_layout_get_auto_dir($!pl);
      },
      STORE => sub ($, Int() $auto_dir is copy) {
        my gboolean $ad = $auto_dir.so.Int;

        pango_layout_set_auto_dir($!pl, $ad);
      }
    );
  }

  method ellipsize is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoEllipsizeModeEnum( pango_layout_get_ellipsize($!pl) );
      },
      STORE => sub ($, Int() $ellipsize is copy) {
        my guint $e = $ellipsize;

        pango_layout_set_ellipsize($!pl, $e);
      }
    );
  }

  method font_description is rw
    is also<
      font-description
      font_desc
      font-desc
    >
  {
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
        my gint $h = $height;

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
        my gint $i = $indent;

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
        my gboolean $j = $justify.so.Int;

        pango_layout_set_justify($!pl, $j);
      }
    );
  }

  method single_paragraph_mode is rw is also<single-paragraph-mode> {
    Proxy.new(
      FETCH => sub ($) {
        so pango_layout_get_single_paragraph_mode($!pl);
      },
      STORE => sub ($, $setting is copy) {
        my gboolean $s = $setting.so.Int;

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
        my gint $s = $spacing;
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
        my gint $w = $width;
        pango_layout_set_width($!pl, $w);
      }
    );
  }

  method wrap is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoWrapModeEnum( pango_layout_get_wrap($!pl) );
      },
      STORE => sub ($, Int() $wrap is copy) {
        my uint32 $w = $wrap;
        pango_layout_set_wrap($!pl, $w);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method context_changed is also<context-changed> {
    pango_layout_context_changed($!pl);
  }

  method get_character_count is also<get-character-count> {
    pango_layout_get_character_count($!pl);
  }

  method get_context is also<get-context> {
    pango_layout_get_context($!pl);
  }

  method get_cursor_pos (
    Int() $index,
    PangoRectangle() $strong_pos,
    PangoRectangle() $weak_pos
  )
    is also<get-cursor-pos>
  {
    my gint $i = $index;

    pango_layout_get_cursor_pos($!pl, $i, $strong_pos, $weak_pos);
  }

  proto method get_extents (|)
    is also<get-extents>
  { * }

  multi method get_extents is also<extents> {
    my ($ir, $lr) = PangoRectangle.new xx 2;
    samewith($ir, $lr);
  }
  multi method get_extents (
    PangoRectangle() $ink_rect,
    PangoRectangle() $logical_rect
  ) {
    pango_layout_get_extents($!pl, $ink_rect, $logical_rect);
    ($ink_rect, $logical_rect);
  }

  method get_iter (:$raw = False) is also<get-iter> {
    my $i = pango_layout_get_iter($!pl);

    $i ??
      ( $raw ?? $i !! Pango::LayoutIter.new($i) )
      !!
      Nil;
  }

  method get_line_count is also<get-line-count> {
    pango_layout_get_line_count($!pl);
  }

  method get_line (Int() $line, :$raw = False) is also<get-line> {
    my $l = $line;
    my $pll = pango_layout_get_line($!pl, $l);

    $pll ??
      ( $raw ?? $pll !! Pango::LayoutLine.new($pll, :!ref ) )
      !!
      Nil;
  }

  method get_line_readonly(Int() $line, :$raw = False)
    is also<get-line-readonly>
  {
    my $l = $line;
    my $pll = pango_layout_get_line_readonly($!pl, $l);

    $pll ??
      ( $raw ?? $pll !! Pango::LayoutLine.new($pll, :!ref ) )
      !!
      Nil;
  }

  method get_lines is also<get-lines> {
    pango_layout_get_lines($!pl);
  }

  method get_lines_readonly is also<get-lines-readonly> {
    pango_layout_get_lines_readonly($!pl);
  }

  method get_log_attrs (PangoLogAttr $attrs, Int() $n_attrs)
    is also<get-log-attrs>
  {
    my gint $na = $n_attrs;

    pango_layout_get_log_attrs($!pl, $attrs, $na);
  }

  method get_log_attrs_readonly (Int() $n_attrs)
    is also<get-log-attrs-readonly>
  {
    my gint $na = $n_attrs;

    pango_layout_get_log_attrs_readonly($!pl, $na);
  }

  proto method get_pixel_extents (|)
    is also<get-pixel-extents>
  { * }

  multi method get_pixel_extents
    is also<
      pixel_extents
      pixel-extents
    >
  {
    my ($ir, $lr) = PangoRectangle.new xx 2;
    samewith($ir, $lr);
  }
  multi method get_pixel_extents (
    PangoRectangle() $ink_rect,
    PangoRectangle() $logical_rect
  ) {
    pango_layout_get_pixel_extents($!pl, $ink_rect, $logical_rect);
    ($ink_rect, $logical_rect);
  }

  proto method get_pixel_size (|)
    is also<get-pixel-size>
  { * }

  multi method get_pixel_size {
    samewith($, $);
  }

  multi method get_pixel_size ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    pango_layout_get_pixel_size($!pl, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_serial is also<get-serial> {
    pango_layout_get_serial($!pl);
  }

  proto method get_size (|)
    is also<get-size>
  { * }

  multi method get_size {
    samewith($, $);
  }
  multi method get_size ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    pango_layout_get_size($!pl, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_text is also<get-text> {
    pango_layout_get_text($!pl);
  }

  method get_unknown_glyphs_count is also<get-unknown-glyphs-count> {
    pango_layout_get_unknown_glyphs_count($!pl);
  }

  method index_to_line_x (
    Int() $index,
    Int() $trailing,
    Int() $line,
    Int() $x_pos
  )
    is also<index-to-line-x>
  {
    my gboolean $t = $trailing.Int.so;
    my ($ii, $ll, $xp) = ($index, $line, $x_pos);

    pango_layout_index_to_line_x($!pl, $ii, $t, $ll, $xp);
  }

  method index_to_pos (Int() $index, PangoRectangle $pos)
    is also<index-to-pos>
  {
    my gint $i = $index;

    pango_layout_index_to_pos($!pl, $i, $pos);
  }

  method is_ellipsized is also<is-ellipsized> {
    pango_layout_is_ellipsized($!pl);
  }

  method is_wrapped is also<is-wrapped> {
    pango_layout_is_wrapped($!pl);
  }

  method move_cursor_visually (
    Int() $strong,
    Int() $old_index,
    Int() $old_trailing,
    Int() $direction,
    Int() $new_index,
    Int() $new_trailing
  )
    is also<move-cursor-visually>
  {
    my gboolean $s = $strong.Int.so;
    my int32 ($oi, $ot, $d, $ni, $nt) =
      ($old_index, $old_trailing, $direction, $new_index, $new_trailing);

    pango_layout_move_cursor_visually($!pl, $s, $oi, $ot, $d, $ni, $nt);
  }

  proto method set_markup (|)
    is also<set-markup>
  { * }

  multi method set_markup (Str() $markup) {
    samewith($markup, -1);
  }
  multi method set_markup (Str() $markup, Int() $length) {
    my int32 $l = $length // -1;

    pango_layout_set_markup($!pl, $markup, $l);
  }

  method set_markup_with_accel (
    Str() $markup,
    Int() $length,
    Int() $accel_marker,
    Int() $accel_char
  )
    is also<set-markup-with-accel>
  {
    my int32 $l = $length;
    my gunichar ($am, $ac) = ($accel_marker, $accel_char);

    pango_layout_set_markup_with_accel($!pl, $markup, $l, $am, $ac);
  }

  method set_text (Str() $text, Int() $length = $text.chars)
    is also<set-text>
  {
    my int32 $l = $length;

    pango_layout_set_text($!pl, $text, $length);
  }

  method xy_to_index (
    Int() $x,
    Int() $y,
    Int() $index,
    Int() $trailing
  )
    is also<xy-to-index>
  {
    my int32 ($xx, $yy, $i, $t) = ($x, $y, $index, $trailing);

    pango_layout_xy_to_index($!pl, $xx, $yy, $i, $t);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
