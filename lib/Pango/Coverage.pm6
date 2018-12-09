use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Coverage;
use Pango::Raw::Types;

use Pango::Roles::Types;

class Pango::Coverage {
  also does Pango::Roles::Types;

  has PangoCoverage $!pc;

  submethod BUILD (:$coverage) {
    $!pc = $coverage;
  }

  submethod DESTROY {
    self.downref;
  }

  multi method new (PangoCoverage $coverage) {
    my $o = self.bless(:$coverage);
    $o.upref;
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

  method from_bytes ($bytes, $n_bytes?) {
    # Force ASCII byute stream.
    my gint32 $nb;
    my $b = CArray[uint8].new(do given $bytes {
      when Str  { $bytes.encode('ASCII'); }
      when Buf  { $_.decode('ASCII').encode('ASCII') }
      when Blob { $_.decode('ASCII').encode('ASCII') }
    });
    $nb = $n_bytes // $b.elems;
    pango_coverage_from_bytes($!pc, $n_bytes);
  }

  method get (Int() $index) {
    my gint $i = self.RESOLVE-INT($index);
    pango_coverage_get($!pc, $i);
  }

  method max (PangoCoverage $other) {
    pango_coverage_max($!pc, $other);
  }

  method upref {
    pango_coverage_ref($!pc);
  }

  method set ( Int() $index, Int() $level ) {
    my int32 $i = self.RESOLVE-INT($index);
    my uint32 $l = self.RESOLVE-UINT($level);
    pango_coverage_set($!pc, $i, $l);
  }

  multi method to_bytes {
    my ($b, $nb) = ('', 0);
    samewith($b, $nb);
  }
  multi method to_bytes (Str $bytes, Int $n_bytes is rw) {
    my $ba = CArray[Str].new;
    my int32 $nb = 0;
    pango_coverage_to_bytes($!pc, $bytes, $nb);
    ($bytes, $n_bytes) = ($ba[0], $nb);
  }

  method downref {
    pango_coverage_unref($!pc);
  }

}
