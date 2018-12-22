use v6.c;

use NativeCall;

unit package Pango::Compat::FreeType;

class FT_Bitmap is repr('CStruct') is export {
  has uint32          $.rows         is rw;
  has uint32          $.width        is rw;
  has int32           $.pitch        is rw;
  has CArray[uint8]   $.buffer;
  has uint16          $.num_grays    is rw;
  has uint8           $.pixel_mode   is rw;
  has uint8           $.palette_mode is rw;
  has Pointer         $.palette;

  method buffer_pointer {
    say +( nativecast(Pointer, $!buffer) );
  }

  method buffer is rw {
    Proxy.new(
      FETCH => -> $ { $!buffer },
      STORE => -> $, $val {
        use nqp;
        nqp::bindattr(
          nqp::decont(self), FT_Bitmap, '$!buffer', nqp::decont($val)
        )
      }
    );
  }

  # Other attributes?
  submethod BUILD (:$rows, :$width, :$num_grays) {
    FT_Bitmap_Init(self);
    ($!rows, $!width, $!num_grays) = ($rows, $width, $num_grays);
    self.buffer = CArray[uint8].new;
    $!buffer[$_] = 0 for ^($!rows * $!width);
  }

  method new (
    Int :$rows is copy,                 # So it can be re-assigned.
    Int :$height,
    Int :$width,
    Int :$num_grays
  ) {
    $rows //= $height with $height;
    self.bless(:$rows, :$width, :$num_grays);
  }
}

sub FT_Bitmap_Init(FT_Bitmap)
  is native('freetype')
  { * }

our enum FT_Pixel_MODE is export (
  'FT_PIXEL_MODE_NONE' => 0,
  'FT_PIXEL_MODE_MONO',
  'FT_PIXEL_MODE_GRAY',
  'FT_PIXEL_MODE_GRAY2',
  'FT_PIXEL_MODE_GRAY4',
  'FT_PIXEL_MODE_LCD',
  'FT_PIXEL_MODE_LCD_V',
  'FT_PIXEL_MODE_BGRA',
  'FT_PIXEL_MODE_MAX'      # do not remove
);
