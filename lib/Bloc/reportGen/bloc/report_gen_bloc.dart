import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cognicare/utils/report_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

part 'report_gen_event.dart';
part 'report_gen_state.dart';

class ReportGenBloc extends Bloc<ReportGenEvent, ReportGenState> {
  ReportGenBloc() : super(ReportGenInitial()) {
    on<ReportGenStart>(_onReportGenStart);
  }

  Future<void> _onReportGenStart(
      ReportGenStart event, Emitter<ReportGenState> emit) async {
    emit(FetchLoading());

    try {
      final localhost = dotenv.env['localhost1'] ?? 'http://localhost:8000';
      final url = Uri.parse('$localhost/report/${event.userId}');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isEmpty) {
          emit(const FetchFailure(errorMessage: 'No report found.'));
          return;
        }

        final report = ReportModel.fromJson(data.first);
        emit(FetchSuccess(report: report));
      } else {
        emit(FetchFailure(
            errorMessage: 'Failed to fetch report. (${response.statusCode})'));
      }
    } catch (e) {
      emit(FetchFailure(errorMessage: e.toString()));
    }
  }
}
