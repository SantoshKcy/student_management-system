import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:softwarica_student_management_bloc/app/usecase/usecase.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/repository/course_repository.dart';

class DeleteCourseParams extends Equatable {
  final String courseId;

  const DeleteCourseParams({required this.courseId});

  @override
  List<Object?> get props => [courseId];
}

class DeleteCourseUsecase
    implements UseCaseWithParams<void, DeleteCourseParams> {
  final ICourseRepository repository;
  DeleteCourseUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(DeleteCourseParams params) async {
    return await repository.deleteCourse(params.courseId);
  }
}
