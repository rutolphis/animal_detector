import 'package:flutter/material.dart';
import 'package:nie_vmm/widgets/camera.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.black.withOpacity(0.6), Colors.transparent]),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Animal recognizer',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 32),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.question_mark,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              // Action to be performed when question icon is tapped
              // For example, show a dialog or a new screen with information
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('How to use'),
                    content: Text(
                        'Direct your camera towards an animal, and the application will identify it for you, providing additional information about the species.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: CameraWidget(), // Your existing CameraWidget
    );
  }
}
