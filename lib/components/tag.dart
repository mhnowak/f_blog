import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:f_blog/constants/theme.dart';

class Tag extends StatelessComponent {
  final String tag;
  final bool hasHover;

  const Tag({required this.tag, this.hasHover = false, super.key});

  @override
  Component build(BuildContext context) {
    return span(
      classes: 'tag-item ${hasHover ? 'tag-hover' : ''}',
      [Component.text('#$tag')],
    );
  }

  @css
  static List<StyleRule> get styles => [
        css('.tag-item').styles(
          padding: Padding.symmetric(
              horizontal: 0.75.rem, vertical: 0.5.rem), // px-3 py-2
          backgroundColor: AppColors.tagBackground, // bg-blue-50
          color: AppColors.tagText, // text-blue-700
          radius: BorderRadius.circular(9999.px), // rounded-full
          fontSize: 0.875.rem, // text-sm
          fontWeight: FontWeight.w500, // font-medium
        ),
        css('.tag-hover').styles(
          raw: {'transition': 'background-color 150ms'}, // transition-colors
        ),
        css('.tag-hover:hover').styles(
          backgroundColor: AppColors.tagBackgroundHover, // hover:bg-blue-100
        ),
      ];
}
