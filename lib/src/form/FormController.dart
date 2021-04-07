import 'package:softi_common/core.dart';
import 'package:softi_common/src/form/FormControllerMixin.dart';

abstract class FormController<T> extends BaseViewController with FormControllerMixin<T> {
  FormController(editingRecord) {
    initForm(editingRecord);
  }
}
