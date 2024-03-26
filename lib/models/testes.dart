// To parse this JSON data, do
//
//     final teste = testeFromJson(jsonString);

import 'dart:convert';

List<Teste> testeFromJson(String str) =>
    List<Teste>.from(json.decode(str).map((x) => Teste.fromJson(x)));

String testeToJson(List<Teste> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Teste {
  String id;
  DateTime horaDaColeta;
  int matriculaAtleta;
  String idModalidade;
  int idTipoTeste;
  int idade;

  Teste({
    required this.id,
    required this.horaDaColeta,
    required this.matriculaAtleta,
    required this.idModalidade,
    required this.idTipoTeste,
    required this.idade,
  });

  factory Teste.fromJson(Map<String, dynamic> json) => Teste(
        id: json["id"],
        horaDaColeta: DateTime.parse(json["horaDaColeta"]),
        matriculaAtleta: json["matriculaAtleta"],
        idModalidade: json["idModalidade"],
        idTipoTeste: json["idTipoTeste"],
        idade: json["idade"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "horaDaColeta": horaDaColeta.toIso8601String(),
        "matriculaAtleta": matriculaAtleta,
        "idModalidade": idModalidade,
        "idTipoTeste": idTipoTeste,
        "idade": idade,
      };
}
