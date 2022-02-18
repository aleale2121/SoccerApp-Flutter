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
          Club? clubA = await getClub(fixture.firstClub);
          Club? clubB = await getClub(fixture.secondClub);
          fixture.clubA = clubA;
          fixture.clubB = clubB;
          print("---------------club A");
          print(clubA);
          print("---------------club B");
          print(clubB);
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
      (DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          Fixture fix = Fixture.fromSnapshoot(documentSnapshot);
          Club? clubA = await getClub(fix.firstClub);
          Club? clubB = await getClub(fix.secondClub);
          fix.clubA = clubA;
          fix.clubB = clubB;
          print("---------------club A");
          print(clubA);
          print("---------------club B");
          print(clubB);
          return fix;
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

  Future<Club?> getClub(String name) async {
    try {
      Club? club;
      await _firebaseFirestore
          .collection(clubCollection)
          .where('name', isEqualTo: name)
          .get()
          .then((value) => {club = Club.fromSnapshoot(value.docs.first)});
      return club;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
