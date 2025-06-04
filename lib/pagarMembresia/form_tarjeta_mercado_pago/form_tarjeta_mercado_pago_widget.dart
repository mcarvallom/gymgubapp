import 'dart:ui';
import 'package:app_movil/backend/supabase_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_movil/utiles/theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> obtenerToken({
  required String cardNumber,
  required String expirationMonth,
  required String expirationYear,
  required String securityCode,
  required String cardholderName,
  required String identificationNumber,
}) async {
  final rutLimpio = identificationNumber.replaceAll('.', '');
  
  final url = Uri.parse("https://panelgymhub.restify.cl/mercadopago/get_token.php");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "card_number": cardNumber,
      "expiration_month": expirationMonth,
      "expiration_year": expirationYear,
      "security_code": securityCode,
      "cardholder_name": cardholderName,
      "identification_type": "RUT",
      "identification_number": rutLimpio,
    }),
  );

  if (response.statusCode == 201) {
    final data = jsonDecode(response.body);
    return data["id"];
  } else {
    print("Error al obtener token: ${response.body}");
    return null;
  }
}

Future<bool> procesarPago({
  required String email,
  required String rut,
  required String token,
  required double amount,
}) async {
  final url = Uri.parse("https://panelgymhub.restify.cl/mercadopago/process_payment.php");
  
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "token": token,
      "amount": amount,
      "email": email,
      "rut": rut.replaceAll('.', '').replaceAll('-', ''),
      "payment_method_id": "visa",
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    final data = jsonDecode(response.body);
    return data['status'] == 'approved';
  } else {
    print("Error en procesarPago: ${response.body}");
    return false;
  }
}

Future<bool> verificarMembresiaActiva() async {
  final userId = SupabaseConfig.client.auth.currentUser?.id;
  if (userId == null) return false;
  
  final response = await SupabaseConfig.client
      .from('membresia')
      .select('estado')
      .eq('id_usuario', userId)
      .single();
  
  // Asumiendo que '047930a7-0dd1-4885-92da-7a849d353e9a' es el ID de estado activo
  return response['estado'] == '047930a7-0dd1-4885-92da-7a849d353e9a';
}

class PagarMembresiaScreen extends StatefulWidget {
  final String planName;
  final double planPrice;
  final String userEmail;
  final String userId;

  const PagarMembresiaScreen({
    Key? key,
    required this.planName,
    required this.planPrice,
    required this.userEmail,
    required this.userId,
  }) : super(key: key);

  @override
  State<PagarMembresiaScreen> createState() => _PagarMembresiaScreenState();
}

class _PagarMembresiaScreenState extends State<PagarMembresiaScreen> {
  bool _membresiaActiva = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _verificarMembresia();
  }

  Future<void> _verificarMembresia() async {
    final activa = await verificarMembresiaActiva();
    if (mounted) {
      setState(() {
        _membresiaActiva = activa;
        _loading = false;
      });
      
      if (_membresiaActiva) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/inicio',
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_membresiaActiva) {
      return Scaffold(
        body: Center(child: Text('Redirigiendo...')),
      );
    }

    return Scaffold(
      body: FormTarjetaMercadoPagoWidget(
        planName: widget.planName,
        planPrice: widget.planPrice,
        userEmail: widget.userEmail,
        userId: widget.userId,
      ),
    );
  }
}

class FormTarjetaMercadoPagoWidget extends StatefulWidget {
  const FormTarjetaMercadoPagoWidget({
    Key? key,
    required this.planName,
    required this.planPrice,
    required this.userEmail,
    required this.userId,
  }) : super(key: key);

  final String planName;
  final double planPrice;
  final String userEmail;
  final String userId;

  @override
  State<FormTarjetaMercadoPagoWidget> createState() =>
      _FormTarjetaMercadoPagoWidgetState();
}

