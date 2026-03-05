import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:f_blog/components/tag.dart';
import 'package:f_blog/components/blog_post_card.dart';
import 'package:f_blog/models/blog_post.dart';
import 'package:f_blog/constants/env.dart';

import 'package:f_blog/route_loaders/filtered_filesystem_loader.dart';
import 'package:f_blog/constants/theme.dart';

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

    return div(classes: 'index-container', [
      div(classes: 'index-content', [
        _buildHeader(),
        if (tags.isNotEmpty) _buildTags(tags),
        _buildPosts(posts),
      ]),
    ]);
  }

  Component _buildHeader() {
    return header(
      classes: 'index-header',
      [
        h1(classes: 'index-title', [Component.text('Blog')]),
        p(
          classes: 'index-subtitle',
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
      classes: 'index-tags-section',
      [
        h2(
          classes: 'index-tags-title',
          [Component.text('Topics')],
        ),
        div(
          classes: 'index-tags-list',
          [for (final tag in tags) Tag(tag: tag, hasHover: true)],
        ),
      ],
    );
  }

  Component _buildPosts(List<BlogPost> posts) {
    return div(classes: 'index-posts-grid', [
      for (final post in posts) BlogPostCard(post: post),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
        css('.index-container').styles(
          minHeight: 100.vh,
          backgroundColor: AppColors.background,
        ),
        css('.index-content').styles(
          maxWidth: 1280.px, // max-w-7xl
          margin: Margin.symmetric(horizontal: Unit.auto),
          padding: Padding.symmetric(horizontal: 1.rem, vertical: 2.rem),
        ),
        css('.index-header').styles(
          margin: Margin.only(bottom: 2.rem),
          textAlign: TextAlign.center,
        ),
        css('.index-title').styles(
          fontSize: 1.5.rem,
          fontWeight: FontWeight.bold,
          color: AppColors.text,
          margin: Margin.only(bottom: 1.rem), // mb-4
        ),
        css('.index-subtitle').styles(
          fontSize: 1.rem,
          color: AppColors.textSecondary,
          maxWidth: 672.px, // max-w-2xl
          margin: Margin.symmetric(horizontal: Unit.auto),
          lineHeight: 1.625.em, // leading-relaxed
        ),
        css('.index-tags-section').styles(
          margin: Margin.only(bottom: 1.5.rem),
        ),
        css('.index-tags-title').styles(
          fontSize: 1.rem, // text-base
          fontWeight: FontWeight.w600, // font-semibold
          color: AppColors.text,
          margin: Margin.only(bottom: 1.rem), // mb-4
        ),
        css('.index-tags-list').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(0.5.rem), // gap-2
        ),
        css('.index-posts-grid').styles(
          display: Display.grid,
          gap: Gap.all(1.5.rem), // gap-6
          raw: {
            'grid-template-columns': 'repeat(1, minmax(0, 1fr))'
          }, // default 1 col
        ),
        // Media queries for breakpoints
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.index-content').styles(
            padding: Padding.symmetric(
                horizontal: 1.rem, vertical: 3.rem), // md:py-12
          ),
          css('.index-header').styles(
            margin: Margin.only(bottom: 3.rem), // md:mb-12
          ),
          css('.index-title').styles(
            fontSize: 2.25.rem, // md:text-4xl
          ),
          css('.index-subtitle').styles(
            fontSize: 1.25.rem, // md:text-xl
          ),
          css('.index-tags-section').styles(
            margin: Margin.only(bottom: 2.rem), // md:mb-8
          ),
          css('.index-tags-title').styles(
            fontSize: 1.125.rem, // md:text-lg
          ),
          css('.index-posts-grid').styles(
            gap: Gap.all(2.rem), // md:gap-8
            raw: {
              'grid-template-columns': 'repeat(2, minmax(0, 1fr))'
            }, // md:grid-cols-2
          ),
        ]),
        css.media(MediaQuery.screen(minWidth: 1024.px), [
          css('.index-posts-grid').styles(
            raw: {
              'grid-template-columns': 'repeat(3, minmax(0, 1fr))'
            }, // lg:grid-cols-3
          ),
        ]),
      ];
}
