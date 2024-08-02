import 'package:url_launcher/url_launcher.dart';


//*************URLS EMPRESA**************//

Future<void> launchUrlsNeitor(_urls) async {
final Uri _url = Uri.parse(_urls);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}



 
 


abrirPDFPedidos(int idPedido,String rucEmpresa) async {
  final url = 'https://backsigeop.neitor.com/api/reportes/pedido?disId=$idPedido&rucempresa=$rucEmpresa';
  if (await canLaunch(url)) {
    print(url);
    await launch(url);
  } else {
    throw 'No se puede abrir: $url';
  }
}

abrirPaginaNeitor() async {
  const url = 'https://neitor.com/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No se puede abrir: $url';
  }
}
abrirPagina2Jl() async {
  const url = 'http://2jl.ec';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No se puede abrir: $url';
  }
}
abrirPaginaPazViSeg() async {
  const url = 'https://sigeop.neitor.com/l';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No se puede abrir: $url';
  }
}







void urlSendEmail(String _email){
                              
String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');

      
}
                                final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: _email,
    query: encodeQueryParameters(<String, String>{
      'subject': 'Solicitar información',
    }),
    
  );

launchUrl(emailLaunchUri);
}









void launchWaze(double lat, double lng) async {
  var url = 'waze://?ll=${lat.toString()},${lng.toString()}';
  var fallbackUrl =
      'https://waze.com/ul?ll=${lat.toString()},${lng.toString()}&navigate=yes';
  try {
    bool launched =
        await launch(url, forceSafariVC: false, forceWebView: false);
    if (!launched) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  } catch (e) {
    await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
  }
}

void launchGoogleMaps(double lat, double lng) async {
  var url = 'google.navigation:q=${lat.toString()},${lng.toString()}';
  var fallbackUrl =
      'https://www.google.com/maps/search/?api=1&query=${lat.toString()},${lng.toString()}';
  try {
    bool launched =
        await launch(url, forceSafariVC: false, forceWebView: false);
    if (!launched) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  } catch (e) {
    await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
  }
}