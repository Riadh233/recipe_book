import 'package:dio/dio.dart';

abstract class DataState<T>{
  final T ? data;
  final String? nextPageUrl;
  final DioException ? error;

  const DataState({this.data, this.nextPageUrl, this.error});
}
class DataSuccess<T> extends DataState<T>{
  const DataSuccess(T data, String? nextPageUrl) : super(data: data,nextPageUrl: nextPageUrl);
}
class DataFailed<T> extends DataState<T>{
  const DataFailed(DioException error) : super(error: error);
}
