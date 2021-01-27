import 'package:softi_common/core.dart';
import 'package:softi_common/src/form/FormControllerMixin.dart';

abstract class FormController<T> extends BaseController with FormControllerMixin<T> {
  FormController({T editingRecord}) {
    initForm(editingRecord);
  }
}
