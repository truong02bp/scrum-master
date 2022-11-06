import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/model/role.dart';
import 'package:scrum_master_front_end/pages/settings/bloc/setting_bloc.dart';
import 'package:scrum_master_front_end/pages/settings/components/organization_title.dart';
import 'package:scrum_master_front_end/pages/settings/components/users.dart';
import 'package:scrum_master_front_end/widgets/loading_icon.dart';

class SettingScreen extends StatelessWidget {
  List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingBloc()..add(SettingInitialEvent(context)),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
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
