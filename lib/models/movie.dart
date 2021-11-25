class Movie {
  int? id;
  String movieName;
  String description;
  String actors;
  int? votes; //oy sayısı
  int? mark; //puanı
  //String photoname --> assestsdeki fotoğrafın adını vericez eklerken
  //Movie durumu eklenicek vizyonda ise 1 değilse 2
  Movie(
      {required this.movieName,
      required this.description,
      required this.actors,
      id,
      votes,
      mark});

  Map<String, dynamic> toMovieMap() {
    var map = <String, dynamic>{
      'id': id,
      'movieName': movieName,
      'description': description,
      'actors': actors,
      'votes': votes,
      'mark': mark
    };
    return map;
  }

  static fromMovieMap(Map<String, dynamic> c) {
    return Movie(
        id: c['id'],
        movieName: c['movieName'],
        description: c['description'],
        actors: c['actors'],
        votes: c['votes'],
        mark: c['mark']);
  }
}
