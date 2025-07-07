import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:f_blog/models/blog_post.dart';

class BlogPostCard extends StatelessComponent {
  final BlogPost post;

  const BlogPostCard({required this.post, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield article(
      classes:
          'bg-white rounded-lg shadow-sm hover:shadow-md transition-shadow duration-300 overflow-hidden',
      [
        if (post.coverImage case final img?) _buildCoverImage(img, post.title),
        div(classes: 'p-4 md:p-6', [
          if (post.tags.isNotEmpty) _buildTags(post.tags),
          _buildTitle(post),
          _buildExcerpt(post.excerpt),
          _buildMeta(post),
        ]),
      ],
    );
  }

  Component _buildCoverImage(String coverImage, String title) {
    return img(
      src: coverImage,
      alt: 'Cover image for $title',
      classes: 'w-full h-48 sm:h-56 object-cover',
    );
  }

  Component _buildTags(List<String> tags) {
    return div(
      classes: 'flex flex-wrap gap-2 mb-3',
      [
        for (final tag in post.tags.take(3))
          span(
            classes:
                'px-2 py-1 bg-gray-100 text-gray-700 rounded text-xs font-medium',
            [text(tag)],
          ),
      ],
    );
  }

  Component _buildTitle(BlogPost post) {
    final BlogPost(title: title, slug: slug) = post;

    return h3(
        classes:
            'text-lg md:text-xl font-bold text-gray-900 mb-3 leading-tight',
        [
          Link(
            to: 'blog/$slug',
            classes:
                'hover:text-blue-600 focus:text-blue-600 focus:ring-2 focus:ring-blue-500 focus:outline-none transition-colors',
            child: text(title),
          ),
        ]);
  }

  Component _buildExcerpt(String excerpt) {
    return p(
      classes: 'text-gray-600 mb-4 leading-relaxed text-sm md:text-base',
      [text(excerpt)],
    );
  }

  Component _buildMeta(BlogPost post) {
    final BlogPost(publishedAt: publishedAt, readTimeMinutes: readTime) = post;

    return div(
      classes:
          'flex flex-col sm:flex-row sm:items-center sm:justify-between text-sm text-gray-500 space-y-2 sm:space-y-0',
      [
        span(
          classes: 'flex items-center',
          [text(_formatDate(publishedAt))],
        ),
        span([text('$readTime min read')]),
      ],
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
