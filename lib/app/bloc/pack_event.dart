part of 'pack_bloc.dart';

sealed class PackEvent extends Equatable {
  const PackEvent();

  @override
  List<Object> get props => [];
}

class LoadPack extends PackEvent {
  // final dynamic data;
  // const LoadPack({required this.data});

  @override
  List<Object> get props => [
        // data
      ];
}

class LoadSessionByIdx extends PackEvent {
  @override
  List<Object> get props => [];
}
