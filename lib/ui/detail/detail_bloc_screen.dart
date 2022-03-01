import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/detail_block/detail_bloc_cubit.dart';
import 'package:majootestcase/ui/detail/detail_bloc_loaded_screen.dart';
import 'package:majootestcase/ui/extra/error_screen.dart';
import 'package:majootestcase/ui/extra/loading.dart';

class DetailBlocScreen extends StatelessWidget {
  const DetailBlocScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBlocCubit, DetailBlocState>(
        builder: (context, state) {
      if (state is DetailBlocLoadedState) {
        return DetailBlocLoadedScreen(data: state.data);
      } else if (state is DetailBlocLoadingState) {
        return LoadingIndicator();
      } else if (state is DetailBlocInitialState) {
        return Scaffold(
          body: Container(color: Colors.redAccent),
        );
      } else if (state is DetailBlocErrorState) {
        return ErrorScreen(message: state.error);
      }

      return Center(
          child: Text(kDebugMode ? "state not implemented $state" : ""));
    });
  }
}
