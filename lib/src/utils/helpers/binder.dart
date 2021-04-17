import 'dart:async';

StreamTransformer<S, T> streamBinder<S, T>(
  Stream<T> Function(S) handler,
) {
  return StreamTransformer<S, T>.fromBind((masterStream) {
    return masterStream.asyncExpand<T>((master) {
      if (master == null) {
        // if (nullMasterHandler != null) {
        // return nullMasterHandler();
        // } else {
        return null;
        // }
      } else {
        return handler(master);
      }
    });
  });
}
