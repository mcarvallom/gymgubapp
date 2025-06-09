import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/gymhub/gymhub_theme.dart';
import '/gymhub/gymhub_util.dart';
import '/pages/formulario_tarjeta/formulario_tarjeta_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'pagina_espera_model.dart';
export 'pagina_espera_model.dart';

class PaginaEsperaWidget extends StatefulWidget {
  const PaginaEsperaWidget({super.key});

  static String routeName = 'paginaEspera';
  static String routePath = '/paginaEspera';

  @override
  State<PaginaEsperaWidget> createState() => _PaginaEsperaWidgetState();
}

class _PaginaEsperaWidgetState extends State<PaginaEsperaWidget> {
  late PaginaEsperaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaginaEsperaModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (loggedIn) {
        _model.membresia = await MembresiaTable().queryRows(
          queryFn: (q) => q.eqOrNull(
            'id_usuario',
            currentUserUid,
          ),
        );
        FFAppState().estado = _model.membresia!.firstOrNull!.estado;
        safeSetState(() {});
        if (_model.membresia?.firstOrNull?.estado ==
            '047930a7-0dd1-4885-92da-7a849d353e9a') {
          context.pushNamed(
            InicioWidget.routeName,
            extra: <String, dynamic>{
              kTransitionInfoKey: TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
                duration: Duration(milliseconds: 0),
              ),
            },
          );
        } else {
          await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (dialogContext) {
              return Dialog(
                elevation: 0,
                insetPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                alignment: AlignmentDirectional(0.0, 0.0)
                    .resolve(Directionality.of(context)),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(dialogContext).unfocus();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: FormularioTarjetaWidget(),
                ),
              );
            },
          );
        }
      } else {
        context.goNamed(
          LoginWidget.routeName,
          extra: <String, dynamic>{
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: GymHubTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
