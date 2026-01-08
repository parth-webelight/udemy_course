class QuizQuestion {
  final String text;
  final List<String> answers;

  const QuizQuestion(this.text, this.answers);
}

const questions = [
  QuizQuestion(
    'What is Flutter?',
    [
      'A UI toolkit for building apps',
      'A programming language',
      'A database',
      'An operating system',
    ],
  ),
  QuizQuestion(
    'Which language is used to write Flutter apps?',
    [
      'Dart',
      'Java',
      'Kotlin',
      'Swift',
    ],
  ),
  QuizQuestion(
    'What widget is used for immutable UI in Flutter?',
    [
      'StatelessWidget',
      'StatefulWidget',
      'InheritedWidget',
      'StreamBuilder',
    ],
  ),
  QuizQuestion(
    'What does hot reload do in Flutter?',
    [
      'Updates UI instantly without restarting app',
      'Rebuilds entire project',
      'Clears app cache',
      'Stops the app',
    ],
  ),
  QuizQuestion(
    'Which widget is used to arrange widgets vertically?',
    [
      'Column',
      'Row',
      'Stack',
      'Container',
    ],
  ),
  QuizQuestion(
    'What is the root widget of a Flutter app?',
    [
      'MaterialApp',
      'Scaffold',
      'Container',
      'AppBar',
    ],
  ),
  QuizQuestion(
    'Which command creates a new Flutter project?',
    [
      'flutter create',
      'flutter init',
      'flutter new',
      'flutter start',
    ],
  ),
  QuizQuestion(
    'What is Scaffold used for?',
    [
      'Basic app layout structure',
      'State management',
      'Navigation',
      'Animations',
    ],
  ),
  QuizQuestion(
    'Which widget adds padding around a widget?',
    [
      'Padding',
      'Margin',
      'Align',
      'SizedBox',
    ],
  ),
  QuizQuestion(
    'What does setState() do?',
    [
      'Updates the UI when state changes',
      'Stops the widget rebuild',
      'Deletes widget state',
      'Initializes the widget',
    ],
  ),
];
