import 'package:formz/formz.dart';

enum BiographyValidationError { empty }

class Biography extends FormzInput<String, BiographyValidationError> {
  const Biography.pure() : super.pure('');
  const Biography.dirty([String value = '']) : super.dirty(value);

  @override
  BiographyValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : BiographyValidationError.empty;
  }
}
