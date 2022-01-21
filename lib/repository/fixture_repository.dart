import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soccer_app/models/custom_exception.dart';
import 'package:soccer_app/shared/constants.dart';
import '../models/model.dart';

class FixtureRepository {
  final FirebaseFirestore _firebaseFirestore;

  FixtureRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  Stream<List<Fixture>> fixtures() {
    return _firebaseFirestore
        .collection(fixtureCollection)
        .snapshots()
        .asyncMap((snapshoot) async {
      final list = snapshoot.docs.map(
        (doc) async {
          Fixture fixture = Fixture.fromSnapshoot(doc);
          if (fixture.status == "live") {
            Result? result = await getResult(fixture.id!);
            fixture.result = result;
          }
          return fixture;
        },
      ).toList();
      return await Future.wait(list);
    }).handleError((error) => throw error);
  }

  Future<Fixture?> fixture(String fixtureId) async {
    _firebaseFirestore.collection(fixtureCollection).doc(fixtureId).get().then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return Fixture.fromSnapshoot(documentSnapshot);
        }
        throw CustomException(cause: 'fixture not found');
      },
    ).catchError((error) => throw error);
  }

  Future<Fixture> addFixture(Fixture fixture) async {
    await _firebaseFirestore
        .collection(fixtureCollection)
        .add(fixture.toSnapshoot())
        .catchError((error) => throw error);

    return fixture;
  }

  Future<Fixture> updateFixture(Fixture fixture) async {
    await _firebaseFirestore
        .collection(fixtureCollection)
        .doc(fixture.id)
        .update(fixture.toSnapshoot())
        .catchError((error) => throw error);
    return fixture;
  }

  Future<void> deleteFixture(String id) async {
    await _firebaseFirestore
        .collection(fixtureCollection)
        .doc(id)
        .delete()
        .catchError((error) => throw error);
  }

  Future<Result?> getResult(String fixId) async {
    await _firebaseFirestore.collection(resultCollection).doc(fixId).get().then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return Result.fromSnap(documentSnapshot);
        }
        throw CustomException(cause: 'result not found');
      },
    ).catchError((error) => throw error);
  }
}
