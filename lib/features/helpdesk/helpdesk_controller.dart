import 'package:flutter/material.dart';

import 'helpdesk_model.dart';
import 'helpdesk_repository.dart';

class HelpdeskController extends ChangeNotifier {
  final HelpdeskRepository _repository;

  HelpdeskController(this._repository);

  List<HelpdeskContact> contacts = [];

  bool isLoading = false;
  String? errorMessage;

  Future<void> loadContacts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      contacts = await _repository.getContacts();
    } catch (e) {
      errorMessage = 'Unable to load helpdesk contacts';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}