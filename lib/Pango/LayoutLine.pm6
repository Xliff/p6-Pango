use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Layout;
use Pango::Raw::Types;

class Pango::LayoutLine {
  has PangoLayoutLine $!pll is implementor;

  submethod BUILD (:$line) {
    $!pll = $line;
  }

  submethod DESTROY {
    self.downref;
  }

  method Pango::Raw::Definitions::PangoLayoutLine
    is also<PangoLayoutLine>
  { $!pll }

  method new (PangoLayoutLine $line, :$ref = True) {
    my $o = self.bless(:$line);
    $o.upref if $ref;
    $o;
  }

  method get_extents (
    PangoRectangle() $ink_rect,
    PangoRectangle() $logical_rect
  )
    is also<get-extents>
  {
    pango_layout_line_get_extents($!, $ink_rect, $logical_rect);
  }

  method get_pixel_extents (
    PangoRectangle() $ink_rect,
    PangoRectangle() $logical_rect
  )
    is also<get-pixel-extents>
  {
    pango_layout_line_get_pixel_extents($!pll, $ink_rect, $logical_rect);
  }

  proto method get_x_ranges (|)
    is also<get-x-ranges>
    { * }

  multi method get_x_ranges(Int() $start_index, Int() $end_index) {
    samewith($start_index, $end_index, @, $);
  }
  multi method get_x_ranges (
    Int() $start_index,
    Int() $end_index,
          @ranges,
          $n_ranges     is rw
  ) {
    my        $ca            = newCArray( CArray[int32] );
    my int32 ($si, $ei, $nr) = ($start_index, $end_index, 0);

    pango_layout_line_get_x_ranges($!pll, $si, $ei, $ca, $nr);
    $n_ranges = $nr;
    @ranges   = CArrayToArray($ca[0], $nr * 2);
  }

  proto method index_to_x (|)
    is also<index-to-x>
    { * }

  multi method index_to_x (Int() $index, Int() $trailing) {
    my Int $xp = 0;
    samewith($index, $trailing, $xp);
    $xp;
  }
  multi method index_to_x (Int() $index, Int() $trailing, $x_pos is rw) {
    my gboolean  $t        = $trailing.so.Int;
    my int32    ($i,  $xp) = ($index, 0 );

    my $rc = pango_layout_line_index_to_x($!pll, $i, $t, $xp);
    $x_pos = $xp;
    $rc;
  }

  method upref {
    pango_layout_line_ref($!pll);
  }

  method downref {
    pango_layout_line_unref($!pll);
  }

  proto method x_to_index (|)
    is also<x-to-index>
  { * }

  multi method x_to_index (Int() $x_pos) {
    samewith($x_pos, $, $, :all);
  }
  multi method x_to_index (
    Int()  $x_pos,
           $index    is rw,
           $trailing is rw,
          :$all              = False
  ) {
    my int32 ($xp, $i, $t) = ($x_pos, 0, 0);

    my $rc = pango_layout_line_x_to_index($!pll, $xp, $i, $t);
    ($index, $trailing) = ($i, $t);
    return $rc unless $all;
    $rc ?? ($index, $trailing) !! Nil;
  }
}
