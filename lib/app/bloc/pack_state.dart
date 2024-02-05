part of 'pack_bloc.dart';

class PackState extends Equatable {
  const PackState();

  @override
  List<Object> get props => [];
}

class PackInitial extends PackState {
  @override
  List<Object> get props => [];
}

class PackLoading extends PackState {
  @override
  List<Object> get props => [];
}

class PackLoaded extends PackState {
  final Pack pack;

  const PackLoaded({required this.pack});

  @override
  List<Object> get props => [pack];
}
