import 'package:flutter/material.dart';

import 'helpdesk_model.dart';
import 'helpdesk_repository.dart';

class HelpdeskController extends ChangeNotifier {
  final HelpdeskRepository _repository;

  HelpdeskController(this._repository);

  List<HelpdeskContact> contacts = [];

  void loadContacts() {
    contacts = _repository.getContacts();
    notifyListeners();
  }
}
