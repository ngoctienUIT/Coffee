import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/tag.dart';
import '../../../domain/use_cases/tag_use_case/create_tag.dart';
import '../../../domain/use_cases/tag_use_case/update_tag.dart';
import 'add_tag_event.dart';
import 'add_tag_state.dart';

@injectable
class AddTagBloc extends Bloc<AddTagEvent, AddTagState> {
  final CreateTagUseCase _createTagUseCase;
  final UpdateTagUseCase _updateTagUseCase;

  AddTagBloc(
    this._createTagUseCase,
    this._updateTagUseCase,
  ) : super(InitState()) {
    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<CreateTagEvent>((event, emit) => createTag(event.tag, emit));

    on<UpdateTagEvent>((event, emit) => updateTag(event.tag, emit));

    on<ChangeColorEvent>((event, emit) => emit(ChangeColorState()));
  }

  Future createTag(Tag tag, Emitter emit) async {
    emit(AddTagLoadingState());
    final response = await _createTagUseCase.call(params: tag);
    if (response is DataSuccess) {
      emit(AddTagSuccessState());
    } else {
      emit(AddTagErrorState(response.error ?? ""));
    }
  }

  Future updateTag(Tag tag, Emitter emit) async {
    emit(AddTagLoadingState());
    final response = await _updateTagUseCase.call(params: tag);
    if (response is DataSuccess) {
      emit(AddTagSuccessState());
    } else {
      emit(AddTagErrorState(response.error ?? ""));
    }
  }
}
