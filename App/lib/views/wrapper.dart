import 'package:flutter/material.dart';
import 'package:hackmanthan_app/bloc/app_bloc/app_bloc_files.dart';
import 'package:hackmanthan_app/shared/loading.dart';
import 'package:hackmanthan_app/views/home_page.dart';
import 'package:hackmanthan_app/views/login_page.dart';

class Wrapper extends StatelessWidget {
  final AppState state;

  const Wrapper({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state is Uninitialized) {
      return const LoadingPage();
    } else if (state is Unauthenticated || state is LoginPageState) {
      return const LoginPage();
    } else if (state is Authenticated) {
      return const HomePage();
    } else {
      return const LoadingPage();
    }
  }
}
