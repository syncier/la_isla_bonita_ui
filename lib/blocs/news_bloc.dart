import 'package:la_isla_Bonita_ui/blocs/blocs.dart';
import 'package:la_isla_Bonita_ui/models/models.dart';
import 'package:la_isla_Bonita_ui/repositories/repositories.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';


class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({@required this.newsRepository})
      : assert(newsRepository != null),
        super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is NewsRequested) {
      yield NewsLoadInProgress();
      try {
        final NewsApiResponse news = await newsRepository.getNews(event.query);
        yield NewsLoadSuccess(news: news);
      } catch (_) {
        yield NewsLoadFailure();
      }
    }
  }
}