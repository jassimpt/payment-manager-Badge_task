import 'package:hive/hive.dart';
part 'visitorsmodel.g.dart';

@HiveType(typeId: 2)
class VisitorsModel {
  @HiveField(0)
  String name;
  @HiveField(1)
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
