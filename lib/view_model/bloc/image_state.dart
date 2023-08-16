part of 'image_bloc.dart';

abstract class ImageState {
  final ImagesDTO? imagesData;

  const ImageState({this.imagesData});
}

class ImageIntial extends ImageState {
  const ImageIntial() : super();
}

class ImageLoaded extends ImageState {
  const ImageLoaded({required super.imagesData});
}

class ImageLoading extends ImageState {
  const ImageLoading() : super();
}

class ImageError extends ImageState {
  final String errorMessage;
  const ImageError({required this.errorMessage}) : super();
}
