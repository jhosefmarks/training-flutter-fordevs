import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:fordevs/domain/entities/entities.dart';
import 'package:fordevs/domain/usecases/usecases.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({ @required this.saveSecureCacheStorage });

  Future<void> save(AccountEntity account) async {
    await saveSecureCacheStorage.save(key: 'token', value: account.token);
  }

}

abstract class SaveSecureCacheStorage {
  Future<void> save({ @required String key, @required String value });
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

void main() {
  test('Should call SaveCacheStorage with correct values', () async {
    final saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    final sut = LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    final account = AccountEntity(faker.guid.guid());

    sut.save(account);

    verify(saveSecureCacheStorage.save(key: 'token', value: account.token));
  });
}