// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_bloc.dart';

abstract class ImageEvent {}

class OnFetchDefaultData extends ImageEvent {
  final String query;
  OnFetchDefaultData({
    this.query = "default",
  });
}

class OnImageSearch extends ImageEvent {
  final String query;
  final int page;
  final int page_size;

  OnImageSearch(this.query, this.page, this.page_size);
}
