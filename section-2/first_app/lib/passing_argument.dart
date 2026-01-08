import 'package:first_app/styled_text.dart';
import 'package:flutter/material.dart';

// REQUIRED ARHUMENTS
class PassingrRequiredArgument extends StatelessWidget {
  const PassingrRequiredArgument({
    super.key,
    required this.name,
    required this.message,
  });
  final String name;
  final String message;
  @override
  Widget build(BuildContext context) {
    return StyledText("REQUIRED ARGUMENT : $name, $message");
  }
}

// OPTIONAL NAMED ARGUMENT
// NULLBLE ARGUMENT
class OptionalArgumet extends StatelessWidget {
  const OptionalArgumet({this.title = 'User', this.subtitle, super.key});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return StyledText("OPTIONAL NAMED ARGUMENT : $title $subtitle");
  }
}

// POSITIONAL ARGUMENTS
class PositionalArgument extends StatelessWidget {
  const PositionalArgument(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return StyledText("POSITIONAL ARGUMENT : $data");
  }
}

// REQUIRED ARHUMENTS WITH STATEFULL
class RequiredArgument extends StatefulWidget {
  const RequiredArgument({required this.data, super.key});
  final String data;

  @override
  State<RequiredArgument> createState() => _RequiredArgumentState();
}

class _RequiredArgumentState extends State<RequiredArgument> {
  @override
  Widget build(BuildContext context) {
    return StyledText("REQUIRED ARHUMENTS WITH STATEFULL : ${widget.data}");
  }
}

// OPTIONAL NAMED ARGUMENT
// NULLBLE ARGUMENT WITH STATEFULL
class OptionalArgumentStateFull extends StatefulWidget {
  const OptionalArgumentStateFull({
    super.key,
    required this.userName,
    this.isTheme,
    this.showButton = true,
  });
  final String userName;
  final bool? isTheme;
  final bool showButton;
  @override
  State<OptionalArgumentStateFull> createState() => _OptionalArgumentState();
}

class _OptionalArgumentState extends State<OptionalArgumentStateFull> {
  @override
  Widget build(BuildContext context) {
    return StyledText("OPTIONAL NAMED ARGUMENT STATEFULL : ${widget.userName}, ${widget.isTheme}, ${widget.showButton}");
  }
}

// NAMED ARGUMENT WITH STATEFULL
class NamedArgument extends StatefulWidget {
  final String userName;
  final String token;
  const NamedArgument({super.key, required this.userName, this.token = ""});

  @override
  State<NamedArgument> createState() => _NamedArgumentState();
}

class _NamedArgumentState extends State<NamedArgument> {
  @override
  Widget build(BuildContext context) {
    return StyledText("NAMED ARGUMENT WITH STATEFULL : ${widget.userName}, ${widget.token}");
  }
}