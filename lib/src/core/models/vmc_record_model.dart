class VMCRecordModel {
  Vmcrecord? vmcrecord;

  VMCRecordModel({this.vmcrecord});

  VMCRecordModel.fromJson(Map<String, dynamic> json) {
    vmcrecord = json['vmcrecord'] != null
        ? new Vmcrecord.fromJson(json['vmcrecord'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vmcrecord != null) {
      data['vmcrecord'] = this.vmcrecord!.toJson();
    }
    return data;
  }
}

class Vmcrecord {
  String? id;
  int? shareContent;
  int? referAFriend;
  int? receivePositiveReviews;
  String? dateCreated;
  int? totalVmcPoints;

  Vmcrecord(
      {this.id,
      this.shareContent,
      this.referAFriend,
      this.receivePositiveReviews,
      this.dateCreated,
      this.totalVmcPoints});

  Vmcrecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shareContent = json['shareContent'];
    referAFriend = json['referAFriend'];
    receivePositiveReviews = json['receivePositiveReviews'];
    dateCreated = json['dateCreated'];
    totalVmcPoints = json['totalVmcPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shareContent'] = this.shareContent;
    data['referAFriend'] = this.referAFriend;
    data['receivePositiveReviews'] = this.receivePositiveReviews;
    data['dateCreated'] = this.dateCreated;
    data['totalVmcPoints'] = this.totalVmcPoints;
    return data;
  }
}

