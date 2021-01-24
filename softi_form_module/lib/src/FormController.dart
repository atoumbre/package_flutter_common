import 'package:softi_core_module/core.dart';
import 'package:softi_form_module/src/FormControllerMixin.dart';

abstract class FormController<T> extends BaseController with FormControllerMixin<T> {
  FormController({T editingRecord}) {
    initForm(editingRecord);
  }
}
