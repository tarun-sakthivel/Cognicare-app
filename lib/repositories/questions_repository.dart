import 'dart:io';
import 'package:http/http.dart' as http;

class QuestionsRepository {
  Future<void> submitForm(Map<String, dynamic> answers, {File? file}) async {
    final url = Uri.parse(
        'http://10.239.101.101:8000/predict/combined'); // your API endpoint

    var request = http.MultipartRequest('POST', url);

    // Add form fields
    request.fields.addAll({
      'A1': answers['A1'].toString(),
      'A2': answers['A2'].toString(),
      'A3': answers['A3'].toString(),
      'A4': answers['A4'].toString(),
      'A5': answers['A5'].toString(),
      'A6': answers['A6'].toString(),
      'A7': answers['A7'].toString(),
      'A8': answers['A8'].toString(),
      'A9': answers['A9'].toString(),
      'A10': answers['A10'].toString(),
      'Age_Mons': answers['Age_Mons'].toString(),
      'Sex': answers['Sex'].toString(),
      'Ethnicity': answers['Ethnicity'].toString(),
      'Jaundice': answers['Jaundice'].toString(),
      'Family_mem_with_ASD': answers['Family_mem_with_ASD'].toString(),
    });

    // If your endpoint expects a file (optional)
    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(" Form submitted successfully!");
        print("Response: ${response.body}");
      } else {
        print(" Failed to submit form: ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print(" Error submitting form: $e");
    }
  }
}
