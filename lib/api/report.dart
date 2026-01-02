import 'package:dz_pub/api/users.dart';

class ReportsRes {
  final bool status;
  final String message;
  final List<Report> data;

  ReportsRes({required this.status, required this.message, required this.data});

  factory ReportsRes.fromJson(Map<String, dynamic> json) {
    return ReportsRes(
      status: json['status'] == true,
      message: s(json['message']),
      data: json['data'] != null
          ? (json['data'] as List).map((e) => Report.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
  };
}

class AddReportRes {
  final bool status;
  final String message;
  final Report? data;

  AddReportRes({required this.status, required this.message, this.data});

  factory AddReportRes.fromJson(Map<String, dynamic> json) {
    return AddReportRes(
      status: json['status'] == true,
      message: s(json['message']),
      data: json['data'] != null ? Report.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class ReportStatus {
  final int id;
  final String name;

  ReportStatus({required this.id, required this.name});

  factory ReportStatus.fromJson(Map<String, dynamic> json) {
    return ReportStatus(id: i(json['id']) ?? 0, name: s(json['name']));
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class Report {
  int? id;
  int? reporterId;
  int? reportedId;
  String? content;
  int? reportStatusId;
  String? createdAt;
  String? updatedAt;

  User? reporter;
  User? reported;
  ReportStatus? status;

  Report({
    this.id,
    this.reporterId,
    this.reportedId,
    this.content,
    this.reportStatusId,
    this.createdAt,
    this.updatedAt,
    this.reporter,
    this.reported,
    this.status,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: i(json['id']),
      reporterId: i(json['reporter_id']),
      reportedId: i(json['reported_id']),
      content: s(json['content']),
      reportStatusId: i(json['report_status_id']),
      createdAt: s(json['created_at']),
      updatedAt: s(json['updated_at']),
      reporter: json['reporter'] != null
          ? User.fromJson(json['reporter'])
          : null,
      reported: json['reported'] != null
          ? User.fromJson(json['reported'])
          : null,
      status: json['status'] != null
          ? ReportStatus.fromJson(json['status'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reporter_id': reporterId,
      'reported_id': reportedId,
      'content': content,
      'report_status_id': reportStatusId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'reporter': reporter?.toJson(),
      'reported': reported?.toJson(),
      'status': status?.toJson(),
    };
  }
}
