import 'package:flutter/material.dart';
import 'package:nseguridad/src/pages/activar_gps.dart';
import 'package:nseguridad/src/pages/editar_user_pass.dart';
import 'package:nseguridad/src/pages/permisos_page.dart';
import 'package:nseguridad/src/pages/acerca_page.dart';
import 'package:nseguridad/src/pages/home.dart';
import 'package:nseguridad/src/pages/login.dart';
import 'package:nseguridad/src/pages/novedades_page.dart';
import 'package:nseguridad/src/pages/password_page.dart';
import 'package:nseguridad/src/pages/prueba.dart';
import 'package:nseguridad/src/pages/splash_screen.dart';
import 'package:nseguridad/src/pages/valida_acceso_turno.dart';


/** */
import 'package:flutter/material.dart';
import 'package:nseguridad/src/pages/permisos_page.dart';
import 'package:nseguridad/src/pages/acerca_page.dart';
import 'package:nseguridad/src/pages/actividades_page.dart';
import 'package:nseguridad/src/pages/alerta_page.dart';
import 'package:nseguridad/src/pages/busca_clientes_varios.dart';
import 'package:nseguridad/src/pages/busca_guardias.dart';
import 'package:nseguridad/src/pages/busca_guardias_consigna.dart';
import 'package:nseguridad/src/pages/busca_guardias_varios_pedidos.dart';
import 'package:nseguridad/src/pages/buscar_cliente_pedidos.dart';
import 'package:nseguridad/src/pages/buscar_clientes.dart';
import 'package:nseguridad/src/pages/buscar_clientes_informes.dart';
import 'package:nseguridad/src/pages/buscar_clientes_multas_page.dart';
import 'package:nseguridad/src/pages/buscar_guardias_informes.dart';
import 'package:nseguridad/src/pages/buscar_guardias_multiples.dart';
import 'package:nseguridad/src/pages/buscar_guardias_pedidos.dart';
import 'package:nseguridad/src/pages/buscar_guardias_varios.dart';
import 'package:nseguridad/src/pages/buscar_persona_informes.dart';
import 'package:nseguridad/src/pages/buscar_personal_multas_page.dart';
import 'package:nseguridad/src/pages/compartir_clientes.dart';
import 'package:nseguridad/src/pages/comunicado_leido_cliente_page.dart';
import 'package:nseguridad/src/pages/comunicado_leido_guardia_page.dart';
import 'package:nseguridad/src/pages/consigna_leida_cliente_page.dart';
import 'package:nseguridad/src/pages/consigna_leida_guardia_page.dart';
import 'package:nseguridad/src/pages/creaEdita_comunicado_cliente_page.dart';
import 'package:nseguridad/src/pages/crea_aviso_salida_guardia.dart';
import 'package:nseguridad/src/pages/crea_consigna_cliente_page.dart';
import 'package:nseguridad/src/pages/crea_pedidos_guardia_page.dart';
import 'package:nseguridad/src/pages/crea_turno_extra.dart';
import 'package:nseguridad/src/pages/crear_apelacion_page.dart';
import 'package:nseguridad/src/pages/crear_ausencia.dart';
import 'package:nseguridad/src/pages/crear_cambio_puesto.dart';
import 'package:nseguridad/src/pages/crear_capacitacion.dart';
import 'package:nseguridad/src/pages/crear_informe_guardias.dart';
import 'package:nseguridad/src/pages/crear_multa_guardia_page.dart';
import 'package:nseguridad/src/pages/crear_turno_emergente.dart';
import 'package:nseguridad/src/pages/detalle_actividades_page.dart';
import 'package:nseguridad/src/pages/detalle_bitacora.dart';
import 'package:nseguridad/src/pages/detalle_contrato_cliente_page.dart';
import 'package:nseguridad/src/pages/detalle_de_apelacion.dart';
import 'package:nseguridad/src/pages/detalle_informe_guardia.dart';
import 'package:nseguridad/src/pages/detalle_multa_guardia.dart';
import 'package:nseguridad/src/pages/detalle_novedades_page.dart';
import 'package:nseguridad/src/pages/edita_ausencia.dart';
import 'package:nseguridad/src/pages/edita_aviso_salida.dart';
import 'package:nseguridad/src/pages/edita_cambio_puesto.dart';

import 'package:nseguridad/src/pages/edita_informe_guardia.dart';
import 'package:nseguridad/src/pages/edita_pedidos_guardia_page.dart';
import 'package:nseguridad/src/pages/edita_turno_extra.dart';
import 'package:nseguridad/src/pages/editar_devolucion_page.dart';
// import 'package:nseguridad/src/pages/home_page.dart';
import 'package:nseguridad/src/pages/list_notifications.dart';
import 'package:nseguridad/src/pages/lista_ausencias_page.dart';
import 'package:nseguridad/src/pages/lista_aviso_salida_guardia.dart';
import 'package:nseguridad/src/pages/lista_bitacora.dart';
import 'package:nseguridad/src/pages/lista_cambio_puesto.dart';
import 'package:nseguridad/src/pages/lista_capacitaciones.dart';
import 'package:nseguridad/src/pages/lista_comunicados_clientes.dart';
import 'package:nseguridad/src/pages/lista_comunicados_guardias.dart';
import 'package:nseguridad/src/pages/lista_consignas_clientes_page.dart';
import 'package:nseguridad/src/pages/lista_consignas_guardias_page.dart';

