import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';

abstract interface class ICourseDataSource {
  Future<void> createCourse(CourseEntity course);
  Future<List<CourseEntity>> getCourses();
  Future<void> deleteCourse(String id);
}
