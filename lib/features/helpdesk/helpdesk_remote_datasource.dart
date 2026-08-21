import 'package:tvk_grievance/core/constants/configs/helpDesk.config.dart';
import 'package:tvk_grievance/core/network/api_client.dart';
import 'package:tvk_grievance/features/helpdesk/helpdesk_model.dart';

class HelpdeskRemoteDataSource {
  final ApiClient _apiClient;

  HelpdeskRemoteDataSource(this._apiClient);

  Future<List<HelpdeskContact>> getContacts() async {
    final response = await _apiClient.get(
      HelpDeskConfig.getAllHelpdesk,
    );

    final data = response.data;

    if (data is! Map<String, dynamic>) {
      throw Exception('Invalid helpdesk response');
    }

    final contacts = data['data'];

    if (contacts is! List) {
      return [];
    }

    return contacts
        .whereType<Map<String, dynamic>>()
        .map(HelpdeskContact.fromJson)
        .toList();
  }
}