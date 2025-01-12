import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:softwarica_student_management_bloc/app/usecase/usecase.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/repository/course_repository.dart';

class CreateCourseParams extends Equatable {
  final String courseName;
  const CreateCourseParams({
    required this.courseName,
  });
  @override
  List<Object?> get props => [courseName];
}

class CreateCourseUsecase
    implements UseCaseWithParams<void, CreateCourseParams> {
  final ICourseRepository repository;
  CreateCourseUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(CreateCourseParams params) {
    var courseEntity = CourseEntity(courseName: params.courseName);
    return repository.createCourse(courseEntity);
  }
}
