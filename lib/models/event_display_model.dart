// class EventDisplayModel {
//   List<Events>? events;
//   String? message;
//   int? statusCode;
//   String? statusMessage;

//   EventDisplayModel(
//       {this.events, this.message, this.statusCode, this.statusMessage});

//   EventDisplayModel.fromJson(Map<String, dynamic> json) {
//     if (json['events'] != null) {
//       events = <Events>[];
//       json['events'].forEach((v) {
//         events!.add(new Events.fromJson(v));
//       });
//     }
//     message = json['message'];
//     statusCode = json['statusCode'];
//     statusMessage = json['statusMessage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.events != null) {
//       data['events'] = this.events!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     data['statusCode'] = this.statusCode;
//     data['statusMessage'] = this.statusMessage;
//     return data;
//   }
// }

class Events {
  EventOrganiserClub? eventOrganiserClub;
  String? sId;
  String? title;
  String? description;
  String? tagLine;
  String? startTime;
  String? endTime;
  String? eventVenue;
  List<EventImages>? eventImages;
  String? eventType;
  int? eventMinParticipants;
  int? eventMaxParticipants;
  int? eventPrice;
  List<EventCoordinators>? eventCoordinators;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Events(
      {this.eventOrganiserClub,
      this.sId,
      this.title,
      this.description,
      this.tagLine,
      this.startTime,
      this.endTime,
      this.eventVenue,
      this.eventImages,
      this.eventType,
      this.eventMinParticipants,
      this.eventMaxParticipants,
      this.eventPrice,
      this.eventCoordinators,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Events.fromJson(Map<String, dynamic> json) {
    eventOrganiserClub = json['eventOrganiserClub'] != null
        ? new EventOrganiserClub.fromJson(json['eventOrganiserClub'])
        : null;
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    tagLine = json['tagLine'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    eventVenue = json['eventVenue'];
    if (json['eventImages'] != null) {
      eventImages = <EventImages>[];
      json['eventImages'].forEach((v) {
        eventImages!.add(new EventImages.fromJson(v));
      });
    }
    eventType = json['eventType'];
    eventMinParticipants = json['eventMinParticipants'];
    eventMaxParticipants = json['eventMaxParticipants'];
    eventPrice = json['eventPrice'];
    if (json['eventCoordinators'] != null) {
      eventCoordinators = <EventCoordinators>[];
      json['eventCoordinators'].forEach((v) {
        eventCoordinators!.add(new EventCoordinators.fromJson(v));
      });
    }
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventOrganiserClub != null) {
      data['eventOrganiserClub'] = this.eventOrganiserClub!.toJson();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['tagLine'] = this.tagLine;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['eventVenue'] = this.eventVenue;
    if (this.eventImages != null) {
      data['eventImages'] = this.eventImages!.map((v) => v.toJson()).toList();
    }
    data['eventType'] = this.eventType;
    data['eventMinParticipants'] = this.eventMinParticipants;
    data['eventMaxParticipants'] = this.eventMaxParticipants;
    data['eventPrice'] = this.eventPrice;
    if (this.eventCoordinators != null) {
      data['eventCoordinators'] =
          this.eventCoordinators!.map((v) => v.toJson()).toList();
    }
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class EventOrganiserClub {
  String? name;
  String? image;

  EventOrganiserClub({this.name, this.image});

  EventOrganiserClub.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class EventImages {
  String? url;
  String? sId;

  EventImages({this.url, this.sId});

  EventImages.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['_id'] = this.sId;
    return data;
  }
}

class EventCoordinators {
  String? name;
  String? phone;
  String? sId;

  EventCoordinators({this.name, this.phone, this.sId});

  EventCoordinators.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['_id'] = this.sId;
    return data;
  }
}
