import '../models/article.dart';
import '../../domain/models/geo_location.dart';

abstract class DatabaseRepository {
  Future<List<Article>> getSavedArticles();

  Future<void> saveArticle(Article article);

  Future<void> removeArticle(Article article);

}
