// class UserModelQr {
//   User? user;
//   String? message;
//   int? statusCode;
//   String? statusMessage;

//   UserModelQr({this.user, this.message, this.statusCode, this.statusMessage});

//   UserModelQr.fromJson(Map<String, dynamic> json) {
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//     message = json['message'];
//     statusCode = json['statusCode'];
//     statusMessage = json['statusMessage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (user != null) {
//       data['user'] = user!.toJson();
//     }
//     data['message'] = message;
//     data['statusCode'] = statusCode;
//     data['statusMessage'] = statusMessage;
//     return data;
//   }
// }

class User {
  String? sId;
  String? name;
  bool? verified;
  String? espektroId;
  String? email;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? college;
  String? degree;
  String? year;
  String? stream;
  int? coins;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? profileImageUrl;

  User(
      {this.sId,
      this.name,
      this.verified,
      this.espektroId,
      this.email,
      this.phone,
      this.gender,
      this.dateOfBirth,
      this.college,
      this.degree,
      this.year,
      this.stream,
      this.coins,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.profileImageUrl});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    verified = json['verified'];
    espektroId = json['espektroId'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    college = json['college'];
    degree = json['degree'];
    year = json['year'];
    stream = json['stream'];
    coins = json['coins'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['verified'] = verified;
    data['espektroId'] = espektroId;
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    data['college'] = college;
    data['degree'] = degree;
    data['year'] = year;
    data['stream'] = stream;
    data['coins'] = coins;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['profileImageUrl'] = profileImageUrl;
    return data;
  }
}
