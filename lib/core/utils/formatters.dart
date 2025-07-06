String dateFormat(DateTime data) {
  final day = data.day.toString().padLeft(2, '0');
  final month = data.month.toString().padLeft(2, '0');
  final year = data.year;
  final hour = data.hour.toString().padLeft(2, '0');
  final minute = data.minute.toString().padLeft(2, '0');
  return '$day/$month/$year - $hour:$minute';
}
