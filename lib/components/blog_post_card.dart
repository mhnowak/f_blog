import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import 'package:jaspr_router/jaspr_router.dart';
import 'package:f_blog/models/blog_post.dart';
import 'package:f_blog/constants/theme.dart';

class BlogPostCard extends StatelessComponent {
  final BlogPost post;

  const BlogPostCard({required this.post, super.key});

  @override
  Component build(BuildContext context) {
    return article(
      classes: 'post-card',
      [
        Link(
          to: post.slug.startsWith('/') ? post.slug.substring(1) : post.slug,
          classes: 'post-link-wrapper',
          child: div([
            if (post.coverImage case final img?)
              _buildCoverImage(img, post.title),
            div(classes: 'post-content', [
              if (post.tags.isNotEmpty) _buildTags(post.tags),
              _buildTitle(post),
              _buildExcerpt(post.excerpt),
              _buildMeta(post),
            ]),
          ]),
        ),
      ],
    );
  }

  Component _buildCoverImage(String coverImage, String title) {
    return img(
      src: coverImage,
      alt: 'Cover image for $title',
      classes: 'post-cover',
    );
  }

  Component _buildTags(List<String> tags) {
    return div(
      classes: 'post-tags',
      [
        for (final tag in post.tags.take(3))
          span(
            classes: 'post-tag',
            [Component.text(tag)],
          ),
      ],
    );
  }

  Component _buildTitle(BlogPost post) {
    return h3(classes: 'post-title', [
      Component.text(post.title),
    ]);
  }

  Component _buildExcerpt(String excerpt) {
    return p(
      classes: 'post-excerpt',
      [Component.text(excerpt)],
    );
  }

  Component _buildMeta(BlogPost post) {
    final BlogPost(publishedAt: publishedAt, readTimeMinutes: readTime) = post;

    return div(
      classes: 'post-meta',
      [
        span(
          classes: 'post-meta-item',
          [Component.text(_formatDate(publishedAt))],
        ),
        span([Component.text('$readTime min read')]),
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

  @css
  static List<StyleRule> get styles => [
        css('.post-card').styles(
          backgroundColor: AppColors.surface,
          radius: BorderRadius.circular(0.5.rem), // rounded-lg
          overflow: Overflow.hidden,
          raw: {
            'box-shadow': '0 1px 2px 0 rgba(0, 0, 0, 0.05)', // shadow-sm
            'transition': 'box-shadow 300ms',
          },
        ),
        css('.post-card:hover').styles(
          raw: {
            'box-shadow':
                '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)', // shadow-md
          },
        ),
        css('.post-cover').styles(
          width: 100.percent,
          height: 12.rem, // h-48
          raw: {'object-fit': 'cover'},
        ),
        css('.post-content').styles(
          padding: Padding.all(1.rem), // p-4
        ),
        css('.post-tags').styles(
          display: Display.flex,
          flexWrap: FlexWrap.wrap,
          gap: Gap.all(0.5.rem), // gap-2
          margin: Margin.only(bottom: 0.75.rem), // mb-3
        ),
        css('.post-tag').styles(
          padding: Padding.symmetric(
              horizontal: 0.5.rem, vertical: 0.25.rem), // px-2 py-1
          backgroundColor: AppColors.surfaceHover, // bg-gray-100
          color: AppColors.textBase, // text-gray-700
          radius: BorderRadius.circular(0.25.rem), // rounded
          fontSize: 0.75.rem, // text-xs
          fontWeight: FontWeight.w500, // font-medium
        ),
        css('.post-title').styles(
          fontSize: 1.125.rem, // text-lg
          fontWeight: FontWeight.bold,
          color: AppColors.text,
          margin: Margin.only(bottom: 0.75.rem), // mb-3
          lineHeight: 1.25.em, // leading-tight
        ),
        css('.post-link-wrapper').styles(
          display: Display.block,
          raw: {
            'text-decoration': 'none',
            'outline': 'none',
          },
        ),
        css('.post-link-wrapper:focus').styles(
          raw: {
            'box-shadow': '0 0 0 2px #fff, 0 0 0 4px #3b82f6'
          }, // ring-2 ring-blue-500
        ),
        css('.post-link-wrapper:hover .post-title').styles(
          color: AppColors.primary, // text-blue-600
        ),
        css('.post-excerpt').styles(
          color: AppColors.textSecondary,
          margin: Margin.only(bottom: 1.rem), // mb-4
          lineHeight: 1.625.em, // leading-relaxed
          fontSize: 0.875.rem, // text-sm
        ),
        css('.post-meta').styles(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          fontSize: 0.875.rem, // text-sm
          color: AppColors.textMuted, // text-gray-500
          gap: Gap.all(0.5.rem), // space-y-2
        ),
        css('.post-meta-item').styles(
          display: Display.flex,
          alignItems: AlignItems.center,
        ),
        // Breakpoints
        css.media(MediaQuery.screen(minWidth: 640.px), [
          css('.post-cover').styles(
            height: 14.rem, // sm:h-56
          ),
          css('.post-meta').styles(
            flexDirection: FlexDirection.row,
            alignItems: AlignItems.center,
            justifyContent: JustifyContent.spaceBetween,
            gap: Gap.all(0.px), // cancel space-y-2
          ),
        ]),
        css.media(MediaQuery.screen(minWidth: 768.px), [
          css('.post-content').styles(
            padding: Padding.all(1.5.rem), // md:p-6
          ),
          css('.post-title').styles(
            fontSize: 1.25.rem, // md:text-xl
          ),
          css('.post-excerpt').styles(
            fontSize: 1.rem, // md:text-base
          ),
        ]),
      ];
}
