import 'package:flutter/material.dart';

class BeginnerLevelScreen extends StatefulWidget {
  const BeginnerLevelScreen({Key? key}) : super(key: key);

  @override
  _BeginnerLevelScreenState createState() => _BeginnerLevelScreenState();
}

class _BeginnerLevelScreenState extends State<BeginnerLevelScreen> {
  final List<Map<String, int>> problems = [
    {'number1': 3, 'number2': 5},
    {'number1': 7, 'number2': 2},
    {'number1': 4, 'number2': 3},
    {'number1': 8, 'number2': 1},
    {'number1': 3, 'number2': 2},
    {'number1': 7, 'number2': 1},
    {'number1': 3, 'number2': 3},
    {'number1': 6, 'number2': 2},
    {'number1': 3, 'number2': 5},
    {'number1': 1, 'number2': 2},
    {'number1': 2, 'number2': 7},
    {'number1': 5, 'number2': 2},
  ];

  int currentProblemIndex = 0;
  int? userAnswer;
  bool isCorrect = false;
  bool isAnswered = false;

  void checkAnswer(int answer) {
    setState(() {
      userAnswer = answer;
      isCorrect = (problems[currentProblemIndex]['number1']! + problems[currentProblemIndex]['number2']! == answer);
      isAnswered = true;
    });
  }

  void nextProblem() {
    setState(() {
      if (isCorrect) {
        currentProblemIndex = (currentProblemIndex + 1) % problems.length;
      }
      userAnswer = null;
      isCorrect = false;
      isAnswered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int number1 = problems[currentProblemIndex]['number1']!;
    int number2 = problems[currentProblemIndex]['number2']!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beginner Level'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$number1 + $number2 = ',
            style: const TextStyle(fontSize: 60),
          ),
          DragTarget<int>(
            builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
                ) {
              return Container(
                width: 200,
                height: 150,
                alignment: Alignment.center,
                color: Colors.blue.shade100,
                child: Text(
                  userAnswer?.toString() ?? '?',
                  style: const TextStyle(fontSize: 60),
                ),
              );
            },
            onAccept: (int value) {
              checkAnswer(value);
            },
          ),
          const SizedBox(height: 20),
          Wrap(
            children: List.generate(10, (index) {
              return Draggable<int>(
                data: index,
                child: NumberBox(number: index),
                feedback: NumberBox(number: index, isDragging: true),
                childWhenDragging: NumberBox(number: index, isDragging: true),
              );
            }),
          ),
          const SizedBox(height: 20),
          if (isAnswered)
            Text(
              isCorrect ? 'Correct!' : 'Incorrect, try again.',
              style: TextStyle(fontSize: 24, color: isCorrect ? Colors.green : Colors.red),
            ),
          const SizedBox(height: 20),
          InkWell(
            onTap: nextProblem,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: const Center(
                  child: Text("Next Problem",style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class NumberBox extends StatelessWidget {
  final int number;
  final bool isDragging;

  const NumberBox({
    Key? key,
    required this.number,
    this.isDragging = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDragging ? Colors.grey : Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        number.toString(),
        style: const TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}


