import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:music_mates_app/data/data_export.dart';
import 'package:music_mates_app/data/model/error.dart';

class QueriesDocumentProvider extends InheritedWidget {
  const QueriesDocumentProvider(
      {Key? key, required this.queries, required Widget child})
      : super(key: key, child: child);

  final MusicMateQueries queries;

  static MusicMateQueries of(BuildContext context) {
    final InheritedElement? element = context
        .getElementForInheritedWidgetOfExactType<QueriesDocumentProvider>();
    assert(element != null, 'No MusicMateQueries found in context');
    return (element!.widget as QueriesDocumentProvider).queries;
  }

  @override
  bool updateShouldNotify(QueriesDocumentProvider oldWidget) =>
      queries != oldWidget.queries;
}

extension BuildContextExtension on BuildContext {
  /// Enables us to use context to access queries with [context.queries]
  MusicMateQueries get queries => QueriesDocumentProvider.of(this);

  /// Use context to show material banner with [context.showError()]
  void showError(ErrorModel error) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      var theme = Theme.of(this);
      ScaffoldMessenger.of(this).showMaterialBanner(
        MaterialBanner(
          backgroundColor: theme.colorScheme.primary,
          contentTextStyle:
              theme.textTheme.headlineSmall!.copyWith(color: Colors.white),
          content: Text(error.error),
          actions: [
            InkWell(
              onTap: () => ScaffoldMessenger.of(this).clearMaterialBanners(),
              child: const Icon(Icons.close, color: Colors.white),
            )
          ],
        ),
      );
    });
  }

  /// Enables us to use context to access an instance of [GraphQLClient] with [context.graphQlClient]
  GraphQLClient get graphQlClient => GraphQLProvider.of(this).value;

  /// Take advantage of the GraphQL cache to cache the user's Google ID
  /// to be used across the app
  void cacheGoogleId(String googleId) {
    graphQlClient.cache.writeNormalized('AppData', {'googleId': googleId});
  }

  /// Retrieves current user's Google ID from the cache
  String get retrieveGoogleId =>
      graphQlClient.cache.store.get('AppData')!['googleId'];
}
