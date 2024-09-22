class MCQModel {
  final String? title;
  final int? points;
  final List<String>? options;
  final int? answerIndex;

  MCQModel({
    this.title,
    this.points,
    this.options,
    this.answerIndex,
  });

  // Factory constructor for creating a new MCQModel instance from a JSON object
  factory MCQModel.fromJson(Map<String, dynamic> json) {
    return MCQModel(
      title: json['title'] as String?,
      points: json['points'] as int?,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
      answerIndex: json['answerIndex'] as int?,
    );
  }

  // Method for converting the MCQModel instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'points': points,
      'options': options,
      'answerIndex': answerIndex,
    };
  }
}

class MCQSectionModel {
  final List<MCQModel>? macqList;
  final String? contenst;
  MCQSectionModel({
    this.macqList,
    this.contenst,
  });
  factory MCQSectionModel.fromJson(Map<String, dynamic> json) {
    return MCQSectionModel(
      contenst: json['title'] as String?,
      macqList: (json['macqList'] as List<dynamic>?)
          ?.map((e) => MCQModel.fromJson(e))
          .toList(),
    );
  }

  // Method for converting the MCQModel instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'macqList': macqList,
      'contenst': contenst,
    };
  }
}
