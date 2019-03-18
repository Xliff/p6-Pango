use v6.c;

use NativeCall;

use Pango::Compat::Types;
use Pango::Raw::Types;

unit package Pango::Raw::Coverage;

sub pango_coverage_copy (PangoCoverage $coverage)
  returns PangoCoverage
  is native(pango)
  is export
  { * }

sub pango_coverage_from_bytes (CArray[Str] $bytes, int32 $n_bytes)
  returns PangoCoverage
  is native(pango)
  is export
  { * }

sub pango_coverage_get (PangoCoverage $coverage, int32 $index_)
  returns uint32 # PangoCoverageLevel
  is native(pango)
  is export
  { * }

sub pango_coverage_max (PangoCoverage $coverage, PangoCoverage $other)
  is native(pango)
  is export
  { * }

sub pango_coverage_new ()
  returns PangoCoverage
  is native(pango)
  is export
  { * }

sub pango_coverage_ref (PangoCoverage $coverage)
  returns PangoCoverage
  is native(pango)
  is export
  { * }

sub pango_coverage_set (
  PangoCoverage $coverage,
  int32 $index,
  uint32 $level               # PangoCoverageLevel $level
)
  is native(pango)
  is export
  { * }

sub pango_coverage_to_bytes (
  PangoCoverage $coverage,
  CArray[CArray[uint8]] $bytes,
  int32 $n_bytes is rw
)
  is native(pango)
  is export
  { * }

sub pango_coverage_unref (PangoCoverage $coverage)
  is native(pango)
  is export
  { * }
