import 'package:test/test.dart';

import 'package:fordevs/main/factories/factories.dart';

import 'package:fordevs/validation/validators/validators.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password')
    ]);
  });
}