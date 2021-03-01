import 'package:meta/meta.dart';
import '../data_provider/data.dart';
import '../models/model.dart';

class UserRepository {
  final UserDataProvider userDataProvider;

  UserRepository({@required this.userDataProvider})
      : assert(userDataProvider != null);

  Future<List<User>> getUsers() async {
    return await userDataProvider.getUsers();
  }

  Future<User> updateUser(User user) async {
    return await userDataProvider.updateUser(user);
  }

  Future<User> updateUserPassword(User user, String oldPassword) async {
    return await userDataProvider.updateUserPassword(user, oldPassword);
  }

  Future<User> login(User user) async {
    return await userDataProvider.login(user);
  }

  Future<User> signUp(User user) async {
    return await userDataProvider.signUp(user);
  }
}
