import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soccer_app/models/custom_exception.dart';
import 'package:soccer_app/shared/constants.dart';
import '../models/model.dart';

class UserRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firebaseFirestore;
  final FlutterSecureStorage _secureStorage;

  UserRepository({
    FirebaseFirestore? firebaseFirestore,
    FirebaseAuth? auth,
    FlutterSecureStorage? secureStorage,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        _secureStorage = secureStorage ?? FlutterSecureStorage();

  Stream<List<UsersInfo>> users() {
    return _firebaseFirestore.collection(usersCollection).snapshots().map(
      (snapshoot) {
        return snapshoot.docs
            .map((doc) => UsersInfo.fromSnapshoot(doc))
            .toList();
      },
    );
  }

  Future<UsersInfo?> login(LoginRequestModel loginData) async {
    UserCredential result;
    try {
      result = await _auth.signInWithEmailAndPassword(
        email: loginData.email,
        password: loginData.password,
      );
      User? user = _auth.currentUser;
      if (user == null) {
        throw CustomException(cause: 'User Not Found');
      }
      // if (!user.emailVerified) {
      //   _auth.signOut();
      //   throw CustomException(cause: 'Email not Verified');
      // }
      UsersInfo? userDetail = await getUser(user.uid);
      if (userDetail != null) {
        storeTokenAndData(
          result,
          userDetail,
        );
      }
      return userDetail;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(UsersInfo userData) async {
    UserCredential result;

    try {
      result = await _auth.createUserWithEmailAndPassword(
        email: userData.email,
        password: userData.password,
      );
      await _auth.currentUser?.updateDisplayName(userData.displayName);

      User? user = result.user;
      if (user != null) {
        await user.sendEmailVerification();
        await user.reload();
        userData.uuid = user.uid;
        await addUser(userData);
      } else {
        throw CustomException(cause: 'Failed To SIGNUP');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UsersInfo> updateUser(UsersInfo user) async {
    await _firebaseFirestore
        .collection(usersCollection)
        .doc(user.uuid)
        .update(user.toMap())
        .catchError((error) => throw error);
    return user;
  }

  Future<UsersInfo?> getUser(String uuid) async {
    return await _firebaseFirestore
        .collection(usersCollection)
        .doc(uuid)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return UsersInfo.fromSnapshoot(documentSnapshot);
        }
        throw CustomException(cause: 'user not found');
      },
    ).catchError((error) => throw error);
  }

  Future<UsersInfo> updatePassword(UsersInfo user) async {
    await _firebaseFirestore
        .collection(usersCollection)
        .doc(user.uuid)
        .update({'password': user.password}).catchError((error) => throw error);
    return user;
  }

  Future<UsersInfo> addUser(UsersInfo usersInfo) async {
    await _firebaseFirestore
        .collection(usersCollection)
        .doc(usersInfo.uuid)
        .set(usersInfo.toMap())
        .catchError((error) => throw error);

    return usersInfo;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _secureStorage.delete(key: "token");
    } catch (e) {
      rethrow;
    }
  }

  void storeTokenAndData(
    UserCredential userCredential,
    UsersInfo usersInfo,
  ) async {
    await _secureStorage.write(
      key: "token",
      value: userCredential.credential?.token.toString(),
    );
    await _secureStorage.write(
      key: "usercredential",
      value: userCredential.toString(),
    );

    await _secureStorage.write(key: "email", value: usersInfo.email);
    await _secureStorage.write(key: "password", value: usersInfo.password);
    await _secureStorage.write(key: "phone", value: usersInfo.phone);
    await _secureStorage.write(key: "role", value: usersInfo.role);
    await _secureStorage.write(key: "uuid", value: usersInfo.uuid);
    await _secureStorage.write(
        key: "displayName", value: usersInfo.displayName);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: "token");
  }

  Future<UsersInfo?> autoLogin() async {
    return UsersInfo(
      displayName: (await _secureStorage.read(key: "displayName"))!,
      email: (await _secureStorage.read(key: "email"))!,
      password: (await _secureStorage.read(key: "password"))!,
      phone: (await _secureStorage.read(key: "phone"))!,
      role: (await _secureStorage.read(key: "role"))!,
      uuid: await _secureStorage.read(key: "uuid"),
    );
  }
}
