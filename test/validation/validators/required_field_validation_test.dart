import 'package:test/test.dart';

abstract class FieldValidation {
  String get field;

  String validate(String value);
}

class RequiredFieldValidation implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  String validate(String value) {
    return value.isEmpty ? 'Campo obrigatório.' : null;
  }
}

void main() {
  RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });
  test('Shoud return null if values is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('Shoud return error if values is empty', () {
    expect(sut.validate(''), 'Campo obrigatório.');
  });
}