import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rw_test/app.dart';
import 'package:rw_test/core/bloc_observer.dart';

void main() {
      Bloc.observer = SimpleBlocObserver();
  runApp(const GroceryStoreApp());
}
