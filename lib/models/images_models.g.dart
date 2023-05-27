// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PixelImages _$PixelImagesFromJson(Map<String, dynamic> json) => PixelImages(
      id: json['id'] as String,
      filename: json['filename'] as String,
      title: json['title'] as String?,
      description: json['description'] as String,
      largeSize: json['url_full_size'] as String,
      mediumSize: json['url_medium_size'] as String,
      smallSize: json['url_small_size'] as String,
    );

Map<String, dynamic> _$PixelImagesToJson(PixelImages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filename': instance.filename,
      'title': instance.title,
      'description': instance.description,
      'url_full_size': instance.largeSize,
      'url_medium_size': instance.mediumSize,
      'url_small_size': instance.smallSize,
    };
