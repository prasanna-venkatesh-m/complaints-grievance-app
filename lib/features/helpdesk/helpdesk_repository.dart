import 'helpdesk_model.dart';
import 'helpdesk_remote_datasource.dart';

class HelpdeskRepository {
  final HelpdeskRemoteDataSource _remoteDataSource;

  HelpdeskRepository(this._remoteDataSource);

  Future<List<HelpdeskContact>> getContacts() {
    return _remoteDataSource.getContacts();
  }
}