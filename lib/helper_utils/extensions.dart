

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension StringExtensionAllLower on String {
  String capitalizeAndLower() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}