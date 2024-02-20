import 'package:bullseye/base/stateless_component.dart';
import 'package:bullseye/elements/component.dart';

class Span extends Component {
  List<String>? children;

  Span({super.id, this.children});
}