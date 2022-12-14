import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/model/api_model.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
import 'package:scrum_master_front_end/pages/sprint/bloc/sprint_bloc.dart';
import 'package:scrum_master_front_end/repositories/api_repository.dart';

class SprintRepository {
  ApiRepository apiRepository = ApiRepository();

  String endpoints = host + "/sprint";

  Future<List<Sprint>?> findByProjectId(int projectId) async {
    ApiModel model = ApiModel(
        url: endpoints + "s",
        params: {"projectId": "$projectId"},
        parse: (data) {
          return data.map<Sprint>((json) => Sprint.fromJson(json)).toList();
        });

    List<Sprint>? sprints = await apiRepository.get(model);
    return sprints;
  }

  Future<Sprint?> findActiveSprintByProjectId(int projectId) async {
    ApiModel model = ApiModel(
        url: endpoints ,
        params: {"projectId": "$projectId"},
        parse: (json) => Sprint.fromJson(json)
        );

    Sprint? sprint = await apiRepository.get(model);
    return sprint;
  }

  Future<Sprint?> activeBySprintId(int sprintId) async {
    ApiModel model = ApiModel(
        url: endpoints + "/active",
        params: {"sprintId": "$sprintId"},
        parse: (json) => Sprint.fromJson(json));

    Sprint? sprint = await apiRepository.put(model);
    return sprint;
  }

  Future<Sprint?> completeBySprintId(int sprintId) async {
    ApiModel model = ApiModel(
        url: endpoints + "/complete",
        params: {"sprintId": "$sprintId"},
        parse: (json) => Sprint.fromJson(json));

    Sprint? sprint = await apiRepository.put(model);
    return sprint;
  }

  Future<Sprint?> create(CreateSprintEvent event) async {
    Sprint sprint = Sprint(null, event.name, event.project, null,
        event.startDate, event.endDate, 'INACTIVE');
    ApiModel model = ApiModel(
        url: endpoints, body: sprint, parse: (json) => Sprint.fromJson(json));

    Sprint? sprintCreated = await apiRepository.post(model);
    return sprintCreated;
  }
}
