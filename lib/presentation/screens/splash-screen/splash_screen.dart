import 'package:components/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fm/di/dependency_injection.dart';
import 'package:flutter_fm/presentation/navigation/app_navigation.dart';
import 'package:flutter_fm/presentation/screens/splash-screen/interactor/interactor.dart';
import 'package:flutter_fm/shared/localizations/l10n/localy.dart';
import 'package:flutter_fm/shared/utils/page_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashScreenBloc splashScreenBloc;

  @override
  void initState() {
    super.initState();
    splashScreenBloc = getIt<SplashScreenBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(Localy.of(context)!.splashScreenScreenTitle),
        ),
        body: BlocProvider<SplashScreenBloc>(
            create: (_) => splashScreenBloc..add(const OnInitialEvent()),
            child: BlocConsumer<SplashScreenBloc, SplashScreenState>(
                listenWhen: (previous, current) =>
                    previous.pageState != PageState.success &&
                    current.pageState == PageState.success,
                listener: pageCommandListener,
                builder: (_, state) {
                  switch (state.pageState) {
                    case PageState.initial:
                      return const SizedBox.shrink();

                    case PageState.loading:
                      return LoadingWidget();

                    case PageState.failure:
                      return const SizedBox.shrink();

                    case PageState.success:
                      return const SizedBox.shrink();
                  }
                })),
      ),
    );
  }

  Future<void> pageCommandListener(
      BuildContext context, SplashScreenState state) async {
    final pageCommand = state.pageCommand;
    splashScreenBloc.add(const ClearSplashScreenPageCommand());

    if (pageCommand is ShowLoginScreen) {
      await AppNavigation.onNavigateToLogin();
    }
  }
}
