part of 'report_gen_bloc.dart';

sealed class ReportGenEvent extends Equatable {
  const ReportGenEvent();

  @override
  List<Object> get props => [];
}

class ReportGenStart extends ReportGenEvent {
  final String userId;

  const ReportGenStart({required this.userId});

  @override
  List<Object> get props => [userId];
}