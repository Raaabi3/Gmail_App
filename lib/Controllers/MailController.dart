import 'package:intl/intl.dart';

String extractNameFromSender(String sender) {
  if (sender.contains('"')) {
    final startIndex = sender.indexOf('"') + 1;
    final endIndex = sender.indexOf('"', startIndex);
    return sender.substring(startIndex, endIndex);
  } else if (sender.contains('<')) {
    return sender.substring(0, sender.indexOf('<')).trim();
  }
  return sender.split(RegExp(r'[ <]')).first.trim();
}

List<String> extractTime(DateTime datetime) {
  final dayOfWeek = DateFormat('EEEE').format(datetime); // e.g., Monday
  final monthName = DateFormat('MMMM').format(datetime); // e.g., January
  final formattedTime = DateFormat(
    'hh:mm a',
  ).format(datetime); // e.g., 03:45 PM
  final day = datetime.day.toString().padLeft(2, '0');
  final year = datetime.year.toString();
  return [dayOfWeek, monthName, day, year, formattedTime];
}

String formatEmailTimestamp(DateTime emailDate) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final emailDay = DateTime(emailDate.year, emailDate.month, emailDate.day);
  final difference = today.difference(emailDay).inDays;

  if (difference == 0) {
    // Same day → time only (e.g., 3:45 PM)
    return DateFormat('h:mm a').format(emailDate);
  } else if (difference == 1) {
    // Yesterday
    return 'Yesterday';
  } else if (difference < 7 && emailDate.weekday < today.weekday) {
    // Within same week (before today) → weekday name (e.g., Monday)
    return DateFormat('EEEE').format(emailDate);
  } else if (emailDate.year == now.year) {
    // Same year → month + day (e.g., Apr 15)
    return DateFormat('MMM d').format(emailDate);
  } else {
    // Older → month + day + year (e.g., Apr 15, 2023)
    return DateFormat('MMM d, y').format(emailDate);
  }
}

String extractemailname(sender) {
  if (sender.contains('@')) {
    final startIndex = sender.indexOf('<') + 1;
    final endIndex = sender.indexOf('@', startIndex);
    return sender.substring(startIndex, endIndex);
  }
  return sender.split(RegExp(r'[ <]')).first.trim();
}

String extractemail(sender) {
  if (sender.contains('<')) {
    final startIndex = sender.indexOf('<') + 1;
    final endIndex = sender.indexOf('>', startIndex);
    return sender.substring(startIndex, endIndex);
  }
  return sender.split(RegExp(r'[ <]')).first.trim();
}

String? extractFirstUrl(String text) {
  final urlRegExp = RegExp(
    r'(https?:\/\/[^\s<>()]+)',
    caseSensitive: false,
  );

  final match = urlRegExp.firstMatch(text);
  return match?.group(0); // returns null if no match
}

