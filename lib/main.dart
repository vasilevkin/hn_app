import 'package:flutter/material.dart';
import 'src/article.dart';

import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
//          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Refreshed")));

          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            _articles.removeAt(0);
          });
//          return ;
        },
        child: ListView(
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
          children: _articles
              .map(_buildItem
//              (article) => Text(article.text)
                  )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
//      child: ListTile(
        title: Text(
          article.text,
          style: TextStyle(fontSize: 24),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('${article.commentsCount} comments'),
              IconButton(
                  icon: Icon(Icons.launch),
                  onPressed: () async {
                    final fakeUrl = "http://${article.domain}";
                    print('Subtitle: ${article.commentsCount} comments');
                    if (await canLaunch(fakeUrl)) print("can launch  $fakeUrl");
                    launch(fakeUrl);
                  }),
//              MaterialButton(
//                color: Colors.green,
//                onPressed: () {},
//                child: Text("OPEN"),
//              ),
            ],
          ),
        ],

//        subtitle: Text('${article.commentsCount} comments'),
//        onTap: () async {
//          final fakeUrl = "http://${article.domain}";
//          print('Subtitle: ${article.commentsCount} comments');
//          if (await canLaunch(fakeUrl))
//            print("can launch  $fakeUrl");
//          launch(fakeUrl);
//          _launchURL();
//        },
      ),
    );
  }

  _launchURL() async {
    const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
