import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tvk_grievance/features/grievance/grievance_remote_data_source.dart';
import 'package:tvk_grievance/features/location_picker/location_picker_model.dart';
import 'package:tvk_grievance/shared/models/media_file_model.dart';

import 'grievance_constants.dart';
import 'grievance_model.dart';
import 'grievance_repository.dart';

class GrievanceController extends ChangeNotifier {
  final GrievanceRepository repository;

  GrievanceController(this.repository);

  double? latitude;
  double? longitude;
  String? address;

  final List<MediaFileModel> attachments = [];

  // ============================================================
  // API STATE - GET GRIEVANCES
  // ============================================================

  bool isLoadingGrievances = false;
  String? grievanceErrorMessage;

  // ============================================================
  // API STATE - SUBMIT GRIEVANCE
  // ============================================================

  bool isSubmittingGrievance = false;
  String? submitGrievanceErrorMessage;

  // ============================================================
  // MAP
  // ============================================================

  void setLocation(LocationPickerModel location) {
    latitude = location.latitude;
    longitude = location.longitude;
    address = location.address;

    notifyListeners();
  }

  // ============================================================
  // FILES
  // ============================================================

  void addMedia(List<MediaFileModel> files) {
    attachments.addAll(files);
    notifyListeners();
  }

  void removeMedia(int index) {
    if (index < 0 || index >= attachments.length) {
      return;
    }

    attachments.removeAt(index);
    notifyListeners();
  }

  void clearMedia() {
    attachments.clear();
    notifyListeners();
  }

  // ============================================================
  // FORM
  // ============================================================

  void changeAreaText(String value) {
    selectedArea = value;
    notifyListeners();
  }

  void changeStreetText(String value) {
    selectedStreet = value;
    notifyListeners();
  }

  // ============================================================
  // TAB
  // ============================================================

  GrievanceTab selectedTab = GrievanceTab.fileNew;

  void changeTab(GrievanceTab tab) {
    selectedTab = tab;
    notifyListeners();
  }

  // ============================================================
  // MY GRIEVANCES
  // ============================================================

  List<GrievanceModel> grievances = [];

  List<GrievanceModel> openGrievances = [];

  List<GrievanceModel> resolvedGrievances = [];

  Future<void> loadGrievances({required String userId}) async {
    if (isLoadingGrievances) {
      return;
    }

    isLoadingGrievances = true;
    grievanceErrorMessage = null;

    notifyListeners();

    try {
      final response = await repository.getLatestGrievances(userId: userId);

      openGrievances = response.latestOpen;
      resolvedGrievances = response.recentResolved;
      grievances = response.allGrievances;
    } catch (error) {
      grievanceErrorMessage = _getUserFriendlyError(error);
    } finally {
      isLoadingGrievances = false;
      notifyListeners();
    }
  }

  Future<void> refreshGrievances({required String userId}) {
    return loadGrievances(userId: userId);
  }

  // ============================================================
  // SUBMIT GRIEVANCE
  // ============================================================

  Future<bool> submitGrievance({
    required String userId,
    required String description,
  }) async {
    if (isSubmittingGrievance) {
      return false;
    }

    isSubmittingGrievance = true;
    submitGrievanceErrorMessage = null;

    notifyListeners();

    try {
      // --------------------------------------------------------
      // STEP 1:
      // Take a snapshot of the currently selected local files.
      // --------------------------------------------------------

      final selectedAttachments = List<MediaFileModel>.from(attachments);

      // --------------------------------------------------------
      // STEP 2:
      // Upload only now.
      //
      // The repository handles:
      // - fresh SAS
      // - Azure Blob upload
      // - final AttachmentModel creation
      // --------------------------------------------------------

      final uploadedAttachments = await repository.uploadAttachments(
        files: selectedAttachments,
      );

      // --------------------------------------------------------
      // STEP 3:
      // Build grievance payload using uploaded attachments.
      // --------------------------------------------------------

      final payload = _buildGrievancePayload(
        userId: userId,
        description: description,
        uploadedAttachments: uploadedAttachments,
      );

      // --------------------------------------------------------
      // STEP 4:
      // Create grievance only after every attachment upload
      // has succeeded.
      // --------------------------------------------------------

      await repository.createGrievance(data: payload);

      return true;
    } catch (error) {
      submitGrievanceErrorMessage = _getUserFriendlyError(error);

      return false;
    } finally {
      isSubmittingGrievance = false;
      notifyListeners();
    }
  }

