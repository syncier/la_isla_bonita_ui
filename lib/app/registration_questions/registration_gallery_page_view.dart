import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/app/registration_questions/registration_interested_topics.dart';
import 'package:la_isla_Bonita_ui/app/registration_questions/registration_languages.dart';
import 'package:la_isla_Bonita_ui/app/registration_questions/registration_location_page.dart';
import 'package:la_isla_Bonita_ui/app/registration_questions/registration_sliders_page.dart';

class RegistrationGalleryPageView extends StatelessWidget {
  final PageController controller = PageController(initialPage: 0);
  static const _duration = const Duration(milliseconds: 300);
  static const _curve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 32.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: () {
                  controller.previousPage(duration: _duration, curve: _curve);
                },
                backgroundColor: Color(0xFF3455C3),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  onPressed: () {
                    controller.nextPage(duration: _duration, curve: _curve);
                  },
                  backgroundColor: Color(0xFF3455C3),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: PageView(
          controller: controller,
          children: [
            RegistrationLocationPage(),
            RegistrationSlidersPage(),
            RegistrationInterestedTopicsPage(),
            RegistrationLanguagesPage()
          ],
        ),
      ),
    );
  }
}
