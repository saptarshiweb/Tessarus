class ParticipantsModel {
  List<Events>? events;
  String? message;
  int? statusCode;
  String? statusMessage;

  ParticipantsModel(
      {this.events, this.message, this.statusCode, this.statusMessage});

  ParticipantsModel.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(Events.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['statusMessage'] = statusMessage;
    return data;
  }
}

class Events {
  String? sId;
  String? eventId;
  String? userId;
  bool? checkedIn;
  Team? team;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? userName;
  String? userPhone;
  String? userEmail;
  String? userCollege;
  String? userYear;
  String? userEspektroId;
  String? checkedInAt;
  String? ticketNumber;

  Events(
      {this.sId,
      this.eventId,
      this.userId,
      this.checkedIn,
      this.team,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.userName,
      this.userPhone,
      this.userEmail,
      this.userCollege,
      this.userYear,
      this.userEspektroId,
      this.checkedInAt,
      this.ticketNumber});

  Events.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    eventId = json['eventId'];
    userId = json['userId'];
    checkedIn = json['checkedIn'];
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    userName = json['userName'];
    userPhone = json['userPhone'];
    userEmail = json['userEmail'];
    userCollege = json['userCollege'];
    userYear = json['userYear'];
    userEspektroId = json['userEspektroId'];
    checkedInAt = json['checkedInAt'];
    ticketNumber = json['ticketNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['eventId'] = eventId;
    data['userId'] = userId;
    data['checkedIn'] = checkedIn;
    if (team != null) {
      data['team'] = team!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['userName'] = userName;
    data['userPhone'] = userPhone;
    data['userEmail'] = userEmail;
    data['userCollege'] = userCollege;
    data['userYear'] = userYear;
    data['userEspektroId'] = userEspektroId;
    data['checkedInAt'] = checkedInAt;
    data['ticketNumber'] = ticketNumber;
    return data;
  }
}

class Team {
  String? name;
  List<Members>? members;

  Team({this.name, this.members});

  Team.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  String? espektroId;
  String? sId;

  Members({this.espektroId, this.sId});

  Members.fromJson(Map<String, dynamic> json) {
    espektroId = json['espektroId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['espektroId'] = espektroId;
    data['_id'] = sId;
    return data;
  }
}
