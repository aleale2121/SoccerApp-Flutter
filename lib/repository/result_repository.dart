import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soccer_app/models/custom_exception.dart';
import 'package:soccer_app/models/live_description.dart';
import 'package:soccer_app/shared/constants.dart';

import '../models/model.dart';

class ResultRepository {
  final FirebaseFirestore _firebaseFirestore;

  ResultRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Result>> results() {
    return _firebaseFirestore
        .collection(resultCollection)
        .snapshots()
        .asyncMap((snapshoot) async {
      final list = snapshoot.docs.map(
        (doc) async {
          Result result = Result.fromSnap(doc);
          Fixture? fixture = await getFixture(result.fixtureId);
          print("****************************");
          print(fixture);
          print("****************************");
          result.fixture = fixture;
          result = result.copyWith(fixture: fixture);
          return result;
        },
      ).toList();
      return await Future.wait(list);
    }).handleError((error) => throw error);
  }

  Future<Result?> result(String resultId) async {
    await _firebaseFirestore
        .collection(resultCollection)
        .doc(resultId)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return Result.fromSnap(documentSnapshot);
        }
        throw CustomException(cause: 'result not found');
      },
    ).catchError((error) => throw error);
  }

  Future<Result> addResult(Result result) async {
    await _firebaseFirestore
        .collection(resultCollection)
        .doc(result.fixtureId)
        .set((result.toSnap()))
        .catchError(
          (error) => throw error,
        );
    await deleteFixture(result.fixtureId);
    return result;
  }

  Future<Result> updateResult(Result result) async {
    await _firebaseFirestore
        .collection(resultCollection)
        .doc(result.id)
        .update(result.toSnap())
        .catchError((error) => throw error);
    return result;
  }

  Future<void> addGoal(String id, Goal goal) async {
    await _firebaseFirestore.collection(resultCollection).doc(id).update(
      {
        'scores': FieldValue.arrayUnion([goal])
      },
    ).catchError((error) => throw error);
  }

  Future<void> addLiveDescription(String id, LiveDescription desc) async {
    await _firebaseFirestore.collection(resultCollection).doc(id).update(
      {
        'liveDescription': FieldValue.arrayUnion([desc])
      },
    ).catchError((error) => throw error);
  }

  Future<void> changeStatus(String status, String id) async {
    await _firebaseFirestore.collection(resultCollection).doc(id).update(
      {
        'status': status,
      },
    ).catchError((error) => throw error);
  }

  Future<void> deleteResult(String id) async {
    await _firebaseFirestore
        .collection(resultCollection)
        .doc(id)
        .delete()
        .catchError((error) => throw error);
  }

  Future<Fixture?> getFixture(String fixtureId) async {
    Fixture? fix;
    await _firebaseFirestore
        .collection(fixtureCollection)
        .doc(fixtureId.trim())
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          fix = Fixture.fromSnapshoot(documentSnapshot);
          print("---------------");
          print(fix);
          return fix;
        }
      },
    ).catchError((error) {
      print("---------------");
      print(error);
      print("---------------");

      throw error;
    });
    return fix;
  }

  Future<void> deleteFixture(String id) async {
    await _firebaseFirestore
        .collection(fixtureCollection)
        .doc(id)
        .delete()
        .catchError((error) => throw error);
  }
}
