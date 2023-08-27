import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fm/di/dependency_injection.dart';
import 'package:flutter_fm/presentation/navigation/app_navigation.dart';
import 'package:flutter_fm/presentation/screens/login-screen/interactor/interactor.dart';
import 'package:flutter_fm/presentation/screens/login-screen/interactor/validator/login_screen.validate.dart';
import 'package:flutter_fm/shared/localizations/l10n/localy.dart';
import 'package:flutter_fm/shared/utils/page_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginScreenBloc loginScreenBloc;

  final _formLogin = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loginScreenBloc = getIt<LoginScreenBloc>();

    _emailController.addListener(() {
      loginScreenBloc.add(OnChangeEmail(email: _emailController.text));
    });

    _passwordController.addListener(() {
      loginScreenBloc.add(OnChangePassword(password: _passwordController.text));
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(Localy.of(context)!.loginScreenLabelAppBarTitle),
        ),
        body: BlocProvider(
          create: (_) => loginScreenBloc,
          child: BlocConsumer<LoginScreenBloc, LoginScreenState>(
            listenWhen: (previous, current) =>
                previous.pageState != PageState.success &&
                current.pageState == PageState.success,
            listener: pageCommandListener,
            builder: (_, state) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    key: _formLogin,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SpacingAlias.SizeHeight32,
                              ExpandableTextComponent(
                                textStyle:
                                    Theme.of(context).textTheme.headline2,
                                text: Localy.of(context)!
                                    .loginScreenLabelTitlePage,
                              ),
                              SpacingAlias.SizeHeight8,
                              ExpandableTextComponent(
                                text: Localy.of(context)!
                                    .loginScreenLabelSubTitle,
                              ),
                              SpacingAlias.SizeHeight32,
                            ],
                          ),
                          TextFormFieldCustom(
                            enabled: true,
                            labelText:
                                Localy.of(context)?.loginScreenLabelEmail,
                            controller: _emailController,
                            suffixIcon: const SizedBox.shrink(),
                            validator: (value) {
                              return LoginScreenValidationResults(context)
                                      .validateEmail(value!)
                                      .errorMessage ??
                                  null;
                            },
                          ),
                          TextFormFieldCustom(
                            enabled: true,
                            obscureText: true,
                            labelText:
                                Localy.of(context)?.loginScreenLabelPassword,
                            controller: _passwordController,
                            suffixIcon: const SizedBox.shrink(),
                            validator: (value) {
                              return LoginScreenValidationResults(context)
                                      .validatePassword(value!)
                                      .errorMessage ??
                                  null;
                            },
                          ),
                          SpacingAlias.SizeHeight32,
                          FlatButtonComponent(
                            onPressed: _onSubmitted,
                            title:
                                Localy.of(context)!.loginScreenLabelLoginButton,
                          ),
                        ],
                      ),
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
      BuildContext context, LoginScreenState state) async {}

  void _onSubmitted() {
    if (_formLogin.currentState!.validate()) {
      resetForm();
      AppNavigation.onNavigateToEmployeeListScreen(context);
    }
  }

  void resetForm() {
    loginScreenBloc.add(OnResetState());
    _emailController.text = "";
    _passwordController.text = "";
  }
}
