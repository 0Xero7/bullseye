import 'package:bullseye/bullseye.dart';
import 'package:bullseye/controllers/input_controller.dart';

class Input extends Component {
  String? type;
  InputController? inputController;

  Input({
    super.id,
    this.inputController,
    this.type
  });
}