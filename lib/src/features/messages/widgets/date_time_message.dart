import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String timeAgoMessage() {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if (difference.inSeconds < 1) {
      return 'Now';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds} sec ago';
    } else if (difference.inMinutes == 1) {
      return '1 min ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} mins ago';
    } else if (difference.inHours == 1) {
      return '1 hr ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hrs ago';
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months} month${months == 1 ? '' : 's'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years} yr${years == 1 ? '' : 's'} ago';
    }
  }


 String timeMessage() {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if (difference.inSeconds < 1) {
      return 'Now';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds} sec';
    } else if (difference.inMinutes == 1) {
      return '1 min ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} mins';
    } else if (difference.inHours == 1) {
      return '1 hr ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hrs';
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months} month${months == 1 ? '' : 's'}';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years} yr${years == 1 ? '' : 's'}';
    }
  }


  String dateAgoMessage() {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if (difference.inDays >= 2) {
      return '${difference.inDays}days';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours}hrs';
    } else if (difference.inDays >= 1) {
      return '1d';
    } else if (difference.inHours >= 1) {
      return '1hr';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes}m';
    } else if (difference.inMinutes >= 1) {
      return '1m';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds}s';
    } else {
      return 'now';
    }
  }
}

final formatter = DateFormat('MMM dd, y');
