import 'package:bloc/bloc.dart';
import 'package:untitled1/cubit/State.dart';
import 'package:untitled1/model/NoteModel.dart';

import '../database/DbHelper.dart';

class NoteCubit extends Cubit<NoteState> {
  DbHelper dbHelper;

  NoteCubit({required this.dbHelper}) : super(InitialState());

  AddData(NoteModel noteModel) async {
    emit(LoadingState());
    bool check = await dbHelper.AddData(noteModel);

    if (check) {
      var list = await dbHelper.FetchData();
      emit(LoadedState(arrlist: list));
    } else {
      emit(ErrorState(errorMessage: "Getting error while adding data"));
    }
  }

  UpdateData(NoteModel noteModel) async {
    emit(LoadingState());
    bool check = await dbHelper.UpdateData(noteModel);

    if (check) {
      var list = await dbHelper.FetchData();
      emit(LoadedState(arrlist: list));
    } else {
      emit(ErrorState(errorMessage: "getting error while updating data"));
    }
  }

  deleteData(int id) async {
    emit(LoadingState());
    var check = await dbHelper.DeleteDat(id);
    if (check) {
      var list = await dbHelper.FetchData();
      emit(LoadedState(arrlist: list));
    } else {
      emit(ErrorState(errorMessage: "Getting error while deleting the data"));
    }
  }

  FetchData() async{
    emit(LoadingState());
    var list = await dbHelper.FetchData();
    emit(LoadedState(arrlist: list));
  }
}
