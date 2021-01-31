import 'package:la_isla_Bonita_ui/models/models.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoadInProgress extends NewsState {}

class NewsLoadSuccess extends NewsState {
  final NewsApiResponse news;

  const NewsLoadSuccess({@required this.news}) : assert(news != null);

  @override
  List<Object> get props => [news];
}

class NewsLoadFailure extends NewsState {}
