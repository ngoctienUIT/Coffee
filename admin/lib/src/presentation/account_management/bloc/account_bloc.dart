import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/list_extension.dart';
import 'package:coffee_admin/src/data/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/account_management_use_case/delete_account.dart';
import '../../../domain/use_cases/account_management_use_case/get_all_account.dart';
import 'account_event.dart';
import 'account_state.dart';

@injectable
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final DeleteAccountUseCase _deleteAccountUseCase;
  final GetAllAccountUseCase _getAllAccountUseCase;

  AccountBloc(this._deleteAccountUseCase, this._getAllAccountUseCase)
      : super(InitState()) {
    on<FetchData>(_getData);

    on<UpdateData>((event, emit) => getDataAccount(false, event.index, emit));

    on<DeleteEvent>(_deleteAccount);

    on<RefreshData>((event, emit) => getDataAccount(true, event.index, emit));
  }

  Future _getData(FetchData event, Emitter emit) async {
    emit(AccountLoading());
    final response = await _getAllAccountUseCase.call();
    User user = getIt<User>();
    if (response is DataSuccess) {
      final listAccount = response.data!.filterAdminAndStaff(user.email);
      emit(AccountLoaded(0, listAccount));
    } else {
      emit(AccountError(response.error));
    }
  }

  Future getDataAccount(bool check, int index, Emitter emit) async {
    if (check) emit(AccountLoading());
    String type = index == 0 ? "" : (index == 1 ? "ADMIN" : "STAFF");
    final response = await _getAllAccountUseCase.call();
    User user = getIt<User>();
    if (response is DataSuccess) {
      final listAccount = index == 0
          ? response.data!.filterAdminAndStaff(user.email)
          : response.data!.filter(type: type, email: user.email);
      emit(AccountLoaded(0, listAccount));
    } else {
      emit(AccountError(response.error));
    }
  }

  Future _deleteAccount(DeleteEvent event, Emitter emit) async {
    emit(AccountLoading(false));
    String type =
        event.index == 0 ? "" : (event.index == 1 ? "ADMIN" : "STAFF");
    final responseDelete = await _deleteAccountUseCase.call(params: event.id);
    User user = getIt<User>();
    if (responseDelete is DataSuccess) {
      final response = await _getAllAccountUseCase.call();
      if (response is DataSuccess) {
        final listAccount = event.index == 0
            ? response.data!.filterAdminAndStaff(user.email)
            : response.data!.filter(type: type, email: user.email);
        emit(AccountLoaded(event.index, listAccount, false));
      } else {
        emit(AccountError(response.error));
      }
    } else {
      emit(AccountError(responseDelete.error));
    }
  }
}
