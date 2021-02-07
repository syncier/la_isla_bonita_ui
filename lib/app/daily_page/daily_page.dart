import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_isla_Bonita_ui/blocs/blocs.dart';
import 'package:la_isla_Bonita_ui/models/articles.dart';
import "package:story_view/story_view.dart";

class DailyPage extends StatelessWidget {
  final StoryController storyController = StoryController();

  @override
  Widget build(BuildContext context) {
    final query = ArticlesQuery.buildQuery(query: 'ocean');
    BlocProvider.of<NewsBloc>(context).add(NewsRequested(query: query));

    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      print(state is NewsLoadSuccess);
      if (state is NewsLoadSuccess) {
        print(state.news.articles[0].title);
        return _buildChildren(context, state);
      }
      return _buildChildren(context, state);
    });
  }

  Widget _buildChildren(BuildContext context, NewsState state) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: StoryView(
              controller: storyController,
              storyItems: _buildStoryItems(state),
              progressPosition: ProgressPosition.top,
              repeat: false,
            ),
            elevation: 2,
            margin: EdgeInsets.only(left: 5, right: 5, top: 32, bottom: 8),
          ),
        ),
      ],
    );
  }

  List<StoryItem> _buildStoryItems(NewsState state) {
    if (state is NewsLoadSuccess) {
      return state.news.articles.map((a) {
        print(a.urlToImage);
        return StoryItem.inlineImage(
            url: a.urlToImage,
            caption: Text(
              a.title,
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
            controller: storyController,
            duration: Duration(seconds: 10));
      }).toList();
    }
    return [StoryItem.text(title: 'No news', backgroundColor: Colors.indigo)];
  }
}
