// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_network.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AppointmentClient implements AppointmentClient {
  _AppointmentClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://etapp.egypttrust.com/api/Mobsys2/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<BranchListModel>> getBranches({
    required lang,
    cityId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = {
      'Lang': lang,
      'CityID': cityId,
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<BranchListModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'ListBranches',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<BranchListModel>.fromJson(
      _result.data!,
      (json) => BranchListModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<ServiceTypeData>>> getServices({
    required lang,
    required branchId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'Lang': lang,
      'BranchID': branchId,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<ServiceTypeData>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'ListServiceTypes',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<ServiceTypeData>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<ServiceTypeData>(
                  (i) => ServiceTypeData.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<BranchAvailableTimeData>>> getAvailableTimes({
    required lang,
    required branchId,
    required dateTicket,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'Lang': lang,
      'BranchID': branchId,
      'DateTicket': dateTicket,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<BranchAvailableTimeData>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'ListAvailableTimes',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<BranchAvailableTimeData>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<BranchAvailableTimeData>((i) =>
                  BranchAvailableTimeData.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<ApiResponse<TicketResponseData>> reserveTicket({
    required lang,
    required natID,
    required custName,
    required mobileNo,
    required branchID,
    required serviceTypeID,
    required dateTicket,
    required timeTicket,
    required orderRequestNo,
    required ticketID,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'Lang': lang,
      'NatID': natID,
      'CustName': custName,
      'MobileNo': mobileNo,
      'BranchID': branchID,
      'ServiceTypeID': serviceTypeID,
      'DateTicket': dateTicket,
      'TimeTicket': timeTicket,
      'OrderRequestNo': orderRequestNo,
      'TicketID': ticketID,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<TicketResponseData>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'ReserveTicket',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<TicketResponseData>.fromJson(
      _result.data!,
      (json) => TicketResponseData.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<dynamic>> deleteTicket({
    required lang,
    required natID,
    required custName,
    required mobileNo,
    delete = 1,
    required ticketID,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'Lang': lang,
      'NatID': natID,
      'CustName': custName,
      'MobileNo': mobileNo,
      'DeleteReserve': delete,
      'TicketID': ticketID,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'ReserveTicket',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ApiResponse<ReservationModel>> inquiryReservation({
    required lang,
    required natId,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'Lang': lang,
      'NatID': natId,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<ReservationModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              'MyReservation',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<ReservationModel>.fromJson(
      _result.data!,
      (json) => ReservationModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
