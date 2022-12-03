import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/pages/settings/bloc/setting_bloc.dart';

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingBloc>(context);
    return BlocBuilder<SettingBloc, SettingState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.users == null) {
          return CircularProgressIndicator();
        }
        return ListView(
          padding: const EdgeInsets.all(5),
          children: List.generate(
              state.users!.length,
              (index) => InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(15),
                  child:
                      _buildItem(user: state.users![index], context: context))),
        );
      },
    );
  }

  Container _buildItem({required User user, required BuildContext context}) {
    final bloc = BlocProvider.of<SettingBloc>(context);
    return Container(
      height: 70,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Image.asset('assets/images/loading.gif');
              },
              imageUrl: minioHost + user.avatarUrl!,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Text(
              user.name!,
              style: TextStyle(fontSize: 14),
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Text(
              user.email,
              style: TextStyle(fontSize: 14),
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              user.role.code,
              style: TextStyle(fontSize: 14),
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              user.isActive == true ? "Activated" : "Disabled",
              style: TextStyle(
                  fontSize: 14,
                  color: user.isActive == true ? Colors.green : Colors.red),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.NO_HEADER,
                  width: 500,
                  padding:
                      EdgeInsets.only(top: 40, bottom: 40, left: 40, right: 40),
                  btnOkOnPress: () {
                    bloc.add(RemoveMemberEvent(user.id));
                  },
                  body: SizedBox(
                    height: 50,
                    child: Text(
                      'Are you sure to delete this user?',
                    ),
                  ),
                  btnOkText: 'Confirm',
                  btnCancelOnPress: () {})
                ..show();
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 17,
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
