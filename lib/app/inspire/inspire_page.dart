import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_isla_Bonita_ui/blocs/blocs.dart';
import 'package:la_isla_Bonita_ui/common_widgets/custom_raised_button.dart';
import 'package:la_isla_Bonita_ui/models/articles.dart';

class InspirePage extends StatefulWidget {
  @override
  _InspirePageState createState() => _InspirePageState();
}

class _InspirePageState extends State<InspirePage> {
  int _selectedValue = 0;

  final array = [
    'Food',
    'Mobility',
    'Plastic',
    'Zero-Waste',
    'Option 5',
    'Option 6'
  ];

  @override
  Widget build(BuildContext context) {
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
                      array.length, // place the length of the array here
                      (int index) {
                    return ChoiceChip(
                      label: Text(array[index],
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
        CustomRaisedButton(
          child: Text('Get News'),
          onPressed: () {
            print('something');
            final query = ArticlesQuery.buildQuery(query: 'ocean');
            BlocProvider.of<NewsBloc>(context).add(NewsRequested(query: query));
          },
        ),
        BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            print(state is NewsLoadSuccess);
            if (state is NewsLoadSuccess) {
              print(state.news.articles[0].title);
          }
          return Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                'https://placeimg.com/720/720/any',
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 3,
              margin: EdgeInsets.all(10),
            );
          }
        ),
      ],
    );
  }
}
