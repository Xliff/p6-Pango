use v6.c;

use NativeCall;

#use Cairo;
use Pango::Raw::Cairo;
use Pango::Raw::FontMap;
use Pango::Raw::DescriptionMetrics;
use Pango::Raw::FT2FontMap;
use Pango::Raw::Layout;
use Pango::Compat::FreeType;
#use Pango::Cairo;
#use Pango::FontDescription;
use Pango::FontMap::FT2;
use Pango::Layout;
use Pango::Raw::Types;

sub cairo_format_stride_for_width(int32, int32)
  returns int32
  is native('cairo')
  { * }

sub cairo_image_surface_create_for_data(Pointer, int32, int32, int32, int32)
  returns Pointer
  is native('cairo')
  { * }

sub cairo_create(Pointer)
  returns Pointer
  is native('cairo')
  { * }

sub cairo_surface_write_to_png(Pointer, Str)
  returns uint32
  is native('cairo')
  { * }

sub cairo_surface_status(Pointer)
  returns uint32
  is native('cairo')
  { * }

sub MAIN ($filename = 'test-font.png') {
  my $bmp = FT_Bitmap.new(width => 640, rows => 480, num_grays => 256);
  ($bmp.pitch, $bmp.pixel_mode) = (($bmp.width + 3) +& -4, FT_PIXEL_MODE_GRAY);

  # my $surf = Cairo::Image.create(
  #   FORMAT_A8, $bmp.width, $bmp.rows, $bmp.buffer, True
  # );
  my int32 $f = 2;
  my int32 $s = cairo_format_stride_for_width($f, $bmp.width);
  my $surf = cairo_image_surface_create_for_data(
    $bmp.buffer, $f, $bmp.width, $bmp.rows, $s
  );

  my $st = cairo_surface_status($surf);
  die qq:to/DIE/.chomp unless $st == 0;
Error! Could not create the surface, and cannot continue. Error #{ $st }
DIE

  #my $cr = Cairo::Context.new($surf);
  my $cr = cairo_create($surf);
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

  # Check layout for issues since nothing is happening to context.
  my $font_desc = Pango::FontDescription.new_from_string('Station 35');
  $layout.font_description = $font_desc;
  $font_map.load_font($context, $font_desc);
  $layout.width = 150 * PANGO_SCALE;
  #pango_layout_set_width($layout.layout, 150 * PANGO_SCALE);

  my $mu = q:to/TEXT/;
<span foreground="blue" font_family="Station">
   <b> bold </b>
   <u> is </u>
   <i> nice </i>
</span>
<tt> hello </tt>
<span font_family="sans" font_stretch="ultracondensed" letter_spacing="500" font_weight="light"> SANS</span>
<span foreground="#FFCC00"> colored</span>
TEXT

  # Remove carriage returns to match C version.
  $mu ~~ s:g/\n//;
  $layout.set_markup($mu);
  $font_map.render_layout($bmp, $layout, 30, 100);

  # Problem is here? -- Convert these to C equivs and see.
  #Pango::Cairo.new($cr.context).update_layout($layout);
  #my $pc = pango_cairo_create_context($cr.context);

  # CAIRO context, not a Pango context.
  #pango_cairo_update_layout($cr.context, $layout.layout);
  pango_cairo_update_layout($cr, $layout.layout);
  try {
    CATCH {
      default { say "Error: Couldn't write png to $filename: { .message }"; }
    }
    #$surf.write_png($filename)
    cairo_surface_write_to_png($surf, $filename);
  }
}
