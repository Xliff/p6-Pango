use v6.c;

use Method::Also;

use Pango::Raw::Attr;
use Pango::Raw::Types;

class Pango::Color {
  has PangoColor $!pc;

  submethod BUILD (:$color) {
    $!pc = $color;
  }

  method Pango::Raw::Structs::PangoColor
    is also<PangoColor>
  { $!pc }

  ### ATTRIBUTES FOR RGB ###
  method r is also<red> is rw {
    Proxy.new(
      FETCH => sub ($) {
        $!pc.red
      },
      STORE => -> $, Int() $val {
        my guint16 $v = $val;

        $!pc.red = $val;
      }
    );
  }

  method g is also<green> is rw {
    Proxy.new(
      FETCH => sub ($) {
        $!pc.green
      },
      STORE => -> $, Int() $val {
        my guint16 $v = $val;

        $!pc.green = $val;
      }
    );
  }

  method b is also<blue> is rw {
    Proxy.new(
      FETCH => sub ($) {
        $!pc.blue
      },
      STORE => -> $, Int() $val {
        my guint16 $v = $val;

        $!pc.blue = $val;
      }
    );
  }

  multi method new (PangoColor $color) {
    $color ?? self.bless( :$color ) !! Nil;
  }
  multi method new {
    my $color = PangoColor.new();

    $color ?? self.bless( :$color ) !! Nil;
  }

  method copy {
    my $color = pango_color_copy($!pc);

    $color ?? self.bless( :$color ) !! Nil;
  }

  method free {
    pango_color_free($!pc);
  }

  method parse (Str() $spec) {
    pango_color_parse($!pc, $spec);
  }

  method to_string is also<to-string> {
    pango_color_to_string($!pc);
  }
}
