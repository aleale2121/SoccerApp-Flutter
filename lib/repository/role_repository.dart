import 'package:meta/meta.dart';
import '../data_provider/data.dart';
import '../models/model.dart';

class RoleRepository {
  final RoleDataProvider roleDataProvider;

  RoleRepository({@required this.roleDataProvider})
      : assert(roleDataProvider != null);

  Future<List<Role>> getAndSetRoles() async {
    return await roleDataProvider.getAndSetRoles();
  }

  Future<Role> getRole(String roleId) async {
    return await roleDataProvider.getRole(roleId);
  }

  Future<Role> postRole(Role role) async {
    return await roleDataProvider.postRole(role);
  }

  Future<Role> putRole(Role role) async {
    return await roleDataProvider.putRole(role);
  }

  Future<void> deleteRole(String id) async {
    return await roleDataProvider.deleteRole(id);
  }
}
