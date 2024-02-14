import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xs_life/src/constants/collection_constants.dart';
import 'package:xs_life/src/features/forum/data/forum_repository_interface.dart';

class ForumRepository extends IForumRepository {
  @override
  Future<void> addCommentToQuestion(String question_key, String text) async {
    await checkAuth();

    FirebaseFirestore.instance.collection(CollectionConstants.forumComment).add({
      'question_key': question_key,
      'text': text,
      'votes': 0,
      'user_key': FirebaseAuth.instance.currentUser!.uid,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> addQuestion(String category, String question) async {
    await checkAuth();

    await FirebaseFirestore.instance
        .collection(CollectionConstants.forum)
        .add(<String, dynamic>{
      'category': category,
      'question': question,
      'user_key': FirebaseAuth.instance.currentUser!.uid,
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'views': 0
    });
  }

  @override
  Future<void> addViewToQuestion(String key) {
    return FirebaseFirestore.instance
        .collection('forum')
        .doc(key)
        .update({"views": FieldValue.increment(1)});
  }

  @override
  Future<void> likeQuestion(String question_key) async {
    await checkAuth();

    var questionFirestore = FirebaseFirestore.instance
        .collection(CollectionConstants.forum)
        .doc(question_key);
    var question = await questionFirestore.get();

    if (question.exists) {
      var votes = question.data()?['votes'];
      var user = FirebaseAuth.instance.currentUser!.uid;
      if (votes == null) {
        votes = <dynamic>[user];
      } else {
        votes = votes as List<dynamic>;

        if (votes.contains(user)) {
          votes.remove(user);
        } else {
          votes.add(user);
        }
      }

      questionFirestore.update({'votes': votes});
    }
  }
}