class _FormTarjetaMercadoPagoWidgetState
    extends State<FormTarjetaMercadoPagoWidget> {
  final _numTarjetaTextController1 = TextEditingController();
  final _numTarjetaFocusNode1 = FocusNode();
  final _mesTarjetaTextController = TextEditingController();
  final _mesTarjetaFocusNode = FocusNode();
  final _annioTarjetaTextController = TextEditingController();
  final _annioTarjetaFocusNode = FocusNode();
  final _cvvTarjetaTextController = TextEditingController();
  final _cvvTarjetaFocusNode = FocusNode();
  final _numTarjetaTextController2 = TextEditingController();
  final _numTarjetaFocusNode2 = FocusNode();
  final _runTextController = TextEditingController();
  final _runFocusNode = FocusNode();
  final _dvTextController = TextEditingController();
  final _dvFocusNode = FocusNode();
  bool _cvvTarjetaVisibility = false;

  final _numTarjetaMask1 = FilteringTextInputFormatter.digitsOnly;
  final _mesTarjetaMask = FilteringTextInputFormatter.digitsOnly;
  final _annioTarjetaMask = FilteringTextInputFormatter.digitsOnly;
  final _cvvTarjetaMask = FilteringTextInputFormatter.digitsOnly;
  final _runMask = FilteringTextInputFormatter.digitsOnly;

  @override
  void dispose() {
    _numTarjetaTextController1.dispose();
    _numTarjetaFocusNode1.dispose();
    _mesTarjetaTextController.dispose();
    _mesTarjetaFocusNode.dispose();
    _annioTarjetaTextController.dispose();
    _annioTarjetaFocusNode.dispose();
    _cvvTarjetaTextController.dispose();
    _cvvTarjetaFocusNode.dispose();
    _numTarjetaTextController2.dispose();
    _numTarjetaFocusNode2.dispose();
    _runTextController.dispose();
    _runFocusNode.dispose();
    _dvTextController.dispose();
    _dvFocusNode.dispose();
    super.dispose();
  }

  String quitarEspacios(String text) {
    return text.replaceAll(' ', '');
  }

  String ponerPuntoalMil(String numero) {
    String result = '';
    int count = 0;
    for (int i = numero.length - 1; i >= 0; i--) {
      result = numero[i] + result;
      count++;
      if (count == 3 && i != 0) {
        result = '.' + result;
        count = 0;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2.0,
        sigmaY: 2.0,
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: MediaQuery.sizeOf(context).height * 1.0,
        decoration: const BoxDecoration(
          color: Color(0x868B8B8B),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  width: 400.0,
                  decoration: BoxDecoration(
                    color: ThemeAPP.of(context).primaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: Color(0x33000000),
                        offset: Offset(
                          0.0,
                          2.0,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: ThemeAPP.of(context).primary,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        12.0, 8.0, 12.0, 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 8.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  'Pagar plan',
                                  style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height:10),
                        Divider(
                          height: 1.0,
                          thickness: 1.0,
                          color: ThemeAPP.of(context).primary,
                        ),
                        SizedBox(height:10),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                widget.planName,
                                style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                              ),
                              Text(
                                ' - ',
                                style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                              ),
                              Text(
                                '\$${ponerPuntoalMil(widget.planPrice.toString())}',
                                style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height:10),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                child: TextFormField(
                                  controller: _numTarjetaTextController1,
                                  focusNode: _numTarjetaFocusNode1,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Número tarjeta',
                                    labelStyle: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                    hintText: 'Número tarjeta',
                                    hintStyle: ThemeAPP.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.readexPro(),
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ThemeAPP.of(context).primaryText,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ThemeAPP.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ThemeAPP.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor:
                                        ThemeAPP.of(context).secondaryBackground,
                                    counterStyle:TextStyle(color: ThemeAPP.of(context).secondaryText),
                                  ),
                                  style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                  maxLength: 19,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  keyboardType: TextInputType.number,
                                  cursorColor: ThemeAPP.of(context).secondaryText,
                                  inputFormatters: [_numTarjetaMask1],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            child: TextFormField(
                                              controller:
                                                  _mesTarjetaTextController,
                                              focusNode: _mesTarjetaFocusNode,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                counterStyle:TextStyle(color: ThemeAPP.of(context).secondaryText),
                                                isDense: true,
                                                labelText: 'Mes',
                                                labelStyle: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                                hintText: 'Mes',
                                                hintStyle: ThemeAPP.of(context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.readexPro(),
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ThemeAPP.of(context)
                                                        .primaryText,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                ),
                                                errorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ThemeAPP.of(context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ThemeAPP.of(context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                ),
                                                filled: true,
                                                fillColor: ThemeAPP.of(context)
                                                    .secondaryBackground,
                                              ),
                                              style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                              maxLength: 2,
                                              maxLengthEnforcement:
                                                  MaxLengthEnforcement.enforced,
                                              keyboardType: TextInputType.number,
                                              cursorColor:
                                                  ThemeAPP.of(context).secondaryText,
                                              inputFormatters: [_mesTarjetaMask],
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '/',
                                          style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            child: TextFormField(
                                              controller:
                                                  _annioTarjetaTextController,
                                              focusNode: _annioTarjetaFocusNode,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                counterStyle:TextStyle(color: ThemeAPP.of(context).secondaryText),
                                                isDense: true,
                                                labelText: 'Año',
                                                labelStyle: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                                hintText: 'Año',
                                                hintStyle: ThemeAPP.of(context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.readexPro(),
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ThemeAPP.of(context)
                                                        .primaryText,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                ),
                                                errorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ThemeAPP.of(context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: ThemeAPP.of(context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                ),
                                                filled: true,
                                                fillColor: ThemeAPP.of(context)
                                                    .secondaryBackground,
                                              ),
                                              style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                              maxLength: 2,
                                              maxLengthEnforcement:
                                                  MaxLengthEnforcement.enforced,
                                              keyboardType: TextInputType.number,
                                              cursorColor:
                                                  ThemeAPP.of(context).secondaryText,
                                              inputFormatters: [_annioTarjetaMask],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width:10),
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      child: TextFormField(
                                        controller: _cvvTarjetaTextController,
                                        focusNode: _cvvTarjetaFocusNode,
                                        autofocus: false,
                                        obscureText: !_cvvTarjetaVisibility,
                                        decoration: InputDecoration(
                                          counterStyle:TextStyle(color: ThemeAPP.of(context).secondaryText),
                                          isDense: true,
                                          labelText: 'CVV',
                                          labelStyle: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                          hintText: 'CVV',
                                          hintStyle: ThemeAPP.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.readexPro(),
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ThemeAPP.of(context)
                                                  .primaryText,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ThemeAPP.of(context).error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ThemeAPP.of(context).error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          fillColor: ThemeAPP.of(context)
                                              .secondaryBackground,
                                          suffixIcon: InkWell(
                                            onTap: () => setState(
                                              () => _cvvTarjetaVisibility =
                                                  !_cvvTarjetaVisibility,
                                            ),
                                            focusNode: FocusNode(
                                                skipTraversal: true),
                                            child: Icon(
                                              _cvvTarjetaVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons.visibility_off_outlined,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                        style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                        maxLength: 3,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement.enforced,
                                        keyboardType: TextInputType.number,
                                        cursorColor:
                                            ThemeAPP.of(context).secondaryText,
                                        inputFormatters: [_cvvTarjetaMask],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height:10),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                child: TextFormField(
                                  controller: _numTarjetaTextController2,
                                  focusNode: _numTarjetaFocusNode2,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Nombre titular tarjeta',
                                    labelStyle: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                    hintText: 'Nombre titular tarjeta',
                                    hintStyle: ThemeAPP.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.readexPro(),
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ThemeAPP.of(context).primaryText,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ThemeAPP.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ThemeAPP.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor:
                                        ThemeAPP.of(context).secondaryBackground,
                                  ),
                                  style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                  cursorColor: ThemeAPP.of(context).secondaryText,
                                ),
                              ),
                              SizedBox(height:10),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      child: TextFormField(
                                        controller: _runTextController,
                                        focusNode: _runFocusNode,
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          counterStyle:TextStyle(color: ThemeAPP.of(context).secondaryText),
                                          isDense: true,
                                          labelText: 'Run',
                                          labelStyle: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                          hintText: 'Run',
                                          hintStyle: ThemeAPP.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.readexPro(),
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ThemeAPP.of(context)
                                                  .primaryText,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ThemeAPP.of(context).error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ThemeAPP.of(context).error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          fillColor: ThemeAPP.of(context)
                                              .secondaryBackground,
                                        ),
                                        style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                        maxLength: 8,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement.enforced,
                                        keyboardType: TextInputType.number,
                                        cursorColor:
                                            ThemeAPP.of(context).secondaryText,
                                        inputFormatters: [_runMask],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width:10),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      child: TextFormField(
                                        controller: _dvTextController,
                                        focusNode: _dvFocusNode,
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          counterStyle:TextStyle(color: ThemeAPP.of(context).secondaryText),
                                          isDense: true,
                                          labelText: 'Dv',
                                          labelStyle: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                          hintText: 'Dv',
                                          hintStyle: ThemeAPP.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.readexPro(),
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ThemeAPP.of(context)
                                                  .primaryText,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ThemeAPP.of(context).error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ThemeAPP.of(context).error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          fillColor: ThemeAPP.of(context)
                                              .secondaryBackground,
                                        ),
                                        style: TextStyle(color: ThemeAPP.of(context).secondaryText),
                                        maxLength: 1,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement.enforced,
                                        keyboardType: TextInputType.text,
                                        cursorColor:
                                            ThemeAPP.of(context).secondaryText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height:10),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  // Mostrar indicador de carga
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => Center(child: CircularProgressIndicator()),
                                  );

                                  // 1. Obtener datos del formulario
                                  final cardNumber = _numTarjetaTextController1.text.replaceAll(' ', '');
                                  final expirationMonth = _mesTarjetaTextController.text;
                                  final expirationYear = '20${_annioTarjetaTextController.text}';
                                  final securityCode = _cvvTarjetaTextController.text;
                                  final cardholderName = _numTarjetaTextController2.text;
                                  final rutCompleto = '${_runTextController.text}-${_dvTextController.text}';

                                  // 2. Validar campos
                                  if (cardNumber.isEmpty || expirationMonth.isEmpty || rutCompleto.isEmpty) {
                                    Navigator.pop(context); // Cerrar loading
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Complete todos los campos')),
                                    );
                                    return;
                                  }

                                  // 3. Generar token
                                  print("Generando token...");
                                  final token = await obtenerToken(
                                    cardNumber: cardNumber,
                                    expirationMonth: expirationMonth,
                                    expirationYear: expirationYear,
                                    securityCode: securityCode,
                                    cardholderName: cardholderName,
                                    identificationNumber: rutCompleto,
                                  );

                                  if (token == null) {
                                    Navigator.pop(context); // Cerrar loading
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error al generar token')),
                                    );
                                    return;
                                  }

                                  print("Token generado: $token");

                                  // 4. Procesar pago
                                  print("Procesando pago...");
                                  final pagoExitoso = await procesarPago(
                                    email: widget.userEmail,
                                    rut: rutCompleto,
                                    token: token,
                                    amount: widget.planPrice,
                                  );

                                  Navigator.pop(context); // Cerrar loading
                                  final userId = SupabaseConfig.client.auth.currentUser?.id;
                                  if (pagoExitoso) {
                                    // Navegar a pantalla de éxito
                                    Navigator.pop(context);
                                    print("Pago hecho...");
                                    await SupabaseConfig.client
                                    .from('membresia')
                                    .update({'estado': '047930a7-0dd1-4885-92da-7a849d353e9a'})
                                    .eq('id_usuario', userId!)
                                    .select();
                                    print("Membresia actualizada...");
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/inicio',
                                      (Route<dynamic> route) => false,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error al procesar el pago')),
                                    );
                                  }
                                } catch (e) {
                                  Navigator.pop(context); // Cerrar loading si hay error
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error inesperado: $e')),
                                  );
                                  print("Error completo: $e");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeAPP.of(context).primary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                textStyle: ThemeAPP.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.readexPro(),
                                      color: Colors.white,
                                    ),
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text('Pagar'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}