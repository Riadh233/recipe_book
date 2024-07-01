import 'package:recipe_app/data/repository/cloud_store_repository_impl.dart';
import 'package:recipe_app/domain/usecases/usecase.dart';

import '../repository/cloud_store_repository.dart';

class DeleteAllBookmarksUseCase extends UseCase<void,int>{
  CloudStoreRepository repository;
  DeleteAllBookmarksUseCase({required this.repository});
  @override
  Future<void> call({required int params}) async {
    repository.deleteAllBookmarkedRecipes();
  }
}