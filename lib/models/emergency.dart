import 'dart:convert';

class Emeregency {
  Emeregency({
    required this.nombre,
    required this.img,
    this.estado,
    required this.uid,
  });

  String nombre;
  String img;
  bool? estado;
  String uid;

  factory Emeregency.fromJson(String str) =>
      Emeregency.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Emeregency.fromMap(Map<String, dynamic> json) => Emeregency(
        nombre: json["nombre"],
        img: json["img"],
        estado: json["estado"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "img": img,
        "estado": estado,
        "uid": uid,
      };

  Emeregency copy() => Emeregency(
      nombre: this.nombre, img: this.img, estado: this.estado, uid: this.uid);
}
