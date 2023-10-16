class MyList {
  double x;
  double y;
  MyList({required this.x,required this.y});

  factory MyList.fromJson(Map<String, dynamic> json) => MyList(
        x: json["x"],
        y: json["y"],
    );

    Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
    };
}