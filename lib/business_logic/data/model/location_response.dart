

class LocationResponse {
  bool? status;
  String? message;
  List<LocationModel>? locations;

  LocationResponse({this.status, this.message, this.locations});

  LocationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      locations = new List<LocationModel>.empty(growable: true);
      json['result'].forEach((v) {
        locations?.add(new LocationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.locations != null) {
      data['result'] = this.locations?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class LocationModel {
  int? locationId;
  String? locationName;

  LocationModel({
    this.locationId,
    this.locationName,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    locationId = json['id'];
    locationName = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['location_id'] = locationId;
    data['location_name'] = locationName;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'en': locationName,
    };
  }
  LocationModel.fromMap(Map map)
      : locationName = map['name'];

}
