import 'package:hackmanthan_app/bloc/app_bloc/app_bloc_files.dart';
import 'package:hackmanthan_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Something\nWent Wrong",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w600,
                color: CustomTheme.t1,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                context.read<AppBloc>().add(AppStarted());
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                height: 55,
                decoration: BoxDecoration(
                  color: CustomTheme.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.replay_rounded,
                      size: 24,
                      color: CustomTheme.accent,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Please Try Again",
                      style: TextStyle(
                        fontSize: 16,
                        color: CustomTheme.onAccent,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SomethingWentWrongSmall extends StatelessWidget {
  const SomethingWentWrongSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Something\nWent Wrong",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w600,
                color: CustomTheme.t1,
              ),
            ),
            SizedBox(
              height: 40.w,
            ),
            InkWell(
              onTap: () {
                context.read<AppBloc>().add(AppStarted());
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50.w),
                height: 55.w,
                decoration: BoxDecoration(
                  color: CustomTheme.accent,
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.replay_outlined,
                      size: 24.w,
                      color: CustomTheme.onAccent,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "Please Try Again",
                      style: TextStyle(
                        fontSize: 16,
                        color: CustomTheme.t1,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.w),
      ),
      margin: EdgeInsets.all(15.w),
      behavior: SnackBarBehavior.floating,
      backgroundColor: CustomTheme.bg,
      content: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: CustomTheme.t1,
          fontWeight: FontWeight.w400,
        ),
      ),
      action: SnackBarAction(
        label: 'OK',
        textColor: CustomTheme.accent,
        onPressed: () {},
      ),
    ),
  );
}
