part of 'single_user_cubit.dart';

abstract class SingleUserState extends Equatable {
  const SingleUserState();
}

class SingleUserInitial extends SingleUserState {
  @override
  List<Object> get props => [];
}

class SingleUserLoading extends SingleUserState {
  @override
  List<Object> get props => [];
}

class SingleUserLoaded extends SingleUserState {

  final UserEntity currentUser;

  SingleUserLoaded({required this.currentUser});

  @override
  List<Object> get props => [currentUser];
}


class SingleUserFailure extends SingleUserState {
  @override
  List<Object> get props => [];
}