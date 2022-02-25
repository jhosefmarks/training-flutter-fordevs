import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

import 'package:fordevs/presentation/protocols/protocols.dart';
import 'package:fordevs/validation/protocols/protocols.dart';

class MinLengthValidation implements FieldValidation {
  final String field;
  final int size;

  MinLengthValidation({@required this.field, @required this.size});

  ValidationError validate(String value) {
    return value != null && value.length >= size ? null : ValidationError.invalidField;
  }
}

void main() {
  MinLengthValidation sut;

  setUp(() {
    sut = MinLengthValidation(field: 'any_field', size: 5);
  });

  test('Should return error if value is empty', () {
    final error = sut.validate('');

    expect(error, ValidationError.invalidField);
  });

  test('Should return error if value is null', () {
    final error = sut.validate(null);

    expect(error, ValidationError.invalidField);
  });

  test('Should return error if value is less than min size', () {
    expect(sut.validate(faker.randomGenerator.string(4, min: 1)), ValidationError.invalidField);
  });

  test('Should return null if value is equal than min size', () {
    expect(sut.validate(faker.randomGenerator.string(5, min: 5)), null);
  });

  test('Should return null if value is bigger than min size', () {
    expect(sut.validate(faker.randomGenerator.string(10, min: 6)), null);
  });
}