import 'package:nseguridad/src/pages/lista_encuestas_page.dart';
import 'package:nseguridad/src/pages/lista_estado_cuenta_cliente_page.dart';
import 'package:nseguridad/src/pages/lista_evaluaciones_page.dart';
import 'package:nseguridad/src/pages/lista_implemento_pedido_guardia.dart';
import 'package:nseguridad/src/pages/lista_informes_guardias_page.dart';
import 'package:nseguridad/src/pages/lista_multas_guardias_page.dart';
import 'package:nseguridad/src/pages/lista_multas_supervisor_page.dart';
import 'package:nseguridad/src/pages/lista_new_permisos.dart';
import 'package:nseguridad/src/pages/lista_pedidos_page.dart';
import 'package:nseguridad/src/pages/lista_todas_las_devoluciones.dart';
import 'package:nseguridad/src/pages/lista_todos_los_pedidos.dart';
import 'package:nseguridad/src/pages/lista_turno_extra_page.dart';
import 'package:nseguridad/src/pages/listar_tipos_multas_page.dart';


import 'package:nseguridad/src/pages/logisticas_menu_page.dart';
import 'package:nseguridad/src/pages/mis_notificaciones1_push.dart';
import 'package:nseguridad/src/pages/mis_notificaciones2_push.dart';
import 'package:nseguridad/src/pages/new_busca_persona.dart';
import 'package:nseguridad/src/pages/notificacion_comunicados.dart';
import 'package:nseguridad/src/pages/novedades_page.dart';
import 'package:nseguridad/src/pages/password_page.dart';
import 'package:nseguridad/src/pages/lista_de_actividades.dart';
import 'package:nseguridad/src/pages/prueba.dart';
import 'package:nseguridad/src/pages/realizar_actividad_guardia.dart';
import 'package:nseguridad/src/pages/registro_bitacora_page.dart';

