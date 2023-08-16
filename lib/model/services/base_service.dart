abstract class BaseService {
  final String baseUrl = "https://api.pexels.com/v1";
  Future getResponse(String url);
}
