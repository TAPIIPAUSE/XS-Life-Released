import 'package:xs_life/src/common_widgets/repository_interface.dart';

abstract class IForumRepository extends IRepository {
  Future<void> addQuestion(String category, String question);
  Future<void> addCommentToQuestion(String question_key, String text);
  Future<void> addViewToQuestion(String key);
  Future<void> likeQuestion(String question_key);
}
