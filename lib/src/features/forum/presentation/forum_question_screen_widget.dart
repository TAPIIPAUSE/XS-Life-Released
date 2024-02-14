// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:xs_life/src/common_widgets/loading_screen_widget.dart';
import 'package:xs_life/src/features/authentication/data/auth_service.dart';
import 'package:xs_life/src/features/forum/data/forum_repository.dart';
import 'package:xs_life/src/features/forum/domain/forum_question.dart';
import 'package:xs_life/src/features/forum/domain/forum_question_comment.dart';

class ForumQuestionScreenWidget extends StatefulWidget {
  const ForumQuestionScreenWidget(
      {Key? key, this.forumQuestion, this.forumQuestionComments})
      : super(key: key);

  final ForumQuestion? forumQuestion;
  final List<ForumQuestionComment>? forumQuestionComments;

  @override
  State<StatefulWidget> createState() => ForumQuestionScreenWidgetState();
}

class ForumQuestionScreenWidgetState extends State<ForumQuestionScreenWidget> {
  final _formKey = GlobalKey<FormState>();
  final _comment = TextEditingController();
  ForumRepository forumRepository = ForumRepository();

  @override
  Widget build(BuildContext context) {
    List<ForumQuestionComment> comments = widget.forumQuestionComments ?? [];

    var details = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.forumQuestion?.question ?? ""),
          ],
        ),
      ),
    );

    var interactions = Container(
        padding: const EdgeInsets.fromLTRB(6, 34, 16, 32),
        child: Container(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    ),
                    Text("${widget.forumQuestion?.getTotalLikes()} likes")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: VerticalDivider(
                  color: Color.fromARGB(255, 221, 221, 221),
                  thickness: 3,
                  width: 10,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 3, 3, 2),
                    child: Icon(
                      Icons.comment,
                      color: Color.fromARGB(255, 244, 156, 5),
                    ),
                  ),
                  Text("${comments.length} comments")
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: VerticalDivider(
                  color: Color.fromARGB(255, 209, 209, 209),
                  thickness: 3,
                  width: 10,
                ),
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(5, 3, 3, 2),
                    child: Icon(
                      Icons.remove_red_eye_sharp,
                      color: Color.fromARGB(255, 30, 164, 110),
                    ),
                  ),
                  Text("${widget.forumQuestion?.views} views")
                ],
              )
            ],
          ),
        ));
    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset(
            'assets/images/Artboard_11.png',
            height: 120,
            width: 120,
          ),
        ],
        toolbarHeight: 100,
        backgroundColor: Color.fromARGB(255, 255, 110, 14),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 255, 110, 14),
                Color.fromARGB(255, 252, 213, 134)
              ])),
        ),
      ),
      body: widget.forumQuestion == null
          ? const LoadingScreenWidget()
          : Container(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(
                          widget.forumQuestion!.userDetail!.getFullName() ??
                              "Anonymous"),
                    ),
                    details,
                    interactions,
                    Visibility(
                      visible: comments.isNotEmpty,
                      child: Expanded(
                        child: Container(
                          color: Color.fromARGB(1, 197, 73, 73),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 35, 10, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(255, 193, 193, 193)
                                                  .withOpacity(0.5),
                                          // Adjust the shadow color as needed
                                          spreadRadius: 5,
                                          // Adjust the spread radius as needed
                                          blurRadius: 7,
                                          // Adjust the blur radius as needed
                                          offset: Offset(0,
                                              3), // Adjust the offset values as needed
                                        ),
                                      ],
                                      // Adjust the radius as needed
                                    ),
                                    child: Expanded(
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: [
                                          for (ForumQuestionComment comment
                                              in comments)
                                            ListTile(
                                              leading: const Icon(Icons.person),
                                              title: Text(
                                                comment.user_detail
                                                        .getFullName() ??
                                                    "Anonymous",
                                              ),
                                              subtitle: Text(comment.text),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 0),
                                    child: Container(
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: const [
                                                Color.fromARGB(
                                                    255, 255, 110, 14),
                                                Color.fromARGB(
                                                    255, 252, 213, 134)
                                              ])),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Text(
                                              " --- Comment section --- ",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Container(
                          color: Color.fromARGB(255, 255, 255, 255),
                          child: Form(
                            key: _formKey,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the radius as needed
                                border: Border.all(
                                  color: Colors
                                      .grey, // Adjust the border color as needed
                                  width:
                                      1.0, // Adjust the border width as needed
                                ),
                              ),
                              child: TextFormField(
                                controller: _comment,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(
                                      15), // Adjust the padding as needed
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.send),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        AuthService.authCheck(context)
                                            .then((value) async => {
                                                  if (value)
                                                    {
                                                      await forumRepository
                                                          .addCommentToQuestion(
                                                              widget
                                                                  .forumQuestion!
                                                                  .key,
                                                              _comment.text),
                                                      _comment.clear()
                                                    }
                                                });
                                      }
                                    },
                                  ),
                                  border: InputBorder
                                      .none, // Remove the default border
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter text to continue';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
