use v6.c;

use GLib::Raw::Debug;
use GLib::Raw::Distro;

unit package Pango::Raw::Distro;

# Change listing to alpha by-key!
my %pango-adjustments;

BEGIN {
  %pango-adjustments = do {
    (
      linux => (
        Ubuntu => (
          DEFAULTS => (
            lib-append => '-1.0'
          ),

          bionic => my $ulatest = (
            version => v0
          ).Hash,

          # cosmic
          # disco
          # eoan
          # focal
          # hirsute
          # mantic

          latest => $ulatest
        ).Hash,

        Debian => (
          DEFAULTS => (
            lib-append => '-1.0'
          ),
          #
          # buster => my $dlatest = (
          #   version    => v19
          # ).Hash,
          #
          # latest => $dlatest
        ).Hash
      ).Hash
    ).Hash;
  }
}

sub pango-adjustments is export {
  %(
    pango      => %pango-adjustments,
    pangocairo => %pango-adjustments,
    pangoft2   => %pango-adjustments
  ).Map;
}

INIT {
  add-distro-adjustments( pango-adjustments() )
}
