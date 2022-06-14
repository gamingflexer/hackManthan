import 'package:hackmanthan_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SpinKitCircle(
          size: 100.w,
          color: CustomTheme.accent,
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CustomTheme.bg,
        body: Center(
          child: SpinKitCircle(
            size: 100,
            color: CustomTheme.accent,
          ),
        ),
      ),
    );
  }
}

class LoadingSmall extends StatelessWidget {
  final double size;

  LoadingSmall({double? size, Key? key})
      : size = size ?? 100.w,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      child: SpinKitCircle(
        size: size,
        color: CustomTheme.accent,
      ),
    );
  }
}

void showLoadingSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.w),
      ),
      margin: EdgeInsets.all(15.w),
      behavior: SnackBarBehavior.floating,
      backgroundColor: CustomTheme.bg,
      content: Row(
        children: [
          Text(
            'Loading',
            style: TextStyle(
              fontSize: 16,
              color: CustomTheme.accent,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          CircularProgressIndicator(color: CustomTheme.accent),
        ],
      ),

    ),
  );
}

Future<void> showLoadingDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.25),
    builder: (context) {
      return Center(
        child: SizedBox(
          height: 220.w,
          width: 220.w,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.w),
            ),
            child: Container(
              padding: EdgeInsets.all(20.w),
              child: SpinKitCircle(
                size: 110.w,
                color: CustomTheme.accent,
              ),
            ),
          ),
        ),
      );
    },
  );
}
