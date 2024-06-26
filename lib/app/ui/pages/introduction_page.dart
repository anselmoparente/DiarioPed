import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:diarioped/app/ui/theme/design_system.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: size.width * 0.95,
                      decoration: const BoxDecoration(
                        color: DiariopedColors.itemBackGround,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: const Text(
                        textAlign: TextAlign.start,
                        'Bem vindo ao DiarioPed!\n\nEste diário alimentar tem como objetivo identificar os alimentos que podem estar causando desequilíbrio na cavidade bucal e consequentemente a cárie.\nVocê, mãe/pai (ou outra pessoa responsável), deverá registrar quais os alimentos e a quantidade que seu/sua filho(a) consome durante 3 ou 7 dias, para que o Odontopediatra possa identificar quais deles podem contribuir  para o desequilíbrio no meio bucal.\nImportante que todos os alimentos sejam anotados nos horários que são ingeridos.',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      height: size.width * 0.8,
                      child: Transform.translate(
                        offset: const Offset(0, -2),
                        child: SvgPicture.asset(
                          'assets/images/introduction.svg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width * 0.95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 16.0,
                          ),
                          backgroundColor:
                              DiariopedColors.button.withOpacity(0.8),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        onPressed: () => GoRouter.of(context).pop(),
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 16.0,
                          ),
                          backgroundColor:
                              DiariopedColors.button.withOpacity(0.8),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        onPressed: () =>
                            GoRouter.of(context).pushNamed('/link'),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
