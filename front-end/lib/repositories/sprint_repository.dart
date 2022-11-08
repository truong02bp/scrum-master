import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/model/api_model.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
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
}
