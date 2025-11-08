part of 'report_gen_bloc.dart';

sealed class ReportGenEvent extends Equatable {
  const ReportGenEvent();

  @override
  List<Object> get props => [];
}

class ReportGenStart extends ReportGenEvent {
  const ReportGenStart();

  @override
  List<Object> get props => [];
}
