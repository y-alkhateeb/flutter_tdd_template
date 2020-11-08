import 'dart:convert';

class IsTokenValidModel {
  IsTokenValidModel({
    this.userName,
    this.name,
    this.imageUrl,
    this.id,
    this.createDate,
    this.lastModifiedDate,
    this.creatorId,
    this.modifierId,
    this.creator,
    this.modifier,
  });

  final String userName;
  final String name;
  final String imageUrl;
  final String id;
  final String createDate;
  final String lastModifiedDate;
  final String creatorId;
  final String modifierId;
  final String creator;
  final String modifier;

  factory IsTokenValidModel.fromJson(String str) => IsTokenValidModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IsTokenValidModel.fromMap(Map<String, dynamic> json) => IsTokenValidModel(
    userName: json["userName"] == null ? null : json["userName"],
    name: json["name"] == null ? null : json["name"],
    imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
    id: json["id"] == null ? null : json["id"],
    createDate: json["createDate"] == null ? null : json["createDate"],
    lastModifiedDate: json["lastModifiedDate"] == null ? null : json["lastModifiedDate"],
    creatorId: json["creatorId"] == null ? null : json["creatorId"],
    modifierId: json["modifierId"] == null ? null : json["modifierId"],
    creator: json["creator"] == null ? null : json["creator"],
    modifier: json["modifier"] == null ? null : json["modifier"],
  );

  Map<String, dynamic> toMap() => {
    "userName": userName == null ? null : userName,
    "name": name == null ? null : name,
    "imageUrl": imageUrl == null ? null : imageUrl,
    "id": id == null ? null : id,
    "createDate": createDate == null ? null : createDate,
    "lastModifiedDate": lastModifiedDate == null ? null : lastModifiedDate,
    "creatorId": creatorId == null ? null : creatorId,
    "modifierId": modifierId == null ? null : modifierId,
    "creator": creator == null ? null : creator,
    "modifier": modifier == null ? null : modifier,
  };
}
