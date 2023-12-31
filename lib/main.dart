import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:music_mates_app/data/data_export.dart';
import 'package:music_mates_app/presentation/presentation_export.dart';
import 'package:music_mates_app/presentation/query_document_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GraphQLClient client = GraphQLClient(
    link: HttpLink('https://music-mates-fun.herokuapp.com/graphql'),
    cache: GraphQLCache(),
  );

  late final ValueNotifier<GraphQLClient> clientNotifier =
      ValueNotifier<GraphQLClient>(client);

  final queries = MusicMateQueries();

  @override
  Widget build(BuildContext context) {
    return QueriesDocumentProvider(
      queries: queries,
      child: GraphQLProvider(
        client: clientNotifier,
        child: MaterialApp(
          title: 'Music Mates',
          theme: _themeData(context),
          home: const GetStartedScreen(),
          routes: {
            Routes.home: (context) => const HomeScreen(),
            Routes.selectArtist: (context) => const SelectFavouriteArtist(),
          },
        ),
      ),
    );
  }

  ThemeData _themeData(BuildContext context) {
    const titleTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );

    const bottomSheetTheme = BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      backgroundColor: Color(0xff51361a),
      elevation: 5,
    );

    final lightTheme = ThemeData(
      cardColor: Colors.grey[300],
      scaffoldBackgroundColor: Colors.white,
      bottomSheetTheme: bottomSheetTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: titleTextStyle.copyWith(
          color: const Color(0xff232323),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xff232323),
        ),
      ), colorScheme: const ColorScheme.light().copyWith(background: Colors.white),
    );
    return lightTheme;
  }
}

class Routes {
  Routes._();

  static String home = "HomeScreen";
  static String selectArtist = "SelectArtist";
}
