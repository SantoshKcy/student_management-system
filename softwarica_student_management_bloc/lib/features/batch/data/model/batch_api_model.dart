import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';

@JsonSerializable()
class BatchApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? batchId;
  final String batchName;

  const BatchApiModel({
    this.batchId,
    required this.batchName,
  });

  const BatchApiModel.empty()
      : batchId = '',
        batchName = '';

  //From Json
  factory BatchApiModel.fromJson(Map<String, dynamic> json) {
    return BatchApiModel(
      batchId: json['_id'],
      batchName: json['batchName'],
    );
  }

  //To Json
  Map<String, dynamic> toJson() {
    return {
      'batchName': batchName,
    };
  }

  BatchEntity toEntity() => BatchEntity(
        batchId: batchId,
        batchName: batchName,
      );
  static BatchApiModel fromEntity(BatchEntity entity) => BatchApiModel(
        batchId: entity.batchId ?? '',
        batchName: entity.batchName,
      );

  List<BatchEntity> toEntityList(List<BatchApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [batchId, batchName];
}
