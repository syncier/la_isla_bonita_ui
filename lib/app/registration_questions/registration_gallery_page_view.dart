import 'package:flutter/cupertino.dart';
import 'package:la_isla_Bonita_ui/app/registration_questions/registration_location_page.dart';
import 'package:la_isla_Bonita_ui/app/registration_questions/registration_sliders_page.dart';

class RegistrationGalleryPageView extends StatelessWidget {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: PageView(controller: controller, children: [
        RegistrationLocationPage(),
        RegistrationSlidersPage()
      ],),
    );
  }
}
