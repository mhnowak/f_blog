import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:f_blog/pages/blog_page.dart';
import 'package:f_blog/pages/blog_post_page.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(classes: 'min-h-screen bg-gray-50', [
      Router(routes: [
        Route(
            path: '/',
            title: 'Blog | Michal Nowak',
            builder: (context, state) => const BlogPage()),
        Route(
            path: '/blog/:slug',
            title: 'Blog Post | Michal Nowak',
            builder: (context, state) => BlogPostPage(slug: state.params['slug']!)),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
        css('*', [
          css('&').styles(
            boxSizing: BoxSizing.borderBox,
          ),
        ]),
      ];
}
