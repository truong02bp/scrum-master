import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/model/api_model.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/pages/issues/bloc/issue_bloc.dart';
import 'package:scrum_master_front_end/repositories/api_repository.dart';

class IssueRepository {
  ApiRepository apiRepository = ApiRepository();

  String endpoints = host + "/issue";

  Future<List<Issue>?> findByProjectId(int projectId) async {
    ApiModel model = ApiModel(
        url: endpoints,
        params: {"projectId": "$projectId"},
        parse: (data) {
          return data.map<Issue>((json) => Issue.fromJson(json)).toList();
        });

    List<Issue>? issues = await apiRepository.get(model);
    return issues;
  }

  Future<List<Issue>?> findBySprintId(int sprintId) async {
    ApiModel model = ApiModel(
        url: endpoints + "/sprint",
        params: {"sprintId": "$sprintId"},
        parse: (data) {
          return data.map<Issue>((json) => Issue.fromJson(json)).toList();
        });

    List<Issue>? issues = await apiRepository.get(model);
    return issues;
  }

  Future<List<Issue>?> addIssue(int sprintId, Set<int> ids) async {
    String idsParam = "";
    ids.forEach((element) {
      idsParam += "$element,";
    });
    idsParam = idsParam.substring(0, idsParam.length - 1);
    ApiModel model = ApiModel(
        url: endpoints + "/assign",
        params: {"sprintId": "$sprintId", "ids": idsParam},
        parse: (data) {
          return data.map<Issue>((json) => Issue.fromJson(json)).toList();
        });

    List<Issue>? issues = await apiRepository.put(model);
    return issues;
  }

  Future<List<Issue>?> updateIndex(List<Issue> indexIssues) async {
    ApiModel model = ApiModel(
        url: endpoints + "/index",
        body: indexIssues,
        parse: (data) {
          return data.map<Issue>((json) => Issue.fromJson(json)).toList();
        });

    List<Issue>? issues = await apiRepository.put(model);
    return issues;
  }

  Future<Issue?> create(CreateIssueEvent event) async {
    ApiModel model = ApiModel(
        url: endpoints,
        body: {
          "project": event.project,
          "type": event.type,
          "description": event.description,
          "title": event.title,
          "label": event.label,
          "estimate": event.estimate,
          "assignee": event.assignee,
          "sprint": event.sprint
        },
        parse: (json) => Issue.fromJson(json));

    Issue? issue = await apiRepository.post(model);
    return issue;
  }

  Future<Issue?> update(
    int? id,
    String? type,
    String? description,
    String? title,
    String? label,
    int? estimate,
    User? assignee,
    Sprint? sprint
  ) async {
    ApiModel model = ApiModel(
        url: endpoints,
        body: {
          "id": id,
          "type": type,
          "description": description,
          "title": title,
          "label": label,
          "estimate": estimate,
          "assignee": assignee,
          "sprintId": sprint != null ? sprint.id : null
        },
        parse: (json) => Issue.fromJson(json));

    Issue? issue = await apiRepository.put(model);
    return issue;
  }
}
