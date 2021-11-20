import 'package:formz/formz.dart';

enum CourseNameValidationError { empty }

class CourseName extends FormzInput<String, CourseNameValidationError> {
  const CourseName.pure() : super.pure('');
  const CourseName.dirty([String value = '']) : super.dirty(value);

  @override
  CourseNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : CourseNameValidationError.empty;
  }
}
