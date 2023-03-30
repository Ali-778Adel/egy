
import 'package:hive/hive.dart';
part 'branches_model.g.dart';

@HiveType(typeId: 12)
class BranchesModel{
  @HiveField(0)
  final String?name;
  @HiveField(1)
  final String?address;
  @HiveField(2)
  final String?map;
  @HiveField(3)
  final String?longitude;
  @HiveField(4)
  final String?latitude;

  BranchesModel({this.name,this.address,this.map,this.longitude,this.latitude});
  factory BranchesModel.fromJson({required Map<String,dynamic>json}){
    return BranchesModel(
      name: json['name'],
      address: json['address'],
      map: json['map'],
      longitude: json['longitude'],
      latitude: json['latitude']
    );
  }
}