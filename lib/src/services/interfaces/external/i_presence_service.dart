import 'package:softi_common/core.dart';

abstract class IPresenceService extends IBaseService {
  void setOnline();
  void setOffline();
  void setAway();
}
