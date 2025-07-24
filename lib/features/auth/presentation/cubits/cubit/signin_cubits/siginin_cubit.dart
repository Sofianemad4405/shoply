import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'siginin_state.dart';

class SigininCubit extends Cubit<SigininState> {
  SigininCubit() : super(SigininInitial());
}
