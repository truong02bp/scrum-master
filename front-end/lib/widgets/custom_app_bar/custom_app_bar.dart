import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hovering/hovering.dart';
import 'package:scrum_master_front_end/constants/color.dart';
import 'package:scrum_master_front_end/widgets/avatar.dart';
import 'package:scrum_master_front_end/widgets/custom_app_bar/bloc/custom_app_bar_bloc.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomAppBarBloc(),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    final style = TextStyle(fontSize: 16);
    return Row(
      children: [
        Text(
          'Scrum master',
          style: TextStyle(color: Colors.deepOrange, fontSize: 25),
        ),
        const SizedBox(
          width: 30,
        ),
        Spacer(),
        Text(
          'Dashboard',
          style: style,
        ),
        Spacer(),
        buildButton(
            label: "Projects",
            items: List.generate(
                5,
                (index) => DropdownMenuItem(
                      child: Text("$index"),
                      value: index,
                    )),
            onChange: (value) {}),
        Spacer(),
        buildButton(
            label: "Boards",
            items: List.generate(
                5,
                (index) => DropdownMenuItem(
                      child: Text("$index"),
                      value: index,
                    )),
            onChange: (value) {}),
        Spacer(),
        buildButton(
            label: "Issues",
            items: List.generate(
                5,
                (index) => DropdownMenuItem(
                      child: Text("$index"),
                      value: index,
                    )),
            onChange: (value) {}),
        Spacer(),
        HoverButton(
          onpressed: () {},
          child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                  child: Text(
                'Create issue',
                style: style,
              ))),
        ),
        const SizedBox(
          width: 30,
        ),
        Spacer(
          flex: 25,
        ),
        DropdownButton2(
          hint: Avatar(
              size: 45,
              url:
                  "https://vtv1.mediacdn.vn/thumb_w/650/2022/3/4/avatar-jake-neytiri-pandora-ocean-1646372078251163431014-crop-16463720830272075805905.jpg"),
          items: [
            DropdownMenuItem(
              child: Text('Profile'),
              value: "profile",
            ),
            DropdownMenuItem(
              child: Text('Logout'),
              value: "logout",
            ),
          ],
          buttonPadding: const EdgeInsets.only(left: 10),
          itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          buttonDecoration:
              BoxDecoration(borderRadius: BorderRadius.circular(7)),
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: AppColor.white),
          iconEnabledColor: Colors.white,
          underline: Container(),
          onChanged: (value) {},
          dropdownMaxHeight: 400,
          buttonWidth: 90,
          dropdownWidth: 200,
        ),
        Spacer(),
      ],
    );
  }

  Widget buildButton(
      {required String label,
      required List<DropdownMenuItem> items,
      required Function onChange}) {
    return DropdownButton2(
      hint: Text(
        label,
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
      items: items,
      onChanged: (value) {
        onChange(value);
      },
      buttonHeight: 40,
      dropdownMaxHeight: 400,
      buttonWidth: 90,
      dropdownWidth: 200,
      buttonPadding: const EdgeInsets.only(left: 10),
      itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      buttonDecoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
      dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColor.white),
      iconEnabledColor: Colors.white,
      underline: Container(),
    );
  }

  static PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 17),
      title: CustomAppBar(),
    );
  }
}


