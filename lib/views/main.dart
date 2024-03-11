import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/models/post.dart';
import 'package:provider/provider.dart';
import 'package:my_first_flutter_app/services/remote_service.dart';

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
      case 2:
        page = PostPage();
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
                NavigationRailDestination(
                  icon: Icon(Icons.manage_search),
                  label: Text('Posts'),
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

class PostPage extends StatefulWidget {
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Post>? posts;
  var isLoaded = false;

  // pra carregar tudo na hora que a pag inicia
  @override
  void initState() {
    super.initState();

    getData();
  }

  // Usa a funcao definida em services
  getData() async {
    posts = await RemoteService().getPosts();

    // Se tem posts atualiza o estado
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Visibility(
        visible: isLoaded,
        replacement: Center(child: CircularProgressIndicator()),
        child: ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, index) {
              return PostWidget(posts: posts, index: index);
            }),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.posts,
    required this.index,
  });

  final List<Post>? posts;
  final int index;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Card(
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
              posts![index].title.toUpperCase()),
          SizedBox(height: 10),
          Text(textAlign: TextAlign.left, posts![index].body),
        ]),
      ),
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
