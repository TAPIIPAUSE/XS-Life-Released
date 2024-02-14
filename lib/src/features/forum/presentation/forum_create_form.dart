import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xs_life/src/features/forum/data/forum_category.dart';
import 'package:xs_life/src/features/forum/data/forum_repository.dart';

class ForumCreateForm extends StatefulWidget {
  const ForumCreateForm({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => ForumCreateFormState();
}

class ForumCreateFormState extends State<ForumCreateForm> {
  final _formKey = GlobalKey<FormState>();
  ForumCategory? _category;
  bool categoryHasError = false;
  final _question = TextEditingController();

  final ForumRepository forumRepository = ForumRepository();

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: const Color.fromARGB(255, 255, 110, 14),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 255, 110, 14),
                    Color.fromARGB(255, 252, 213, 134)
                  ])),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: const Color.fromARGB(0, 169, 169, 169),
          child: Form(
            key: _formKey,
            child: Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(17),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            height: 80,
                            child: Row(
                              children: ForumCategory.values
                                  .map(
                                    (category) => Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: FilterChip(
                                        selectedColor: const Color.fromARGB(
                                            255, 255, 159, 14),
                                        backgroundColor: const Color.fromARGB(
                                            248, 253, 211, 121),
                                        label: Text(
                                          ForumCategoryHelper.getViewName(
                                              category),
                                        ),
                                        selected: category == _category,
                                        onSelected: (bool value) {
                                          if (value) {
                                            setState(() {
                                              _category = category;
                                            });
                                          } else {
                                            setState(() {
                                              _category = null;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )),
                    ),
                  ),
                  // fromLTRB(8, 30, 8, 0)
                  // Section 2
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(
                                0.5), // Adjust the shadow color as needed
                            spreadRadius: 5, // Adjust the spread radius as needed
                            blurRadius: 7, // Adjust the blur radius as needed

                            offset: const Offset(
                                0, 3), // Adjust the offset values as needed
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 253, 253),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Column(
                            // looking array from here
                            children: [
                              // section 1
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 100, 8, 0),
                                child: Container(
                                    color:
                                        const Color.fromARGB(255, 255, 255, 255),
                                    // Textformfield
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: _question,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 3,
                                      maxLines: 8,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  30)), // Adjust the radius as needed
                                        ),
                                        hintText: "Write your post here",
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 255, 242, 242),
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 40),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your question to continue';
                                        }
                                        return null;
                                      },
                                    )),
                              ),
                              //  end section 1
                              Padding(
                                padding: const EdgeInsets.fromLTRB(9, 21, 8, 100),
                                child: OutlinedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (_category == null) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Error'),
                                              content: const Text(
                                                  'Please select a category'),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Close'))
                                              ],
                                            ),
                                          );
                                        } else {
                                          forumRepository
                                              .addQuestion(
                                                _category!.name,
                                                _question.text,
                                              )
                                              .then((value) =>
                                                  Navigator.pop(context));
                                        }
                                      }
                                      // print(_controller.text);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 251, 166, 38)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'POST',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    )),
                              ),
                            ],

                            // the end of the section
                          ),
                        ),
                      ),
                    ),
                  ),
                  // the end of setion button
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
