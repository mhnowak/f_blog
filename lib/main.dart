import 'package:f_blog/app.dart';
import 'package:jaspr/server.dart';

import 'jaspr_options.dart';

void main() {
  Jaspr.initializeApp(
    options: defaultJasprOptions,
  );

  runApp(Document(
    base: 'f_blog',
    title: 'Michal Nowak Blog | Flutter',
    head: [
      link(href: 'styles.css', rel: 'stylesheet'),
      meta(name: 'viewport', content: 'width=device-width, initial-scale=1'),
      meta(charset: 'utf-8'),
      meta(
          name: 'description',
          content:
              'Personal blog about Flutter development, mobile development, and technology insights. Discover tutorials, tips, and best practices.'),
      meta(name: 'author', content: 'Michal Nowak'),
      meta(name: 'robots', content: 'index, follow'),
      link(
        rel: 'canonical',
        href: 'https://yourdomain.com', // TODO: Replace with your actual domain
      ),
      meta(name: 'theme-color', content: '#02569B'),
    ],
    body: App(),
  ));
}
