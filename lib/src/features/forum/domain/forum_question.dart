import 'package:xs_life/src/features/authentication/data/auth_service.dart';
import 'package:xs_life/src/features/authentication/domain/user_detail.dart';

class ForumQuestion {
  final String key;
  final String category;
  final String question;
  final List<dynamic> votes;
  final int views;
  final UserDetail? userDetail;

  ForumQuestion({
    required this.key,
    required this.category,
    required this.question,
    required this.votes,
    required this.views,
    this.userDetail,
  });

  String getTotalLikes() {
    return votes.length.toString();
  }

  bool hasUserLiked() {
    if (AuthService.loggedIn()) {
      return votes.contains(AuthService.getUid());
    } else {
      return false;
    }
  }
}
