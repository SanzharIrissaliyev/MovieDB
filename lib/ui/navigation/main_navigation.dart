import 'package:flutter/material.dart';
import 'package:themovedb/ui/widgets/main_screen/main_screen_model.dart';
import '../../libruary/widgets/inherited/provider.dart';
import '../widgets/auth/auth_model.dart';
import '../widgets/auth/auth_widget.dart';
import '../widgets/main_screen/main_screen_widget.dart';
import '../widgets/movie_details/movie_details_widget.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '//movie_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.auth: (context) =>
        NotifierProvider(model: AuthModel(), child: const AuthWidget()),
    MainNavigationRouteNames.mainScreen: (context) => NotifierProvider(
          model: MainScreenModel(),
          child: const MainScreenWidget(),
        ),
  };
  // id kino
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => MovieDetailsWidget(movieId: movieId),
        );
      default:
        const widget = Text('Navigation Error!!!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
