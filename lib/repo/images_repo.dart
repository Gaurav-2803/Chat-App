import 'dart:convert';
import '../models/images_models.dart';
import 'package:http/http.dart' as http;

class ImageRepo {
  Future<List<PixelImages>> getNetworkImages() async {
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
  }
}
