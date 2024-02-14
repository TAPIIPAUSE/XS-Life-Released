import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/constants/page_constants.dart';
import 'package:xs_life/src/features/authentication/data/auth_service.dart';
import 'package:xs_life/src/features/forum/data/forum_category.dart';
import 'package:xs_life/src/features/forum/data/forum_repository.dart';
import 'package:xs_life/src/features/forum/domain/forum_question.dart';

class ForumQuestionCard extends StatelessWidget {
  final ForumQuestion forumQuestion;

  const ForumQuestionCard({
    Key? key,
    required this.forumQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForumRepository forumRepository = ForumRepository();

    return Card(
      elevation: 2, // Adjust the elevation value to control the shadow depth
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        onTap: () {
          forumRepository.addViewToQuestion(forumQuestion.key);
          context.push('/${PageConstants.forum}/edit/${forumQuestion.key}');
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(forumQuestion.userDetail!.getFullName() ?? "Anonymous"),
                  Text(
                    ForumCategoryHelper.getViewName(
                        ForumCategoryHelper.getEnum(forumQuestion.category)),
                    style: const TextStyle(fontSize: 14),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              alignment: Alignment.topLeft,
              child: Text(forumQuestion.question),
            ),
            ButtonTheme(
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    color: forumQuestion.hasUserLiked()
                        ? Colors.pink
                        : Colors.grey,
                    onPressed: () {
                      AuthService.authCheck(context).then((value) => {
                        if (value) {
                          forumRepository.likeQuestion(forumQuestion.key)
                        }
                      });
                    },
                  ),
                  Text("${forumQuestion.getTotalLikes()} likes")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
