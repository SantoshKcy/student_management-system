import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:softwarica_student_management_bloc/core/network/hive_service.dart';
import 'package:softwarica_student_management_bloc/features/auth/data/data_source/auth_data_source.dart';
import 'package:softwarica_student_management_bloc/features/auth/data/model/auth_hive_model.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/entity/auth_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    // Return Empty AuthEntity
    return Future.value(AuthEntity(
      userId: "1",
      fName: "",
      lName: "",
      image: "",
      phone: "",
      batch: BatchEntity(batchName: ""),
      courses: [],
      username: "",
      password: "",
    ));
  }

  @override
  Future<String> loginStudent(String username, String password) async {
    try {
      await _hiveService.login(username, password);
      return Future.value("Success");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerStudent(AuthEntity student) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(student);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final profilePicsDir = Directory('${appDocDir.path}/profile_pictures');
      if (!(await profilePicsDir.exists())) {
        await profilePicsDir.create(recursive: true);
      }
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '${profilePicsDir.path}/$fileName';
      final newFile = await file.copy(filePath);
      return Future.value(newFile.path);
    } catch (e) {
      return Future.error("Failed to upload profile picture: ${e.toString()}");
    }
  }
}
