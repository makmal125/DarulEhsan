class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  late String publishedAt;
  late String description;
  late String publishedAtAgo;

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelTitle,
    required this.publishedAt,
    required this.description,
    publishedAtAgo
  });

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],
      publishedAt: snippet['publishedAt'],
      description: snippet['description'],
    );
  }
}