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

  method new {
    my $description = pango_font_description_new();
    self.bless(:$description);
  }

  method family is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_font_description_get_family($!pfd);
      },
      STORE => sub ($, $family is copy) {
        pango_font_description_set_family($!pfd, $family);
      }
    );
  }

  method gravity is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_font_description_get_gravity($!pfd);
      },
      STORE => sub ($, $gravity is copy) {
        pango_font_description_set_gravity($!pfd, $gravity);
      }
    );
  }

  method size is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_font_description_get_size($!pfd);
      },
      STORE => sub ($, $size is copy) {
        pango_font_description_set_size($!pfd, $size);
      }
    );
  }

  method stretch is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_font_description_get_stretch($!pfd);
      },
      STORE => sub ($, $stretch is copy) {
        pango_font_description_set_stretch($!pfd, $stretch);
      }
    );
  }

  method style is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_font_description_get_style($!pfd);
      },
      STORE => sub ($, $style is copy) {
        pango_font_description_set_style($!pfd, $style);
      }
    );
  }

  method variant is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_font_description_get_variant($!pfd);
      },
      STORE => sub ($, $variant is copy) {
        pango_font_description_set_variant($!pfd, $variant);
      }
    );
  }

  method variations is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_font_description_get_variations($!pfd);
      },
      STORE => sub ($, $settings is copy) {
        pango_font_description_set_variations($!pfd, $settings);
      }
    );
  }

  method weight is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_font_description_get_weight($!pfd);
      },
      STORE => sub ($, $weight is copy) {
        pango_font_description_set_weight($!pfd, $weight);
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

  method from_string {
    pango_font_description_from_string($!pfd);
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
    PangoFontDescription $desc_to_merge,
    Int() $replace_existing
  ) {
    my gboolean $re = self.RESOLVE-BOOL($replace_existing);
    pango_font_description_merge($!pfd, $desc_to_merge, $re);
  }

  method merge_static (
    PangoFontDescription $desc_to_merge,
    Int() $replace_existing
  ) {
    my gboolean $re = self.RESOLVE-BOOL($replace_existing);
    pango_font_description_merge_static($!pfd, $desc_to_merge, $re);
  }

  multi method multi_free(@descs) {
    my $descs = CArray[PangoFontDescription].new;
    my $d = 0;
    for @descs {
      $descs[$d++] = do {
        Pango::FontDescription { .font_description }
        PangoFontDescription   { $_ }
        default {
          die qq:to/D/.chomp;
Pango::FontDescription.multi_free does not handle { .^name } objects
D
        }
      }
    }
    self.description_free($descs, $descs.elems);
  }

  method descriptions_free (
    CArray[PangoFontDescriptions] $descs,
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
