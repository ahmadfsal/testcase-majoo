import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/services/api_service.dart';

part 'home_bloc_state.dart';

class HomeBlocCubit extends Cubit<HomeBlocState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  HomeBlocCubit({required this.connectivity}) : super(HomeBlocInitialState()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        emit(InternetDisconnected());
      } else {
        fetchingData();
      }
    });
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }

  void fetchingData() async {
    emit(HomeBlocLoadingState());
    ApiServices apiServices = ApiServices();
    MovieResponse? movieResponse = await apiServices.getMovieList();

    if (movieResponse == null) {
      emit(HomeBlocErrorState("Error Unknown"));
    } else {
      emit(HomeBlocLoadedState(movieResponse.data));
    }
  }
}
