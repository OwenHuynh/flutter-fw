import 'package:components/res/spacing_alias.dart';
import 'package:components/widgets/buttons/flat_button_component.dart';
import 'package:components/widgets/buttons/flat_button_outlined_component.dart';
import 'package:components/widgets/input/text_form_field_custom.dart';
import 'package:cores/cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fm/data/locals/models/employee/employee_model.dart';
import 'package:flutter_fm/di/dependency_injection.dart';
import 'package:flutter_fm/presentation/navigation/app_navigation.dart';
import 'package:flutter_fm/presentation/screens/employee-editor-screen/interactor/validator/employee_editor.validate.dart';
import 'package:flutter_fm/presentation/screens/employee-editor-screen/interactor/viewmodel/employee_editor_screen.bloc.dart';
import 'package:flutter_fm/presentation/screens/employee-editor-screen/interactor/viewmodel/employee_editor_screen.event.dart';
import 'package:flutter_fm/presentation/screens/employee-editor-screen/interactor/viewmodel/employee_editor_screen.state.dart';
import 'package:flutter_fm/presentation/screens/employee-editor-screen/interactor/viewmodel/page_commands.dart';
import 'package:flutter_fm/shared/localizations/l10n/localy.dart';
import 'package:flutter_fm/shared/utils/ui_utils.dart';

class EmployeeEditorScreen extends StatefulWidget {
  const EmployeeEditorScreen(
      {Key? key, this.employeeModel, required this.loadCallback, this.position})
      : super(key: key);

  final EmployeeModel? employeeModel;
  final Function loadCallback;
  final int? position;

  @override
  _EmployeeEditorScreenState createState() => _EmployeeEditorScreenState();
}

class _EmployeeEditorScreenState extends State<EmployeeEditorScreen> {
  late EmployeeEditorScreenBloc employeeEditorScreenBloc;
  late bool isUpdated;
  final _formEmployeeEditor = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdated = widget.employeeModel != null;

    _nameController.text = widget.employeeModel?.name ?? "";
    _emailController.text = widget.employeeModel?.email ?? "";
    _ageController.text = widget.employeeModel?.age.toString() ?? "";
    employeeEditorScreenBloc = getIt<EmployeeEditorScreenBloc>();
    _nameController.addListener(() {
      employeeEditorScreenBloc.add(OnChangeName(name: _nameController.text));
    });
    _emailController.addListener(() {
      employeeEditorScreenBloc.add(OnChangeEmail(email: _emailController.text));
    });
    _ageController.addListener(() {
      employeeEditorScreenBloc.add(OnChangeAge(age: _ageController.text));
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(Localy.of(context)!.employeeEditorScreen),
        ),
        body: BlocProvider(
          create: (_) => employeeEditorScreenBloc
            ..add(OnInitialEmployeeEditorScreenEvent(
                age: StringUtils.defaultString(
                    widget.employeeModel?.age.toString(),
                    defaultStr: ""),
                name: widget.employeeModel?.name ?? "",
                email: widget.employeeModel?.email ?? "")),
          child:
              BlocConsumer<EmployeeEditorScreenBloc, EmployeeEditorScreenState>(
            listener: pageCommandListener,
            builder: (_, state) {
              return SafeArea(
                child: Form(
                  key: _formEmployeeEditor,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormFieldCustom(
                          enabled: true,
                          labelText: Localy.of(context)?.nameEmployee,
                          errorText: state.nameErrorMessage,
                          controller: _nameController,
                          suffixIcon: const SizedBox.shrink(),
                          validator: (value) {
                            return EmployeeEditorValidationResults(context)
                                    .validateName(value!)
                                    .errorMessage ??
                                null;
                          },
                        ),
                        TextFormFieldCustom(
                          enabled: true,
                          labelText: Localy.of(context)?.ageEmployee,
                          errorText: state.nameErrorMessage,
                          controller: _ageController,
                          maxLength: 2,
                          keyboardType: TextInputType.number,
                          suffixIcon: const SizedBox.shrink(),
                          validator: (value) {
                            return EmployeeEditorValidationResults(context)
                                    .validateAge(value!)
                                    .errorMessage ??
                                null;
                          },
                        ),
                        TextFormFieldCustom(
                          enabled: true,
                          labelText: Localy.of(context)?.emailEmployee,
                          errorText: state.emailErrorMessage,
                          controller: _emailController,
                          suffixIcon: const SizedBox.shrink(),
                          validator: (value) {
                            return EmployeeEditorValidationResults(context)
                                    .validateEmail(value!)
                                    .errorMessage ??
                                null;
                          },
                        ),
                        FlatButtonComponent(
                          onPressed: _onUpdated,
                          title: isUpdated
                              ? Localy.of(context)!
                                  .employeesEditorScreenLabelUpdateEmployee
                              : Localy.of(context)!
                                  .employeesEditorScreenLabelAddEmployee,
                        ),
                        SizedBox(height: SpacingAlias.Spacing12),
                        if (isUpdated)
                          FlatButtonOutlinedComponent(
                            onPressed: _onRemove,
                            title: Localy.of(context)!
                                .employeesEditorScreenLabelRemoveEmployee,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> pageCommandListener(
      BuildContext context, EmployeeEditorScreenState state) async {
    final pageCommand = state.pageCommand;
    BlocProvider.of<EmployeeEditorScreenBloc>(context)
        .add(const ClearEmployeeEditorScreenPageCommand());

    if (pageCommand is AddEmployeeList) {
      widget.loadCallback();
      UIUtils.showSuccessMessage(context,
          Localy.of(context)!.employeesEditorScreenLabelCreateSuccessfully);
      await AppNavigation.pop(context);
    }

    if (pageCommand is UpdateEmployeeList) {
      widget.loadCallback();
      UIUtils.showSuccessMessage(context,
          Localy.of(context)!.employeesEditorScreenLabelUpdateSuccessfully);
      await AppNavigation.pop(context);
    }

    if (pageCommand is RemoveEmployeeList) {
      widget.loadCallback();
      UIUtils.showSuccessMessage(context,
          Localy.of(context)!.employeesEditorScreenLabelRemoveSuccessfully);
      await AppNavigation.pop(context);
    }
  }

  void _onUpdated() {
    if (_formEmployeeEditor.currentState!.validate()) {
      if (isUpdated) {
        UIUtils.showConfirmDialog(
            context: context,
            title: Localy.of(context)!
                .employeesEditorScreenLabelUpdateEmployee,
            message: Localy.of(context)!
                .employeesEditorScreenLabelDescriptionConfirmUpdateEmployee,
            buttonConfirmCallback: () {
              employeeEditorScreenBloc
                  .add(OnUpdateEmployee(position: widget.position!));
              AppNavigation.pop(context);
            },
            onCancel: () {
              AppNavigation.pop(context);
            });
      } else {
        employeeEditorScreenBloc.add(OnAddEmployee());
      }
    }
  }

  void _onRemove() {
    UIUtils.showConfirmDialog(
        context: context,
        title: Localy.of(context)!
            .employeesEditorScreenLabelTitleConfirmRemoveEmployee,
        message: Localy.of(context)!
            .employeesEditorScreenLabelDescriptionConfirmRemoveEmployee,
        buttonConfirmCallback: () {
          employeeEditorScreenBloc
              .add(OnRemoveEmployee(position: widget.position!));
          AppNavigation.pop(context);
        },
        onCancel: () {
          AppNavigation.pop(context);
        });
  }
}
