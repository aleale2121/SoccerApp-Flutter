import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soccer_app/models/custom_exception.dart';
import 'package:soccer_app/shared/constants.dart';
import '../models/model.dart';

class ClubRepository {
  final FirebaseFirestore _firebaseFirestore;

  ClubRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Club>> clubs() {
    return _firebaseFirestore
        .collection(clubCollection)
        .snapshots()
        .map((snapshoot) {
      return snapshoot.docs.map((doc) => Club.fromSnapshoot(doc)).toList();
    }).handleError((error) => throw error);
  }

  Future<Club?> club(String clubId) async {
    _firebaseFirestore.collection(clubCollection).doc(clubId).get().then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return Club.fromSnapshoot(documentSnapshot);
        }
        throw CustomException(cause: "club not found");
      },
    ).catchError((error) => throw error);
  }

  Future<Club> addClub(Club club) async {
    await _firebaseFirestore
        .collection(clubCollection)
        .add(club.toSnap())
        .catchError((error) => throw error);
    return club;
  }

  Future<Club> updateClub(Club club) async {
    await _firebaseFirestore
        .collection(clubCollection)
        .doc(club.id)
        .update(club.toSnap())
        .catchError((error) => throw error);
    return club;
  }

  Future<void> deleteClub(String id) async {
    await _firebaseFirestore
        .collection(clubCollection)
        .doc(id)
        .delete()
        .catchError((error) => throw error);
  }
}
