

int preparedColor(String color) {
  final myPrefix = '0xff';
  String modifiedColor = color.replaceFirst(RegExp('#'), myPrefix);

  return int.parse(modifiedColor);
}