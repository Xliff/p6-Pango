use v6.c;

use Method::Also;
use NativeCall;

use Pango::Compat::Types;
use Pango::Raw::Layout;
use Pango::Raw::Types;

class Pango::LayoutLine {
  has PangoLayoutLine $!pll;

  submethod BUILD (:$line) {
    $!pll = $line;
  }

  submethod DESTROY {
    self.downref;
  }

  method new (PangoLayoutLine $line, :$ref = True) {
    my $o = self.bless(:$line);
    $o.upref if $ref;
    $o;
  }

  method Pango::Raw::Types::PangoLayoutLine {
    $!pll;
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
    my @ranges;
    my Int $n_ranges = 0;
    samewith($start_index, $end_index, @ranges, $n_ranges);
    @ranges;
  }
  multi method get_x_ranges (
    Int() $start_index,
    Int() $end_index,
    @ranges,
    Int $n_ranges is rw
  ) {
    my $ca = CArray[CArray[int32]].new;
    my @i = ($start_index, $end_index, 0);
    my int32 ($si, $ei, $nr) = self.RESOLVE-INT(@i);
    pango_layout_line_get_x_ranges($!pll, $si, $ei, $ca, $nr);
    @ranges.push($ca[0][$_]) for ^($nr * 2);
    $n_ranges = $nr;
    Nil;
  }
  
  proto method index_to_x (|)
    is also<index-to-x>
    { * }

  multi method index_to_x (Int() $index, Int() $trailing) {
    my Int $xp = 0;
    samewith($index, $trailing, $xp);
    $xp;
  }
  multi method index_to_x (Int() $index, Int() $trailing, Int $x_pos is rw) {
    my gboolean $t = self.RESOLVE-BOOL($trailing);
    my int32 ($i, $xp) = ( self.RESOLVE-INT($index), 0 );
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
    my Int ($i, $t) = (0, 0);
    my $rc = samewith($x_pos, $i, $t);
    ($i, $t, $rc);
  }
  multi method x_to_index (
    Int() $x_pos,
    Int:D $index is rw,
    Int:D $trailing is rw
  ) {
    my int32 $xp = self.RESOLVE-INT($x_pos);
    my int32 ($i, $t) = (0, 0);
    my $rc = pango_layout_line_x_to_index($!pll, $xp, $i, $t);
    ($index, $trailing) = ($i, $t);
    $rc;
  }
}
