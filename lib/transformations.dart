import 'dart:ui';

class Transformations {
  static Offset transformPoint(
      Offset point, Offset defaultBox, Offset targetBox) {
    if (defaultBox.dx == targetBox.dx && defaultBox.dy == targetBox.dy) {
      return point;
    }
    final widthPercentage = point.dx / defaultBox.dx;
    final newWidth = targetBox.dx * widthPercentage;

    final heightPercentage = point.dy / defaultBox.dy;
    final newHeight = targetBox.dy * heightPercentage;

    return Offset(newWidth, newHeight);
  }
}
