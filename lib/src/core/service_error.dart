class ServiceException implements Exception {
  final String serviceName;
  final String code;
  final String message;

  ServiceException(this.serviceName, this.code, this.message);

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
