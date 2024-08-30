

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:nseguridad/src/controllers/actividades_asignadas_controller.dart';
import 'package:nseguridad/src/controllers/activities_controller.dart';
import 'package:nseguridad/src/controllers/ausencias_controller.dart';
import 'package:nseguridad/src/controllers/aviso_salida_controller.dart';
import 'package:nseguridad/src/controllers/avisos_controller.dart';
import 'package:nseguridad/src/controllers/bitacora_controller.dart';
import 'package:nseguridad/src/controllers/cambio_puesto_controller.dart';
import 'package:nseguridad/src/controllers/capacitaciones_controller.dart';
import 'package:nseguridad/src/controllers/consignas_clientes_controller.dart';
import 'package:nseguridad/src/controllers/consignas_controller.dart';
import 'package:nseguridad/src/controllers/encuastas_controller.dart';
import 'package:nseguridad/src/controllers/estado_cuenta_controller.dart';
import 'package:nseguridad/src/controllers/evaluaciones_controller.dart';
import 'package:nseguridad/src/controllers/gestion_documental_controller.dart';
import 'package:nseguridad/src/controllers/home_ctrl.dart';
import 'package:nseguridad/src/controllers/informes_controller.dart';
import 'package:nseguridad/src/controllers/logistica_controller.dart';
import 'package:nseguridad/src/controllers/multas_controller.dart';
import 'package:nseguridad/src/controllers/new_permisos_controller.dart';
import 'package:nseguridad/src/controllers/new_turno_extra_controller.dart';

import 'package:nseguridad/src/controllers/novedades_controller.dart';
import 'package:nseguridad/src/controllers/prueba_controller.dart';
import 'package:nseguridad/src/controllers/residentes_controller.dart';
import 'package:nseguridad/src/controllers/sugerencias_controller.dart';
import 'package:nseguridad/src/controllers/turno_extra_controller.dart';
import 'package:nseguridad/src/routes/routes.dart';
import 'package:nseguridad/src/service/local_notifications.dart';
import 'package:nseguridad/src/service/notification_push.dart';
import 'package:nseguridad/src/service/notifications_service.dart';
import 'package:nseguridad/src/service/socket_service.dart';

import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  await PushNotificationService.initializeApp(); 
    await LocalNotificationsService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final homeController = HomeController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeApp()),
        ChangeNotifierProvider(create: (_) => PushNotificationService()),
          ChangeNotifierProvider(create: (_) => ImagenCompress()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => ActividadesController()),
        ChangeNotifierProvider(create: (_) => AvisosController()),
        ChangeNotifierProvider(create: (_) => ConsignasClientesController()),
        ChangeNotifierProvider(create: (_) => ConsignasController()),
        ChangeNotifierProvider(create: (_) => EstadoCuentaController()),
        ChangeNotifierProvider(create: (_) => MultasGuardiasContrtoller()),
        ChangeNotifierProvider(create: (_) => InformeController()),
        ChangeNotifierProvider(create: (_) => LogisticaController()),
        ChangeNotifierProvider(create: (_) => AvisoSalidaController()),
        ChangeNotifierProvider(create: (_) => CambioDePuestoController()),
        ChangeNotifierProvider(create: (_) => AusenciasController()),
        ChangeNotifierProvider(create: (_) => TurnoExtraController()),
        ChangeNotifierProvider(create: (_) => ActivitiesController()),
        ChangeNotifierProvider(create: (_) => EncuestasController()),
        ChangeNotifierProvider(create: (_) => EvaluacionesController()),
        ChangeNotifierProvider(create: (_) => CapacitacionesController()),
        ChangeNotifierProvider(create: (_) => SugerenciasController()),
        ChangeNotifierProvider(create: (_) => ActividadesAsignadasController()),
        ChangeNotifierProvider(create: (_) => BitacoraController()),
        ChangeNotifierProvider(create: (_) => ResidentesController()),
        ChangeNotifierProvider(create: (_) => GestionDocumentalController()),

        //**********NUEVOS************//
        ChangeNotifierProvider(create: (_) => NuevoPermisoController()),
        ChangeNotifierProvider(create: (_) => NuevoTurnoExtraController()),
         



      ],
      child: 
      Consumer<ThemeApp>(builder: (_, valueTheme, __) {  
        return   MaterialApp(
            debugShowCheckedModeBanner: false,
            //  CONFIGURACION PARA EL DATEPICKER
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'), // English, no country code
              Locale('es', 'ES'), // Hebrew, no country code
            ],
            // theme: ThemeData(
            //   brightness: Brightness.light,
            //   // primarySwatch: Color(00),
            //   primaryColor: _user.getUsuarioInfo!.colorPrimario!,
            //   // visualDensity: VisualDensity.adaptivePlatformDensity,
            // ),

            //==== AGREGO EL TEMA ====//
            theme: valueTheme.themeData,
//============================//
            initialRoute: 'prueba',

            // initialRoute: 'splash',

            routes: appRoutes,
            navigatorKey: homeController.navigatorKey,
            scaffoldMessengerKey: NotificatiosnService.messengerKey,
          );
      },)
     
    );
  }
}
