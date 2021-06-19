import 'package:flutter/material.dart';

class Mypopmunuitem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;
  Mypopmunuitem({@required this.child, this.onClick}) : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    // ignore: todo
    // TODO: implement createState
    return MypopmunuitemState();
  }
}

class MypopmunuitemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, Mypopmunuitem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
