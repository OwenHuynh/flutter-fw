import 'package:components/components.dart';
import 'package:components/error/page_error_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fm/di/dependency_injection.dart';
import 'package:flutter_fm/presentation/navigation/app_navigation.dart';
import 'package:flutter_fm/presentation/screens/employee-list-screen/component/employee_loading.dart';
import 'package:flutter_fm/presentation/screens/employee-list-screen/interactor/viewmodel/employee_screen.bloc.dart';
import 'package:flutter_fm/presentation/screens/employee-list-screen/interactor/viewmodel/employee_screen.event.dart';
import 'package:flutter_fm/presentation/screens/employee-list-screen/interactor/viewmodel/employee_screen.state.dart';
import 'package:flutter_fm/presentation/screens/employee-list-screen/interactor/viewmodel/page_commands.dart';
import 'package:flutter_fm/shared/localizations/l10n/localy.dart';
import 'package:flutter_fm/shared/utils/page_state.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeeListScreen> {
  late EmployeesScreenBloc employeesScreenBloc;

  @override
  void initState() {
    super.initState();
    employeesScreenBloc = getIt<EmployeesScreenBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localy.of(context)!.employeeScreen),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              AppNavigation.onNavigateToEmployeeEditorScreen(context,
                  loadCallback: loadCallback);
            },
          )
        ],
      ),
      body: BlocProvider<EmployeesScreenBloc>(
        create: (_) => employeesScreenBloc..add(const OnLoadEmployeesList()),
        child: BlocConsumer<EmployeesScreenBloc, EmployeeScreenState>(
          listenWhen: (_, current) => current.pageCommand != null,
          listener: pageCommandListener,
          builder: (_, state) {
            switch (state.pageState) {
              case PageState.initial:
                return const SizedBox.shrink();
              case PageState.loading:
                // return LoadingIndicator();
                return Column(children: [
                  for (var i = 0; i < 4; i++) const EmployeesLoading()
                ]);
              case PageState.failure:
                final errorMessage = state.errorMessage;
                return PageErrorComponent(
                  errorMessage: "${Localy.of(context)!.oops}$errorMessage",
                  buttonTitle: Localy.of(context)!.retry,
                  buttonOnPressed: () {
                    employeesScreenBloc.add(const OnLoadEmployeesList());
                  },
                );
              case PageState.success:
                return ListView.separated(
                  padding: const EdgeInsets.all(SpacingAlias.Spacing12),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.employeeList.length,
                  itemBuilder: (_, index) {
                    final employee = state.employeeList[index];
                    final name = employee?.name;
                    final age = employee?.age;
                    final email = employee?.email;

                    return Card(
                      child: InkWell(
                        onTap: () {
                          employeesScreenBloc
                              .add(OnEmployeeClicked(employee!, index));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SpacingAlias.Spacing8,
                              horizontal: SpacingAlias.Spacing12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${Localy.of(context)!.nameEmployee} $name',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${Localy.of(context)!.ageEmployee} $age',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${Localy.of(context)!.emailEmployee} $email',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: SpacingAlias.Spacing12),
                );
            }
          },
        ),
      ),
    );
  }

  Future<void> pageCommandListener(
      BuildContext context, EmployeeScreenState state) async {
    final pageCommand = state.pageCommand;
    BlocProvider.of<EmployeesScreenBloc>(context)
        .add(const ClearEmployeesScreenPageCommand());

    if (pageCommand is ShowEmployeeDetailScreen) {
      await AppNavigation.onNavigateToEmployeeEditorScreen(context,
          employeeModel: pageCommand.employee,
          position: pageCommand.position,
          loadCallback: loadCallback);
    }
  }

  Future<void> loadCallback() async {
    employeesScreenBloc.add(const OnLoadEmployeesList());
  }
}
