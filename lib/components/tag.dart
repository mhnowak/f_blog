import 'package:jaspr/jaspr.dart';

class Tag extends StatelessComponent {
  final String tag;
  final bool hasHover;

  const Tag({required this.tag, this.hasHover = false, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield span(
      classes: classes,
      [text('#$tag')],
    );
  }

  String get classes {
    const core =
        'px-3 py-2 bg-blue-50 text-blue-700 rounded-full text-sm font-medium';

    if (hasHover) {
      return '$core hover:bg-blue-100 transition-colors';
    }

    return core;
  }
}
