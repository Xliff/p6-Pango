use v6.c;

my $ft-support;
try require ::('Font::FreeType');
try require ::('Font::FreeType::Native');
$ft-support = (
  ::('Font::FreeType'), ::('Font::FreeType::Native')
).none ~~ Failure;

use Cairo;
use Pango::Cairo;
use Pango::FontMap::FT2;
use Pango::Raw::Types;

sub MAIN ($filename = 'test-font.png') {
  die q:to/DIE/.chomp;
This script requires both the FreeType2 libraries and the Font::FreeType
package to install.
DIE

  my ($width, $height) = (640, 480);
  my $buf = Buf[uint8].new($width * $height, 0);
  my $surf = Cairo::Image.create(
    FORMAT_A8, $width, $height, $buf, True
  );
  die q:to/DIE/.chomp without $surf;
Error! Could not create the surface, and cannot continue.
DIE

  my $cr = Cairo::Context.new($surf);
  die q:to/DIE/.chom without $cr;
Error! Apparently ran out of memory, and cannot continue.
DIE

  my $font_map = Pango::FontMap::FT2.new;
  die q:to/DIE/.chomp without $font_map;
Error! Cannot create the pango font map, and cannot continue.
DIE

  my $context = $font_map.create_context;
  die q:to/DIE/.chomp without $context;
Error! Cannot create Pango font context, and cannot contiune.
DIE

  my $layout = Pango::Layout.new($context);
  die q:to/DIE/.chomp without $layout;
Error! Cannot create the Pango layout, and cannot continue.
DIE

  my $font_desc = Pango::FontDescription.new_from_string('Station 35');
  $layout.font_description = $font_desc;
  $font_map.load_font($context, $font_desc);
  $layout.width = 150 * PANGO_SCALE;
  $layout(qq:to/TEXT/);
<span foreground="blue" font_family="Station">
   <b> bold </b>
   <u> is </u>
   <i> nice </i>
</span>
<tt> hello </tt>
<span font_family="sans" font_stretch="ultracondensed" letter_spacing="500" {
} font_weight="light"> SANS</span>
<span foreground="#FFCC00"> colored</span>
TEXT

  $layout($buf, 30, 100);
  Pango::Cairo.new($cr).update_layout($layout);
  say "Error: Couldn't write png to $filename"
    unless $surf.write_png($filename) == STATUS_SUCCESS
}
