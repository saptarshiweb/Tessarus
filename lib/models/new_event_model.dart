class Events {
  String? title;
  String? description;
  String? tagLine;
  String? startTime;
  String? endTime;
  String? eventVenue;
  String? eventType;
  String? rules;
  String? prizes;
  int? eventMinParticipants;
  int? eventMaxParticipants;
  int? eventPrice;
  int? eventPriceForKGEC;
  List<EventImages>? eventImages;
  EventOrganiserClub? eventOrganiserClub;
  List<EventCoordinators>? eventCoordinators;
  List<Sponsors>? sponsors;
  String? otherPlatformUrl;
  Events(
      {this.title,
      this.description,
      this.tagLine,
      this.startTime,
      this.endTime,
      this.eventVenue,
      this.eventType,
      this.rules,
      this.prizes,
      this.eventMinParticipants,
      this.eventMaxParticipants,
      this.eventPrice,
      this.eventPriceForKGEC,
      this.eventImages,
      this.eventOrganiserClub,
      this.eventCoordinators,
      this.sponsors,
      this.otherPlatformUrl});

  Events.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    tagLine = json['tagLine'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    eventVenue = json['eventVenue'];
    eventType = json['eventType'];
    rules = json['rules'];
    prizes = json['prizes'];
    eventMinParticipants = json['eventMinParticipants'];
    eventMaxParticipants = json['eventMaxParticipants'];
    eventPrice = json['eventPrice'];
    eventPriceForKGEC = json['eventPriceForKGEC'];
    if (json['eventImages'] != null) {
      eventImages = <EventImages>[];
      json['eventImages'].forEach((v) {
        eventImages!.add(EventImages.fromJson(v));
      });
    }
    eventOrganiserClub = json['eventOrganiserClub'] != null
        ? EventOrganiserClub.fromJson(json['eventOrganiserClub'])
        : null;
    if (json['eventCoordinators'] != null) {
      eventCoordinators = <EventCoordinators>[];
      json['eventCoordinators'].forEach((v) {
        eventCoordinators!.add(EventCoordinators.fromJson(v));
      });
    }

    if (json['sponsors'] != null) {
      sponsors = <Sponsors>[];
      json['sponsors'].forEach((v) {
        sponsors!.add(Sponsors.fromJson(v));
      });
    }
    otherPlatformUrl = json['otherPlatformUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['tagLine'] = tagLine;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['eventVenue'] = eventVenue;
    data['eventType'] = eventType;
    data['rules'] = rules;
    data['prizes'] = prizes;
    data['eventMinParticipants'] = eventMinParticipants;
    data['eventMaxParticipants'] = eventMaxParticipants;
    data['eventPrice'] = eventPrice;
    data['eventPriceForKGEC'] = eventPriceForKGEC;
    if (eventImages != null) {
      data['eventImages'] = eventImages!.map((v) => v.toJson()).toList();
    }
    if (eventOrganiserClub != null) {
      data['eventOrganiserClub'] = eventOrganiserClub!.toJson();
    }
    if (eventCoordinators != null) {
      data['eventCoordinators'] =
          eventCoordinators!.map((v) => v.toJson()).toList();
    }
    if (sponsors != null) {
      data['sponsors'] = sponsors!.map((v) => v.toJson()).toList();
    }
    data['otherPlatformUrl'] = otherPlatformUrl;
    return data;
  }
}

class EventImages {
  String? url;

  EventImages({this.url});

  EventImages.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
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

class EventCoordinators {
  String? name;
  String? phone;

  EventCoordinators({this.name, this.phone});

  EventCoordinators.fromJson(Map<String, dynamic> json) {
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

class Sponsors {
  String? name;
  String? image;
  String? type;

  Sponsors({this.name, this.image, this.type});

  Sponsors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['type'] = type;
    return data;
  }
}
