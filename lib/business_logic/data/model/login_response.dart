class LoginResponse {
  bool? status;
  String? message;
  Result? result;

  LoginResponse({this.status, this.message, this.result});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result?.toJson();
    }
    return data;
  }
}

class Result {
  String? tokenType;
  int? userId;
  String? email;
  String? accessToken;
  int? roleId;
  String? msg;
  String? userName;
  int? locationId;
  var locationName;
  int? registerStatus;
  var profilePic;

  Result({this.tokenType, this.userId, this.email, this.accessToken, this.roleId, this.msg});

  Result.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    userId = json['user_id'];
    email = json['email'];
    accessToken = json['access_token'];
    roleId = json['role_id'];
    msg = json['msg'];
    userName = json['user_name'];
    locationId = json['location_id'];
    locationName = json['location_name'];
    registerStatus = json['registration_status_id'];
    profilePic = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token_type'] = this.tokenType;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['access_token'] = this.accessToken;
    data['role_id'] = this.roleId;
    data['msg'] = this.msg;
    data['user_name'] = this.userName;
    data['location_id'] = this.locationId;
    data['location_name'] = this.locationName;
    data['registration_status_id'] = this.registerStatus;
    data['profile_image'] = this.profilePic;
    return data;
  }
}
