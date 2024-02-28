import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[]; // vetor de curtidos

  void toggleFavorite() {
    // metodo para curtir
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    var theme = Theme.of(context);
    TextStyle textStyle;
    Color cardColor;
    if (appState.favorites.contains(pair)) {
      textStyle = theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onSecondary,
      );
      cardColor = theme.colorScheme.secondary;
    } else {
      textStyle = theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
      cardColor = theme.colorScheme.primary;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair, style: textStyle, color: cardColor),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    appState.getNext();
                  },
                  child: Text('Next')),
              SizedBox(width: 10),
              ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: Text('Like')),
            ],
          ),
        ],
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var countFavs = appState.favorites.length;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(children: [
        Text("You have $countFavs favorites:"),
        SizedBox(height: 10),
        for (var word in appState.favorites) FavCard(word: word),
      ]),
    );
  }
}

class FavCard extends StatelessWidget {
  const FavCard({
    super.key,
    required this.word,
  });

  final WordPair word;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Card(
        color: theme.cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Icon(Icons.favorite),
            SizedBox(width: 10),
            Text(word.asPascalCase),
          ]),
        ));
    ;
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
    required this.style,
    required this.color,
  });

  final WordPair pair;
  final TextStyle style;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 2.0, // sombra
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asPascalCase,
          style: style,
        ),
      ),
    );
  }
}
