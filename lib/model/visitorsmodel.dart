import 'package:hive/hive.dart';
part 'visitorsmodel.g.dart';

@HiveType(typeId: 2)
class VisitorsModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String sponsorname;
  @HiveField(2)
  String? image;

  VisitorsModel({
    required this.image,
    required this.name,
    required this.sponsorname,
  });

  factory VisitorsModel.fromJson(Map<String, dynamic> json) {
    return VisitorsModel(
      image: json['image'],
      name: json["name"],
      sponsorname: json["sponsorname"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "sponsorname": sponsorname, "image": image};
  }
}