import 'package:nseguridad/src/pages/valida_acceso_multas_page.dart';
import 'package:nseguridad/src/pages/valida_acceso_turno.dart';
import 'package:nseguridad/src/pages/view_image_page.dart';
import 'package:nseguridad/src/pages/view_pdf_page.dart';
import 'package:nseguridad/src/pages/view_video_page.dart';
import 'package:nseguridad/src/pages/vista_ronda_realizada_guardias.dart';
import 'package:nseguridad/src/widgets/error_data.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'splash': (_) => const SplashPage(),
  'login': (_) => const Login(),
  'home': (_) => const Home(),
  'gps': (_) => const PermisosAppPage(),
  'gpsActive': (_) => const ActivarGPSPage(),
    'prueba': (_) =>   ViewsPDFs(),
  'password': (_) => const PasswordPage(),
    'editUserPass': (_) => const UpdatePassUser(),
  'acercade': (_) => const AcercaDePage(),
  'novedades': (_) => const NovedadesPage(),
  'validaAccesoTurno': (_) => const ValidaAccesoTurno(),
  'validaAccesoMultas': (_) => const ValidaAccesoMultas(),
  'multas': (_) => const TipoMultasPage(),
  'detalleDeNovedad': (_) => const DetalleNovedades(),
  'viewPhoto': (_) => const PreviewScreen(),
  'actividades': (_) => ActividadesPage(),
  // 'listaMultas': (_) =>  const ListaMultasPage(),
  'listaComunicadosClientes': (_) => const ListaComunicadosClientesPage(),
  'comunicadoCliente': (_) => const CreaEditaComunicadoClientePage(),
  'comunicadoLeido': (_) => const ComunicadoLeidoClientePage(),
  'listaConsignasClientes': (_) => const ListaConsignasClientesPage(),
  'consignaCliente': (_) => const ConsignaClientePage(),
  'listaComunicadosGuardias': (_) => const ListaComunicadosGuardiasPage(),
  'comunicadoLeidoGuardia': (_) => const ComunicadoLeidoGuardiaPage(),
  'consignacionLeidaCliente': (_) => const ConsignaLeidaClientePage(),
  'listaEstadoCuentaClientes': (_) => const ListaEstadoCuentaClientesPage(),
  'detalleCuentaClientes': (_) => const DetalleContratoPage(),
  'listaConsignasGuardias': (_) => const ListaConsignasGuardiasPage(),
  'consignaLeidaGuardia': (_) => const ConsignaLeidaGuardiaPage(),
 
  'listaMultasSupervisor': (_) => const ListaMultasSupervisor(),
  'listaMultasGuardias': (_) => ListaMultasGuardias(),
  'tipoMultasGuardias': (_) => const TipoMultasPage(),
  'crearMultasGuardias': (_) => const CrearMultaGuardia(),
  'detalleMultaGuardia': (_) => const DetalleMultaGuardiaPage(),
  'buscarClientesMultaGuardia': (_) => const BuscarClientesMultas(),
  'buscarClientesCompartir': (_) => const CompartirClientesMultas(),
  'buscarPersonalMultaGuardia': (_) => const BuscarPersonalMultas(),
  'errorData': (_) => const ErrorData(),
  'listaInformesGuardias': (_) => const ListaInformesGuardiasPage(),
  'crearInformesGuardias': (_) => const CrearInformeGuardiaPage(),
  'buscarPersonalInformeGuardia': (_) => const BuscarPersonalInformes(),
  'buscaClienteInformeGuardia': (_) => const BuscarClientesInformes(),
  'buscaGuardiaConsigna': (_) => const BuscarGuardiasConsignas(),
  'detalleInformeGuardia': (_) => DetalleInformeGuardiaPage(),
  'videoSreen': (_) => const VideoScreenPage(),
  'creaPedido': (_) => const PedidosPage(),
  
  'agregaPedidosGuardia': (_) => const BuscarImplementoPedidoGuardiaPage(),
  'buscaClientePedidos': (_) => const BuscarClientesPedidos(),
  'buscaGuardiasPedido': (_) => const BuscarGuardiasPedido(),
 
  'logisticaMenuPage': (_) => const LogisticaMenuPage(),
  'editarPedidos': (_) => const EditarPedidoPage(),
 
  'editaInformeGuardia': (_) => const EditaInformeGuardiaPage(),
  'listaAvisoSalidaGuardia': (_) => const ListaAvisoSalidaGuardiasPage(),
  'creaAvisoSalida': (_) => const CreaAvisoSalida(),
  'buscaGuardias': (_) => const BuscarGuardias(),
  'editaAvisoSalida': (_) => const EditaAvisoSalida(),
  'listaCambioDePuesto': (_) => const ListaCambioPuestoPage(),
  'creaCambioDePuesto': (_) => const CreaCambioDePuesto(),
  'buscaClientes': (_) => const BuscarClientes(),
  'editaCambioPuesto': (_) => const EditaCambioDePuesto(),
  'listaAusencias': (_) => const ListaAusenciasPage(),
  'creaAusencia': (_) => const CreaAusencia(),
  'editaAusencia': (_) => const EditarAusencia(),
  'listaTurnoExtra': (_) => const ListaTurnoExtraPage(),
  'creaTurnoExtra': (_) => CreaTurnoExtra(),
  'editaTurnoExtra': (_) => const EditaTurnoExtra(),
  'detalleActividades': (_) => const DetalleActividades(),
  'realizaActividadesGuardia': (_) => const RealizarActividadGuardia(),
  'buscarGuardiasVarios': (_) => const BuscarGuardiasVarios(),
  'buscarClientesVarios': (_) => const BuscarClientesVarios(),
  'listaComunicadosPush': (_) => const ListaComunicadosPush(),
  'listaNotificacionesPush': (_) => const ListaNotificacionesPush(),
  'listaNotificaciones2Push': (_) => const ListaNotificaciones2Push(),
  'crearApelacionPage': (_) => const CrearApelacionPage(),
  'buscarGuardiasVariosPedidos': (_) => const BuscarGuardiasVariosPedidos(),
  'alertaPage': (_) => const AlertaPage(),
  'ListaNotifications': (_) => const ListaNotifications(),
  'vistaActividadRealizadasGuardias': (_) =>
      const VistaRondaRealizadasGuardias(),
  'buscarPersonaInformes': (_) => const BuscarPersonaInformes(),
  'listaDePedidos': (_) => const ListaPedidosPage(),
  'editarDevolucion': (_) => const EditarDevolucionPage(),
  'listaTodosLosPedidos': (_) => const ListaTodosLosPedidos(),
  'listaTodasLasDevoluciones': (_) => const ListaTodasLasDevoluciones(),
  'listaBitacora': (_) => const ListaBitacora(),
  'detalleDeBitacora': (_) => const DetalleDeBitacora(),
  'registroDeBitacora': (_) => const RegitroBiracora(),
  'detalleDeApelacion': (_) => const DetalleDeApelacion(),
  'buscarGuardiasMultiples': (_) => const BuscarGuardiasMultiples(),
  'creaTurnoEmergente': (_) => const CreaTurnoEmergente(),
  'encuestas': (_) => const EncuastasPage(),
  'evaluacion': (_) => const EvaluacionPage(),
  'capacitaciones': (_) => const ListaCapacitaciones(),
  'crearCapacitaciones': (_) => const CrearCapacitacion(),




  'prueba': (_) =>  ViewsPDFs(),





//************************//

'nuevosPermisos':(_) =>  const ListaNuevosPermisos(),
'nuevoBuscaPersona':(_) =>   NuevoBuscaPersona(),




};
