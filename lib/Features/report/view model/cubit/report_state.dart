part of 'report_cubit.dart';

@immutable
sealed class ReportState {}

class AddReportInitial extends ReportState {}
class AddReportLoadingState extends ReportState {}

class AddReportSuccessState extends ReportState {}
class GetReportLoadingState extends ReportState {}
class GetReportSuccessState extends ReportState {}
class GetReportErrorState extends ReportState {}

class AddReportErrorState extends ReportState {}
class TakePhotoLoading extends ReportState {}
class TakePhotoSuccess extends ReportState {}
class TakePhotoInitial extends ReportState {}
