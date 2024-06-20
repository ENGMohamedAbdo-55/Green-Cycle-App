class ReportModel {
  String? id;
  String? city;
  String? country;
  String? address;
  String? description;
    String? reportCameraUrl;
  ReportModel(
      {this.id, this.address, this.city, this.description, this.country,this.reportCameraUrl,});
  ReportModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    description = json['description'];
    description = json['description'];
    country = json['country'];
    reportCameraUrl = json['cameraUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'description': description,
      'country': country,
      'address': address,
      'cameraUrl': reportCameraUrl,
    };
  }
}
