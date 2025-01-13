import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/get_all_batch_usecase.dart';

part 'batch_event.dart';
part 'batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  final CreateBatchUsecase _createBatchUsecase;
  final DeleteBatchUsecase _deleteBatchUsecase;
  final GetAllBatchUsecase _getAllBatchUsecase;
  BatchBloc({
    required CreateBatchUsecase createBatchUsecase,
    required DeleteBatchUsecase deleteBatchUsecase,
    required GetAllBatchUsecase getAllBatchUsecase,
  })  : _createBatchUsecase = createBatchUsecase,
        _deleteBatchUsecase = deleteBatchUsecase,
        _getAllBatchUsecase = getAllBatchUsecase,
        super(BatchState.initial()) {
    on<LoadBatches>(_onLoadBatches);
    on<AddBatch>(_onAddBatch);
    on<DeleteBatch>(_onDeleteBatch);
    add(LoadBatches());
  }

  Future<void> _onLoadBatches(
      LoadBatches event, Emitter<BatchState> emit) async {
    emit(state.copyWith(isLoading: true));
    var result = await _getAllBatchUsecase.call();
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.toString())),
      (r) => emit(state.copyWith(isLoading: false, batches: r)),
    );
  }

  Future<void> _onAddBatch(AddBatch event, Emitter<BatchState> emit) async {
    emit(state.copyWith(isLoading: true));
    var result = await _createBatchUsecase
        .call(CreateBatchParams(batchName: event.batchName));
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.toString())),
      (r) {
        emit(state.copyWith(isLoading: false));
        add(LoadBatches());
      },
    );
  }

  Future<void> _onDeleteBatch(
      DeleteBatch event, Emitter<BatchState> emit) async {
    emit(state.copyWith(isLoading: true));
    var result = await _deleteBatchUsecase
        .call(DeleteBatchParams(batchId: event.batchId));
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.toString())),
      (r) {
        emit(state.copyWith(isLoading: false));
        add(LoadBatches());
      },
    );
  }
}
