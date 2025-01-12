import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:softwarica_student_management_bloc/app/usecase/usecase.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/repository/batch_repository.dart';

class DeleteBatchParams extends Equatable {
  final String batchId;

  const DeleteBatchParams({required this.batchId});

  @override
  List<Object?> get props => [batchId];
}

class DeleteBatchUsecase implements UseCaseWithParams<void, DeleteBatchParams> {
  final IBatchRepository repository;
  DeleteBatchUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(DeleteBatchParams params) async {
    return await repository.deleteBatch(params.batchId);
  }
}
