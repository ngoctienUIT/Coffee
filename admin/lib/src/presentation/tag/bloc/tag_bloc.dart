import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/tag_use_case/delete_tag.dart';
import '../../../domain/use_cases/tag_use_case/get_tag.dart';
import 'tag_event.dart';
import 'tag_state.dart';

@injectable
class TagBloc extends Bloc<TagEvent, TagState> {
  final GetTagUseCase _getTagUseCase;
  final DeleteTagUseCase _deleteTagUseCase;

  TagBloc(this._getTagUseCase, this._deleteTagUseCase) : super(InitState()) {
    on<FetchData>((event, emit) => getData(true, emit));

    on<UpdateData>((event, emit) => getData(false, emit));

    on<PickEvent>((event, emit) => emit(PickState()));

    on<DeleteEvent>(_deleteTag);
  }

  Future getData(bool check, Emitter emit) async {
    if (check) emit(TagLoading());
    final response = await _getTagUseCase.call();
    if (response is DataSuccess) {
      emit(TagLoaded(response.data!));
    } else {
      emit(TagError(response.error));
    }
  }

  Future _deleteTag(DeleteEvent event, Emitter emit) async {
    emit(TagLoading(false));
    final response = await _deleteTagUseCase.call(params: event.id);
    if (response is DataSuccess) {
      emit(DeleteSuccess(event.id));
    } else {
      emit(TagError(response.error));
    }
  }
}
