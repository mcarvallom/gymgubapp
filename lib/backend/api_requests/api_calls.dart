import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/gymhub/gymhub_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start mercadopago Group Code

class MercadopagoGroup {
  static String getBaseUrl() => 'https://panelgymhub.restify.cl/mercadopago';
  static Map<String, String> headers = {};
  static CrearTokenCall crearTokenCall = CrearTokenCall();
  static ProcesarPagoCall procesarPagoCall = ProcesarPagoCall();
}

class CrearTokenCall {
  Future<ApiCallResponse> call({
    String? cardNumber = '',
    String? cardExpirationMonth = '',
    String? cardExpirationYear = '',
    String? securityCode = '',
    String? cardholderName = '',
    String? identificationNumber = '',
  }) async {
    final baseUrl = MercadopagoGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "card_number": "${escapeStringForJson(cardNumber)}",
  "expiration_month": "${escapeStringForJson(cardExpirationMonth)}",
  "expiration_year": "20${escapeStringForJson(cardExpirationYear)}",
  "security_code": "${escapeStringForJson(securityCode)}",
  "cardholder_name": "${escapeStringForJson(cardholderName)}",
  "identification_type": "RUT",
  "identification_number": "${escapeStringForJson(identificationNumber)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'crear token',
      apiUrl: '${baseUrl}/get_token.php',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? token(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
}

class ProcesarPagoCall {
  Future<ApiCallResponse> call({
    String? token = '',
    String? email = '',
    String? number = '',
    String? transactionAmount = '',
  }) async {
    final baseUrl = MercadopagoGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "token": "${escapeStringForJson(token)}",
  "email": "${escapeStringForJson(email)}",
  "rut": "${escapeStringForJson(number)}",
  "amount": "${escapeStringForJson(transactionAmount)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'procesar pago',
      apiUrl: '${baseUrl}/process_payment.php',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? estado(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status''',
      ));
}

/// End mercadopago Group Code

class IAGymCall {
  static Future<ApiCallResponse> call({
    String? idUsuario = '',
    String? sexo = '',
    double? pesoActual,
    double? altura,
    String? nivel = '',
    String? objetivo = '',
    double? pesoIdeal,
    String? restriccionFisica = '',
  }) async {
    final ffApiRequestBody = '''
{
  "id_usuario": "${escapeStringForJson(idUsuario)}",
  "objetivo": "${escapeStringForJson(objetivo)}",
  "peso_actual": ${pesoActual},
  "sexo": "${escapeStringForJson(sexo)}",
  "altura": ${altura},
  "nivel": "${escapeStringForJson(nivel)}",
  "peso_ideal": ${pesoIdeal},
  "restriccion_fisica": "${escapeStringForJson(restriccionFisica)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'IA gym',
      apiUrl: 'https://gymhub.restify.cl/ia/ia_ejercicio.php',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class IADietaCall {
  static Future<ApiCallResponse> call({
    String? idUsuario = '',
    String? sexo = '',
    double? pesoActual,
    double? altura,
    String? nivel = '',
    String? objetivo = '',
    double? pesoIdeal,
    String? restriccionAlimentaria = '',
  }) async {
    final ffApiRequestBody = '''
{
  "id_usuario": "${escapeStringForJson(idUsuario)}",
  "objetivo": "${escapeStringForJson(objetivo)}",
  "peso_actual": ${pesoActual},
  "sexo": "${escapeStringForJson(sexo)}",
  "altura": ${altura},
  "nivel": "${escapeStringForJson(nivel)}",
  "peso_ideal": ${pesoIdeal},
  "restriccion_alimentaria": "${escapeStringForJson(restriccionAlimentaria)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'IA dieta',
      apiUrl: 'https://gymhub.restify.cl/ia/ia_dieta.php',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
