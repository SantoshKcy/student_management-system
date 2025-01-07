import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:softwarica_student_management_bloc/app/constants/hive_table_constant.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/model/batch_hive_model.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/model/course_hive_model.dart';

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}softwarica_student_management.db';

    Hive.init(path);

    Hive.registerAdapter(CourseHiveModelAdapter());
    Hive.registerAdapter(BatchHiveModelAdapter());
  }

  Future<void> addBatch(BatchHiveModel batch) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.put(batch.batchId, batch);
  }

  Future<List<BatchHiveModel>> getAllBatches() async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    var batches = box.values.toList();
    return batches;
  }

  Future<void> deleteBatch(String id) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.delete(id);
  }
}
