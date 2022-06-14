import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackmanthan_app/bloc/app_bloc_observer.dart';
import 'package:hackmanthan_app/firebase_options.dart';
import 'package:hackmanthan_app/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  BlocOverrides.runZoned(
    () => {runApp(const FlutterFireInit())},
    eventTransformer: sequential<dynamic>(),
    blocObserver: MyAppBlocObserver(),
  );
}

class FlutterFireInit extends StatefulWidget {
  const FlutterFireInit({Key? key}) : super(key: key);

  @override
  _FlutterFireInitState createState() => _FlutterFireInitState();
}

class _FlutterFireInitState extends State<FlutterFireInit> {
  Future<FirebaseApp> _initialization() async {
    return await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // return const MaterialApp(home: SomethingWentWrong());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        // return const LoadingPage();
        return Container();
      },
    );
  }
}
