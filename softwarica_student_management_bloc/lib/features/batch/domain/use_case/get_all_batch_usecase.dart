import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/app/usecase/usecase.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/repository/batch_repository.dart';

class GetAllBatchUsecase implements UseCaseWithoutParams<List<BatchEntity>> {
  final IBatchRepository repository;
  GetAllBatchUsecase({required this.repository});
  @override
  Future<Either<Failure, List<BatchEntity>>> call() async {
    return await repository.getBatches();
  }
}
