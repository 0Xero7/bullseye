import 'package:bullseye/elements/component.dart';

class Div extends Component {
  List<Component>? children;

  Div({
    super.id,
    this.children
  });
}