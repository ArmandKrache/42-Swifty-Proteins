import 'package:swifty_companion/src/domain/models/article.dart';

abstract class DatabaseRepository {
  Future<List<Article>> getSavedArticles();

  Future<void> saveArticle(Article article);

  Future<void> removeArticle(Article article);
}