  // ============================================================
  // BUILD POST PAYLOAD
  // ============================================================

  Map<String, dynamic> _buildGrievancePayload({
    required String userId,
    required String description,
    required List<AttachmentModel> uploadedAttachments,
  }) {
    final now = DateTime.now();

    final dueDate = now.add(const Duration(days: 3));

    // Get selected category from the existing static category list.
    final issueCategory =
        selectedCategory != null &&
            selectedCategory! >= 0 &&
            selectedCategory! < GrievanceConstants.categories.length
        ? GrievanceConstants.categories[selectedCategory!].$1
        : '';

    return {
      'TicketId': _generateTicketId(),

      'IssueCategory': issueCategory,

      'Department': GrievanceConstants.department,

      'Priority': GrievanceConstants.priority,

      'Source': GrievanceConstants.source,

      'Description': description.trim(),

      'Constituency': 'Chennai Central',

      'Ward': selectedWard?.wardNo.toString() ?? '',

      'Area': selectedArea?.trim() ?? '',

      'Street': selectedStreet?.trim() ?? '',

      'Latitude': latitude,

      'Longitude': longitude,

      'Attachments': uploadedAttachments
          .map((attachment) => attachment.toJson())
          .toList(),

      'SubmittedBy': userId,

      'DueOn': dueDate.toUtc().toIso8601String(),
    };
  }

  // ============================================================
  // RANDOM TICKET ID
  // ============================================================

  String _generateTicketId() {
    final random = Random();

    final number = 10000 + random.nextInt(90000);

    return 'GRV-${DateTime.now().year}-$number';
  }

  // ============================================================
  // ERROR
  // ============================================================

  String _getUserFriendlyError(Object error) {
    if (error is GrievanceSasException) {
      return error.message;
    }

    if (error is GrievanceBlobUploadException) {
      return error.message;
    }

    if (error is GrievanceRepositoryException) {
      return error.message;
    }

    if (error is GrievanceApiException) {
      return error.message;
    }

    return 'Unable to submit grievance. Please try again.';
  }

  // ============================================================
  // CATEGORY
  // ============================================================

  int? selectedCategory;

  void selectCategory(int index) {
    selectedCategory = index;
    notifyListeners();
  }

  // ============================================================
  // WARD
  // ============================================================

  List<WardModel> wards = [];

  WardModel? selectedWard;

  Future<void> loadWards() async {
    try {
      wards = await repository.getWards();

      notifyListeners();
    } catch (_) {
      // Keep existing UI state.
    }
  }

  void changeWard(WardModel? value) {
    selectedWard = value;
    notifyListeners();
  }

  // ============================================================
  // LOAD DROPDOWNS
  // ============================================================

  Future<void> loadDropdowns() async {
    await loadWards();
  }

  // ============================================================
  // AREA / STREET
  // ============================================================

  String? selectedArea;

  String? selectedStreet;

  void changeArea(String? value) {
    selectedArea = value;
    notifyListeners();
  }

  void changeStreet(String? value) {
    selectedStreet = value;
    notifyListeners();
  }

  void clearGrievanceForm() {
    selectedCategory = null;
    selectedWard = null;
    selectedArea = null;
    selectedStreet = null;

    latitude = null;
    longitude = null;
    address = null;

    attachments.clear();

    notifyListeners();
  }
}
