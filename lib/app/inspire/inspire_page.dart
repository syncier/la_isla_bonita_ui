import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_isla_Bonita_ui/blocs/blocs.dart';
import 'package:la_isla_Bonita_ui/models/articles.dart';
import "package:story_view/story_view.dart";

class InspirePage extends StatelessWidget {
  final StoryController storyController = StoryController();

  int _selectedValue = 0;

  final chipsArray = [
    'Food',
    'Mobility',
    'Plastic',
    'Zero-Waste',
    'Option 5',
    'Option 6'
  ];

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
        Padding(
          padding:
              EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.0, top: 8.0),
          child: SizedBox(
            height: 42.0,
            child: ListView(
              primary: true,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Wrap(
                  spacing: 4.0,
                  runSpacing: 0.0,
                  children: List<Widget>.generate(
                      chipsArray.length, // place the length of the array here
                      (int index) {
                    return ChoiceChip(
                      label: Text(chipsArray[index],
                          style:
                              TextStyle(color: Colors.black, fontSize: 16.0)),
                      selected: _selectedValue == index,
                      selectedColor: Color(0xFF4FEAA9),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 550,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: StoryView(
              controller: storyController,
              storyItems: _buildStoryItems(state),
              progressPosition: ProgressPosition.top,
              repeat: false,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 3,
            margin: EdgeInsets.all(10),
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
