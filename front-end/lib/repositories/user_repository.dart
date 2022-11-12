import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/model/api_model.dart';
import 'package:scrum_master_front_end/model/role.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/repositories/api_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static String endpoints = host + "/user";
  ApiRepository apiRepository = new ApiRepository();

  Future<User?> getCurrentUser() async {
    ApiModel model =
        new ApiModel(url: endpoints, parse: (json) => User.fromJson(json));
    User? user = await apiRepository.get(model);
    return user;
  }

  Future<User?> login(String email, String password) async {
    String? token = await authenticate(email, password);
    if (token == null) {
      return null;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
    ApiModel model =
        new ApiModel(url: endpoints, parse: (json) => User.fromJson(json));
    User? user = await apiRepository.get(model);
    if (user != null) {
      sharedPreferences.setInt("userId", user.id);
    }
    return user;
  }

  Future<User?> create(String email, Role role) async {
    ApiModel model = new ApiModel(
        url: endpoints,
        parse: (json) => User.fromJson(json),
        body: {"email": email, "role": role});
    User? user = await apiRepository.post(model);
    return user;
  }

  Future<String?> authenticate(String email, String password) async {
    ApiModel apiModel = ApiModel(
        url: host + "/authenticate",
        body: {"email": email, "password": password});
    String? token = await apiRepository.post(apiModel);
    return token;
  }

  Future<List<User>?> findAll() async {
    ApiModel model = new ApiModel(
        url: endpoints + "/all",
        parse: (data) {
          return data.map<User>((json) => User.fromJson(json)).toList();
        });
    List<User>? users = await apiRepository.get(model);
    return users;
  }

  Future<List<Role>?> findAllRole() async {
    String url = host + "/role";
    ApiModel model = new ApiModel(
        url: url,
        parse: (data) {
          return data.map<Role>((json) => Role.fromJson(json)).toList();
        });
    List<Role>? roles = await apiRepository.get(model);
    return roles;
  }
}
