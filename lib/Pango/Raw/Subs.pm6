use v6.c;

use NativeCall;

use Pango::Raw::Definitions;
use Pango::Raw::Enums;
use Pango::Raw::Structs;

unit package Pango::Raw::Subs;

sub PANGO_MATRIX_INIT is export {
  PangoMatrix.new( :xx(1), :xy(0), :yx(0), :yy(1), :x0(0), :y0(0) );
}

sub       PANGO_PIXELS($d) is export { (($d.Int + 512)  +> 10) }
sub PANGO_PIXELS_FLOOR($d) is export { ($d.Int          +> 10) }
sub  PANGO_PIXELS_CEIL($d) is export { (($d.Int + 1023) +> 10) }

sub    PANGO_ASCENT(PangoRectangle $r) is export { -$r.y            }
sub   PANGO_DESCENT(PangoRectangle $r) is export { $r.y + $r.height }
sub  PANGO_LBEARING(PangoRectangle $r) is export { $r.x             }
sub  PANGO_RBEARING(PangoRectangle $r) is export { $r.x + $r.width  }

sub PANGO_GET_UNKNOWN_GLYPH(Int() $wc) is export { $wc +| PANGO_GLYPH_UNKNOWN_FLAG }

sub PANGO_GRAVITY_IS_VERTICAL(PangoGravity $g) is export {
  $g == (PANGO_GRAVITY_EAST, PANGO_GRAVITY_WEST).any
}
sub PANGO_GRAVITY_IS_IMPROPER(PangoGravity $g) is export {
  $g == (PANGO_GRAVITY_NORTH, PANGO_GRAVITY_WEST).any
}
