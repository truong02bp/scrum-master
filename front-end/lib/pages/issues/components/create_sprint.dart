import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CreateSprint extends StatelessWidget {
  const CreateSprint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AwesomeDialog(
            context: context,
            animType: AnimType.TOPSLIDE,
            dialogType: DialogType.NO_HEADER,
            aligment: Alignment.topCenter,
            keyboardAware: true,
            width: 1000,
            body: Container(
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 50, top: 10, right: 20),
                    child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'Create sprint',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey
                                  .withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(children: [
                              SizedBox(
                                  width: 100,
                                  child: Text(
                                    'Sprint name',
                                    style: TextStyle(
                                        fontSize: 16),
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: 300,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey
                                        .withOpacity(0.15),
                                    borderRadius:
                                    BorderRadius.circular(
                                        7)),
                                padding: EdgeInsets.only(
                                    left: 10, top: 3),
                                child: TextFormField(
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior
                                          .always,
                                      border:
                                      InputBorder.none,
                                      contentPadding:
                                      EdgeInsets.only(
                                          bottom: 10)),
                                ),
                              ),
                            ]),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(children: [
                              SizedBox(
                                  width: 100,
                                  child: Text(
                                    'Duration',
                                    style: TextStyle(
                                        fontSize: 16),
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: 300,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey
                                        .withOpacity(0.15),
                                    borderRadius:
                                    BorderRadius.circular(
                                        7)),
                                padding: EdgeInsets.only(
                                    left: 10, top: 3),
                                child: DropdownSearch<String>(
                                  items: [
                                    '1 week',
                                    '2 weeks',
                                    '3 weeks',
                                    '4 weeks',
                                    'Customize'
                                  ],
                                  dropdownDecoratorProps:
                                  DropDownDecoratorProps(
                                    dropdownSearchDecoration:
                                    InputDecoration(
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior
                                            .always,
                                        border:
                                        InputBorder
                                            .none,
                                        contentPadding:
                                        EdgeInsets
                                            .all(5)),
                                  ),
                                  onChanged: (value) {},
                                ),
                              )
                            ]),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(children: [
                              SizedBox(
                                  width: 100,
                                  child: Text(
                                    'Start date',
                                    style: TextStyle(
                                        fontSize: 16),
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate:
                                      DateTime
                                          .now(),
                                      firstDate:
                                      DateTime(
                                          2020),
                                      lastDate:
                                      DateTime(
                                          2024))
                                      .then((value) =>
                                  {print(value)});
                                },
                                child: Container(
                                  width: 300,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.grey
                                          .withOpacity(0.15),
                                      borderRadius:
                                      BorderRadius.circular(
                                          7)),

                                  child: Center(child: Text('16/07/2000', style: TextStyle(fontSize: 18),)),
                                ),
                              ),
                            ]),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(children: [
                              SizedBox(
                                  width: 100,
                                  child: Text(
                                    'End date',
                                    style: TextStyle(
                                        fontSize: 16),
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate:
                                      DateTime
                                          .now(),
                                      firstDate:
                                      DateTime(
                                          2020),
                                      lastDate:
                                      DateTime(
                                          2024))
                                      .then((value) =>
                                  {print(value)});
                                },
                                child: Container(
                                  width: 300,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.grey
                                          .withOpacity(0.15),
                                      borderRadius:
                                      BorderRadius.circular(
                                          7)),

                                  child: Center(child: Text('16/07/2000', style: TextStyle(fontSize: 18),)),
                                ),
                              ),
                            ]),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )))))
          ..show();
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.7),
            borderRadius: BorderRadius.circular(7)),
        child: Center(child: Text('+ Create sprint')),
      ),
    );
  }
}
