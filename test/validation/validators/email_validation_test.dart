import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:fordevs/validation/protocols/protocols.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  String validate(String value) {
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = value?.isNotEmpty != true || regex.hasMatch(value);

    return isValid ? null : 'E-mail inválido.';
  }
}

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Shoud return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Shoud return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Shoud return null if email is valid', () {
    expect(sut.validate(faker.internet.email()), null);
  });

  test('Shoud return error if email is invalid', () {
    expect(sut.validate('email_invalid'), 'E-mail inválido.');
  });
}