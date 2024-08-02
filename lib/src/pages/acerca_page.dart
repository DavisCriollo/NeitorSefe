import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nseguridad/src/theme/themes_app.dart';
import 'package:nseguridad/src/urls/urls.dart';
import 'package:nseguridad/src/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';






class AcercaDePage extends StatelessWidget {
  const AcercaDePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
      final Responsive size = Responsive.of(context);
        final ctrlTheme = context.read<ThemeApp>();
    return 
      Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
         flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  ctrlTheme.primaryColor,
                  ctrlTheme.secondaryColor,
                ],
              ),
            ),
          ),
        title: Text('Acerca de Nosotros',
        // style:  Theme.of(context).textTheme.headline2,
        ),
       
      ),
      body: 
      SingleChildScrollView(
              child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(size.iScreen(1.0)),
              // color: Colors.red,
              width: size.wScreen(100),
              height: size.hScreen(20),
              child: SizedBox(
                width: size.wScreen(40),
                height: size.hScreen(40),
                child: Image.asset(
                  'assets/imgs/NeitorSafe.png',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: size.iScreen(2.0), vertical: size.iScreen(0.0)),
              // color: Colors.blue,
              width: size.wScreen(100),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                         margin: EdgeInsets.symmetric(
                  horizontal: size.iScreen(2.0), vertical: size.iScreen(0.0)),
                        child: Text(
                          'Versión. 1.0.0',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.6),
                              color: Colors.black87,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                         margin: EdgeInsets.symmetric(
                  vertical: size.iScreen(1.6)),
                        child: Text(
                          // 'Neitor, está diseñado por "2JL Soluciones Integrales".      \nSomos una empresa dedicada al desarrollo de software utilizando tegnología de banguardia comprometidos con nuestros clientes para darle soluciones a todas sus necesidaddes tecnologicas.',
                          'NeitorSafe es un sistema integral de seguridad que protege a tu empres con tecnología avanzada y expertos dedicados. Además, ofrecemos asesoría y desarrollo de software personalizado, creando soluciones innovadoras y eficientes adaptadas a las necesidades de nuestros clientes.',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(1.8),
                              color: Colors.black45,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  Container(
                     margin: EdgeInsets.only(
                  left: size.iScreen(2.0),right: size.iScreen(2.0), top: size.iScreen(5.0),bottom: size.iScreen(2.0)),
                    child: Text(
                      'Contáctenos:',
                      style: GoogleFonts.lexendDeca(
                          fontSize: size.iScreen(2.0),
                          color: Colors.black87,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SelectableText(
                            '0980290473',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                color: const Color(0xFF4064AD),
                                fontWeight: FontWeight.bold),
                          ),
                  Container(
                     margin: EdgeInsets.symmetric(
                   vertical: size.iScreen(1.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Text(
                            'soporte@2jl.ec',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                color:const Color(0xFF4064AD),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                              
                              urlSendEmail('soporte@2jl.ec');

                          },
                        ),
                        GestureDetector(
                                                child: Text(
                            'neitor2jl@gmail.com',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                color:const Color(0xFF4064AD),
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: ()=> urlSendEmail('neitor2jl@gmail.com'),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                         margin: EdgeInsets.symmetric(
                  horizontal: size.iScreen(2.0), vertical: size.iScreen(2.0)),
                        child: Text(
                          'Visita nuestra web',
                          style: GoogleFonts.lexendDeca(
                              fontSize: size.iScreen(2.0),
                              color: Colors.black87,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      GestureDetector(
                                              child: Container(
                           margin: EdgeInsets.symmetric(
                  horizontal: size.iScreen(0.0), vertical: size.iScreen(0.5)),
                          child: Text(
                            'https://neitor.com',
                            style: GoogleFonts.lexendDeca(
                                fontSize: size.iScreen(2.0),
                                color:const Color(0xFF51C1E1),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                         onTap: ()=>launchUrlsNeitor('https://neitor.com/'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                   
                      // INSTAGRAM
                _ItemsSocials(
                  size: size,
                  icon: FontAwesomeIcons.instagram,
                  color:const Color(0xFFD04768),
                  onTap: () => abrirPaginaNeitor(),
                ),
                //FACEBOOK
                _ItemsSocials(
                  size: size,
                  icon: FontAwesomeIcons.facebookF,
                  color:const Color(0xFF4064AD),
                  onTap: () => abrirPaginaNeitor(),
                ),

                //TWITTER
                _ItemsSocials(
                  size: size,
                  icon: FontAwesomeIcons.twitter,
                  color: const Color(0xFF00B1EA),
                  onTap: () => abrirPaginaNeitor(),
                ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    
    
    );
  
  
  }
}
class _ItemsSocials extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function? onTap;

  const _ItemsSocials({
required this.size,
required this.icon,
required this.color,
    this.onTap,
  });

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.iScreen(1.0), vertical: size.iScreen(2.0)),
          padding: EdgeInsets.all(size.iScreen(1.2)),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(15.0)),
          child: Icon(
            icon,
            size: size.iScreen(3.0),
            color: Colors.white,
          )),
      onTap:()=> onTap ,
    );
  }
}
