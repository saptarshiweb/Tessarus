class VolunteerLogin {
  String? authToken;
  Volunteer? volunteer;
  String? message;
  int? statusCode;
  String? statusMessage;

  VolunteerLogin(
      {this.authToken,
      this.volunteer,
      this.message,
      this.statusCode,
      this.statusMessage});

  VolunteerLogin.fromJson(Map<String, dynamic> json) {
    authToken = json['auth_token'];
    volunteer = json['volunteer'] != null
        ? Volunteer.fromJson(json['volunteer'])
        : null;
    message = json['message'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auth_token'] = authToken;
    if (volunteer != null) {
      data['volunteer'] = volunteer!.toJson();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['statusMessage'] = statusMessage;
    return data;
  }
}

class Volunteer {
  String? sId;
  String? name;
  String? email;
  String? phone;
  List<String>? events;
  int? accessLevel;
  String? profileImageUrl;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Volunteer(
      {this.sId,
      this.name,
      this.email,
      this.phone,
      this.events,
      this.accessLevel,
      this.profileImageUrl,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Volunteer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    // if (json['events'] != null) {
    //   events = <Null>[];
    //   json['events'].forEach((v) {
    //     events!.add(Null.fromJson(v));
    //   });
    // }
    //events json
    events = json['events'].cast<String>();

    accessLevel = json['accessLevel'];
    profileImageUrl = json['profileImageUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    // if (this.events != null) {
    //   data['events'] = this.events!.map((v) => v.toJson()).toList();
    // }
    data['events'] = events;
    data['accessLevel'] = accessLevel;
    data['profileImageUrl'] = profileImageUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
