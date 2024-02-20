import 'package:bullseye/bullseye.dart';

abstract class StatelessComponent extends Component {
  StatelessComponent({super.id});

  Component render();
}