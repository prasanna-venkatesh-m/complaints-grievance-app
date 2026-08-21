import 'package:flutter/foundation.dart';

enum GrievanceTab { fileNew, myGrievances }

@immutable
class WardModel {
  final String id;
  final String nameEn;
  final String nameTa;
  final int wardNo;
  final bool isActive;

  const WardModel({
    required this.id,
    required this.nameEn,
    required this.nameTa,
    required this.wardNo,
    required this.isActive,
  });

  factory WardModel.fromJson(Map<String, dynamic> json) {
    final wardName = json['WardName'];

    String nameEn = '';
    String nameTa = '';

    if (wardName is Map) {
      nameEn = wardName['en']?.toString() ?? '';
      nameTa = wardName['ta']?.toString() ?? '';
    }

    return WardModel(
      id: json['_id']?.toString() ?? '',
      nameEn: nameEn,
      nameTa: nameTa,
      wardNo: _toInt(json['WardNo']),
      isActive: json['IsActive'] == true,
    );
  }

  String get displayName => nameEn;

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

@immutable
class GrievanceModel {
  final String id;
  final String ticketId;
  final String issueCategory;
  final String department;
  final String priority;
  final String source;
  final String description;
  final String? constituency;
  final String? ward;
  final String? area;
  final String? street;
  final double? latitude;
  final double? longitude;
  final List<AttachmentModel> attachments;
  final String submittedBy;
  final String status;
  final DateTime? dueOn;
  final List<StatusHistoryModel> statusHistory;
  final List<ProgressHistoryModel> progressHistory;
  final ResolutionModel? resolution;
  final DateTime? reopenedOn;
  final String? reopenReason;
  final int reopenCount;
  final RatingModel? rating;
  final bool isActive;
  final bool isDeleted;

  const GrievanceModel({
    required this.id,
    required this.ticketId,
    required this.issueCategory,
    required this.department,
    required this.priority,
    required this.source,
    required this.description,
    required this.constituency,
    required this.ward,
    required this.area,
    required this.street,
    required this.latitude,
    required this.longitude,
    required this.attachments,
    required this.submittedBy,
    required this.status,
    required this.dueOn,
    required this.statusHistory,
    required this.progressHistory,
    required this.resolution,
    required this.reopenedOn,
    required this.reopenReason,
    required this.reopenCount,
    required this.rating,
    required this.isActive,
    required this.isDeleted,
  });

  factory GrievanceModel.fromJson(Map<String, dynamic> json) {
    return GrievanceModel(
      id: json['_id']?.toString() ?? '',
      ticketId: json['TicketId']?.toString() ?? '',
      issueCategory: json['IssueCategory']?.toString() ?? '',
      department: json['Department']?.toString() ?? '',
      priority: json['Priority']?.toString() ?? '',
      source: json['Source']?.toString() ?? '',
      description: json['Description']?.toString() ?? '',
      constituency: json['Constituency']?.toString(),
      ward: json['Ward']?.toString(),
      area: json['Area']?.toString(),
      street: json['Street']?.toString(),
      latitude: _toDouble(json['Latitude']),
      longitude: _toDouble(json['Longitude']),
      attachments: _parseList(json['Attachments'], AttachmentModel.fromJson),
      submittedBy: json['SubmittedBy']?.toString() ?? '',
      status: json['Status']?.toString() ?? '',
      dueOn: _toDateTime(json['DueOn']),
      statusHistory: _parseList(
        json['StatusHistory'],
        StatusHistoryModel.fromJson,
      ),
      progressHistory: _parseList(
        json['ProgressHistory'],
        ProgressHistoryModel.fromJson,
      ),
      resolution: json['Resolution'] is Map<String, dynamic>
          ? ResolutionModel.fromJson(json['Resolution'] as Map<String, dynamic>)
          : null,
      reopenedOn: _toDateTime(json['ReopenedOn']),
      reopenReason: json['ReopenReason']?.toString(),
      reopenCount: _toInt(json['ReopenCount']),
      rating: json['Rating'] is Map<String, dynamic>
          ? RatingModel.fromJson(json['Rating'] as Map<String, dynamic>)
          : null,
      isActive: json['IsActive'] == true,
      isDeleted: json['IsDeleted'] == true,
    );
  }

  String get title => description;

  int get ratingValue => rating?.rating ?? 0;

  String get date {
    if (resolution?.resolvedOn != null) {
      return _formatDate(resolution!.resolvedOn!);
    }

    if (dueOn != null) {
      return _formatDate(dueOn!);
    }

    return '';
  }

  bool get isResolved => status.toUpperCase() == 'RESOLVED';

  static String _formatDate(DateTime date) {
    final local = date.toLocal();

    return '${local.day.toString().padLeft(2, '0')} '
        '${_monthName(local.month)} '
        '${local.year}';
  }

  static String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return months[month - 1];
  }

