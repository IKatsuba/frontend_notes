import '../enums/enums.dart';
import './base_response.dart';
import './source.dart';

class SourcesResponse extends BaseResponse {
  List<Source> sources;

  SourcesResponse(
      {List sources, String code, String message, ResponseStatuses status})
      : super(code: code, message: message, status: status) {
    this.sources =
        sources.map<Source>((source) => Source.fromJSON(source)).toList();
  }

  factory SourcesResponse.fromJSON(json) => SourcesResponse(
      sources: json['sources'],
      code: json['code'],
      message: json['message'],
      status: json['status']);
}
