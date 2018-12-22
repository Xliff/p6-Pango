use v6.c;

use Cairo;
use Pango::Compat::FreeType;
use Pango::Cairo;
use Pango::FontDescription;
use Pango::FontMap::FT2;
use Pango::Layout;
use Pango::Raw::Types;

sub MAIN ($filename = 'test-font.png') {
  my $bmp = FT_Bitmap.new(width => 640, rows => 480, num_grays => 256);
  ($bmp.pitch, $bmp.pixel_mode) = (($bmp.width + 3) +& -4, FT_PIXEL_MODE_GRAY);

  my $surf = Cairo::Image.create(
    FORMAT_A8, $bmp.width, $bmp.rows, $bmp.buffer, True
  );

  die q:to/DIE/.chomp without $surf;
Error! Could not create the surface, and cannot continue.
DIE

  my $cr = Cairo::Context.new($surf);
  die q:to/DIE/.chomp without $cr;
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
  $layout.set_markup(qq:to/TEXT/);
<span foreground="blue" font_family="Station">
   <b> bold </b>
   <u> is </u>
   <i> nice </i>
</span>
<tt> hello </tt>
<span font_family="sans" font_stretch="ultracondensed" letter_spacing="500" \
font_weight="light"> SANS</span>
<span foreground="#FFCC00"> colored</span>
TEXT

  $bmp.buffer_pointer;
  $font_map.render_layout($bmp, $layout, 30, 100);
  say $bmp.buffer.^name;
  $bmp.buffer_pointer;
  $bmp.buffer_pointer;

  Pango::Cairo.new($cr.context).update_layout($layout);
  try {
    CATCH {
      default { say "Error: Couldn't write png to $filename: { .message }"; }
    }
    $surf.write_png($filename)
  }
}
