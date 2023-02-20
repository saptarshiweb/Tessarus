class PaymentLogs {
  Logs? logs;
  String? message;
  int? statusCode;
  String? statusMessage;

  PaymentLogs({this.logs, this.message, this.statusCode, this.statusMessage});

  PaymentLogs.fromJson(Map<String, dynamic> json) {
    logs = json['logs'] != null ? Logs.fromJson(json['logs']) : null;
    message = json['message'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (logs != null) {
      data['logs'] = logs!.toJson();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['statusMessage'] = statusMessage;
    return data;
  }
}

class Logs {
  int? totalDocuments;
  int? totalPages;
  int? currentPage;
  int? documentPerPage;
  List<Documents>? documents;

  Logs(
      {this.totalDocuments,
      this.totalPages,
      this.currentPage,
      this.documentPerPage,
      this.documents});

  Logs.fromJson(Map<String, dynamic> json) {
    totalDocuments = json['total_documents'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    documentPerPage = json['document_per_page'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_documents'] = totalDocuments;
    data['total_pages'] = totalPages;
    data['current_page'] = currentPage;
    data['document_per_page'] = documentPerPage;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Documents {
  String? sId;
  String? logType;
  String? volunteerId;
  String? userId;
  int? amount;
  String? description;
  int? iV;
  int? coins;

  Documents(
      {this.sId,
      this.logType,
      this.volunteerId,
      this.userId,
      this.amount,
      this.description,
      this.iV,
      this.coins});

  Documents.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    logType = json['logType'];
    volunteerId = json['volunteerId'];
    userId = json['userId'];
    amount = json['amount'];
    description = json['description'];
    iV = json['__v'];
    coins = json['coins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['logType'] = logType;
    data['volunteerId'] = volunteerId;
    data['userId'] = userId;
    data['amount'] = amount;
    data['description'] = description;
    data['__v'] = iV;
    data['coins'] = coins;
    return data;
  }
}
