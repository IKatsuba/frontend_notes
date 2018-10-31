import 'package:frontend_notes/enums/response_statuses.dart';
import 'package:frontend_notes/models/base_response.dart';
import 'package:frontend_notes/models/source.dart';

class SourcesResponse extends BaseResponse {
  List<Source> sources;

  SourcesResponse(
      {this.sources, String code, String message, ResponseStatuses status})
      : super(code: code, message: message, status: status);
}
