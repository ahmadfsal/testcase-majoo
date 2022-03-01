import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';

class NoInternetScreen extends StatelessWidget {
  NoInternetScreen({Key? key}) : super(key: key);
  final connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: 200.0,
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () => HomeBlocCubit(connectivity: connectivity),
                child: Text('Refresh'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
