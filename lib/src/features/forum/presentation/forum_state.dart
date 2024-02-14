import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xs_life/src/features/authentication/data/auth_service.dart';
import 'package:xs_life/src/features/authentication/data/user_repository.dart';
import 'package:xs_life/src/features/authentication/domain/user_detail.dart';

import '../domain/forum_question.dart';

class ForumState extends ChangeNotifier {
  ForumState() {
    init();
  }

  StreamSubscription<QuerySnapshot>? _forumQuestionsSubscription;
  List<ForumQuestion> _forumQuestions = [];

  List<ForumQuestion> get forumQuestions => _forumQuestions;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  UserRepository userRepository = UserRepository();

  Future<void> init() async {
    _forumQuestionsSubscription = FirebaseFirestore.instance
        .collection('forum')
        .orderBy('created_at', descending: true)
        .snapshots()
        .listen((snapshot) async {
      _forumQuestions = [];
      for (final document in snapshot.docs) {
        UserDetail? userDetail =
            await userRepository.getUserDetails(document.data()['user_key']);
        if (userDetail != null) {
          _forumQuestions.add(
            ForumQuestion(
                key: document.id,
                category: document.data()['category'] as String,
                question: document.data()['question'] as String,
                votes: document.data()['votes'] != null
                    ? document.data()['votes'] as List<dynamic>
                    : [],
                views: document.data()['views'] != null
                    ? document.data()['views'] as int
                    : 0,
                userDetail: userDetail),
          );
        }
      }
      _isLoading = false;
      notifyListeners();
    });
  }
}
