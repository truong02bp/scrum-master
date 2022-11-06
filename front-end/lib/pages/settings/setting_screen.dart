import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/pages/settings/bloc/setting_bloc.dart';
import 'package:scrum_master_front_end/pages/settings/components/organization_title.dart';
import 'package:scrum_master_front_end/pages/settings/components/users.dart';
import 'package:scrum_master_front_end/widgets/base_screen.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = "/setting";

  List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(BlocProvider(
      create: (context) => SettingBloc()..add(SettingInitialEvent(context)),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    ));
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<SettingBloc>(context);
    bloc.add(SettingInitialEvent(context));
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrganizationTitle(),
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
          Row(
            children: [
              Text(
                'Members',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(child: Users())
        ],
      ),
    );
  }
}
