import 'dart:convert';
import 'dart:io';
import '../models/images_models.dart';
import 'package:http/http.dart' as http;

class ImageRepo {
  Future<List<PixelImages>> getNetworkImages() async {
    try {
      var endPointURL = Uri.parse('https://pixelford.com/api2/images');
      final response = await http.get(endPointURL);
      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body) as List;

        final List<PixelImages> _pixelImgList = decodedList.map((Listitem) {
          return PixelImages.fromJson(Listitem);
        }).toList();
        return _pixelImgList;
      } else {
        throw Exception('API not successful');
      }
    } on SocketException {
      throw Exception('No Internet Connection :)');
    } on HttpException {
      throw Exception('Couldn\'t retrive images');
    } on FormatException {
      throw Exception('Bad response format!');
    } catch (e) {
      print(e);
      throw Exception('Unknown Error');
    }
  }
}
