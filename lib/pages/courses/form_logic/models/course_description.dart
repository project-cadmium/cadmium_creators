import 'package:formz/formz.dart';

enum CourseDescriptionValidationError { empty }

class CourseDescription
    extends FormzInput<String, CourseDescriptionValidationError> {
  const CourseDescription.pure() : super.pure('');
  const CourseDescription.dirty([String value = '']) : super.dirty(value);

  @override
  CourseDescriptionValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : CourseDescriptionValidationError.empty;
  }
}
