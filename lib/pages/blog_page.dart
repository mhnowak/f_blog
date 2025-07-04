import 'package:f_blog/components/tag.dart';
import 'package:f_blog/models/blog_post.dart';
import 'package:jaspr/jaspr.dart';
import 'package:f_blog/services/blog_service.dart';
import 'package:f_blog/components/blog_post_card.dart';

@client
class BlogPage extends StatelessComponent {
  const BlogPage({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final posts = BlogService.getAllPosts();
    final tags = BlogService.getAllTags();

    yield div(classes: 'min-h-screen bg-gray-50', [
      div(classes: 'max-w-7xl mx-auto px-4 py-8 md:py-12', [
        _buildHeader(),
        if (tags.isNotEmpty) _buildTags(tags),
        _buildPosts(posts),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
        css('.line-clamp-3', [
          css('&').styles(
            overflow: Overflow.hidden,
            textOverflow: TextOverflow.ellipsis,
          ),
        ]),
      ];

  Component _buildHeader() {
    return header(
      classes: 'mb-8 md:mb-12 text-center',
      [
        h1(
            classes: 'text-2xl md:text-4xl font-bold text-gray-900 mb-4',
            [text('Blog')]),
        p(
          classes:
              'text-base md:text-xl text-gray-600 max-w-2xl mx-auto leading-relaxed',
          [
            text(
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
          [text('Topics')],
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
