use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;
use Pango::Raw::DescriptionMetrics;

class Pango::FontDescription {
  has PangoFontDescription $!pfd;

  submethod BUILD (:$description) {
    $!pfd = $description;
  }

  method Pango::Raw::Types::PangoFontDescription
    is also<
      PangoFontDescription
      font-description
    >
  { $!pfd }

  multi method new (PangoFontDescription $description) {
    self.bless( :$description );
  }
  multi method new {
    self.bless( description => pango_font_description_new() );
  }

  method new_from_string(Str $str) is also<new-from-string> {
    self.bless(
      description => pango_font_description_from_string($str)
    );
  }

  method family is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_font_description_get_family($!pfd);
      },
      STORE => sub ($, Str() $family is copy) {
        pango_font_description_set_family($!pfd, $family);
      }
    );
  }

  method gravity is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoGravity( pango_font_description_get_gravity($!pfd) );
      },
      STORE => sub ($, Int() $gravity is copy) {
        my uint32 $g = $gravity;

        pango_font_description_set_gravity($!pfd, $g);
      }
    );
  }

  method size is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_font_description_get_size($!pfd);
      },
      STORE => sub ($, Int() $size is copy) {
        my int32 $s = $size;

        pango_font_description_set_size($!pfd, $s);
      }
    );
  }

  method stretch is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoStretch( pango_font_description_get_stretch($!pfd) );
      },
      STORE => sub ($, Int() $stretch is copy) {
        my uint32 $s = $stretch;

        pango_font_description_set_stretch($!pfd, $s);
      }
    );
  }

  method style is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoStyle( pango_font_description_get_style($!pfd) );
      },
      STORE => sub ($, Int() $style is copy) {
        my uint32 $s = $style;

        pango_font_description_set_style($!pfd, $s);
      }
    );
  }

  method variant is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoVariant( pango_font_description_get_variant($!pfd) );
      },
      STORE => sub ($, Int() $variant is copy) {
        my uint32 $v = $variant;

        pango_font_description_set_variant($!pfd, $v);
      }
    );
  }

  method variations is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_font_description_get_variations($!pfd);
      },
      STORE => sub ($, Str() $settings is copy) {
        pango_font_description_set_variations($!pfd, $settings);
      }
    );
  }

  method weight is rw {
    Proxy.new(
      FETCH => sub ($) {
        PangoWeight( pango_font_description_get_weight($!pfd) );
      },
      STORE => sub ($, Int() $weight is copy) {
        my uint32 $w = $weight;

        pango_font_description_set_weight($!pfd, $w);
      }
    );
  }

  method better_match (
    Pango::FontDescription:U:
    PangoFontDescription() $old_match,
    PangoFontDescription() $new_match
  )
    is also<better-match>
  {
    so pango_font_description_better_match($!pfd, $old_match, $new_match);
  }

  method matches (PangoFontDescription() $b) {
    self.better_match($!pfd, $b);
  }

  method copy (:$raw = False) {
    my $d = pango_font_description_copy($!pfd);

    $d ??
      ( $raw ?? $d !! Pango::FontDescription.new($d) )
      !!
      Nil;
  }

  method copy_static is also<copy-static> {
    pango_font_description_copy_static($!pfd);
  }

  method equal (PangoFontDescription() $desc2) {
    so pango_font_description_equal($!pfd, $desc2);
  }

  method free {
    pango_font_description_free($!pfd);
  }

  method get_set_fields
    is also<
      get-set-fields
      set_fields
      set-fields
    >
  {
    pango_font_description_get_set_fields($!pfd);
  }

  method get_size_is_absolute
    is also<
      get-size-is-absolute
      size_is_absolute
      size-is-absolute
    >
  {
    pango_font_description_get_size_is_absolute($!pfd);
  }

  method hash {
    pango_font_description_hash($!pfd);
  }

  method merge (
    PangoFontDescription() $desc_to_merge,
    Int() $replace_existing
  ) {
    my uint32 $re = $replace_existing;

    pango_font_description_merge($!pfd, $desc_to_merge, $re);
  }

  method merge_static (
    PangoFontDescription() $desc_to_merge,
    Int() $replace_existing
  )
    is also<merge-static>
  {
    my uint32 $re = $replace_existing;

    pango_font_description_merge_static($!pfd, $desc_to_merge, $re);
  }

  multi method multi_free(@descs) is also<multi-free> {
    my $descs = CArray[Pointer[PangoFontDescription]].new;
    my $d = 0;
    for @descs {
      $descs[$d++] = nativecast(Pointer[PangoFontDescription], do {
        when Pango::FontDescription { .font_description }
        when PangoFontDescription   { $_ }
        default {
          die qq:to/D/.chomp;
Pango::FontDescription.multi_free does not handle { .^name } objects
D
        }
      });
    }
    self.description_free($descs, $descs.elems);
  }

  method descriptions_free (
    CArray[Pointer[PangoFontDescription]] $descs,
    Int() $n_descs
  )
    is also<descriptions-free>
  {
    my int32 $nd = $n_descs;

    pango_font_descriptions_free($descs, $nd);
  }

  method set_absolute_size (Int() $size) is also<set-absolute-size> {
    my num32 $s = $size;

    pango_font_description_set_absolute_size($!pfd, $size);
  }

  method set_family_static (Str() $family) is also<set-family-static> {
    pango_font_description_set_family_static($!pfd, $family);
  }

  method set_variations_static (Str() $settings)
    is also<set-variations-static>
  {
    pango_font_description_set_variations_static($!pfd, $settings);
  }

  method to_filename is also<to-filename> {
    pango_font_description_to_filename($!pfd);
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    pango_font_description_to_string($!pfd);
  }

  method unset_fields (PangoFontMask() $to_unset) is also<unset-fields> {
    pango_font_description_unset_fields($!pfd, $to_unset);
  }

}

multi sub infix:<eqv> (Pango::FontDescription $a, Pango::FontDescription $b)
  is export
{
  $a.equal($b);
}
