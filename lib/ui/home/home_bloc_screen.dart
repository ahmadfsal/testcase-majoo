import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/ui/extra/error_screen.dart';
import 'package:majootestcase/ui/extra/loading.dart';
import 'package:majootestcase/ui/extra/no_internet_screen.dart';
import 'home_bloc_loaded_screen.dart';

class HomeBlocScreen extends StatelessWidget {
  const HomeBlocScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBlocCubit, HomeBlocState>(
        builder: (context, homeState) {
      if (homeState is HomeBlocLoadedState) {
        return HomeBlocLoadedScreen(data: homeState.data);
      } else if (homeState is HomeBlocLoadingState) {
        return LoadingIndicator();
      } else if (homeState is HomeBlocInitialState) {
        return Scaffold();
      } else if (homeState is HomeBlocErrorState) {
        return ErrorScreen(message: homeState.error);
      } else if (homeState is InternetDisconnected) {
        return NoInternetScreen();
      }

      return Center(
        child: Text(
          kDebugMode ? "state not implemented $homeState" : "",
        ),
      );
    });
  }
}
