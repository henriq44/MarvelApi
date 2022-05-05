class CharacterModel{
  final int id;

  final String name;

  final String description;

  final ThumbnailModel thumbnailModel;

  CharacterModel({required this.id, required this.name, required this.description, required this.thumbnailModel});

  factory CharacterModel.fromJson(Map<String, dynamic> json){
    return CharacterModel(
      id:  json ['id'],
      name: json ['name'],
      description: json ['description'],
      thumbnailModel: ThumbnailModel.fromJson(json['thumbnail'])
    );
  }
}

class ThumbnailModel {

final String path;

final String extension;

ThumbnailModel({required this.path, required this.extension});



factory ThumbnailModel.fromJson(Map<String, dynamic> json) {

return ThumbnailModel(path: json['path'], extension: json['extension']);

}
}