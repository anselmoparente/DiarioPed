import 'package:diarioped/app/ui/theme/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermPage extends StatefulWidget {
  const TermPage({super.key});

  @override
  State<TermPage> createState() => _TermPageState();
}

class _TermPageState extends State<TermPage> {
  bool termAccept = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: DiariopedColors.button,
        title: const Text(
          'Termo',
          style: TextStyle(color: DiariopedColors.background),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          children: [
            const Expanded(
              child: Card(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 8.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Termo de Adequação à LGPD',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Lei Geral de Proteção de Dados. Lei 13.709/2018',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '         O presente Termo de Adequação LGPD (“Termo”) tem como objetivo garantir a adequação do Aplicativo “Diarioped” à Lei Geral de Proteção de Dados (Lei 13.709/2018).\n         O aplicativo “Diarioped”, está disponível nas plataformas para ser utilizado pelos cirurgiões-dentistas e de seus pacientes. Os profissionais afirmam que adota todas as medidas necessárias para assegurar a observância à Lei Geral de Proteção de Dados.\n         O profissional que utiliza o “Diarioped” se compromete a manter a confiabilidade e a integridade de todos os dados pessoais dos pacientes mantidos ou consultados/transmitidos eletronicamente, para garantir a proteção desses dados contra acesso não autorizado, destruição, uso, modificação, divulgação ou perda acidental ou indevida Para fins de clareza, os dados pessoais correspondem as informações relacionadas as pessoas naturais identificadas ou identificáveis.\n         O profissional assegura que todos os seus colaboradores prepostos, sócios, diretores, representantes ou terceiros contratados que tenham acesso aos dados pessoais que estão sob a responsabilidade do mesmo, assina o Termo de Confiabilidade, bem como compromete-se a manter quaisquer Dados Pessoais estritamente confidenciais e não os utilizar para outros fins, com exceção a prestação de serviços.\n         Os Dados Pessoais não poderão ser revelados a terceiros, com exceção da prévia autorização por escrito do responsável dos dados pessoais, ou ainda na hipótese do profissional, por determinação legal, ter que fornecer os dados pessoais a uma autoridade pública, ocasião em o titular dos dados pessoais que deverá ser informado previamente para que tome as medidas necessárias.',
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              )),
            ),
            IntrinsicHeight(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        activeColor: DiariopedColors.button,
                        value: termAccept,
                        onChanged: (value) {
                          setState(
                            () => termAccept = !termAccept,
                          );
                        },
                      ),
                      const Flexible(
                        child: Text(
                          'Confirmo que li e concordo com o termo de política de privacidade e proteção de dados',
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          termAccept ? DiariopedColors.button : Colors.grey,
                    ),
                    onPressed: termAccept
                        ? () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            await prefs.setBool('termAccept', true);

                            if (context.mounted) {
                              GoRouter.of(context)
                                  .pushReplacementNamed('/access');
                            }
                          }
                        : null,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continuar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
