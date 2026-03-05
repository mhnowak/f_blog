import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:f_blog/constants/env.dart';

class FilteredFilesystemLoader extends FilesystemLoader {
  FilteredFilesystemLoader(super.directory, {super.debugPrint});

  @override
  Future<List<RouteBase>> loadRoutes(
      ConfigResolver resolver, bool eager) async {
    final routes = await super.loadRoutes(resolver, eager);

    if (Env.isDebug) {
      return routes;
    }

    // Filter out debug routes
    // Easiest is to filter out any routes ending with 'test' or in a debug folder
    // But since FilePageSource has frontmatter, we can't easily access the parsed frontmatter
    // at this point. Instead, we can just filter by path name containing 'test' or 'debug'

    List<RouteBase> filterRoutes(List<RouteBase> routeList) {
      return routeList.where((route) {
        if (route is Route) {
          final isDebug = route.path.contains('debug');
          return !isDebug;
        }
        return true; // Keep ShellRoutes or other route types
      }).toList();
    }

    return filterRoutes(routes);
  }
}
