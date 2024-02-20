import 'package:bullseye/elements/component.dart';

class Button extends Component {
  void Function()? onClick;
  List<Component>? children;

  Button({
    super.id,
    this.onClick,
    this.children
  });
}