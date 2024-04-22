// // ignore_for_file: avoid_print

// import 'package:bloc/bloc.dart';
// import 'package:gp/core/api_service.dart';

// part 'predict_state.dart';

// class PredictCubit extends Cubit<PredictState> {
//   PredictCubit() : super(PredictInitial());

//   ApiService api = ApiService();

//   void postData(path, name) {
//     emit(PredictLoading());

//     api.sendVidioToNgrok(path, name).then((value) {
//       emit(PredictSuccess());
//     }).catchError((e) {
//       emit(PredictError(e.toString()));
//     });
//   }
// }
