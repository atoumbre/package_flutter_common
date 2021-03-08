import 'package:softi_common/core.dart';
import 'package:softi_common/resource.dart';
import 'package:softi_common/src/form/FormControllerMixin.dart';

abstract class ResourceFormController<T extends IResourceData> extends BaseController with FormControllerMixin<T> {
  ResourceBase db;

  ResourceFormController({T editingRecord, this.db}) {
    initForm(editingRecord);
  }

  @override
  Map<String, dynamic> buildInitialValue(T record) => record.toJson();

  @override
  Future<T> beforSave(Map<String, dynamic> formData) async => db.deserializer<T>(formData);

  @override
  Future<void> afterSave(T record) async {
    await db.save<T>(record);
    await afterResourceSave(record);
  }

  Future<void> afterResourceSave(T record);
}
