import 'package:la_isla_Bonita_ui/models/articles.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class NewsRequested extends NewsEvent {
  final ArticlesQuery query;

  const NewsRequested({@required this.query}) : assert(query != null);

  @override
  List<Object> get props => [query];
}