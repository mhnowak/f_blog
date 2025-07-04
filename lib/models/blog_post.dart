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

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'],
      title: json['title'],
      excerpt: json['excerpt'],
      content: json['content'],
      slug: json['slug'],
      publishedAt: DateTime.parse(json['publishedAt']),
      tags: List<String>.from(json['tags'] ?? []),
      canonicalUrl: json['canonicalUrl'],
      coverImage: json['coverImage'],
      readTimeMinutes: json['readTimeMinutes'] ?? 5,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'excerpt': excerpt,
      'content': content,
      'slug': slug,
      'publishedAt': publishedAt.toIso8601String(),
      'tags': tags,
      'canonicalUrl': canonicalUrl,
      'coverImage': coverImage,
      'readTimeMinutes': readTimeMinutes,
    };
  }
}
