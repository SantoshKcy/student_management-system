import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:softwarica_student_management_bloc/app/usecase/usecase.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/repository/batch_repository.dart';

class CreateBatchParams extends Equatable {
  final String batchName;
  const CreateBatchParams({
    required this.batchName,
  });
  @override
  List<Object?> get props => [batchName];
}

class CreateBatchUsecase implements UseCaseWithParams<void, CreateBatchParams> {
  final IBatchRepository repository;
  CreateBatchUsecase({required this.repository});
  @override
  Future<Either<Failure, void>> call(CreateBatchParams params) {
    var batchEntity = BatchEntity(batchName: params.batchName);
    return repository.createBatch(batchEntity);
  }
}
