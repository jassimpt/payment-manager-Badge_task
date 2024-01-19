class VisitorsModel {
  String name;
  String sponsorname;

  VisitorsModel({
    required this.name,
    required this.sponsorname,
  });

  factory VisitorsModel.fromJson(Map<String, dynamic> json) {
    return VisitorsModel(
      name: json["name"],
      sponsorname: json["sponsorname"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "sponsorname": sponsorname,
    };
  }
}
