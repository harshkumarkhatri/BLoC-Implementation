import 'package:flutter/material.dart';
import 'package:flutter_bloc_implementation/Controller/counterBloc.dart';
import 'package:flutter_bloc_implementation/newsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
          // For the news App
          // NewsPage()

          // For the counter app
          MyHomePage(title: 'Flutter Demo Home Page'),
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
  final counterBloc = CounterController();

  @override
  void dispose() {
    counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              StreamBuilder(
                  stream: counterBloc.counterStream,
                  builder: (context, snapshot) {
                    return Text(
                      '${snapshot.data}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  })
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () {
                // ++_counter;
                counterBloc.eventSink.add(CounterActions.Increment);
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                // ++_counter;
                counterBloc.eventSink.add(CounterActions.Decrement);
              },
              tooltip: 'Decrement',
              child: Icon(Icons.exposure_minus_1),
            ),
            FloatingActionButton(
              onPressed: () {
                // ++_counter;
                counterBloc.eventSink.add(CounterActions.Reset);
              },
              tooltip: 'Reset',
              child: Icon(Icons.loop),
            ),
          ],
        ));
  }
}
