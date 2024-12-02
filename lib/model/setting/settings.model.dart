class SettingsModel {
  final int? id;
  final String? settingName;
  final dynamic value;

  const SettingsModel({
    this.id,
    required this.settingName,
    required this.value
  });

  Map<String, dynamic> toMap()
  {
    return {
      'id' : id,
      'settingName' : settingName,
      'value' : value
    };
  }

  factory SettingsModel.fromMap(dynamic json)
  {
    return SettingsModel(
      id: json['id']?.toInt(),
      settingName: json['settingName'],
      value: json['value'],
    );
  }
}