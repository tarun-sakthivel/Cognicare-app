class ReportModel {
  final int id;
  final String predictionType;
  final String predictedClass;
  final double confidenceProbability;
  final String videoPrediction;
  final double videoConfidence;
  final double formConfidence;
  final double eyeGazePercentage;
  final String reportText;
  final String timestamp;

  ReportModel({
    required this.id,
    required this.predictionType,
    required this.predictedClass,
    required this.confidenceProbability,
    required this.videoPrediction,
    required this.videoConfidence,
    required this.formConfidence,
    required this.eyeGazePercentage,
    required this.reportText,
    required this.timestamp,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      predictionType: json['prediction_type'] ?? '',
      predictedClass: json['predicted_class'] ?? '',
      confidenceProbability: (json['confidence_probability'] ?? 0).toDouble(),
      videoPrediction: json['video_prediction'] ?? '',
      videoConfidence: (json['video_confidence'] ?? 0).toDouble(),
      formConfidence: (json['form_confidence'] ?? 0).toDouble() * 100,
      eyeGazePercentage: (json['eye_gaze_percentage'] ?? 0).toDouble(),
      reportText: json['report_text'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
  double get combinedProbability {
    return (confidenceProbability * 0.4) +
        (videoConfidence * 0.35) +
        (formConfidence * 0.25);
  }

  String get riskLevel {
    if (combinedProbability >= 80)
      return "High";
    else if (combinedProbability >= 60)
      return "Moderate";
    else
      return "Low";
  }
}
