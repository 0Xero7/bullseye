import 'package:bullseye/bullseye.dart';

abstract class State<T> {
  bool isMarkedDirty;
  State() : isMarkedDirty = false;

  void initState();

  Component render();
}