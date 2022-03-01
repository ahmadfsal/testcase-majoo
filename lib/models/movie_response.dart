class MovieResponse {
  MovieResponse({
    required this.data,
    required this.query,
    required this.v,
  });
  final List<Data> data;
  final String query;
  final int v;

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        data: List<Data>.from(json["d"].map((x) => Data.fromJson(x))),
        query: json["q"],
        v: json["v"],
      );

  Map<String, dynamic> toJson() => {
        "d": List<dynamic>.from(data.map((x) => x.toJson())),
        "q": query,
        "v": v,
      };
}

class Data {
  Data({
    required this.i,
    required this.id,
    required this.l,
    required this.q,
    required this.rank,
    required this.s,
    this.series,
    this.vt,
    required this.year,
    this.yr,
  });

  final I i;
  final String id;
  final String l;
  final String q;
  final int rank;
  final String s;
  final List<Series>? series;
  final int? vt;
  final int year;
  final String? yr;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        i: I.fromJson(json["i"]),
        id: json["id"],
        l: json["l"],
        q: json["q"],
        rank: json["rank"],
        s: json["s"],
        series: json["v"] == null
            ? null
            : List<Series>.from(json["v"].map((x) => Series.fromJson(x))),
        vt: json["vt"] == null ? null : json["vt"],
        year: json["y"],
        yr: json["yr"] == null ? null : json["yr"],
      );

  Map<String, dynamic> toJson() => {
        "i": i.toJson(),
        "id": id,
        "l": l,
        "q": q,
        "rank": rank,
        "s": s,
        "v": series == null
            ? null
            : List<dynamic>.from(series!.map((x) => x.toJson())),
        "vt": vt == null ? null : vt,
        "y": year,
        "yr": yr == null ? null : yr,
      };
}

class I {
  I({
    required this.height,
    required this.imageUrl,
    required this.width,
  });

  final int height;
  final String imageUrl;
  final int width;

  factory I.fromJson(Map<String, dynamic> json) => I(
        height: json["height"],
        imageUrl: json["imageUrl"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "imageUrl": imageUrl,
        "width": width,
      };
}

class Series {
  Series({
    required this.i,
    required this.id,
    required this.l,
    required this.s,
  });

  final I i;
  final String id;
  final String l;
  final String s;

  factory Series.fromJson(Map<String, dynamic> json) => Series(
        i: I.fromJson(json["i"]),
        id: json["id"],
        l: json["l"],
        s: json["s"],
      );

  Map<String, dynamic> toJson() => {
        "i": i.toJson(),
        "id": id,
        "l": l,
        "s": s,
      };
}
