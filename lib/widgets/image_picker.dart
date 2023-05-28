import 'package:flutter/material.dart';
import '../models/images_models.dart';
import '../repo/images_repo.dart';

class ImagePicker extends StatelessWidget {
  ImagePicker({super.key});
  final ImageRepo _imgRepo = ImageRepo();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PixelImages>>(
      future: _imgRepo.getNetworkImages(),
      builder:
          (BuildContext context, AsyncSnapshot<List<PixelImages>> snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Image.network(snapshot.data![index].smallSize);
            },
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
            ),
          );
        }
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
