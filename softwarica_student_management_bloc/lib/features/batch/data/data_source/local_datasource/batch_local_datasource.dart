import 'package:softwarica_student_management_bloc/core/network/hive_service.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/batch_data_source.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/model/batch_hive_model.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';

class BatchLocalDatasource implements IBatchDataSource {
  final HiveService _hiveService;

  BatchLocalDatasource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<void> createBatch(BatchEntity entity) async {
    try {
      // convert entity to hive model

      final batchHiveModel = BatchHiveModel.fromEntity(entity);
      await _hiveService.addBatch(batchHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteBatch(String id) {
    try {
      return _hiveService.deleteBatch(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<BatchEntity>> getBatches() {
    try {
      return _hiveService
          .getAllBatches()
          .then((value) => value.map((e) => e.toEntity()).toList());
    } catch (e) {
      throw Exception(e);
    }
  }
}
