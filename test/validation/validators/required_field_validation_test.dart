import 'package:test/test.dart';

import 'package:fordevs/presentation/protocols/protocols.dart';

import 'package:fordevs/validation/validators/validators.dart';

void main() {
  RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });
  test('Shoud return null if values is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('Shoud return error if values is empty', () {
    expect(sut.validate(''), ValidationError.requiredField);
  });

  test('Shoud return error if values is null', () {
    expect(sut.validate(null), ValidationError.requiredField);
  });
}
