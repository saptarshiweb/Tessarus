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
//         events!.add(Events.fromJson(v));
//       });
//     }
//     message = json['message'];
//     statusCode = json['statusCode'];
//     statusMessage = json['statusMessage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (events != null) {
//       data['events'] = events!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = message;
//     data['statusCode'] = statusCode;
//     data['statusMessage'] = statusMessage;
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
  String? rules;
  String? prizes;
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
      this.rules,
      this.prizes,
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
        ? EventOrganiserClub.fromJson(json['eventOrganiserClub'])
        : null;
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    tagLine = json['tagLine'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    eventVenue = json['eventVenue'];
    rules = json['rules'];
    prizes = json['prizes'];
    if (json['eventImages'] != null) {
      eventImages = <EventImages>[];
      json['eventImages'].forEach((v) {
        eventImages!.add(EventImages.fromJson(v));
      });
    }
    eventType = json['eventType'];
    eventMinParticipants = json['eventMinParticipants'];
    eventMaxParticipants = json['eventMaxParticipants'];
    eventPrice = json['eventPrice'];
    if (json['eventCoordinators'] != null) {
      eventCoordinators = <EventCoordinators>[];
      json['eventCoordinators'].forEach((v) {
        eventCoordinators!.add(EventCoordinators.fromJson(v));
      });
    }
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eventOrganiserClub != null) {
      data['eventOrganiserClub'] = eventOrganiserClub!.toJson();
    }
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['tagLine'] = tagLine;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['eventVenue'] = eventVenue;
    data['rules'] = rules;
    data['prizes'] = prizes;
    if (eventImages != null) {
      data['eventImages'] = eventImages!.map((v) => v.toJson()).toList();
    }
    data['eventType'] = eventType;
    data['eventMinParticipants'] = eventMinParticipants;
    data['eventMaxParticipants'] = eventMaxParticipants;
    data['eventPrice'] = eventPrice;
    if (eventCoordinators != null) {
      data['eventCoordinators'] =
          eventCoordinators!.map((v) => v.toJson()).toList();
    }
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['_id'] = sId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['_id'] = sId;
    return data;
  }
}

class EventCoordinatorsAdd {
  String? name;
  String? phone;

  EventCoordinatorsAdd({this.name, this.phone});

  EventCoordinatorsAdd.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}
