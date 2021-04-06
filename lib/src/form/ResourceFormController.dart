import 'package:softi_common/core.dart';
import 'package:softi_common/resource.dart';
import 'package:softi_common/src/form/FormControllerMixin.dart';

abstract class ResourceFormController<T extends IResourceData> extends BaseController with FormControllerMixin<T> {
  final IResourceBase? db;
  final T record;
  final bool refreshRecord;
  // final String recordId;

  ResourceFormController(this.record, {this.db, this.refreshRecord = true});

  late T _editingRecord;

  @override
  void onInit() async {
    if (refreshRecord && record.isValid()) {
      try {
        _editingRecord = (await db!.api<T>().get(record.getId(), reactive: false).first)!;
      } catch (e) {
        toggleError();
      }
    } else {
      _editingRecord = record;
    }

    initForm(_editingRecord);
    toggleIdle();
    super.onInit();
  }

  @override
  Map<String, dynamic> buildInitialValue(T? record) => record?.toJson() ?? {};

  @override
  Future<T> beforSave(Map<String, dynamic> formData) async {
    var record = db!.resource<T>().deserializer(formData);
    return await beforeResourceSave(record);
  }

  @override
  Future<void> afterSave(T record) async {
    var result = await db!.api<T>().save(record);
    await afterResourceSave(result);
  }

  Future<T> beforeResourceSave(T record) async => record;
  Future<void> afterResourceSave(T? record);
}
