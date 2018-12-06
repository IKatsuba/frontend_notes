import '../enums/enums.dart';

class BaseResponse {
  ResponseStatuses status;
  String code;
  String message;

  BaseResponse({this.code, this.message, this.status});
}
