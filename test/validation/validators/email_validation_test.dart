import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:fordevs/presentation/protocols/protocols.dart';
import 'package:fordevs/validation/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null on invalid case', () {
    expect(sut.validate({}), null);
  });

  test('Shoud return null if email is empty', () {
    expect(sut.validate({'any_field': ''}), null);
  });

  test('Shoud return null if email is null', () {
    expect(sut.validate({'any_field': null}), null);
  });

  test('Shoud return null if email is valid', () {
    expect(sut.validate({'any_field': faker.internet.email()}), null);
  });

  test('Shoud return error if email is invalid', () {
    expect(sut.validate({'any_field': 'email_invalid'}), ValidationError.invalidField);
  });
}
