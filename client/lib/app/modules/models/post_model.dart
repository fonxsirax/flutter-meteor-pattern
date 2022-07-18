class PostModel {
  final String id;
  final String tittle;
  final String description;
  final String date;

  PostModel(
      {required this.tittle,
      required this.description,
      this.date = "",
      this.id = "noId"});
}
