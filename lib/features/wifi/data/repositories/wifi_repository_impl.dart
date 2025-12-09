import '../../domain/entities/wifi_credentials.dart';
import '../../domain/repositories/wifi_repository.dart';
import '../datasources/wifi_local_datasource.dart';
import '../datasources/wifi_remote_datasource.dart';
import '../models/wifi_credentials_model.dart';

/// Implementation of WiFi repository
class WifiRepositoryImpl implements WifiRepository {
  final WifiLocalDatasource _localDatasource;
  final WifiRemoteDatasource _remoteDatasource;

  WifiRepositoryImpl({
    WifiLocalDatasource? localDatasource,
    WifiRemoteDatasource? remoteDatasource,
  })  : _localDatasource = localDatasource ?? WifiLocalDatasource(),
        _remoteDatasource = remoteDatasource ?? WifiRemoteDatasource();

  @override
  Future<void> saveCredentials(WifiCredentials credentials) async {
    final model = WifiCredentialsModel.fromEntity(credentials);
    await _localDatasource.saveCredentials(model);
  }

  @override
  Future<WifiCredentials?> getCredentials() async {
    return _localDatasource.getCredentials();
  }

  @override
  Future<void> deleteCredentials() async {
    await _localDatasource.deleteCredentials();
    await _localDatasource.setAutoLogin(false);
  }

  @override
  Future<WifiLoginResult> login(WifiCredentials credentials) async {
    return _remoteDatasource.login(credentials);
  }

  @override
  Future<WifiLoginResult> logout() async {
    return _remoteDatasource.logout();
  }

  @override
  Future<WifiLoginResult> checkStatus() async {
    return _remoteDatasource.checkStatus();
  }

  @override
  Future<bool> isAutoLoginEnabled() async {
    return _localDatasource.isAutoLoginEnabled();
  }

  @override
  Future<void> setAutoLogin(bool enabled) async {
    await _localDatasource.setAutoLogin(enabled);
  }
}
