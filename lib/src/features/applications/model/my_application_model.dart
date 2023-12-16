class MyJobApplicationModel {
  String? id;
  Job? job;
  double? proposedPrice;
  bool? accepted;
  bool? rejected;
  bool? deleted;
  DateTime? dateCreated;

  MyJobApplicationModel({
    this.id,
    this.job,
    this.proposedPrice,
    this.accepted,
    this.rejected,
    this.deleted,
    this.dateCreated,
  });

  MyJobApplicationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
    proposedPrice = json['proposedPrice'];
    accepted = json['accepted'];
    rejected = json['rejected'];
    deleted = json['deleted'];
    dateCreated = DateTime.parse(
        DateTime.parse(json['dateCreated']).toIso8601String().split("T")[0]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    data['proposedPrice'] = this.proposedPrice;
    data['accepted'] = this.accepted;
    data['rejected'] = this.rejected;
    data['deleted'] = this.deleted;
    data['dateCreated'] = this.dateCreated;
    return data;
  }
}

class Job {
  Creator? creator;
  String? jobTitle;
  String? priceOption;
  double? priceValue;
  String? preferredGender;
  String? shortDescription;
  int? noOfApplicants;
  dynamic briefFile;
  String? brief;
  String? briefLink;
  String? deliverablesType;
  bool? isDigitalContent;
  String? deliveryType;
  dynamic ethnicity;
  dynamic size;
  String? jobType;
  dynamic skinComplexion;
  String? createdAt;
  bool? deleted;
  int? views;
  bool? acceptMultiple;
  int? minAge;
  int? maxAge;
  List<String>? talents;
  dynamic talentHeight;
  List<JobDelivery>? jobDelivery;
  JobLocation? jobLocation;

  Job(
      {this.creator,
      this.jobTitle,
      this.priceOption,
      this.priceValue,
      this.preferredGender,
      this.shortDescription,
      this.briefFile,
      this.brief,
      this.briefLink,
      this.deliverablesType,
      this.isDigitalContent,
      this.deliveryType,
      this.ethnicity,
      this.noOfApplicants,
      this.size,
      this.jobType,
      this.skinComplexion,
      this.createdAt,
      this.deleted,
      this.views,
      this.acceptMultiple,
      this.minAge,
      this.maxAge,
      this.talents,
      this.talentHeight,
      this.jobDelivery,
      this.jobLocation});

  Job.fromJson(Map<String, dynamic> json) {
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    jobTitle = json['jobTitle'];
    priceOption = json['priceOption'];
    priceValue = json['priceValue'];
    preferredGender = json['preferredGender'];
    shortDescription = json['shortDescription'];
    briefFile = json['briefFile'];
    jobType = json['jobType'];
    brief = json['brief'];
    noOfApplicants = json['noOfApplicants'];
    briefLink = json['briefLink'];
    deliverablesType = json['deliverablesType'];
    isDigitalContent = json['isDigitalContent'];
    deliveryType = json['deliveryType'];
    ethnicity = json['ethnicity'];
    size = json['size'];
    skinComplexion = json['skinComplexion'];
    createdAt = json['createdAt'];
    deleted = json['deleted'];
    views = json['views'];
    acceptMultiple = json['acceptMultiple'];
    minAge = json['minAge'];
    maxAge = json['maxAge'];
    talents = json['talents'].cast<String>();
    talentHeight = json['talentHeight'];
    if (json['jobDelivery'] != null) {
      jobDelivery = <JobDelivery>[];
      json['jobDelivery'].forEach((v) {
        jobDelivery!.add(new JobDelivery.fromJson(v));
      });
    }
    jobLocation = json['jobLocation'] != null
        ? new JobLocation.fromJson(json['jobLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    data['jobTitle'] = this.jobTitle;
    data['priceOption'] = this.priceOption;
    data['priceValue'] = this.priceValue;
    data['preferredGender'] = this.preferredGender;
    data['shortDescription'] = this.shortDescription;
    data['briefFile'] = this.briefFile;
    data['brief'] = this.brief;
    data['jobType'] = this.jobType;
    data['briefLink'] = this.briefLink;
    data['noOfApplicants'] = this.noOfApplicants;
    data['deliverablesType'] = this.deliverablesType;
    data['isDigitalContent'] = this.isDigitalContent;
    data['deliveryType'] = this.deliveryType;
    data['ethnicity'] = this.ethnicity;
    data['size'] = this.size;
    data['skinComplexion'] = this.skinComplexion;
    data['createdAt'] = this.createdAt;
    data['deleted'] = this.deleted;
    data['views'] = this.views;
    data['acceptMultiple'] = this.acceptMultiple;
    data['minAge'] = this.minAge;
    data['maxAge'] = this.maxAge;
    data['talents'] = this.talents;
    data['talentHeight'] = this.talentHeight;
    if (this.jobDelivery != null) {
      data['jobDelivery'] = this.jobDelivery!.map((v) => v.toJson()).toList();
    }
    if (this.jobLocation != null) {
      data['jobLocation'] = this.jobLocation!.toJson();
    }
    return data;
  }
}

class Creator {
  String? id;
  String? profilePicture;
  String? lastName;
  String? firstName;
  String? username;

  Creator(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.profilePicture});

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    profilePicture = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['profilePicture'] = this.profilePicture;

    return data;
  }
}

class JobDelivery {
  String? date;
  String? startTime;
  String? endTime;

  JobDelivery({this.date, this.startTime, this.endTime});

  JobDelivery.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }
}

class JobLocation {
  String? latitude;
  String? longitude;
  String? locationName;

  JobLocation({this.latitude, this.longitude, this.locationName});

  JobLocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    locationName = json['locationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['locationName'] = this.locationName;
    return data;
  }
}