  static double? _toDouble(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString());
  }

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static DateTime? _toDateTime(dynamic value) {
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(value.toString());
  }

  static List<T> _parseList<T>(
    dynamic value,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (value is! List) {
      return const [];
    }

    return value
        .whereType<Map>()
        .map((item) => fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}

@immutable
class GrievanceLatestResponse {
  final List<GrievanceModel> latestOpen;
  final List<GrievanceModel> recentResolved;
  final String message;

  const GrievanceLatestResponse({
    required this.latestOpen,
    required this.recentResolved,
    required this.message,
  });

  factory GrievanceLatestResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map
        ? Map<String, dynamic>.from(json['data'] as Map)
        : <String, dynamic>{};

    return GrievanceLatestResponse(
      latestOpen: GrievanceModel._parseList(
        data['latestOpen'],
        GrievanceModel.fromJson,
      ),
      recentResolved: GrievanceModel._parseList(
        data['recentResolved'],
        GrievanceModel.fromJson,
      ),
      message: json['message']?.toString() ?? '',
    );
  }

  List<GrievanceModel> get allGrievances {
    return [...latestOpen, ...recentResolved];
  }
}

@immutable
class AttachmentModel {
  final String type;
  final String url;
  final String? thumbnailUrl;
  final String? title;
  final int? fileSize;
  final DateTime? uploadedOn;

  const AttachmentModel({
    required this.type,
    required this.url,
    required this.thumbnailUrl,
    required this.title,
    required this.fileSize,
    required this.uploadedOn,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      type: json['Type']?.toString() ?? '',
      url: json['Url']?.toString() ?? '',
      thumbnailUrl: json['ThumbnailUrl']?.toString(),
      title: json['Title']?.toString(),
      fileSize: _toInt(json['FileSize']),
      uploadedOn: _toDateTime(json['UploadedOn']),
    );
  }

  static int? _toInt(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value.toString());
  }

  static DateTime? _toDateTime(dynamic value) {
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(value.toString());
  }
}

@immutable
class StatusHistoryModel {
  final String status;
  final String? remarks;
  final String changedBy;
  final DateTime? changedOn;

  const StatusHistoryModel({
    required this.status,
    required this.remarks,
    required this.changedBy,
    required this.changedOn,
  });

  factory StatusHistoryModel.fromJson(Map<String, dynamic> json) {
    return StatusHistoryModel(
      status: json['Status']?.toString() ?? '',
      remarks: json['Remarks']?.toString(),
      changedBy: json['ChangedBy']?.toString() ?? '',
      changedOn: DateTime.tryParse(json['ChangedOn']?.toString() ?? ''),
    );
  }
}

@immutable
class ProgressHistoryModel {
  final String description;
  final String updatedBy;
  final DateTime? updatedOn;
  final List<AttachmentModel> attachments;

  const ProgressHistoryModel({
    required this.description,
    required this.updatedBy,
    required this.updatedOn,
    required this.attachments,
  });

  factory ProgressHistoryModel.fromJson(Map<String, dynamic> json) {
    final rawAttachments = json['Attachments'];

    return ProgressHistoryModel(
      description: json['Description']?.toString() ?? '',
      updatedBy: json['UpdatedBy']?.toString() ?? '',
      updatedOn: DateTime.tryParse(json['UpdatedOn']?.toString() ?? ''),
      attachments: rawAttachments is List
          ? rawAttachments
                .whereType<Map>()
                .map(
                  (item) =>
                      AttachmentModel.fromJson(Map<String, dynamic>.from(item)),
                )
                .toList()
          : const [],
    );
  }
}

@immutable
class ResolutionModel {
  final String? description;
  final String? resolvedBy;
  final DateTime? resolvedOn;
  final List<AttachmentModel> attachments;

  const ResolutionModel({
    required this.description,
    required this.resolvedBy,
    required this.resolvedOn,
    required this.attachments,
  });

  factory ResolutionModel.fromJson(Map<String, dynamic> json) {
    final rawAttachments = json['Attachments'];

    return ResolutionModel(
      description: json['Description']?.toString(),
      resolvedBy: json['ResolvedBy']?.toString(),
      resolvedOn: DateTime.tryParse(json['ResolvedOn']?.toString() ?? ''),
      attachments: rawAttachments is List
          ? rawAttachments
                .whereType<Map>()
                .map(
                  (item) =>
                      AttachmentModel.fromJson(Map<String, dynamic>.from(item)),
                )
                .toList()
          : const [],
    );
  }
}

@immutable
class RatingModel {
  final int rating;
  final String? feedback;
  final String ratedBy;
  final DateTime? ratedOn;

  const RatingModel({
    required this.rating,
    required this.feedback,
    required this.ratedBy,
    required this.ratedOn,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rating: _toInt(json['Rating']),
      feedback: json['Feedback']?.toString(),
      ratedBy: json['RatedBy']?.toString() ?? '',
      ratedOn: DateTime.tryParse(json['RatedOn']?.toString() ?? ''),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class DropdownData {
  final List<String> wards;
  final List<String> areas;
  final List<String> streets;

  DropdownData({
    required this.wards,
    required this.areas,
    required this.streets,
  });
}
