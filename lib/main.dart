import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'score_bar.dart';
import 'game.dart';
import 'next_block.dart';
import 'block.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => Data(),
    child: const MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return const MaterialApp(
      home: Tetris(),
    );
  }
}

class Tetris extends StatefulWidget {
  const Tetris({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  final GlobalKey<GameState> _keyGame = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TETRIS GAME'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
      ),
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const ScoreBar(),
            Expanded(
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                        child: Game(key: _keyGame),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const NextBlock(),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              child: Text(
                                Provider.of<Data>(context,listen: false).isPlaying
                                    ? 'End'
                                    : 'Start',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[200],
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary:  Colors.indigo[700],
                              ),
                              // color: Colors.indigo[700],
                              onPressed: () {
                                Provider.of<Data>(context,listen: false).isPlaying
                                    ? _keyGame.currentState?.endGame()
                                    : _keyGame.currentState?.startGame();
                              },
                            ),
                            const Text("By",style:  TextStyle(fontSize: 24,color: Colors.white,height: 3),),
                            const Text("Murad Abed",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Data with ChangeNotifier {
  num score = 0;
  bool isPlaying = false;
  late Block nextBlock;

  void setScore(score) {
    this.score = score;
    notifyListeners();
  }

  void addScore(score) {
    this.score += score;
    notifyListeners();
  }

  void setIsPlaying(isPlaying) {
    this.isPlaying = isPlaying;
    notifyListeners();
  }

  void setNextBlock(Block nextBlock) {
    this.nextBlock = nextBlock;
    notifyListeners();
  }

  Widget getNextBlockWidget() {
    if (!isPlaying) return Container();

    var width = nextBlock.width;
    var height = nextBlock.height;
    var color;

    List<Widget> columns = [];
    for (var y = 0; y < height; ++y) {
      List<Widget> rows = [];
      for (var x = 0; x < width; ++x) {
        if (nextBlock.subBlocks
            .where((subBlock) => subBlock.x == x && subBlock.y == y)
            .length >
            0) {
          color = nextBlock.getcolor;
        } else {
          color = Colors.transparent;
        }

        rows.add(Container(width: 12, height: 12, color: color));
      }

      columns.add(
        Row(mainAxisAlignment: MainAxisAlignment.center, children: rows),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: columns,
    );
  }
}
