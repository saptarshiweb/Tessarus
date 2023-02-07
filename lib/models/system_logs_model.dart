class SystemLogs {
  Logs? logs;
  String? message;
  int? statusCode;
  String? statusMessage;

  SystemLogs({this.logs, this.message, this.statusCode, this.statusMessage});

  SystemLogs.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Documents(
      {this.sId,
      this.logType,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Documents.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    logType = json['logType'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['logType'] = logType;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
