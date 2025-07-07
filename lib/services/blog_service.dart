import 'dart:io';
import 'dart:convert';
import 'package:f_blog/models/blog_post.dart';

final blogService = BlogService();

class BlogService {
  BlogService._() : _posts = _loadPosts();

  factory BlogService() => _instance;

  static final BlogService _instance = BlogService._();

  final List<BlogPost> _posts;

  static List<BlogPost> _loadPosts() {
    try {
      final articlesDir = Directory('content/articles');

      if (!articlesDir.existsSync()) {
        print('Articles directory does not exist: ${articlesDir.path}');

        return [];
      }

      return articlesDir
          .listSync()
          .whereType<Directory>()
          .map(_dirToPost)
          .whereType<BlogPost>()
          .toList();
    } catch (e) {
      print('Error loading articles: $e');

      return [];
    }
  }

  static BlogPost? _dirToPost(Directory articleDir) {
    try {
      final metadataFile = File('${articleDir.path}/metadata.json');
      final contentFile = File('${articleDir.path}/content.md');

      if (!metadataFile.existsSync()) {
        print('Skipping ${articleDir.path}: metadata.json not found');

        return null;
      }

      if (!contentFile.existsSync()) {
        print('Skipping ${articleDir.path}: content.md not found');

        return null;
      }

      final metadataJson = jsonDecode(metadataFile.readAsStringSync());
      final content = contentFile.readAsStringSync();

      return BlogPost.from(
        metadata: metadataJson,
        content: content,
      );
    } catch (e) {
      print('Error loading articles: $e');

      return null;
    }
  }

  List<BlogPost> getAllPosts() {
    return List.from(_posts)
      ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }

  BlogPost? getPostBySlug(String slug) {
    try {
      return _posts.firstWhere((post) => post.slug == slug);
    } catch (e) {
      return null;
    }
  }

  List<BlogPost> getPostsByTag(String tag) {
    return _posts.where((post) => post.tags.contains(tag)).toList()
      ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }

  List<String> getAllTags() {
    final Set<String> tags = {};
    for (final post in _posts) {
      tags.addAll(post.tags);
    }
    return tags.toList()..sort();
  }
}
