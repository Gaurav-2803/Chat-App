import 'package:json_annotation/json_annotation.dart';
part 'images_models.g.dart';

@JsonSerializable()
class PixelImages {
  String id;
  String filename;
  String? title;
  String description;
  @JsonKey(name: 'url_full_size')
  String largeSize;
  @JsonKey(name: 'url_medium_size')
  String mediumSize;
  @JsonKey(name: 'url_small_size')
  String smallSize;

  PixelImages({
    required this.id,
    required this.filename,
    this.title,
    required this.description,
    required this.largeSize,
    required this.mediumSize,
    required this.smallSize,
  });

  factory PixelImages.fromJson(Map<String, dynamic> json) =>
      _$PixelImagesFromJson(json);

  Map<String, dynamic> toJson() => _$PixelImagesToJson(this);
}
