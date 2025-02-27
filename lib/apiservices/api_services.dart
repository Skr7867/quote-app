import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/io_client.dart';

import '../model/quote_model.dart';

class ApiServices {
  Future<QuoteModel?> quoteModel() async {
    try {
      var url = Uri.parse("https://api.quotable.io/random");

      HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      IOClient ioClient = IOClient(httpClient);
      var response = await ioClient.get(url);

      if (response.statusCode == 200) {
        return QuoteModel.fromJson(jsonDecode(response.body));
      } else {
        log('status code: ${response.statusCode}');
      }
    } catch (e) {
      log('error during fetch quote $e');
    }
    return null;
  }
}
