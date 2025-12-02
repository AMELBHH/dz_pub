
class ShowSnackBarState {

  String ?message;
  ShowSnackBarState({  this.message,});
ShowSnackBarState copyWith({String? message,}) {
  return ShowSnackBarState(
    message: message ?? this.message,

  );
}
}
