import 'package:curie/model/services/base_service.dart';
import 'package:curie/model/services/image_service.dart';

import '../../Model/art_dto.dart';

class ImageRepo {
  final BaseService imageService = ImageService();

  Future<ImagesDTO> fetchImages({String query = "nature", int page = 1, int pageSize = 15}) async {
    dynamic response = await imageService.getResponse("search?query=$query&page=$page&per_page=$pageSize");
    ImagesDTO listOfCountries = ImagesDTO.fromJson(response);
    return listOfCountries;
  }
}
