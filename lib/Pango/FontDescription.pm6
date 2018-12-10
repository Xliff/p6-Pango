use v6.c;

use NativeCall;

use Pango::Compat::Types;
use Pango::Raw::Types;
use Pango::Raw::DescriptionMetrics;

use Pango::Roles::Types;

class Pango::FontDescription {
  also does Pango::Roles::Types;

  has PangoFontDescription $!pfd;

  submethod BUILD (:$description) {
    $!pfd = $description;
  }

  method Pango::Raw::Types::PangoFontDescription {
    $!pfd;
  }
  method font_description {
    $!pfd;
  }

  method new {
    my $description = pango_font_description_new();
    self.bless(:$description);
  }

  method new_from_string(Str $str) {
    my $description = pango_font_description_from_string($str);
    self.bless(:$description);
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
        my guint $g = self.RESOLVE-UINT($gravity);
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
        my gint $s = self.RESOLVE-INT($size);
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
        my guint $s = self.RESOLVE-UINT($stretch);
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
        my guint $s = self.RESOLVE-UINT($style);
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
        my guint $v = self.RESOLVE-UINT($variant);
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
        my guint $w = self.RESOLVE-UINT($weight);
        pango_font_description_set_weight($!pfd, $w);
      }
    );
  }

  method better_match (
    PangoFontDescription() $old_match,
    PangoFontDescription() $new_match
  ) {
    so pango_font_description_better_match($!pfd, $old_match, $new_match);
  }

  method matches (PangoFontDescription() $b) {
    self.better_match(PangoFontDescription, $b);
  }

  method copy {
    pango_font_description_copy($!pfd);
  }

  method copy_static {
    pango_font_description_copy_static($!pfd);
  }

  method equal (PangoFontDescription() $desc2) {
    pango_font_description_equal($!pfd, $desc2);
  }

  method free {
    pango_font_description_free($!pfd);
  }

  method get_set_fields {
    pango_font_description_get_set_fields($!pfd);
  }

  method get_size_is_absolute {
    pango_font_description_get_size_is_absolute($!pfd);
  }

  method hash {
    pango_font_description_hash($!pfd);
  }

  method merge (
    PangoFontDescription() $desc_to_merge,
    Int() $replace_existing
  ) {
    my gboolean $re = self.RESOLVE-BOOL($replace_existing);
    pango_font_description_merge($!pfd, $desc_to_merge, $re);
  }

  method merge_static (
    PangoFontDescription() $desc_to_merge,
    Int() $replace_existing
  ) {
    my gboolean $re = self.RESOLVE-BOOL($replace_existing);
    pango_font_description_merge_static($!pfd, $desc_to_merge, $re);
  }

  multi method multi_free(@descs) {
    my $descs = CArray[Pointer[PangoFontDescription]].new;
    my $d = 0;
    for @descs {
      $descs[$d++] = nativecast(Pointer[PangoFontDescription], do {
        Pango::FontDescription { .font_description }
        PangoFontDescription   { $_ }
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
  ) {
    my gint $nd = self.RESOLVE-UINT($n_descs);
    pango_font_descriptions_free($descs, $nd);
  }

  method set_absolute_size (gdouble $size) {
    pango_font_description_set_absolute_size($!pfd, $size);
  }

  method set_family_static (Str() $family) {
    pango_font_description_set_family_static($!pfd, $family);
  }

  method set_variations_static (Str() $settings) {
    pango_font_description_set_variations_static($!pfd, $settings);
  }

  method to_filename {
    pango_font_description_to_filename($!pfd);
  }

  method to_string {
    pango_font_description_to_string($!pfd);
  }

  method unset_fields (PangoFontMask $to_unset) {
    pango_font_description_unset_fields($!pfd, $to_unset);
  }

}

method infix:<eqv> (Pango::FontDescription $a, Pango::FontDescription $b)
  is export
{
  $a.equal($b);
}
