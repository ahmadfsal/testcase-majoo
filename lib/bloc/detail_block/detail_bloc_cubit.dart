import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/models/movie_response.dart';
part 'detail_bloc_state.dart';

class DetailBlocCubit extends Cubit<DetailBlocState> {
  DetailBlocCubit() : super(DetailBlocInitialState());

  void fetchingDetailMovie(Data? data) async {
    emit(DetailBlocInitialState());

    if (data == null) {
      emit(DetailBlocErrorState("Error Unknown"));
    } else {
      emit(DetailBlocLoadedState(data));
    }
  }
}
