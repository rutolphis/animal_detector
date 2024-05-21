import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class Api {

  Future uploadImageAndPredict(File imageFile) async {
    String error = "Error";
    if (imageFile != null) {
      // Prepare for the POST request
      var uri = Uri.parse('http://10.0.2.2:5000/predict');
      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        // Receive the response
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var prediction = json.decode(responseString);
        return prediction['class'];
      } else {
        print('Failed to get prediction.');
        return error;
      }
    } else {
      print('No image file provided.');
    }
  }

}
