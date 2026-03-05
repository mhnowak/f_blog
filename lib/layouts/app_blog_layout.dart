import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:f_blog/components/tag.dart';

class AppBlogLayout extends PageLayoutBase {
  const AppBlogLayout();

  @override
  Pattern get name => 'blog';

  @override
  Component buildBody(Page page, Component child) {
    return _AppBlogPageContent(page: page, child: child);
  }
}

class _AppBlogPageContent extends StatelessComponent {
  final Page page;
  final Component child;

  const _AppBlogPageContent({required this.page, required this.child});

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'min-h-screen bg-white',
      [
        div(classes: 'max-w-7xl mx-auto px-4 py-6 md:py-8', [
          _buildBackButton(),
          _buildArticle(),
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
        child: Component.text('← Back to Blog'),
      ),
    ]);
  }

  Component _buildArticle() {
    final pageData = page.data.page;
    final tagsList = pageData['tags'];
    final tags = (tagsList is List)
        ? tagsList.map((e) => e.toString()).toList()
        : <String>[];
    final title = pageData['title'] as String? ?? 'Untitled';
    final coverImage = pageData['coverImage'] as String?;
    final canonicalUrl = pageData['canonicalUrl'] as String?;

    return article(classes: 'max-w-2xl mx-auto', [
      header(classes: 'mb-8 md:mb-12 text-center', [
        if (tags.isNotEmpty) _buildTags(tags),
        _buildTitle(title),
        _buildMeta(),
      ]),
      if (coverImage != null) _buildCoverImage(coverImage, title),
      _buildContent(child),
      if (canonicalUrl != null) _buildCanonicalNotice(canonicalUrl),
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
      [Component.text(title)],
    );
  }

  Component _buildMeta() {
    final pageData = page.data.page;

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

    int readTime = 0;
    final rt = pageData['readTime'];
    if (rt is num) {
      readTime = rt.toInt();
    } else if (rt is String) {
      readTime = int.tryParse(rt.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    }

    return div(
      classes:
          'flex flex-col sm:flex-row sm:items-center sm:justify-center gap-4 md:gap-6 text-gray-600 text-sm md:text-base',
      [
        span([Component.text(_formatDate(publishedAt))]),
        span([Component.text('$readTime min read')]),
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
            Component.text('Originally published at '),
            a(
              href: canonicalUrl,
              target: Target.blank,
              classes:
                  'font-medium underline hover:no-underline focus:ring-2 focus:ring-yellow-500 focus:outline-none',
              [Component.text(_getDomain(canonicalUrl))],
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

  Component _buildContent(Component contentBody) {
    return div(
      classes: 'prose prose-lg max-w-none',
      [
        div(
          classes: 'text-base md:text-lg leading-relaxed text-gray-700',
          [contentBody],
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
    final uri = Uri.tryParse(url);
    if (uri == null) return url;
    return uri.host.replaceFirst('www.', '');
  }
}
