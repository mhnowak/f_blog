import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:f_blog/route_loaders/filtered_filesystem_loader.dart';
import 'package:f_blog/pages/index_page.dart';
import 'package:f_blog/layouts/app_blog_layout.dart';

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
        return div(classes: 'min-h-screen bg-gray-50', [
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
            color: const Color('#f9fafb'),
            backgroundColor: const Color('#1f2937'),
          ),
          css('code').styles(
            padding: Padding.symmetric(horizontal: 4.px, vertical: 2.px),
            radius: BorderRadius.circular(4.px),
            fontSize: 14.px,
            backgroundColor: const Color('#f3f4f6'),
          ),
          css('blockquote').styles(
            padding: Padding.symmetric(horizontal: 1.5.em),
            border: Border.only(
                left: BorderSide(color: const Color('#6b7280'), width: 4.px)),
            color: const Color('#6b7280'),
            fontStyle: FontStyle.italic,
            backgroundColor: const Color('#f9fafb'),
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
