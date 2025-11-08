part of 'report_gen_bloc.dart';

sealed class ReportGenState extends Equatable {
  const ReportGenState();

  @override
  List<Object?> get props => [];
}

final class ReportGenInitial extends ReportGenState {}

final class FetchLoading extends ReportGenState {}

class FetchSuccess extends ReportGenState {
  final List<ReportModel> reports;
  FetchSuccess(this.reports);
}

final class FetchFailure extends ReportGenState {
  final String errorMessage;
  const FetchFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
