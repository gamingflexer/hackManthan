import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hackmanthan_app/bloc/app_bloc/app_bloc_files.dart';
import 'package:hackmanthan_app/models/user.dart';
import 'package:hackmanthan_app/repositories/auth_repository.dart';
import 'package:hackmanthan_app/shared/error_screen.dart';
import 'package:hackmanthan_app/theme/theme.dart';
import 'package:hackmanthan_app/views/wrapper.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (context) => AuthRepository(),
      child: BlocProvider<AppBloc>(
        create: (context) {
          AppBloc appBloc =
              AppBloc(authRepository: context.read<AuthRepository>());
          appBloc.add(AppStarted());
          return appBloc;
        },
        child: Builder(
          builder: (context) {
            return BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                UserData user = context.read<AppBloc>().user;
                // DatabaseBloc
                return ScreenUtilInit(
                  designSize: const Size(414, 896),
                  builder: (context, child) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: CustomTheme.getTheme(context),
                      home: Wrapper(state: state),
                      builder: (context, child) {
                        int width = MediaQuery.of(context).size.width.toInt();
                          return MediaQuery(
                            data:
                            MediaQuery.of(context).copyWith(textScaleFactor: width / 414),
                            child: child ?? const SomethingWentWrong(),
                          );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
