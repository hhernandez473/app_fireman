import 'dart:convert';

class Information {
  Information({
    required this.tipoEmergencia,
    required this.locacionEmergencia,
     required this.url,
  });

  String tipoEmergencia;
  String locacionEmergencia;
  String url;

  factory Information.fromJson(String str) =>
      Information.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Information.fromMap(Map<String, dynamic> json) => Information(
        tipoEmergencia: json["tipoEmergencia"],
        locacionEmergencia: json["locacionEmergencia"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "tipoEmergencia": tipoEmergencia,
        "locacionEmergencia": locacionEmergencia,
       
      };

  Information copy() => Information(
      tipoEmergencia: this.tipoEmergencia, locacionEmergencia: this.locacionEmergencia, url: this.url);
}
