import 'package:recipe_app/data/remote/recipe_query_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'recipe_api_service.g.dart';

@RestApi()
abstract class RecipeApiService {
  factory RecipeApiService(Dio dio) = _RecipeApiService;

  @GET('https://api.edamam.com/api/recipes/v2')
  Future<HttpResponse<RecipeQueryModel>> getRecipes({
    @Query("app_key") required String appKey,
    @Query("app_id") required String appId,
    @Query("type")  String type = 'public',
    @Query("q") String? query,
    @Query("health") String health_label = 'alcohol-free',
    @Query("health") String health_label2 = 'pork-free',
    @Queries() required Map<String,dynamic> queryParameters,
   });

  @GET('{nextPageUrl}')
  Future<HttpResponse<RecipeQueryModel>> getNextPageRecipes({
    @Path() String? nextPageUrl});
}
