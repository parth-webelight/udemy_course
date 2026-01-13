import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/todo/model/todo_model.dart';
import 'package:todo_app/features/widgets/custom_button.dart';
import 'package:todo_app/features/widgets/todo_list_item.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {

  List<TodoModel> _todos = [
  TodoModel(
    id: DateTime.now().toString(),
    title: "Buy groceries",
    description: "Milk, eggs, bread, fruits",
  ),
  TodoModel(
    id: DateTime.now().add(const Duration(seconds: 1)).toString(),
    title: "Workout",
    description: "30 minutes morning exercise",
  ),
  TodoModel(
    id: DateTime.now().add(const Duration(seconds: 2)).toString(),
    title: "Study Flutter",
    description: "Learn StatefulWidget lifecycle",
  ),
  TodoModel(
    id: DateTime.now().add(const Duration(seconds: 3)).toString(),
    title: "Office work",
    description: "Complete assigned tasks",
  ),
  TodoModel(
    id: DateTime.now().add(const Duration(seconds: 4)).toString(),
    title: "Read book",
    description: "Read 20 pages before sleep",
  ),
];

  List<TodoModel> get _pendingTodos {
    return _todos.where((todo) => !todo.isCompleted).toList();
  }

  List<TodoModel> get _completedTodos {
    return _todos.where((todo) => todo.isCompleted).toList();
  }

  void _addTodo(String title, String description) {
    setState(() {
      _todos.add(
        TodoModel(
          id: DateTime.now().toString(),
          title: title,
          description: description,
        ),
      );
    });
  }

  void _deleteTodo(String id) {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
    });
  }

  void _editTodo(TodoModel todo, String title, String description) {
    setState(() {
      // FIX 
      // final _todoIndex = _todos.indexWhere((element) => element.id == todo.id,);
      _todos = _todos.map((t) {
        if (t.id == todo.id) {
          return t.copyWith(title: title, description: description);
        }
        return t;
      }).toList();
    });
  }

  void _toggleTodo(String id) {
    setState(() {
      _todos = _todos.map((todo) {
        if (todo.id == id) {
          return todo.copyWith(isCompleted: !todo.isCompleted);
        }
        return todo;
      }).toList();
    });
  }
  
  void _showAddTodoDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Add New Todo",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                hintText: "Enter todo title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                hintText: "Enter todo description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          CustomButton(
            onPress: () => Navigator.pop(context),
            title: "Cancel",
            isBackgroundColor: false,
          ),
          CustomButton(
            onPress: () {
              if (titleController.text.trim().isNotEmpty) {
                _addTodo(
                  titleController.text.trim(),
                  descriptionController.text.trim(),
                );
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                _emptyFieldDialog("Please add proper inputs retry !");
              }
            },
            title: "Add",
            isBackgroundColor: true,
          ),
        ],
      ),
    );
  }

  void _emptyFieldDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Error",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        content: Text(
          error,
          style: GoogleFonts.poppins(),
        ),
        actions: [
          CustomButton(
            onPress: () => Navigator.pop(context),
            title: "Okay",
            isBackgroundColor: true,
          ),
        ],
      ),
    );
  }

  void _showEditTodoDialog(TodoModel todo) {
    final titleController = TextEditingController(text: todo.title);
    final descriptionController = TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Edit Todo",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              cursorColor: Colors.indigo,
              decoration: InputDecoration(
                labelText: "Title",
                hintText: "Enter todo title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              cursorColor: Colors.indigo,
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                hintText: "Enter todo description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          CustomButton(
            onPress: () => Navigator.pop(context),
            title: "Cancel",
            isBackgroundColor: false,
          ),
          CustomButton(
            onPress: () {
              if (titleController.text.trim().isNotEmpty) {
                _editTodo(
                  todo,
                  titleController.text.trim(),
                  descriptionController.text.trim(),
                );
                Navigator.pop(context);
              } else {
                 Navigator.pop(context);
                _emptyFieldDialog("Please add proper inputs and retry !");
              }
            },
            title: "Save",
            isBackgroundColor: true,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final todoDate = DateTime(date.year, date.month, date.day);

    int hour12 = date.hour % 12;
    if (hour12 == 0) hour12 = 12;
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    final minuteStr = date.minute.toString().padLeft(2, '0');

    if (todoDate == today) {
      return "Today, $hour12:$minuteStr $amPm";
    } else if (todoDate == today.subtract(const Duration(days: 1))) {
      return "Yesterday, $hour12:$minuteStr $amPm";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "My Todos",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Center(
              child: Text(
                "${_pendingTodos.length} pending",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _todos.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 80,
                          color: Colors.indigo.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No todos yet!",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.indigo.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Tap the + button to add a new todo",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.indigo.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_pendingTodos.isNotEmpty) ...[
                    Text(
                      "Pending (${_pendingTodos.length})",
                      style: GoogleFonts.poppins(
                        color: Colors.indigo,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _pendingTodos.length,
                      itemBuilder: (context, index) {
                        final todo = _pendingTodos[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: TodoListItem(
                            todo: todo,
                            onEdit: () => _showEditTodoDialog(todo),
                            formattedDate: _formatDate(todo.createdAt),
                            onToggle: () => _toggleTodo(todo.id),
                            onDelete: () => _deleteTodo(todo.id),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (_completedTodos.isNotEmpty) ...[
                    Text(
                      "Completed (${_completedTodos.length})",
                      style: GoogleFonts.poppins(
                        color: Colors.indigo.shade400,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _completedTodos.length,
                      itemBuilder: (context, index) {
                        final todo = _completedTodos[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: TodoListItem(
                            todo: todo,
                            onEdit: () => _showEditTodoDialog(todo),
                            formattedDate: _formatDate(todo.createdAt),
                            onToggle: () => _toggleTodo(todo.id),
                            onDelete: () => _deleteTodo(todo.id),
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}