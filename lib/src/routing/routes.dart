import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xs_life/src/constants/page_constants.dart';
import 'package:xs_life/src/features/app/presentation/splash_screen_widget.dart';
import 'package:xs_life/src/features/authentication/application/authentication_actions.dart';
import 'package:xs_life/src/features/authentication/presentation/profile_edit_screen_widget.dart';
import 'package:xs_life/src/features/authentication/presentation/profile_edit_state.dart';
import 'package:xs_life/src/features/forum/presentation/forum_create_form.dart';
import 'package:xs_life/src/features/forum/presentation/forum_question_screen_widget.dart';
import 'package:xs_life/src/features/forum/presentation/forum_question_state.dart';
import 'package:xs_life/src/features/forum/presentation/forum_screen_widget.dart';
import 'package:xs_life/src/features/forum/presentation/forum_state.dart';
import 'package:xs_life/src/features/introduction/presentation/introduction_page.dart';
import 'package:xs_life/src/features/map/presentation/map_screen_widget.dart';
import 'package:xs_life/src/features/map/presentation/map_state.dart';

class Routes {
  static final router = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const SplashScreenWidget(),
      routes: [
        GoRoute(
          path: PageConstants.signIn,
          builder: (context, state) {
            return SignInScreen(
              actions: [
                AuthenticationActions.forgotPassword,
                AuthenticationActions.authStateChangeAction,
              ],
            );
          },
          routes: [
            GoRoute(
              path: 'forgot-password',
              builder: (context, state) {
                final arguments = state.queryParameters;
                return ForgotPasswordScreen(
                  email: arguments['email'],
                  headerMaxExtent: 200,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: PageConstants.profile,
          builder: (context, state) {
            return ChangeNotifierProvider(
              create: (context) => ProfileEditState(),
              builder: (context, child) {
                return Consumer<ProfileEditState>(
                  builder: (context, profileEditState, _) =>
                      ProfileEditScreenWidget(
                    userDetail: profileEditState.userDetail,
                    isLoading: profileEditState.isLoading,
                  ),
                );
              },
            );
            // return ProfileEditScreenWidget();
            // return ProfileScreen(
            //   providers: const [],
            //   actions: [
            //     SignedOutAction((context) {
            //       context.replace("/${PageConstants.map}");
            //     }),
            //   ],
            // );
          },
        ),
        GoRoute(
          path: PageConstants.map,
          builder: (context, state) {
            return ChangeNotifierProvider(
              create: (context) => MapState(),
              builder: (context, child) {
                return Consumer<MapState>(
                  builder: (context, mapState, _) => MapScreenWidget(
                    mapItems: mapState.mapItems,
                    mapCategories: mapState.mapCategories,
                    isLoading: mapState.isLoading,
                  ),
                );
              },
            );
          },
        ),
        GoRoute(
            path: PageConstants.introduction,
            builder: (context, state) => const IntroductionPage()),
        GoRoute(
          path: PageConstants.forum,
          builder: (context, state) {
            final forumState = Provider.of<ForumState>(context, listen: true);
            return ForumScreenWidget(
              questions: forumState.forumQuestions,
              isLoading: forumState.isLoading,
            );
          },
          routes: [
            GoRoute(
              path: 'add',
              builder: (context, state) {
                return const ForumCreateForm();
              },
            ),
            GoRoute(
              path: 'edit/:question',
              builder: (context, state) {
                return ChangeNotifierProvider(
                  create: (context) => ForumQuestionState(
                      state.pathParameters['question'] as String),
                  builder: (context, child) {
                    return Consumer<ForumQuestionState>(
                      builder: (context, appState, _) =>
                          ForumQuestionScreenWidget(
                        forumQuestion: appState.forumQuestion,
                        forumQuestionComments: appState.forumQuestionComments,
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ],
    )
  ]);
}
