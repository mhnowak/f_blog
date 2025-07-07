import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:f_blog/pages/blog_page.dart';
import 'package:f_blog/pages/blog_post_page.dart';
import 'package:f_blog/services/blog_service.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final posts = blogService.getAllPosts();

    final routes = <Route>[
      Route(
        path: '/',
        title: 'Blog | Michal Nowak',
        builder: (context, state) => const BlogPage(),
      ),
      ...posts.map((post) => Route(
            path: '/blog/${post.slug}',
            title: '${post.title} | Michal Nowak',
            builder: (context, state) => BlogPostPage(slug: post.slug),
          )),
    ];

    yield div(classes: 'min-h-screen bg-gray-50', [
      Router(routes: routes),
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
