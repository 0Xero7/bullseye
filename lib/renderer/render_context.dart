import 'dart:html';

import 'package:bullseye/bullseye.dart';

class RenderContext {
  Map<String, Component> internalIdNodes;
  Map<String, Component> userIdNodes;

  RenderContext() : internalIdNodes = {},
                    userIdNodes = {};
}