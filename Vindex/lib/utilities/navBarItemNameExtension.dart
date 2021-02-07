import 'navBarItemName.dart';

extension NavBarItemNameExtension on NavBarItemName {
  String getEnumString() {
    return this.toString().split('.').toList()[1];
  }
}