import 'package:flutter/material.dart';
import '../models/images_models.dart';
import '../repo/images_repo.dart';

class ImagePicker extends StatelessWidget {
  final Function(String) imageSelected;
  final ImageRepo _imgRepo = ImageRepo();
  ImagePicker({super.key, required this.imageSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: FutureBuilder<List<PixelImages>>(
        future: _imgRepo.getNetworkImages(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PixelImages>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      imageSelected(snapshot.data![index].smallSize);
                    },
                    child: Image.network(snapshot.data![index].smallSize));
              },
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
              ),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('This is an Error : ${snapshot.error}'),
            );
          }
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
