import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../api/api.dart';
import '../constants/animals.dart';

class ImageDialog extends StatefulWidget {
  final String imagePath;

  ImageDialog({required this.imagePath});

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  bool isLoading = true;
  Api _api = Api();

  void _showClassInfoDialog(String className) {
    String habitat =
        animalInfo[className]?["Habitat"] ?? "Information not available";
    String lifeSpan =
        animalInfo[className]?["Lifespan"] ?? "Information not available";
    String diet = animalInfo[className]?["Diet"] ?? "Information not available";
    String overview = animalInfo[className]?["Characteristics"] ??
        "Information not available";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(className),
          content: SingleChildScrollView(
            // Added for better readability if content is long
            child: className == "Error"
                ? Text("Animal wasnt recognized.")
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Habitat",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(habitat),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Lifespan",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(lifeSpan),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Diet",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(diet),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Overview",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  overview,
                )
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(20),
      actionsAlignment: MainAxisAlignment.center,
      content: isLoading
          ? Container(height: 500,
            width: 300,
            child: const Center(
              child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator(color: Colors.black,),
      ),
            ),
          )
          : Container(
        width: 300, // Set the width of the container
        height: 500, // Set the height of the container
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Same radius as the Container
          child: Image.file(
            File(widget.imagePath), // Use your image file path here
            fit: BoxFit.cover, // This ensures the image covers the container bounds
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.white)),
          child: const Text(
            'Recognize animal',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () async {
            var animal = await _api.uploadImageAndPredict(File(widget.imagePath));
            Navigator.of(context).pop();
            _showClassInfoDialog(animal);
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.red)),
          child: Text('Close', style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );
  }
}