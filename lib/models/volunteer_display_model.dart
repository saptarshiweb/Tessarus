class VolunteerDisplayModel {
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

  VolunteerDisplayModel(
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

  VolunteerDisplayModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
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
    data['events'] = events;
    data['accessLevel'] = accessLevel;
    data['profileImageUrl'] = profileImageUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
