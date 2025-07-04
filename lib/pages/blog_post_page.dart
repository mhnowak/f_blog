import 'package:f_blog/components/tag.dart';
import 'package:f_blog/models/blog_post.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:jaspr_markdown/jaspr_markdown.dart';
import 'package:f_blog/services/blog_service.dart';

@client
class BlogPostPage extends StatelessComponent {
  final String slug;

  const BlogPostPage({required this.slug, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final post = BlogService.getPostBySlug(slug);

    if (post case final post?) {
      yield _buildPage(post);
    } else {
      yield _buildPageNotFound();
    }
  }

  Component _buildPage(BlogPost post) {
    return div(
      classes: 'min-h-screen bg-white',
      [
        div(classes: 'max-w-7xl mx-auto px-4 py-6 md:py-8', [
          _buildBackButton(),
          _buildArticle(post),
        ]),
      ],
    );
  }

  Component _buildPageNotFound() {
    return section(
      classes: 'min-h-screen flex items-center justify-center',
      [
        div(classes: 'text-center', [
          h1(
              classes: 'text-4xl font-bold text-gray-900 mb-4',
              [text('Post Not Found')]),
          p(
              classes: 'text-gray-600 mb-8',
              [text('The blog post you\'re looking for doesn\'t exist.')]),
          Link(
            to: '/blog',
            classes:
                'inline-block px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors',
            child: text('← Back to Blog'),
          ),
        ]),
      ],
    );
  }

  Component _buildBackButton() {
    return nav(classes: 'mb-6 md:mb-8', [
      Link(
        to: '/',
        classes:
            'inline-flex items-center px-4 py-3 text-blue-600 hover:text-blue-800 focus:text-blue-800 focus:ring-2 focus:ring-blue-500 focus:outline-none transition-colors rounded-lg',
        child: text('← Back to Blog'),
      ),
    ]);
  }

  Component _buildArticle(BlogPost post) {
    return article(classes: 'max-w-2xl mx-auto', [
      header(classes: 'mb-8 md:mb-12 text-center', [
        if (post.tags.isNotEmpty) _buildTags(post.tags),
        _buildTitle(post.title),
        _buildMeta(post),
      ]),
      if (post.coverImage case final img?) _buildCoverImage(img, post.title),
      _buildContent(post.content),
      if (post.canonicalUrl case final url?) _buildCanonicalNotice(url),
    ]);
  }

  Component _buildTags(List<String> tags) {
    return div(
      classes: 'flex flex-wrap justify-center gap-2 mb-4 md:mb-6',
      [for (final tag in tags) Tag(tag: tag)],
    );
  }

  Component _buildTitle(String title) {
    return h1(
      classes:
          'text-2xl md:text-4xl lg:text-5xl font-bold text-gray-900 mb-4 md:mb-6 leading-tight',
      [text(title)],
    );
  }

  Component _buildMeta(BlogPost post) {
    final BlogPost(publishedAt: publishedAt, readTimeMinutes: readTime) = post;

    return div(
      classes:
          'flex flex-col sm:flex-row sm:items-center sm:justify-center gap-4 md:gap-6 text-gray-600 text-sm md:text-base',
      [
        span([text(_formatDate(publishedAt))]),
        span([text('$readTime min read')]),
      ],
    );
  }

  Component _buildCanonicalNotice(String canonicalUrl) {
    return div(
      classes:
          'mt-6 p-4 bg-yellow-50 border border-yellow-200 rounded-lg text-left',
      [
        p(
          classes: 'text-sm text-yellow-800',
          [
            text('Originally published at '),
            a(
              href: canonicalUrl,
              target: Target.blank,
              classes:
                  'font-medium underline hover:no-underline focus:ring-2 focus:ring-yellow-500 focus:outline-none',
              [text(_getDomain(canonicalUrl))],
            )
          ],
        ),
      ],
    );
  }

  Component _buildCoverImage(String coverImage, String title) {
    return div(classes: 'mb-12', [
      img(
        src: coverImage,
        alt: title,
        classes: 'w-full h-96 object-cover rounded-lg shadow-lg',
      ),
    ]);
  }

  Component _buildContent(String content) {
    return div(
      classes: 'prose prose-lg max-w-none',
      [
        div(
          classes: 'text-base md:text-lg leading-relaxed text-gray-700',
          [
            Markdown(
              markdown: content,
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _getDomain(String url) {
    final uri = Uri.parse(url);
    return uri.host.replaceFirst('www.', '');
  }

  @css
  static List<StyleRule> get styles => [
        css('.prose', [
          css('&').styles(
            color: const Color('#374151'),
          ),
          css('h1, h2, h3, h4, h5, h6').styles(
            color: const Color('#111827'),
            fontWeight: FontWeight.bold,
          ),
          css('p').styles(
            margin: Margin.only(bottom: 1.5.em),
          ),
          css('pre').styles(
            padding: Padding.all(1.5.em),
            radius: BorderRadius.circular(8.px),
            overflow: Overflow.auto,
            color: const Color('#f9fafb'), // bg-gray-800 for dark code blocks
            backgroundColor:
                const Color('#1f2937'), // text-gray-50 for code text
          ),
          css('code').styles(
            padding: Padding.symmetric(horizontal: 4.px, vertical: 2.px),
            radius: BorderRadius.circular(4.px),
            fontSize: 14.px,
            backgroundColor:
                const Color('#f3f4f6'), // bg-gray-100 for inline code
          ),
        ]),
      ];
}
