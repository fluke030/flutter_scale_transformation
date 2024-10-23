import 'dart:ui';

class Transformations {
  static Offset transformPoint(
      Offset point, Offset sourceBox, Offset targetBox) {
    if (sourceBox.dx == targetBox.dx && sourceBox.dy == targetBox.dy) {
      return point;
    }
    final widthPercentage = point.dx / sourceBox.dx;
    final newWidth = targetBox.dx * widthPercentage;

    final heightPercentage = point.dy / sourceBox.dy;
    final newHeight = targetBox.dy * heightPercentage;

    return Offset(newWidth, newHeight);
  }
}
