// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:f_blog/pages/blog_page.dart' as _blog_page;
import 'package:f_blog/pages/blog_post_page.dart' as _blog_post_page;
import 'package:f_blog/app.dart' as _app;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  styles: () => [
    ..._blog_page.BlogPage.styles,
    ..._blog_post_page.BlogPostPage.styles,
    ..._app.App.styles,
  ],
);
