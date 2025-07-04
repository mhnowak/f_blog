import 'package:f_blog/models/blog_post.dart';

class BlogService {
  static final List<BlogPost> _posts = [
    BlogPost(
      id: '1',
      title: 'My First Blog Post',
      excerpt:
          'This is an example of how to structure your existing blog posts with canonical links for SEO.',
      content: '''
# My First Blog Post

This is an example of how to structure your existing blog posts with canonical links for SEO.

## Why Canonical Links Matter

When you republish content from another platform, canonical links tell search engines which version is the original and should be indexed.

## How to Use This System

1. Add your existing posts to the `_posts` list
2. Include the original URL as `canonicalUrl`
3. The system will automatically add the canonical link to the HTML head
4. Your SEO value will be preserved!

This is just placeholder content - replace with your actual blog posts.
''',
      slug: 'my-first-blog-post',
      publishedAt: DateTime(2024, 1, 15),
      tags: ['jaspr', 'flutter', 'web', 'seo'],
      canonicalUrl:
          'https://medium.com/@yourname/my-first-blog-post-123456', // Replace with your actual URL
      readTimeMinutes: 5,
    ),
    // Add more of your existing posts here...
  ];

  static List<BlogPost> getAllPosts() {
    return List.from(_posts)
      ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }

  static BlogPost? getPostBySlug(String slug) {
    try {
      return _posts.firstWhere((post) => post.slug == slug);
    } catch (e) {
      return null;
    }
  }

  static List<BlogPost> getPostsByTag(String tag) {
    return _posts.where((post) => post.tags.contains(tag)).toList()
      ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }

  static List<String> getAllTags() {
    final Set<String> tags = {};
    for (final post in _posts) {
      tags.addAll(post.tags);
    }
    return tags.toList()..sort();
  }
}
