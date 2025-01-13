import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/create_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/delete_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/get_all_course_usecase.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CreateCourseUsecase _createCourseUsecase;
  final DeleteCourseUsecase _deleteCourseUsecase;
  final GetAllCourseUsecase _getAllCourseUsecase;
  CourseBloc({
    required CreateCourseUsecase createCourseUsecase,
    required DeleteCourseUsecase deleteCourseUsecase,
    required GetAllCourseUsecase getAllCourseUsecase,
  })  : _createCourseUsecase = createCourseUsecase,
        _deleteCourseUsecase = deleteCourseUsecase,
        _getAllCourseUsecase = getAllCourseUsecase,
        super(CourseState.initial()) {
    on<LoadCourses>(_onLoadCourses);
    on<AddCourse>(_onAddCourse);
    on<DeleteCourse>(_onDeleteCourse);
    add(LoadCourses());
  }

  Future<void> _onLoadCourses(
      LoadCourses event, Emitter<CourseState> emit) async {
    emit(state.copyWith(isLoading: true));
    var result = await _getAllCourseUsecase.call();
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.toString())),
      (r) => emit(state.copyWith(isLoading: false, courses: r)),
    );
  }

  Future<void> _onAddCourse(AddCourse event, Emitter<CourseState> emit) async {
    emit(state.copyWith(isLoading: true));
    var result = await _createCourseUsecase
        .call(CreateCourseParams(courseName: event.courseName));
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.toString())),
      (r) {
        emit(state.copyWith(isLoading: false));
        add(LoadCourses());
      },
    );
  }

  Future<void> _onDeleteCourse(
      DeleteCourse event, Emitter<CourseState> emit) async {
    emit(state.copyWith(isLoading: true));
    var result = await _deleteCourseUsecase
        .call(DeleteCourseParams(courseId: event.courseId));
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.toString())),
      (r) {
        emit(state.copyWith(isLoading: false));
        add(LoadCourses());
      },
    );
  }
}
