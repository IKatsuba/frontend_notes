import 'package:frontend_notes/enums/response_statuses.dart';
import './base_response.dart';
import './source.dart';

class SourcesResponse extends BaseResponse {
  List<Source> sources;

  SourcesResponse(
      {this.sources, String code, String message, ResponseStatuses status})
      : super(code: code, message: message, status: status);
}
