import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/model/api_model.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/repositories/api_repository.dart';

class ProjectRepository {
  ApiRepository apiRepository = ApiRepository();

  String endpoints = host + "/project";

  Future<List<Project>?> findAll() async {
    ApiModel model = ApiModel(
        url: endpoints + "s",
        parse: (data) {
          return data.map<Project>((json) => Project.fromJson(json)).toList();
        });

    List<Project>? projects = await apiRepository.get(model);
    return projects;
  }

  Future<Project?> create(String name, String projectKey, User projectLeader) async {
    ApiModel model = ApiModel(
        url: endpoints,
        body: {"name": name, "key": projectKey, "projectLeader": projectLeader},
        parse: (json) => Project.fromJson(json));

    Project? project = await apiRepository.post(model);
    return project;
  }
}
