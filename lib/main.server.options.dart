// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:f_blog/components/blog_post_card.dart' as _blog_post_card;
import 'package:f_blog/components/tag.dart' as _tag;
import 'package:f_blog/layouts/app_blog_layout.dart' as _app_blog_layout;
import 'package:f_blog/pages/index_page.dart' as _index_page;
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
    ..._blog_post_card.BlogPostCard.styles,
    ..._tag.Tag.styles,
    ..._app_blog_layout.AppBlogPageContent.styles,
    ..._index_page.IndexPage.styles,
    ..._app.App.styles,
  ],
);
