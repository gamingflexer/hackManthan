import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackmanthan_app/bloc/app_bloc/app_bloc.dart';
import 'package:hackmanthan_app/bloc/app_bloc/app_bloc_files.dart';
import 'package:hackmanthan_app/shared/shared_widgets.dart';
import 'package:hackmanthan_app/theme/theme.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18.w),
              child: const CustomBackButton(),
            ),
            SizedBox(height: 30.w),
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: CustomTheme.t1,
                ),
              ),
            ),
            SizedBox(height: 25.w),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                context.read<AppBloc>().add(LogoutUser());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Text(
                      'Sign Out',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: CustomTheme.t1,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 25.w,
                      color: CustomTheme.accent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
