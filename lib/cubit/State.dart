import '../model/NoteModel.dart';

class NoteState {}

class InitialState extends NoteState {}

class LoadingState extends NoteState {}

class LoadedState extends NoteState {
  List<NoteModel> arrlist = [];

  LoadedState({required this.arrlist});
}

class ErrorState extends NoteState {
  String errorMessage;

  ErrorState({required this.errorMessage});
}
