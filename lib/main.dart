import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:majootestcase/ui/home/home_bloc_screen.dart';
import 'package:majootestcase/ui/auth/login_page.dart';
import 'package:flutter/foundation.dart';
import 'bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc/home_bloc_cubit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => AuthBlocCubit()..fetchHistoryLogin(),
        child: MyHomePageScreen(),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyHomePageScreen extends StatelessWidget {
  MyHomePageScreen({Key? key}) : super(key: key);
  final connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBlocCubit, AuthBlocState>(builder: (context, state) {
      if (state is AuthBlocLoginState) {
        return LoginPage();
      } else if (state is AuthBlocLoggedInState) {
        return BlocProvider(
          create: (context) => HomeBlocCubit(connectivity: connectivity),
          child: HomeBlocScreen(),
        );
      }

      return Center(
          child: Text(kDebugMode ? "state not implemented $state" : ""));
    });
  }
}
