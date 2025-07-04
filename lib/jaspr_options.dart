// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';
import 'package:f_blog/pages/blog_page.dart' as prefix0;
import 'package:f_blog/pages/blog_post_page.dart' as prefix1;
import 'package:f_blog/app.dart' as prefix2;

/// Default [JasprOptions] for use with your jaspr project.
///
/// Use this to initialize jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'jaspr_options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultJasprOptions,
///   );
///
///   runApp(...);
/// }
/// ```
JasprOptions get defaultJasprOptions => JasprOptions(
  clients: {
    prefix0.BlogPage: ClientTarget<prefix0.BlogPage>('pages/blog_page'),

    prefix1.BlogPostPage: ClientTarget<prefix1.BlogPostPage>(
      'pages/blog_post_page',
      params: _prefix1BlogPostPage,
    ),
  },
  styles: () => [
    ...prefix0.BlogPage.styles,
    ...prefix1.BlogPostPage.styles,
    ...prefix2.App.styles,
  ],
);

Map<String, dynamic> _prefix1BlogPostPage(prefix1.BlogPostPage c) => {
  'slug': c.slug,
};
