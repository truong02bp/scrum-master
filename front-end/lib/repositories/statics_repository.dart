import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/model/api_model.dart';
import 'package:scrum_master_front_end/model/issue_statics.dart';
import 'package:scrum_master_front_end/model/performance_statics.dart';
import 'package:scrum_master_front_end/model/project_member_statics.dart';
import 'package:scrum_master_front_end/model/project_statics.dart';
import 'package:scrum_master_front_end/repositories/api_repository.dart';

class StaticsRepository {
  ApiRepository apiRepository = ApiRepository();

  String endpoints = host + "/statics";

  Future<IssueStatics?> exportIssueStatics(int userId) async {
    String url = endpoints + "/issue";
    ApiModel model = ApiModel(
        url: url,
        params: {"userId": "$userId"},
        parse: (json) => IssueStatics.fromJson(json));
    IssueStatics? statics = await apiRepository.get(model);
    return statics;
  }

  Future<PerformanceStatics?> exportPerformanceStatics(int userId) async {
    String url = endpoints + "/performance";
    ApiModel model = ApiModel(
        url: url,
        params: {"userId": "$userId"},
        parse: (json) => PerformanceStatics.fromJson(json));
    PerformanceStatics? statics = await apiRepository.get(model);
    return statics;
  }

  Future<ProjectStatics?> exportProjectStatics(int userId) async {
    String url = endpoints + "/project";
    ApiModel model = ApiModel(
        url: url,
        params: {"userId": "$userId"},
        parse: (json) => ProjectStatics.fromJson(json));
    ProjectStatics? statics = await apiRepository.get(model);
    return statics;
  }

  Future<ProjectMemberStatics?> exportProjectMemberStatics(int projectId) async {
    String url = endpoints + "/project/member";
    ApiModel model = ApiModel(
        url: url,
        params: {"projectId": "$projectId"},
        parse: (json) => ProjectMemberStatics.fromJson(json));
    ProjectMemberStatics? statics = await apiRepository.get(model);
    return statics;
  }


}
