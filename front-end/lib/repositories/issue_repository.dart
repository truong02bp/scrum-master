
import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/model/api_model.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
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
}