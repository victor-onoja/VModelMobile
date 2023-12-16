import '../../../../core/models/app_user.dart';

class JobApplicationsModel {
  String? id;
  double? proposedPrice;
  bool? accepted;
  bool? rejected;
  bool? deleted;
  String? dateCreated;
  Job? job;
  VAppUser? applicant;

  JobApplicationsModel({
    this.id,
    this.proposedPrice,
    this.accepted,
    this.rejected,
    this.deleted,
    this.dateCreated,
    this.job,
    this.applicant,
  });

  JobApplicationsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    proposedPrice = json['proposedPrice'];
    accepted = json['accepted'];
    rejected = json['rejected'];
    deleted = json['deleted'];
    dateCreated = json['dateCreated'];
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
    applicant = json['applicant'] != null
        ? VAppUser.fromMinimalMap(json['applicant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['proposedPrice'] = this.proposedPrice;
    data['accepted'] = this.accepted;
    data['rejected'] = this.rejected;
    data['deleted'] = this.deleted;
    data['dateCreated'] = this.dateCreated;
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    if (this.applicant != null) {
      data['applicant'] = this.applicant!.toJson();
    }
    return data;
  }
}

class Job {
  String? id;

  Job({this.id});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Applicant {
  String? id;
  String? username;
  String? displayName;
  String? profilePictureUrl;
  String? thumbnailUrl;
  String? email;
  String? label;
  bool? isVerified;
  String? bio;

  Applicant(
      {this.id,
      this.username,
      this.displayName,
      this.profilePictureUrl,
      this.thumbnailUrl,
      this.email,
      this.label,
      this.isVerified,
      this.bio});

  Applicant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    displayName = json['displayName'];
    profilePictureUrl = json['profilePictureUrl'];
    thumbnailUrl = json['thumbnailUrl'];
    email = json['email'];
    label = json['label'];
    isVerified = json['isVerified'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['displayName'] = this.displayName;
    data['profilePictureUrl'] = this.profilePictureUrl;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['email'] = this.email;
    data['label'] = this.label;
    data['isVerified'] = this.isVerified;
    data['bio'] = this.bio;
    return data;
  }
}
