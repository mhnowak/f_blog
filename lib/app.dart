import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:f_blog/route_loaders/filtered_filesystem_loader.dart';
import 'package:f_blog/pages/index_page.dart';
import 'package:f_blog/layouts/app_blog_layout.dart';
import 'package:f_blog/constants/theme.dart';

class App extends StatelessComponent {
  const App({super.key});

  static final _loader = FilteredFilesystemLoader('content');
  static final _configResolver = PageConfig.all(
    parsers: [
      MarkdownParser(),
    ],
    layouts: [
      const AppBlogLayout(),
      const EmptyLayout(),
    ],
  );

  @override
  Component build(BuildContext context) {
    return ContentApp.custom(
      loaders: [_loader],
      eagerlyLoadAllPages: true,
      configResolver: _configResolver,
      routerBuilder: (routes) {
        return div(classes: 'app-root', [
          Router(routes: [
            Route(
              path: '/',
              title: 'Michal Nowak Blog | Flutter',
              builder: (context, state) => IndexPage(loader: _loader),
            ),
            for (final r in routes) ...r,
          ]),
        ]);
      },
    );
  }

  @css
  static List<StyleRule> get styles => [
        css('*', [
          css('&').styles(
            boxSizing: BoxSizing.borderBox,
          ),
        ]),
        css('body').styles(
          margin: Margin.zero,
          fontFamily: const FontFamily.list(
              [FontFamily('Inter'), FontFamilies.sansSerif]),
        ),
        css('.app-root').styles(
          minHeight: 100.vh,
          backgroundColor: AppColors.background,
        ),
        css('.prose', [
          css('&').styles(
            color: AppColors.textSecondary,
          ),
          css('h1, h2, h3, h4, h5, h6').styles(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
          css('p').styles(
            margin: Margin.only(bottom: 1.5.em),
          ),
          css('pre').styles(
            padding: Padding.all(1.5.em),
            radius: BorderRadius.circular(8.px),
            overflow: Overflow.auto,
            color: AppColors.background,
            backgroundColor: AppColors.preBackground,
          ),
          css('code').styles(
            padding: Padding.symmetric(horizontal: 4.px, vertical: 2.px),
            radius: BorderRadius.circular(4.px),
            fontSize: 14.px,
            backgroundColor: AppColors.surfaceHover,
          ),
          css('blockquote').styles(
            padding: Padding.symmetric(horizontal: 1.5.em),
            border: Border.only(
                left: BorderSide(color: AppColors.textMuted, width: 4.px)),
            color: AppColors.textMuted,
            fontStyle: FontStyle.italic,
            backgroundColor: AppColors.background,
          ),
        ]),
        css('.gist', [
          css('tbody tr').styles(
            border: Border.only(bottom: BorderSide.none()),
          ),
          css('td').styles(
            border: Border.none,
          ),
        ]),
        css('.line-clamp-3', [
          css('&').styles(
            overflow: Overflow.hidden,
            textOverflow: TextOverflow.ellipsis,
          ),
        ]),
      ];
}
