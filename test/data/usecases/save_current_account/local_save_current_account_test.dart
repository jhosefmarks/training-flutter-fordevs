import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:fordevs/data/cache/cache.dart';
import 'package:fordevs/data/usecases/usecases.dart';
import 'package:fordevs/domain/entities/entities.dart';
import 'package:fordevs/domain/helpers/helpers.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

void main() {
  LocalSaveCurrentAccount sut;
  SaveSecureCacheStorageSpy saveSecureCacheStorage;
  AccountEntity account;

  void mockError() {
    when(saveSecureCacheStorage.saveSecure(key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());
  }

  setUp(() {
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(token: faker.guid.guid());
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    sut.save(account);

    verify(saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws', () async {
    mockError();

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
