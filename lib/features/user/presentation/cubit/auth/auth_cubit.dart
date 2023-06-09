import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_group_chat/features/user/domain/usercases/get_current_uid_usecase.dart';
import 'package:flutter_group_chat/features/user/domain/usercases/is_sign_in_usecase.dart';
import 'package:flutter_group_chat/features/user/domain/usercases/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUIDUseCase getCurrentUIDUseCase;
  AuthCubit(
      {required this.isSignInUseCase, required this.signOutUseCase, required this.getCurrentUIDUseCase}) : super(AuthInitial());




  Future<void> appStarted()async {
    try{

      final isSignIn =await isSignInUseCase.call();

      if (isSignIn == true){
        final uid=await getCurrentUIDUseCase.call();


        emit(Authenticated(uid: uid));
      }else{
        emit(UnAuthenticated());
      }

    }catch(_){
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn()async{
    try{

      final uid = await getCurrentUIDUseCase.call();

      emit(Authenticated(uid: uid));

    }catch(_){
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut()async{
    try{

      await signOutUseCase.call();
     emit(UnAuthenticated());

    }catch(_){
      emit(UnAuthenticated());
    }
  }

}
