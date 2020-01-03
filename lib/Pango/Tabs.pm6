use v6.c;

use Method::Also;
use NativeCall;


use Pango::Raw::Tabs;
use Pango::Raw::Types;

use Pango::Roles::Types;

class Pango::Tabs {
  also does Pango::Roles::Types;

  has PangoTabArray $!pta;

  submethod BUILD (:$tabs) {
    $!pta = $tabs;
  }

  method Pango::Raw::Types::PangoTabArray is also<TabArray> { $!pta }

  multi method new (PangoTabArray $tabs) {
    self.bless(:$tabs);
  }
  multi method new (Int() $initial_size, Int() $positions_in_pixels) {
    my gint $is = self.RESOLVE-INT($initial_size);
    my guint $pip = self.RESOLVE-BOOL($positions_in_pixels);
    my $tabs = pango_tab_array_new($is, $pip);
    self.bless(:$tabs);
  }
  multi method new (Int() $positions_in_pixels, @l) {
    my guint $pip = self.RESOLVE-BOOL($positions_in_pixels);
    die '<locations> must be a list of Integers' unless @l.all ~~ Int;
    my $o = samewith(@l.elems, $pip);
    $o.set_tabs(@l);
    $o;
  }

  method copy {
    my $tabs = pango_tab_array_copy($!pta);
    self.bless(:$tabs);
  }

  method free {
    pango_tab_array_free($!pta);
  }

  method get_positions_in_pixels is also<get-positions-in-pixels> {
    pango_tab_array_get_positions_in_pixels($!pta);
  }

  method get_size is also<get-size> {
    pango_tab_array_get_size($!pta);
  }

  proto method get_tab (|)
    is also<get-tab>
    { * }
    
  multi method get_tab ( Int() $tab_index ) {
    my ($a, $l);
    samewith($tab_index, $a, $l);
  }
  multi method get_tab (
    Int() $tab_index,
    Int() $alignment is rw,           # PangoTabAlign $alignment,
    Int() $location
  ) {
    my gint ($ti, $l) = ( self.RESOLVE-INT($tab_index), 0 );
    my guint32 $a = 0;
    pango_tab_array_get_tab($!pta, $tab_index, $a, $l);
    ($alignment, $location) = ($a, $l);
  }
  
  proto method get_tabs
    is also<get-tabs>
    { * }
    
  multi method get_tabs {
    my (@a, @l);
    samewith(@a, @l);
    my @c = do for @a Z @l -> ($a, $l) {
      $a => $l;
    }
    @c;
  }
  multi method get_tabs (@alignments, @locations) {
    my $a = CArray[uint32].new;
    my $l = CArray[gint].new;
    pango_tab_array_get_tabs($!pta, $a, $l);
    my $size = self.get_size;
    @alignments.push($a[$_]) for ^$size;
    @locations.push($l[$_])  for ^$size;
  }

  method get_type is also<get-type> {
    pango_tab_array_get_type();
  }

  method resize (Int() $new_size) {
    my gint $ns = self.RESOLVE-INT($new_size);
    pango_tab_array_resize($!pta, $ns);
  }

  proto method set_tab (|)
    is also<set-tab>
    { * }
  # Interface WOULD be the following:
  # method set_tab (
  #   Int() $tab_index,
  #   Int() $alignment,
  #   Int() $location
  # )
  #... but current implementation forces $alignment to always be
  # PANGO_TAB_LEFT, hence we have the following sub definitions:
  multi method set_tab (
    Int() $tab_index,
    Int() $location
  ) {
    my @i = ($tab_index, $location);
    my gint ($t, $l) = self.RESOLVE-INT(@i);
    #my guint $a = self.RESOLVE-UINT($alignment);
    my guint $a = self.RESOLVE-UINT(PANGO_TAB_LEFT.Int);
    pango_tab_array_set_tab($!pta, $t, $a, $l);
  }

  # multi method set_tabs (@al) {
  #   samewith( roundrobin( @al.map({ $_.key, $_.value }) ) );
  # }

  #multi
  multi method set_tabs (@l) {
    # die '<alignments> and <locations> must be the same size'
    #   unless +@a == +@l;
    # die '<alignment> must consist of Integer-compatible elements'
    #   unless @a.all ~~ Int;
    die '<locations> must consist of Integer elements'
      unless @l.all ~~ Int;

    my $ti = 0;
    #for @a Z @l -> $a, $l {
    for @l -> $l {
      # self.set_tab($ti++, $a, $l);
      self.set_tab($ti++, $l);
    }
  }

}
