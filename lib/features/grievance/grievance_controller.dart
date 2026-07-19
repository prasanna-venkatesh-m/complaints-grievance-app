import 'package:flutter/material.dart';

import 'grievance_model.dart';
import 'grievance_repository.dart';

class GrievanceController extends ChangeNotifier {
  final GrievanceRepository repository;

  GrievanceController(this.repository);

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