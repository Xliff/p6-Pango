use v6.c;

use Method::Also;
use NativeCall;


use Pango::Raw::Coverage;
use Pango::Raw::Types;

class Pango::Coverage {
  has PangoCoverage $!pc is implementor;

  submethod BUILD (:$coverage) {
    $!pc = $coverage;
  }

  submethod DESTROY {
    self.downref;
  }

  multi method new (PangoCoverage $coverage, :$ref = True) {
    my $o = self.bless(:$coverage);
    $o.upref if $ref;
    $o;
  }
  multi method new {
    my $coverage = pango_coverage_new();
    self.bless(:$coverage);
  }

  method copy {
    my $coverage = pango_coverage_copy($!pc);
    self.bless(:$coverage);
  }

  method from_bytes ($bytes, $n_bytes?) is also<from-bytes> {
    # Force ASCII byute stream.
    my gint32 $nb;
    my $b = CArray[uint8].new(do given $bytes {
      when Str  { $bytes.encode('ASCII'); }
      when Buf  { $_.decode('ASCII').encode('ASCII') }
      when Blob { $_.decode('ASCII').encode('ASCII') }
    });
    $nb = $n_bytes // $b.elems;
    pango_coverage_from_bytes($b, $nb);
  }

  method get (Int() $index) {
    my gint $i = $index;
    pango_coverage_get($!pc, $i);
  }

  method max (PangoCoverage $other) {
    pango_coverage_max($!pc, $other);
  }

  method upref {
    pango_coverage_ref($!pc);
  }

  method set ( Int() $index, Int() $level ) {
    my int32 $i = $index;
    my uint32 $l = $level;
    pango_coverage_set($!pc, $i, $l);
  }

  proto method to_bytes (|)
    is also<to-bytes>
  { * }

  multi method to_bytes {
    my ($b, $nb) = (Blob[uint8].new, 0);
    samewith($b, $nb);
  }
  multi method to_bytes ($bytes is rw, $n_bytes is rw) {
    my $ba = CArray[CArray[uint8]].new;
    $ba[0] = CArray[uint8];
    my int32 $nb = 0;
    pango_coverage_to_bytes($!pc, $ba, $nb);
    my Blob $b = Blob[uint8].new($ba);
    ($bytes, $n_bytes) = ($b, $nb);
  }

  method downref {
    pango_coverage_unref($!pc);
  }

}
