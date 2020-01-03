use v6.c;

use Method::Also;


use Pango::Raw::Attr;
use Pango::Raw::Types;

use Pango::Roles::Types;

class Pango::Color {
  also does Pango::Roles::Types;

  has PangoColor $!pc;

  submethod BUILD (:$color) {
    $!pc = $color;
  }

  method Pango::Raw::Types::PangoColor {
    $!pc;
  }

  ### ATTRIBUTES FOR RGB ###
  method r is also<red> is rw {
    Proxy.new(
      FETCH => -> $ {
        $!pc.red
      },
      STORE => -> $, Int() $val {
        my guint16 $v = self.RESOLVE-UINT16($val);
        $!pc.red = $val;
      }
    );
  }

  method g is also<green> is rw {
    Proxy.new(
      FETCH => -> $ {
        $!pc.green
      },
      STORE => -> $, Int() $val {
        my guint16 $v = self.RESOLVE-UINT16($val);
        $!pc.green = $val;
      }
    );
  }

  method b is also<blue> is rw {
    Proxy.new(
      FETCH => -> $ {
        $!pc.blue
      },
      STORE => -> $, Int() $val {
        my guint16 $v = self.RESOLVE-UINT16($val);
        $!pc.blue = $val;
      }
    );
  }

  multi method new (PangoColor $color) {
    self.bless($color);
  }
  multi method new {
    self.bless( color => PangoColor.new );
  }

  method copy {
    Pango::Color.new( pango_color_copy($!pc) );
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
