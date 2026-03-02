import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr_content/theme.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:f_blog/pages/blog_page.dart';
import 'package:f_blog/pages/blog_post_page.dart';
import 'package:f_blog/services/blog_service.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    final posts = blogService.getAllPosts();

    final routes = <Route>[
      Route(
        path: '/',
        title: 'Blog | Michal Nowak',
        builder: (context, state) => const BlogPage(),
      ),
      ...posts.map((post) => Route(
            path: '/${post.slug}',
            title: '${post.title} | Michal Nowak',
            builder: (context, state) => BlogPostPage(slug: post.slug),
          )),
    ];

    return div(classes: 'min-h-screen bg-gray-50', [
      // It's required to wrap it with theme.none so tailwind styles are not overriden
      Content.wrapTheme(
        const ContentTheme.none(),
        child: Router(routes: routes),
      ),
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
