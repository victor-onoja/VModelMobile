//a data model for the notifications feature

class NotificationsData {
  final String msg;
  final String picPath;
  final String notificationType;
  NotificationsData({required this.msg, required this.picPath, required this.notificationType,});
}

List<NotificationsData> todayMessage = [
  NotificationsData(
      msg: "Samantha wants to connect", picPath: "assets/images/pr1.jpeg", notificationType: "accept"),
  NotificationsData(
      msg: "Samantha wants to connect", picPath: "assets/images/pr2.jpeg", notificationType: "accepted"),

  NotificationsData(
      msg: "Samantha liked you post", picPath: "assets/images/pr3.jpg",  notificationType: "liked"),
  NotificationsData(
      msg: "Samantha wants to connect",
      picPath: "assets/images/pr4.jpeg",  notificationType: "accepted"),
  NotificationsData(
      msg: "Samantha wants to connect",
      picPath: "assets/images/pr5.jpg",  notificationType: "accept"),
  NotificationsData(
      msg: "Samantha liked you post", picPath: "assets/images/pr6.jpg",  notificationType: "liked"),
  NotificationsData(
      msg: "Samantha wants to connect",
      picPath: "assets/images/pr1.jpeg",  notificationType: "accept"),

];

List<NotificationsData> yesterdayMessage = [
  NotificationsData(
      msg: "Samantha wants to connect",
      picPath: "assets/images/pr5.jpg",  notificationType: "accept"),
  NotificationsData(
      msg: "Samantha wants to connect",
      picPath: "assets/images/pr3.jpg",  notificationType: "accepted"),

  NotificationsData(
      msg: "Samantha liked you post  3d",
      picPath: "assets/images/pr6.jpg",  notificationType: "liked"),
];
