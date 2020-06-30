use v6.c;

use Pango::Raw::Types;
use RandomColor;

use Cairo;
use Pango::Cairo;
use Pango::Layout;
use Pango::FontDescription;

use LWP::Simple;
use Mojo::DOM:from<Perl5>;

sub get_rdjt_scribbles {
#   my @a;
#
#   @a.push: q:to/RDJT1/.chomp;
# 40 years of corruption. 40 years of repression. 40 years of terror. The
# regime in Iran has produced only #40YearsofFailure. The long-suffering
# Iranian people deserve a much brighter future.
# RDJT1
#
#   @a.push: q:to/RDJT2/.chomp;
# Will be heading to El Paso very soon. Big speech on Border Security and
# much else tonight. Tremendous crowd! See you later!
# RDJT2
#
#   @a.pick;
  # my $data;
  # my $dom = Mojo::DOM.new(
  #   $data = LWP::Simple.new.get( 'https://twitter.com/realDonaldTrump' )
  # );
  #
  # my @texts;
  # for @( $dom.find('p.TweetTextSize').to_array ) -> $e {
  #   @texts.push: $e.all_text if $e.defined;
  # }
  #
  # @texts.pick;

  do qq:to/TEXT/;
    Sorry to inform the Do Nothing Democrats, but I am getting VERY GOOD
    internal Polling Numbers. Just like 2016, the \@nytimes Polls are Fake!
    The \@FoxNews Polls are a JOKE! Do you think they will apologize to me &
    their subscribers AGAIN when I WIN? People want LAW, ORDER & SAFETY!
    TEXT
}

#constant FONT = 'Sans Bold 14';
constant FONT = 'Qwurky 10';

sub draw_text($c, $rc) {
  my $text;
  my $pango_cairo = Pango::Cairo.new($c.context);
  my $layout = Pango::Cairo.create_layout($c.context);
  # $layout.width = 1050 * PANGO_SCALE;
  # $layout.wrap = True;
  $text = get_rdjt_scribbles;
  $layout.text = $text;
  my $desc = Pango::FontDescription.new_from_string(FONT);
  $layout.font_description = $desc;
  $desc.free;

  $c.save;
  $c.rgb( |$rc.map( * / 255 ) );
  $pango_cairo.update_layout($layout);
  my ($w, $h) = $layout.get_size;
  $pango_cairo.show_layout($layout);
  $c.restore;

  $text.say;
}

sub MAIN ($filename = 'donald_tweet.png') {
  my $rc = RandomColor.new(format => 'rgbarray').list[0];
  my $surface = Cairo::Image.create(
    FORMAT_ARGB32, 1050, 300
  );

  my $cairo = Cairo::Context.new($surface);
  $cairo.rgb(1, 1, 1);
  $cairo.scale(2, 2);
  $cairo.paint;
  draw_text($cairo, $rc);
  $cairo.destroy;

  my $status = $surface.write_png($filename);
  die "Could not save png to $filename"
    unless $status == CAIRO_STATUS_SUCCESS.Int;
}
