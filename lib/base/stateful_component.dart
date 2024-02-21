import 'dart:async';

import 'package:bullseye/base/state.dart';
import 'package:bullseye/bullseye.dart';

abstract class StatefulComponent extends Component {
  StatefulComponent({super.id});

  void setState(void Function() body) {
    body.call();
    
    scheduleMicrotask(() {
      Renderer.rerender(internalId!);
    });
  }

  Component render();
}