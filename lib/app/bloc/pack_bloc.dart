import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/imports/all_imports.dart';

part 'pack_event.dart';
part 'pack_state.dart';

class PackBloc extends Bloc<PackEvent, PackState> {
  APackRepo packRepo;

  PackBloc(this.packRepo) : super(PackInitial()) {
    on<LoadPack>(_onGetPack);
  }

  void _onGetPack(LoadPack event, Emitter<PackState> emit) async {
    final pack = await packRepo.getPackWrapper();
    emit(PackLoaded(pack: pack));
  }
}
