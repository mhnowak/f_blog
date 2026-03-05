import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:f_blog/components/tag.dart';
import 'package:f_blog/constants/theme.dart';

class AppBlogLayout extends PageLayoutBase {
  const AppBlogLayout();

  @override
  Pattern get name => 'blog';

  @override
  Component buildBody(Page page, Component child) {
    return AppBlogPageContent(page: page, child: child);
  }
}

class AppBlogPageContent extends StatelessComponent {
  final Page page;
  final Component child;

  const AppBlogPageContent({required this.page, required this.child});

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'blog-layout',
      [
        div(classes: 'blog-container', [
          _buildBackButton(),
          _buildArticle(),
        ]),
      ],
    );
  }

  Component _buildBackButton() {
    return nav(classes: 'blog-nav', [
      Link(
        to: '/',
        classes: 'blog-back-link',
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

    return article(classes: 'blog-article', [
      header(classes: 'blog-header', [
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
      classes: 'blog-tags',
      [for (final tag in tags) Tag(tag: tag)],
    );
  }

  Component _buildTitle(String title) {
    return h1(
      classes: 'blog-title',
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
      classes: 'blog-meta',
      [
        span([Component.text(_formatDate(publishedAt))]),
        span([Component.text('$readTime min read')]),
      ],
    );
  }

  Component _buildCanonicalNotice(String canonicalUrl) {
    return div(
      classes: 'blog-canonical',
      [
        p(
          classes: 'blog-canonical-text',
          [
            Component.text('Originally published at '),
            a(
              href: canonicalUrl,
              target: Target.blank,
              classes: 'blog-canonical-link',
              [Component.text(_getDomain(canonicalUrl))],
            )
          ],
        ),
      ],
    );
  }

  Component _buildCoverImage(String coverImage, String title) {
    return div(classes: 'blog-cover-container', [
      img(
        src: coverImage,
        alt: title,
        classes: 'blog-cover',
      ),
    ]);
  }

  Component _buildContent(Component contentBody) {
    return div(
      classes: 'prose prose-lg blog-prose',
      [
        div(
          classes: 'blog-content',
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

  // ignore: unused_element
  @css
  static List<StyleRule> get styles => [
        css('.blog-layout').styles(
          minHeight: 100.vh,
          backgroundColor: AppColors.surface, // bg-white
        ),
        css('.blog-container').styles(
          maxWidth: Unit.pixels(1280), // max-w-7xl
          margin: Margin.symmetric(horizontal: Unit.auto),
          padding: Padding.symmetric(
              horizontal: 1.rem, vertical: 1.5.rem), // px-4 py-6
        ),
        css('.blog-nav').styles(
          margin: Margin.only(bottom: 1.5.rem), // mb-6
        ),
        css('.blog-back-link').styles(
          display: Display.inlineFlex,
          alignItems: AlignItems.center,
          padding: Padding.symmetric(
              horizontal: 1.rem, vertical: 0.75.rem), // px-4 py-3
          color: AppColors.primary, // text-blue-600
          radius: BorderRadius.circular(0.5.rem), // rounded-lg
          raw: {'outline': 'none', 'transition': 'color 150ms'},
        ),
        css('.blog-back-link:hover').styles(
          color: AppColors.primaryHover, // hover:text-blue-800
        ),
        css('.blog-back-link:focus').styles(
          color: AppColors.primaryHover,
          raw: {'box-shadow': '0 0 0 2px #fff, 0 0 0 4px #3b82f6'},
        ),
        css('.blog-article').styles(
          maxWidth: 42.rem, // max-w-2xl
          margin: Margin.symmetric(horizontal: Unit.auto),
        ),
        css('.blog-header').styles(
          margin: Margin.only(bottom: 2.rem), // mb-8
          textAlign: TextAlign.center,
        ),
        css('.blog-tags').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          justifyContent: JustifyContent.center,
          gap: Gap.all(0.5.rem), // gap-2
          margin: Margin.only(bottom: 1.rem), // mb-4
        ),
        css('.blog-title').styles(
          fontSize: 1.5.rem, // text-2xl
          fontWeight: FontWeight.bold,
          color: AppColors.text, // text-gray-900
          margin: Margin.only(bottom: 1.rem), // mb-4
          lineHeight: 1.25.em, // leading-tight
        ),
        css('.blog-meta').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column, // sm:flex-row
          gap: Gap.all(1.rem), // sm:gap-4
          color: AppColors.textSecondary, // text-gray-600
          fontSize: 0.875.rem, // text-sm
        ),
        css('.blog-canonical').styles(
          margin: Margin.only(top: 1.5.rem), // mt-6
          padding: Padding.all(1.rem), // p-4
          backgroundColor: AppColors.warningBackground, // bg-yellow-50
          border: Border.all(
              color: AppColors.warningBorder, width: 1.px), // border-yellow-200
          radius: BorderRadius.circular(0.5.rem), // rounded-lg
          textAlign: TextAlign.left,
        ),
        css('.blog-canonical-text').styles(
          fontSize: 0.875.rem, // text-sm
          color: AppColors.warningText, // text-yellow-800
        ),
        css('.blog-canonical-link').styles(
          fontWeight: FontWeight.w500, // font-medium
          raw: {
            'text-decoration': 'underline',
            'outline': 'none',
          },
        ),
        css('.blog-canonical-link:hover').styles(
          raw: {'text-decoration': 'none'},
        ),
        css('.blog-canonical-link:focus').styles(
          raw: {
            'box-shadow': '0 0 0 2px #fff, 0 0 0 4px #eab308'
          }, // ring-yellow-500
        ),
        css('.blog-cover-container').styles(
          margin: Margin.only(bottom: 3.rem), // mb-12
        ),
        css('.blog-cover').styles(
          width: 100.percent,
          height: 24.rem, // h-96
          radius: BorderRadius.circular(0.5.rem), // rounded-lg
          raw: {
            'object-fit': 'cover',
            'box-shadow':
                '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)', // shadow-lg
          },
        ),
        css('.blog-prose').styles(
          raw: {'max-width': 'none'}, // max-w-none
        ),
        css('.blog-content').styles(
          fontSize: 1.rem, // text-base
          lineHeight: 1.625.em, // leading-relaxed
          color: AppColors.textBase, // text-gray-700
        ),
        // Breakpoints
        css.media(MediaQuery.screen(minWidth: 640.px), [
          css('.blog-meta').styles(
            flexDirection: FlexDirection.row,
            alignItems: AlignItems.center,
            justifyContent: JustifyContent.center,
          ),
        ]),
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.blog-container').styles(
            padding: Padding.symmetric(
                horizontal: 1.rem, vertical: 2.rem), // md:py-8
          ),
          css('.blog-nav').styles(
            margin: Margin.only(bottom: 2.rem), // md:mb-8
          ),
          css('.blog-header').styles(
            margin: Margin.only(bottom: 3.rem), // md:mb-12
          ),
          css('.blog-tags').styles(
            margin: Margin.only(bottom: 1.5.rem), // md:mb-6
          ),
          css('.blog-title').styles(
            fontSize: 2.25.rem, // md:text-4xl
            margin: Margin.only(bottom: 1.5.rem), // md:mb-6
          ),
          css('.blog-meta').styles(
            gap: Gap.all(1.5.rem), // md:gap-6
            fontSize: 1.rem, // md:text-base
          ),
          css('.blog-content').styles(
            fontSize: 1.125.rem, // md:text-lg
          ),
        ]),
        css.media(MediaQuery.screen(minWidth: 1024.px), [
          css('.blog-title').styles(
            fontSize: 3.rem, // lg:text-5xl
          ),
        ]),
      ];
}
