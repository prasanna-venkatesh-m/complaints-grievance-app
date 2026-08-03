import 'package:flutter/material.dart';
import 'package:tvk_grievance/features/location_picker/location_picker_model.dart';
import 'grievance_model.dart';
import 'grievance_repository.dart';
import '../../shared/models/media_file_model.dart';

class GrievanceController extends ChangeNotifier {
  final GrievanceRepository repository;
  double? latitude;
  double? longitude;
  String? address;

  GrievanceController(this.repository);

  final List<MediaFileModel> attachments = [];

  /// ==========================
  /// MAPS
  /// ==========================

  void setLocation(LocationPickerModel location) {
    latitude = location.latitude;
    longitude = location.longitude;
    address = location.address;

    notifyListeners();
  }

  /// ==========================
  /// FILES
  /// ==========================

  void addMedia(List<MediaFileModel> files) {
    attachments.addAll(files);
    notifyListeners();
  }

  void removeMedia(int index) {
    attachments.removeAt(index);
    notifyListeners();
  }

  void clearMedia() {
    attachments.clear();
    notifyListeners();
  }

  /// ==========================
  /// TAB
  /// ==========================

  GrievanceTab selectedTab = GrievanceTab.fileNew;

  void changeTab(GrievanceTab tab) {
    selectedTab = tab;
    notifyListeners();
  }

  /// ==========================
  /// MY GRIEVANCES
  /// ==========================

  List<GrievanceModel> grievances = [];

  void loadGrievances() {
    grievances = repository.getGrievances();
    notifyListeners();
  }

  /// ==========================
  /// CATEGORY
  /// ==========================

  int? selectedCategory;

  void selectCategory(int index) {
    selectedCategory = index;
    notifyListeners();
  }

  /// ==========================
  /// DROPDOWNS
  /// ==========================

  List<String> wards = [];
  List<String> areas = [];
  List<String> streets = [];

  String? selectedWard;
  String? selectedArea;
  String? selectedStreet;

  Future<void> loadDropdowns() async {
    wards = await repository.getWards();
    areas = await repository.getAreas();
    streets = await repository.getStreets();

    notifyListeners();
  }

  void changeWard(String? value) {
    selectedWard = value;
    notifyListeners();
  }

  void changeArea(String? value) {
    selectedArea = value;
    notifyListeners();
  }

  void changeStreet(String? value) {
    selectedStreet = value;
    notifyListeners();
  }
}
