class ListModel {
  String? title;
  String? subtitle;
  String? image;
  String? icon;
  String? text;
  String? comment;
  String? number;
  String? locationNumber;
  String? jobQualityNumber;
  String? timingNumber;
  String? workEnergyNumber;

  ListModel(
      {this.title,
      this.subtitle,
      this.image,
      this.icon,
      this.text,
      this.comment,
      this.number,
      this.locationNumber,
      this.jobQualityNumber,
      this.timingNumber,
      this.workEnergyNumber});
}

class ImageModel {
  final String image;
  ImageModel({required this.image});
}

class ContainerModel {
  String text;
  String jobs;
  String icon;

  ContainerModel({required this.text, required this.jobs, required this.icon});
}
