import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:f_blog/components/tag.dart';
import 'package:f_blog/components/blog_post_card.dart';
import 'package:f_blog/models/blog_post.dart';
import 'package:f_blog/constants/env.dart';

import 'package:f_blog/route_loaders/filtered_filesystem_loader.dart';

class IndexPage extends StatelessComponent {
  const IndexPage({required this.loader, super.key});

  final FilteredFilesystemLoader loader;

  @override
  Component build(BuildContext context) {
    // Retrieve all blog posts from the eager pages
    final pages = loader.sources.map((s) => s.page).whereType<Page>();

    final posts = pages.where((p) {
      final pageData = p.data.page;
      if (pageData['layout'] != 'blog') return false;

      final isDebug = pageData['debug'] == true;
      if (isDebug && !Env.isDebug) return false;

      return true;
    }).map((p) {
      final pageData = p.data.page;

      DateTime publishedAt;
      try {
        final dateVal = pageData['date'];
        if (dateVal is DateTime) {
          publishedAt = dateVal;
        } else {
          publishedAt = DateTime.parse(dateVal.toString());
        }
      } catch (_) {
        publishedAt = DateTime.now();
      }

      final tagsList = pageData['tags'];
      final tags = (tagsList is List)
          ? tagsList.map((e) => e.toString()).toList()
          : <String>[];

      // We parse readTime to int if we can
      int readTime = 0;
      final rt = pageData['readTime'];
      if (rt is num) {
        readTime = rt.toInt();
      } else if (rt is String) {
        readTime = int.tryParse(rt.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      }

      return BlogPost(
        id: pageData['id']?.toString() ?? p.url,
        title: pageData['title']?.toString() ?? 'Untitled',
        excerpt: pageData['excerpt']?.toString() ?? '',
        slug: p.url.startsWith('/') ? p.url.substring(1) : p.url,
        publishedAt: publishedAt,
        tags: tags,
        canonicalUrl: pageData['canonicalUrl']?.toString(),
        coverImage: pageData['coverImage']?.toString(),
        readTimeMinutes: readTime,
        content: p.content,
      );
    }).toList();

    posts.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

    final tagsSet = <String>{};
    for (var post in posts) {
      tagsSet.addAll(post.tags);
    }
    final tags = tagsSet.toList()..sort();

    return div(classes: 'min-h-screen bg-gray-50', [
      div(classes: 'max-w-7xl mx-auto px-4 py-8 md:py-12', [
        _buildHeader(),
        if (tags.isNotEmpty) _buildTags(tags),
        _buildPosts(posts),
      ]),
    ]);
  }

  Component _buildHeader() {
    return header(
      classes: 'mb-8 md:mb-12 text-center',
      [
        h1(
            classes: 'text-2xl md:text-4xl font-bold text-gray-900 mb-4',
            [Component.text('Blog')]),
        p(
          classes:
              'text-base md:text-xl text-gray-600 max-w-2xl mx-auto leading-relaxed',
          [
            Component.text(
                'Thoughts, ideas, and insights about Flutter development, technology, and life.')
          ],
        ),
      ],
    );
  }

  Component _buildTags(List<String> tags) {
    return section(
      classes: 'mb-6 md:mb-8',
      [
        h2(
          classes: 'text-base md:text-lg font-semibold text-gray-900 mb-4',
          [Component.text('Topics')],
        ),
        div(
          classes: 'flex flex-wrap gap-2',
          [for (final tag in tags) Tag(tag: tag, hasHover: true)],
        ),
      ],
    );
  }

  Component _buildPosts(List<BlogPost> posts) {
    return div(classes: 'grid gap-6 md:gap-8 md:grid-cols-2 lg:grid-cols-3', [
      for (final post in posts) BlogPostCard(post: post),
    ]);
  }
}
