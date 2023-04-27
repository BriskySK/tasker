import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String toFormattedString() {
    final formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(this);
  }
}
