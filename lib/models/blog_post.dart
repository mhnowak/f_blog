class BlogPost {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final String slug;
  final DateTime publishedAt;
  final List<String> tags;
  final String? canonicalUrl;
  final String? coverImage;
  final int readTimeMinutes;

  const BlogPost({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.slug,
    required this.publishedAt,
    required this.tags,
    this.canonicalUrl,
    this.coverImage,
    required this.readTimeMinutes,
  });

  factory BlogPost.from({
    required Map<String, dynamic> metadata,
    required String content,
  }) {
    return BlogPost(
      id: metadata['id'],
      title: metadata['title'],
      excerpt: metadata['excerpt'],
      slug: metadata['slug'],
      publishedAt: DateTime.parse(metadata['publishedAt']),
      tags: List<String>.from(metadata['tags'] ?? []),
      canonicalUrl: metadata['canonicalUrl'],
      coverImage: metadata['coverImage'],
      readTimeMinutes: metadata['readTimeMinutes'] ?? 5,
      content: content,
    );
  }
}
