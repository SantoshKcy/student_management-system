import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/app/usecase/usecase.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/repository/course_repository.dart';

class GetAllCourseUsecase implements UseCaseWithoutParams<List<CourseEntity>> {
  final ICourseRepository repository;
  GetAllCourseUsecase({required this.repository});
  @override
  Future<Either<Failure, List<CourseEntity>>> call() async {
    return await repository.getCourses();
  }
}
