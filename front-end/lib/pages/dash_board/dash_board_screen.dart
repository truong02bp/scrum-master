import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/pages/dash_board/bloc/dash_board_bloc.dart';
import 'package:scrum_master_front_end/time_ultil.dart';
import 'package:scrum_master_front_end/widgets/base_screen.dart';

import 'components/reorder_list.dart';

class DashBoardScreen extends StatelessWidget {
  static const String routeName = "/dashboard";
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(BlocProvider(
      create: (context) => DashBoardBloc()..add(DashBoardInitial(context)),
      child: Builder(builder: (context) {
        return _buildView(context);
      }),
    ));
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<DashBoardBloc>(context);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bloc.add(GetLog());
      }
    });
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My issues',
                        style: TextStyle(fontSize: 21, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: BlocBuilder<DashBoardBloc, DashBoardState>(
                          bloc: bloc,
                          builder: (context, state) {
                            if (state.issues.isEmpty) {
                              return Container();
                            }
                            return ReorderList(state.issues);
                          },
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(
              height: 30,
            ),
            Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent activity',
                        style: TextStyle(fontSize: 21, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: BlocBuilder<DashBoardBloc, DashBoardState>(
                          bloc: bloc,
                          builder: (context, state) {
                            final logs = state.logs;
                            if (state.logs.isEmpty) {
                              return Container();
                            }
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListView.builder(
                                  itemCount: logs.length,
                                  controller: _scrollController,
                                  itemBuilder: (context, index) {
                                    final log = logs[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5, top: 10),
                                      child: Row(children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          child: CachedNetworkImage(
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) {
                                              return Image.asset(
                                                  'assets/images/loading.gif');
                                            },
                                            imageUrl: minioHost +
                                                log.user!.avatarUrl!,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(log.user!.name!),
                                        Text(' ${log.description!}'),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            child: Text(
                                              ' ${log.issue!.code!}: ${log.issue!.title!}',
                                              style: TextStyle(
                                                  color: Colors.blueAccent),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Text(getTimeOnlineString(
                                            time: log.createdDate!))
                                      ]),
                                    );
                                  }),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
