import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fm/presentation/navigation/auto_slide_route_observer.dart';
import 'package:flutter_fm/presentation/navigation/navigation_handler.dart';
import 'package:flutter_fm/shared/theme/app_theme.dart';
import 'package:flutter_fm/shared/utils/orientation_utils.dart';
import 'package:flutter_fm/states-management/demo/viewmodel/demo.bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class Application extends StatefulWidget {
  State<Application> createState() => new _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
    OrientationHelper.setPreferredOrientations([DeviceOrientation.portraitUp]);
    OrientationHelper.forceOrientation(DeviceOrientation.portraitUp);
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (_) {},
        child: MultiBlocProvider(
            providers: [BlocProvider<DemoBloc>(create: (_) => DemoBloc())],
            child: Builder(builder: (context) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                routerDelegate: AutoRouterDelegate(
                  appRouter,
                  navigatorObservers: () => [AutoSlideRouteObserver()],
                ),
                routeInformationParser: appRouter.defaultRouteParser(),
                locale:
                    Locale.fromSubtags(languageCode: Intl.getCurrentLocale()),
                supportedLocales: Localy.supportedLocales,
                localizationsDelegates: Localy.localizationsDelegates,
              );
            })));
  }
}
