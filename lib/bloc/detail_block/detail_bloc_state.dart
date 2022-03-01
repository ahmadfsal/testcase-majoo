part of 'detail_bloc_cubit.dart';

abstract class DetailBlocState extends Equatable {
  const DetailBlocState();

  @override
  List<Object> get props => [];
}

class DetailBlocInitialState extends DetailBlocState {}

class DetailBlocLoadingState extends DetailBlocState {}

class DetailBlocLoadedState extends DetailBlocState {
  final Data data;
  DetailBlocLoadedState(this.data);
  @override
  List<Object> get props => [data];
}

class DetailBlocErrorState extends DetailBlocState {
  final error;

  DetailBlocErrorState(this.error);

  @override
  List<Object> get props => [error];
}
