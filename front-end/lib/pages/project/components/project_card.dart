import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/pages/project_members/project_members.dart';
import 'package:scrum_master_front_end/widgets/avatar.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  ProjectCard(this.project);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectMembers(project)));
      },
      child: Container(
        height: 150,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Stack(children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: 60,
                        child: Center(
                            child: Text(
                          'Name : ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                    Text(
                      '${project.name!}',
                      style: TextStyle(fontSize: 15),
                    ),
                    Spacer(
                      flex: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        width: 60,
                        child: Center(
                            child: Text(
                          'Owner : ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: CachedNetworkImage(
                        height: 25,
                        width: 25,
                        fit: BoxFit.cover,
                        imageUrl: minioHost + project.owner!.avatarUrl!,
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      '${project.owner!.name!}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        width: 60,
                        child: Center(
                            child: Text(
                          'Leader : ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ))),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: CachedNetworkImage(
                        height: 25,
                        width: 25,
                        fit: BoxFit.cover,
                        imageUrl: minioHost + project.projectLeader!.avatarUrl!,
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      '${project.projectLeader!.name!}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: CachedNetworkImage(
                height: 30,
                width: 30,
                fit: BoxFit.cover,
                imageUrl: minioHost + project.owner!.organization.logo,
              ),
            ),)
          ]),
        ),
      ),
    );
  }
}
