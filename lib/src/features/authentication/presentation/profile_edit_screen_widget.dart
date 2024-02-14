import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xs_life/src/common_widgets/loading_screen_widget.dart';
import 'package:xs_life/src/features/authentication/data/user_repository.dart';
import 'package:xs_life/src/features/authentication/domain/user_detail.dart';

class ProfileEditScreenWidget extends StatefulWidget {
  const ProfileEditScreenWidget(
      {super.key, this.userDetail, required this.isLoading});

  final UserDetail? userDetail;
  final bool isLoading;

  @override
  State<ProfileEditScreenWidget> createState() =>
      _ProfileEditScreenWidgetState();
}

class _ProfileEditScreenWidgetState extends State<ProfileEditScreenWidget> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Scaffold(body: LoadingScreenWidget());
    }

    if (widget.userDetail != null) {
      if (_firstName.text.isEmpty) {
        _firstName.text = widget.userDetail!.firstname;
      }
      if (_lastName.text.isEmpty) {
        _lastName.text = widget.userDetail!.lastname;
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 147, 64),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * .85,
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(195, 255, 255, 255),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Image.asset(
                          'assets/images/Artboard_11.png',
                          width: 300,
                          height: 300,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 15,
                        child: GestureDetector(
                          onTap: () {
                            // Handle icon tap action
                            // For example, navigate back to the previous screen
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Edit your profile",
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Start from here
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: TextFormField(
                                controller: _firstName,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(15),
                                  hintText: 'Enter your first name',
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: TextFormField(
                                controller: _lastName,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(15),
                                  hintText: 'Enter your last name',
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 300,
                                  child: FilledButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        UserRepository userRepo =
                                            UserRepository();
                                        UserDetail? userDetail =
                                            widget.userDetail;
                                        if (userDetail != null) {
                                          userDetail.firstname = _firstName.text;
                                          userDetail.lastname = _lastName.text;
                                          userRepo.updateUser(userDetail);
                                        } else {
                                          userRepo.checkLoggedInUser(
                                              _firstName.text, _lastName.text);
                                        }

                                        const snackBar = SnackBar(
                                          content: Text('User details saved'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                    child: const Text('Save'),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  child: FilledButton(
                                    onPressed: () async {
                                      FirebaseAuth.instance.signOut().then(
                                            (value) => Navigator.pop(context),
                                          );
                                    },
                                    child: const Text('Sign out'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
