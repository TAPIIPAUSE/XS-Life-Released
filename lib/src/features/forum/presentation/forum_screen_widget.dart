// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/common_widgets/loading_screen_widget.dart';
import 'package:xs_life/src/constants/page_constants.dart';
import 'package:xs_life/src/features/app/presentation/fab_navigation_widget.dart';
import 'package:xs_life/src/features/app/presentation/navigate_profile.dart';
import 'package:xs_life/src/features/authentication/data/auth_service.dart';
import 'package:xs_life/src/features/forum/data/forum_category.dart';
import 'package:xs_life/src/features/forum/domain/forum_question.dart';
import 'package:xs_life/src/features/forum/presentation/forum_question_card.dart';

class ForumScreenWidget extends StatefulWidget {
  const ForumScreenWidget(
      {super.key, required this.questions, required this.isLoading});

  final List<ForumQuestion> questions;
  final bool isLoading;

  @override
  State<ForumScreenWidget> createState() => _ForumScreenWidgetState();
}

void _onFabPressed() {
  FabNavigateprofile();
}

class _ForumScreenWidgetState extends State<ForumScreenWidget> {
  List<ForumCategory> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    List<ForumQuestion> questions = widget.questions;
    if (selectedCategories.isNotEmpty) {
      questions = questions
          .where(
            (question) =>
                selectedCategories.isEmpty ||
                selectedCategories.contains(
                  ForumCategoryHelper.getEnum(question.category),
                ),
          )
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle_rounded),
          onPressed: _onFabPressed,
        ),
        leadingWidth: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Artboard_1.png',
                  height: 70,
                  width: 70,
                ),
                Visibility(
                  visible: AuthService.loggedIn(),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    onPressed: () {
                      context.push('/${PageConstants.forum}/add');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
        toolbarHeight: 120,
        backgroundColor: Color.fromARGB(255, 255, 110, 14),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // ignore: prefer_const_literals_to_create_immutables
              colors: [
                Color.fromARGB(255, 255, 126, 14),
                Color.fromARGB(255, 255, 221, 153),
              ],
            ),
          ),
        ),
      ),
      body: widget.isLoading
          ? const LoadingScreenWidget()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: Row(
                        children: ForumCategory.values
                            .map(
                              (category) => Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: FilterChip(
                                  selectedColor:
                                      Color.fromARGB(255, 255, 159, 14),
                                  backgroundColor:
                                      Color.fromARGB(248, 253, 211, 121),
                                  label: Text(
                                    ForumCategoryHelper.getViewName(category),
                                  ),
                                  selected:
                                      selectedCategories.contains(category),
                                  onSelected: (bool value) {
                                    if (value) {
                                      selectedCategories.add(category);
                                    } else {
                                      selectedCategories.remove(category);
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                          child: ForumQuestionCard(
                            forumQuestion: questions[index],
                          ),
                        );
                      },
                      itemCount: questions.length,
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: const FabNavigationWidget(),
    );
  }
}
