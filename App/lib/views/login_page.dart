import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackmanthan_app/bloc/app_bloc/app_bloc_files.dart';
import 'package:hackmanthan_app/shared/error_screen.dart';
import 'package:hackmanthan_app/shared/loading.dart';
import 'package:hackmanthan_app/shared/shared_widgets.dart';
import 'package:hackmanthan_app/theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  String stateMessage = '';
  bool showPassword = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) async {
        if (state is LoginPageState) {
          if (state == LoginPageState.loading) {
            showLoadingSnackBar(context);
          } else {
            showErrorSnackBar(context, state.message);
          }
        }
        if (state is Authenticated) {
          stateMessage = 'Success!';
          Navigator.pop(context);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          print('Navigating..');
          Navigator.popUntil(context, ModalRoute.withName('/'));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              color: CustomTheme.bg,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          SizedBox(
                            height: 130.w,
                            child: Image.asset('assets/police_logo.png'),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            'Chhattisgarh\nPolice',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          'Login to continue',
                          style: TextStyle(
                            height: 1.25.w,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      CustomShadow(
                        child: TextFormField(
                          decoration: customInputDecoration(labelText: 'Email'),
                          style: formTextStyle(),
                          onSaved: (value) {
                            email = value ?? '';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!validateEmail(email)) {
                              return 'Invalid email format';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20.w),
                      Stack(
                        children: [
                          CustomShadow(
                            child: TextFormField(
                              decoration:
                                  customInputDecoration(labelText: 'Password'),
                              style: formTextStyle(),
                              obscureText: !showPassword,
                              onSaved: (value) {
                                password = value ?? '';
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 10.w),
                            height: 56.w,
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(
                                  showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 28.w),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.w),
                      CustomElevatedButton(
                        text: 'Login',
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState?.save();
                          showErrorSnackBar(context, stateMessage);
                          BlocProvider.of<AppBloc>(context)
                              .add(LoginUser(email: email, password: password));
                        },
                      ),
                      const Spacer(flex: 4),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool validateEmail(String email) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}
