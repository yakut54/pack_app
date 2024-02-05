const double screen1024 = 1024.0;
const double screen900 = 900.0;
const double screen700 = 700.0;
const double screen600 = 600.0;
const double screen500 = 500.0;
const double screen450 = 450.0;
const double screen400 = 400.0;
const double screen360 = 360.0;

class ResponsiveSizingConstants {
  static const List<double> breakpoints = [
    screen1024,
    screen900,
    screen700,
    screen600,
    screen500,
    screen450,
    screen400,
    screen360
  ];

  static const List<double> fontSizeTileLargeList = [
    26, // screen1024
    26, // screen900
    24, // screen700
    23, // screen600
    22, // screen500
    24, // screen450
    23, // screen400
    22, // screen360
    21, // screen330
  ];
  static const List<double> fontSizeTileMediumList = [
    25, // screen1024
    24, // screen900
    23, // screen700
    22, // screen600
    21, // screen500
    20, // screen450
    19, // screen400
    18, // screen360
    17, // screen330
  ];
  static const List<double> fontSizeHeaderLargeList = [
    50, // screen1024
    45, // screen900
    43, // screen700
    40, // screen600
    38, // screen500
    36, // screen450
    34, // screen400
    30, // screen360
    28, // screen330
  ];
  static const List<double> fontSizeHeaderSmallList = [
    30, // screen1024
    28, // screen900
    26, // screen700
    26, // screen600
    24, // screen500
    22, // screen450
    21, // screen400
    19, // screen360
    18, // screen330
  ];
  static const List<double> heightHeaderList = [
    340, // screen1024
    320, // screen900
    300, // screen700
    280, // screen600
    260, // screen500
    240, // screen450
    200, // screen400
    190, // screen360
    180 // screen330
  ];

  static void checkListLengths() {
    if (fontSizeHeaderLargeList.length != breakpoints.length + 1 ||
        fontSizeHeaderSmallList.length != breakpoints.length + 1 ||
        fontSizeTileLargeList.length != breakpoints.length + 1 ||
        fontSizeTileMediumList.length != breakpoints.length + 1 ||
        heightHeaderList.length != breakpoints.length + 1) {
      throw Exception('List lengths do not match the number of breakpoints plus one for the default.');
    }
  }
}
