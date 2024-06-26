import 'package:tools/core/utils/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///Provides an interface to store values with encryption.
abstract class SecureStorage {
  ///Reads a value saved with [key] from storage
  Future<String?> read(String key);

  ///Writes [value] to storage with [key].
  Future<void> write({
    required String key,
    required String value,
  });

  ///Deletes a value saved with [key] from storage
  Future<bool> delete(String key);
}

class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl({FlutterSecureStorage? storage}) {
    _storage = storage ?? const FlutterSecureStorage();
  }

  late FlutterSecureStorage _storage;
  late final _logger = LoggerFactory.getLogger(SecureStorageImpl);

  @override
  Future<bool> delete(String key) async {
    try {
      await _storage.delete(key: key);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      _logger.error('read error', error: e);
      return null;
    }
  }

  @override
  Future<void> write({required String key, required String value}) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      _logger.error('write error', error: e);
    }
  }
}
