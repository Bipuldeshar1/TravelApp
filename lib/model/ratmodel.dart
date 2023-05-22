class RatingModel {
  final String id;
  final String value;

  final String pid;

  RatingModel({required this.id, required this.value, required this.pid});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'],
      value: json['value'],
      pid: json['pid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'pid': pid,
    };
  }
}
