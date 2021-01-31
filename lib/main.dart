import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_isla_Bonita_ui/app/landing_page.dart';
import 'package:la_isla_Bonita_ui/repositories/news_repository.dart';
import 'package:la_isla_Bonita_ui/repositories/repositories.dart';
import 'package:la_isla_Bonita_ui/services/auth.dart';
import 'package:la_isla_Bonita_ui/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'blocs/blocs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final NewsRepository newsRepository = NewsRepository(
    newsApiClient: NewsApiClient(
      httpClient: http.Client(),
    ),
  );
  runApp(App(
    newsRepository: newsRepository,
  ));
}

class App extends StatelessWidget {
  final NewsRepository newsRepository;

  App({Key key, @required this.newsRepository})
      : assert(newsRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'La Isla Bonita',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: BlocProvider(
            create: (context) => NewsBloc(newsRepository: newsRepository),
            child: LandingPage()),
      ),
    );
  }
}
