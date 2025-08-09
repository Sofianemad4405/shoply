// import 'package:bloc/bloc.dart';
// import 'package:shopify/core/errors/fire_base_auth_failure.dart';
// import 'package:shopify/features/auth/domain/repos/auth_repo.dart';
// import 'package:shopify/features/auth/domain/entities/user_entity.dart';

// part 'siginin_state.dart';

// class SigininCubit extends Cubit<SigininState> {
//   SigininCubit({required this.authRepo}) : super(SigininInitial());
//   final AuthRepo authRepo;

//   Future<void> signin({required String email, required String password}) async {
//     try {
//       emit(SigininLoading());
//       final result = await authRepo.signinWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       result.fold(
//         (failure) => emit(SigininError(message: failure.errorMessage)),
//         (user) => emit(SigininSuccess(user: user)),
//       );
//     } on FireBaseAuthFailure catch (e) {
//       emit(SigininError(message: e.code));
//     }
//   }
// }
