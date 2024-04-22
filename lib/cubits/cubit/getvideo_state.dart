part of 'getvideo_cubit.dart';

sealed class GetvideoState {}

final class GetvideoSucces extends GetvideoState {}

final class GetvideoFail extends GetvideoState {}

final class ChangeView extends GetvideoState {}

final class PredictInitial extends GetvideoState {}

final class PredictSuccess extends GetvideoState {
  final String word;

  PredictSuccess(this.word);
}

final class PredictLoading extends GetvideoState {}

final class PredictError extends GetvideoState {
  final String error;

  PredictError(this.error);
}
