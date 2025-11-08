import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cognicare/utils/local_storage.dart';
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

  Future<void> fetchPredictionHistory() async {
    try {} catch (e, stack) {
      print('Exception while fetching history: $e');
      print(stack);
    }
  }

  Future<void> _onReportGenStart(
      ReportGenStart event, Emitter<ReportGenState> emit) async {
    emit(FetchLoading());

    try {
      final localhost = dotenv.env['localhost1'] ?? 'http://localhost:8000';
      final url = Uri.parse('$localhost/data/history');

      //  Get auth token
      final token = await LocalStorage.getString('authToken') ?? '';
      print("Bearer token: $token");

      if (token.isEmpty) {
        print(' Missing auth token.');
        return;
      }

      //  Setup headers
      final headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      //  API Call
      print('Fetching prediction history from: $url');
      final response = await http.get(url, headers: headers);

      //  Handle response
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        print(' History fetched successfully (${jsonData.length} records)');
        for (var item in jsonData) {
          print(
              'Prediction ID: ${item["id"]}, Type: ${item["prediction_type"]}');
        }
        final reports = jsonData.map((e) => ReportModel.fromJson(e)).toList();
        emit(FetchSuccess(reports));
        // you can emit this data in BLoC or return it
      } else if (response.statusCode == 401) {
        emit(FetchFailure(
            errorMessage: "Unauthorized — Token may be expired or invalid."));
        print(' Unauthorized — Token may be expired or invalid.');
      } else {
        emit(FetchFailure(
            errorMessage:
                'Failed to fetch history. Code: ${response.statusCode}'));
        print('Failed to fetch history. Code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      emit(FetchFailure(errorMessage: e.toString()));
    }
  }
}
