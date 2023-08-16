import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curie/Model/art_dto.dart';
import 'package:curie/model/repository/image_repo.dart';
part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(const ImageIntial()) {
    on<OnFetchDefaultData>((event, emit) async {
      emit(const ImageLoading());
      try {
        var data = await ImageRepo().fetchImages(query: event.query, page: 1, pageSize: 15);
        emit(ImageLoaded(imagesData: data));
      } catch (e) {
        emit(const ImageError(errorMessage: "Something went wrong1"));
      }
    });
    on<OnImageSearch>((event, emit) async {
      emit(const ImageLoading());
      try {
        var data = await ImageRepo().fetchImages(query: event.query, page: event.page, pageSize: event.page_size);
        emit(ImageLoaded(imagesData: data));
      } catch (e) {
        emit(const ImageError(errorMessage: "Something went wrong2"));
      }
    });
  }
}
