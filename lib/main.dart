import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
            primarySwatch: Colors.red, scaffoldBackgroundColor: Colors.black),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _movies = <String>["Movie 01", "Movie 02", "Movie 03", "Movie 04"];
  final _saved = <String>[];

  Widget movieCard(String movie) {
    final alreadySaved = _saved.contains(movie);
    return Card(
      child: ListTile(
        leading: Icon(Icons.movie, size: 40.0, color: Colors.black54),
        title: Text(
          movie,
          style: TextStyle(fontSize: 18),
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          // NEW from here ...
          setState(() {
            if (alreadySaved) {
              _saved.remove(movie);
            } else {
              _saved.add(movie);
            }
          }); // to here.
        },
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {

          final movies = _saved.map((movie) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.movie, size: 40.0, color: Colors.black54),
                title: Text(
                  movie,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
          });

          final divided = movies.isNotEmpty
              ? movies.toList()
              : <Widget>[];

          return Scaffold(
              appBar: AppBar(
                title: const Text('Favorites'),
              ),
              body: ListView(
                padding: const EdgeInsets.all(16.0),
                children: divided,
              ));
        },
      ), // ...to here.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // NEW from here ...
        appBar: AppBar(
          title: const Text('Movies'),
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: _pushSaved,
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [for (var movie in _movies) movieCard(movie)],
        ));
  }
}
