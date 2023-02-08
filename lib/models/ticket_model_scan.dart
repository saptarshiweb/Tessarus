class TicketModel {
  List<Tickets>? tickets;
  String? message;
  int? statusCode;
  String? statusMessage;

  TicketModel(
      {this.tickets, this.message, this.statusCode, this.statusMessage});

  TicketModel.fromJson(Map<String, dynamic> json) {
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(Tickets.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['statusMessage'] = statusMessage;
    return data;
  }
}

class Tickets {
  Team? team;
  String? sId;
  String? eventId;
  String? userId;
  bool? checkedIn;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? checkedInAt;
  String? ticketNumber;

  Tickets(
      {this.team,
      this.sId,
      this.eventId,
      this.userId,
      this.checkedIn,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.checkedInAt,
      this.ticketNumber});

  Tickets.fromJson(Map<String, dynamic> json) {
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    sId = json['_id'];
    eventId = json['eventId'];
    userId = json['userId'];
    checkedIn = json['checkedIn'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    checkedInAt = json['checkedInAt'];
    ticketNumber = json['ticketNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (team != null) {
      data['team'] = team!.toJson();
    }
    data['_id'] = sId;
    data['eventId'] = eventId;
    data['userId'] = userId;
    data['checkedIn'] = checkedIn;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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
  String? name;
  String? designation;
  String? espektroId;
  String? sId;

  Members({this.name, this.designation, this.espektroId, this.sId});

  Members.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    designation = json['designation'];
    espektroId = json['espektroId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['designation'] = designation;
    data['espektroId'] = espektroId;
    data['_id'] = sId;
    return data;
  }
}
