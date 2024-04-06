import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/cubits/app_cubit/cubit.dart';
import 'package:todo_list_app/widgets/custom_text_form_field.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController dateController;
  final TextEditingController timeController;

  const CustomFloatingActionButton({
    super.key,
    required this.formKey,
    required this.scaffoldKey,
    required this.titleController,
    required this.dateController,
    required this.timeController,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (AppCubit.get(context).isBottomSheetShown) {
          if (formKey.currentState!.validate()) {
            AppCubit.get(context).insertToDatabase(
              title: titleController.text,
              date: dateController.text,
              time: timeController.text,
            );
          }
        } else {
          scaffoldKey.currentState!
              .showBottomSheet(
                (context) => Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextFormField(
                          controller: titleController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Title can not be empty';
                            }
                            return null;
                          },
                          hintText: 'Task Title',
                          labelText: 'Task',
                          prefixIcon: Icons.title,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              timeController.text =
                                  value!.format(context).toString();
                            });
                          },
                          controller: timeController,
                          type: TextInputType.datetime,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'time can not be empty';
                            }
                            return null;
                          },
                          hintText: 'time For task',
                          labelText: 'time',
                          prefixIcon: Icons.watch,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2025-12-07'),
                              initialDate: DateTime.now(),
                            ).then((value) {
                              dateController.text =
                                  DateFormat.yMMMd().format(value!);
                            });
                          },
                          controller: dateController,
                          type: TextInputType.datetime,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'date can not be empty';
                            }
                            return null;
                          },
                          hintText: 'date For task',
                          labelText: 'date',
                          prefixIcon: Icons.calendar_month,
                        ),
                      ],
                    ),
                  ),
                ),
                elevation: 20.0,
              )
              .closed
              .then(
            (value) {
              AppCubit.get(context).changeBottomSheetState(
                isShown: false,
                icon: Icons.edit,
              );
            },
          );
          AppCubit.get(context).changeBottomSheetState(
            isShown: true,
            icon: Icons.add,
          );
        }
      },
      child: Icon(
        AppCubit.get(context).fabIcon,
      ),
    );
  }
}
