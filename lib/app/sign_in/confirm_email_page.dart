import 'package:flutter/material.dart';
import 'package:la_isla_Bonita_ui/services/auth.dart';
import 'package:provider/provider.dart';

class ConfirmEmail extends StatelessWidget {
  static const PAGE_COLOR = 0xFF4F6BE7;
  static const id = 'confirm-email';

  const ConfirmEmail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return Scaffold(
      backgroundColor: Color(PAGE_COLOR),
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(null),
          ),
        ],
        backgroundColor: Color(PAGE_COLOR),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 64.0,
              ),
              Text(
                'You received mail from us',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Please click on the link in the mail, \nto confirm your e-mail address.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    'No mail in your inbox?',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        auth.resendEmail().then((value) async => {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Email sent'),
                                        content: Text(
                                            'Email resent successfully. Please check your mailbox.'),
                                        actions: [
                                          TextButton(
                                            child: Text('OK'),
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                          ),
                                        ],
                                      ))
                            });
                      },
                      child: Text(
                        'Send link again',
                        style: TextStyle(
                            color: Color(PAGE_COLOR),
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
