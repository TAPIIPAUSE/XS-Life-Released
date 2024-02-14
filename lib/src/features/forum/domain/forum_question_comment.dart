import 'package:xs_life/src/features/authentication/domain/user_detail.dart';

class ForumQuestionComment {
  final String key;
  final UserDetail user_detail;
  final String question_key;
  final String text;
  final DateTime? created_at;

  ForumQuestionComment(this.key, this.user_detail, this.question_key, this.text,
      this.created_at);
}
