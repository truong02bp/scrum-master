import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/model/api_model.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/project_member.dart';
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

  Future<Project?> create(
      String name, String projectKey, User projectLeader) async {
    ApiModel model = ApiModel(
        url: endpoints,
        body: {"name": name, "key": projectKey, "projectLeader": projectLeader},
        parse: (json) => Project.fromJson(json));

    Project? project = await apiRepository.post(model);
    return project;
  }

  Future<ProjectMember?> addMember(int id, User user, String role) async {
    String url = endpoints + "/$id/member";
    ApiModel model = ApiModel(
        url: url,
        body: {"user": user, "role": role},
        parse: (json) => ProjectMember.fromJson(json));

    ProjectMember? projectMember = await apiRepository.put(model);
    return projectMember;
  }

  Future<ProjectMember?> removeMember(int id, User user) async {
    String url = endpoints + "/$id/member";
    ApiModel model = ApiModel(
        url: url,
        body: {"user": user},
        parse: (json) => ProjectMember.fromJson(json));

    ProjectMember? projectMember = await apiRepository.delete(model);
    return projectMember;
  }
}
