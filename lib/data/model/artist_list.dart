import 'package:music_mates_app/data/model/artist.dart';

class ArtistList {
  final List<ArtistModel> artists;

  ArtistList.allArtistFromJson(Map<String, dynamic> json)
      : artists = json['allArtists']
            .list
            .map((e) => ArtistModel.fromJson(e))
            .toList();
}
