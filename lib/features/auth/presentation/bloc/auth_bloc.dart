import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmgmt/features/auth/domain/usecases/login_usecase.dart';
import 'package:taskmgmt/features/auth/domain/usecases/signup_usecsae.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;
  AuthBloc({required this.loginUsecase, required this.signupUsecase})
      : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await loginUsecase.call(event.email, event.password);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (success) => emit(AuthAuthenticated()),
      );
    });

    on<SignupRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await signupUsecase.call(event.email, event.password);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (success) => emit(AuthAuthenticated()),
      );
    });
  }
}
