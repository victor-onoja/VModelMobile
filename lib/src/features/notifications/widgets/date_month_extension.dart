extension DateTimeExtension on DateTime {


  String monthAgo() {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return 'This week';
    } else if (difference.inHours <= 12) {
      return 'Today';
    } else {
      return 'This month';
    }
  }

  
}