// To parse this JSON data, do
//
//     final fotoUrl = fotoUrlFromMap(jsonString);

import 'dart:convert';

class FotoUrl {
    FotoUrl({
        required this.urls,
    });

    List<Url> urls;

    factory FotoUrl.fromJson(String str) => FotoUrl.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FotoUrl.fromMap(Map<String, dynamic> json) => FotoUrl(
        urls: List<Url>.from(json["urls"].map((x) => Url.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "urls": List<dynamic>.from(urls.map((x) => x.toMap())),
    };
}

class Url {
    Url({
        required this.nombre,
        required this.url,
    });

    String? nombre;
    String? url;

    factory Url.fromJson(String str) => Url.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Url.fromMap(Map<String, dynamic> json) => Url(
        nombre: json["nombre"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "url": url,
    };
}
