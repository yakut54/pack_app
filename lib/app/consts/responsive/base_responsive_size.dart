import 'responsive_size_constants.dart';

const breakpoints = ResponsiveSizingConstants.breakpoints;

abstract class AbstractResponsiveSizing {
  double responsiveValue(List<double> values);
  double get fontSizeHeaderLarge;
  double get fontSizeHeaderSmall;
  double get fontSizeTileLarge;
  double get fontSizeTileMedium;
  double get heightHeader;
}

class BaseResponsiveSizing implements AbstractResponsiveSizing {
  final double screenWidth;

  BaseResponsiveSizing(this.screenWidth) {
    ResponsiveSizingConstants.checkListLengths();
  }

  @override
  double responsiveValue(List<double> values) {
    for (int i = 0; i < breakpoints.length; i++) {
      if (screenWidth >= breakpoints[i]) {
        return values[i];
      }
    }
    return values.last;
  }

  @override
  double get fontSizeHeaderLarge =>
      responsiveValue(ResponsiveSizingConstants.fontSizeHeaderLargeList);

  @override
  double get fontSizeHeaderSmall =>
      responsiveValue(ResponsiveSizingConstants.fontSizeHeaderSmallList);

  @override
  double get heightHeader =>
      responsiveValue(ResponsiveSizingConstants.heightHeaderList);

  @override
  double get fontSizeTileLarge =>
      responsiveValue(ResponsiveSizingConstants.fontSizeTileLargeList);

  @override
  double get fontSizeTileMedium =>
      responsiveValue(ResponsiveSizingConstants.fontSizeTileMediumList);
}
