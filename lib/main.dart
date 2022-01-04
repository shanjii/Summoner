import 'package:flutter/material.dart';
import 'package:league_checker/app.dart';
import 'package:league_checker/repositories/checker_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CheckerRepository(),
      child: const MyApp(),
    ),
  );
}
