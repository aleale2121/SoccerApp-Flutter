import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:soccer_app/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class FileRepository {
  final firebase_storage.FirebaseStorage storage;
  FileRepository({
    required this.storage,
  });

  Future<firebase_storage.UploadTask?> uploadFile(
    String name,
    String filePathX,
  ) async {
    late firebase_storage.UploadTask uploadTask;

    try {
      firebase_storage.Reference ref =
          storage.ref().child('$logosFolder').child('/$name');

      final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {
          'picked-file-path': filePathX,
        },
      );
      uploadTask = ref.putFile(io.File(filePathX), metadata);
      return Future.value(uploadTask);
    } on firebase_core.FirebaseException catch (e) {
      if (e.code == 'canceled') {
        print('The task has been canceled');
      }
      if (uploadTask.snapshot.state == firebase_storage.TaskState.canceled) {
        print('The task has been canceled');
      }
      print(firebase_storage.TaskState.error);
      throw e;
    } catch (exception) {
      throw exception;
    }
  }
}
