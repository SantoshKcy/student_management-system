import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/local_datasource/batch_local_datasource.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/repository/batch_repository.dart';

class BatchLocalRepository implements IBatchRepository {
  final BatchLocalDatasource _batchLocalDatasource;
  BatchLocalRepository({required BatchLocalDatasource batchLocalDatasource})
      : _batchLocalDatasource = batchLocalDatasource;
  @override
  Future<Either<Failure, void>> createBatch(BatchEntity entity) async {
    try {
      await _batchLocalDatasource.createBatch(entity);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBatch(String id) async {
    try {
      _batchLocalDatasource.deleteBatch(id);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getBatches() async {
    try {
      final batches = await _batchLocalDatasource.getBatches();
      return Right(batches);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
