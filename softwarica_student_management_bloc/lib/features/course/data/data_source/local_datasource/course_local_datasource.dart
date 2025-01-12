import 'package:softwarica_student_management_bloc/core/network/hive_service.dart';
import 'package:softwarica_student_management_bloc/features/course/data/data_source/course_data_source.dart';
import 'package:softwarica_student_management_bloc/features/course/data/model/course_hive_model.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';

class CourseLocalDatasource implements ICourseDataSource {
  final HiveService _hiveService;

  CourseLocalDatasource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<void> createCourse(CourseEntity entity) async {
    try {
      // convert entity to hive model

      final courseHiveModel = CourseHiveModel.fromEntity(entity);
      await _hiveService.addCourse(courseHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCourse(String id) {
    try {
      return _hiveService.deleteCourse(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CourseEntity>> getCourses() {
    try {
      return _hiveService
          .getAllCourses()
          .then((value) => value.map((e) => e.toEntity()).toList());
    } catch (e) {
      throw Exception(e);
    }
  }
}
