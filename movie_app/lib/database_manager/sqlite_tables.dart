class MovieTable {
  static const tableName = "MovieStore";
  static const movieName = "movieName";
  static const directorName = "directorName";
  static const movieImage = "imageUrl";
  static const timestamp = "timestamp";
  static const movieObject = "config";

  static const createTableQuery = "create table $tableName($movieName text, "
      "$directorName text, $movieImage text, $timestamp text, $movieObject text,  primary key($movieName))";
}
