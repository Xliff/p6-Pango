use v6.c;

use Pango::Raw::Types;

use Cairo;
use Pango::Cairo;
use Pango::Layout;
use Pango::FontDescription;

constant RADIUS = 150;
constant FONT = 'Sans Bold 27';
constant N_WORDS = 10;

sub draw_text($c) {
  my $pango_cairo = Pango::Cairo.new($c.context);
  $c.translate(RADIUS, RADIUS);
  my $layout = Pango::Cairo.create_layout($c.context);
  $layout.set_text('Text');
  my $desc = Pango::FontDescription.new_from_string(FONT);
  $layout.font_description = $desc;
  $desc.free;

  for ^N_WORDS {
    my ($angle, $w) = (360 * $_ / N_WORDS);
    my $red = (1 + (($angle - 60) * π/180).cos) / 2;

    $c.save;
    $c.rgb($red, 0, 1 - $red);
    $c.rotate($angle * π/180);
    $pango_cairo.update_layout($layout);
    ($w, $) = $layout.get_size;
    $c.move_to($w / PANGO_SCALE, -RADIUS);
    $pango_cairo.show_layout($layout);
    $c.restore;
  }
}

sub MAIN ($filename) {
  my $surface = Cairo::Image.create(
    FORMAT_ARGB32, 2 * RADIUS, 2 * RADIUS
  );
  my $cairo = Cairo::Context.new($surface);
  $cairo.rgb(1, 1, 1);
  $cairo.paint;
  draw_text($cairo);
  $cairo.destroy;

  my $status = $surface.write_png($filename);
  die "Could not save png to $filename"
    unless $status == CAIRO_STATUS_SUCCESS.Int;
}
