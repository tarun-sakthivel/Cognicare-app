part of 'report_gen_bloc.dart';

sealed class ReportGenState extends Equatable {
  const ReportGenState();

  @override
  List<Object?> get props => [];
}

final class ReportGenInitial extends ReportGenState {}

final class FetchLoading extends ReportGenState {}

final class FetchSuccess extends ReportGenState {
  final ReportModel report;
  const FetchSuccess({required this.report});

  @override
  List<Object?> get props => [report];
}

final class FetchFailure extends ReportGenState {
  final String errorMessage;
  const FetchFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
