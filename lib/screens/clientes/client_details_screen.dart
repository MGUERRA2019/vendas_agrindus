import 'package:flutter/material.dart';
import 'package:vendasagrindus/model/clientes.dart';
import 'package:vendasagrindus/screens/pedidos/new_order_screen.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import 'client_details_widgets.dart';

class ClientDetailsScreen extends StatelessWidget {
  final Clientes cliente;
  ClientDetailsScreen(this.cliente);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            backgroundColor: Colors.blueAccent,
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            snap: false,
            actions: [
              IconButton(
                  icon: Icon(Icons.add_box_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewOrderScreen(cliente)));
                  })
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                cliente.nOMFANTASIA,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoSlab',
                    fontWeight: FontWeight.w600,
                    color: kHeaderTitleColor),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: kGradientStyle,
                ),
              ),
            ),
          ),
          DetailsHeader(title: 'Dados Cadastrais'),
          SliverPadding(padding: EdgeInsets.only(bottom: 20)),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              DetailsCard(
                items: [
                  DetailItem(
                      title: 'Razão Social:', description: cliente.rAZSOCIAL),
                  DetailItem(
                      title: 'Nome Fantasia:',
                      description: cliente.nOMFANTASIA),
                  DetailItem(title: 'Email:', description: cliente.eMAIL)
                ],
              ),
              DetailsCard(
                items: [
                  DetailItem(title: 'Endereço:', description: cliente.eNDERECO),
                  DetailItem(title: 'Cidade:', description: cliente.cIDADE),
                  DetailItem(title: 'Estado:', description: cliente.eSTADO),
                  DetailItem(title: 'Bairro:', description: cliente.bAIRRO),
                  DetailItem(title: 'CEP :', description: cliente.cEP),
                  DetailItem(title: 'Telefone:', description: cliente.tELEFONE),
                ],
              ),
              DetailsCard(
                items: [
                  DetailItem(title: 'CGC CPF :', description: cliente.cGCCPF),
                  DetailItem(
                      title: 'INSCR_ESTAD:', description: cliente.iNSCRESTAD),
                ],
              ),
            ],
          )),
          SliverPadding(padding: EdgeInsets.only(bottom: 20)),
          DetailsHeader(title: 'Dados Financeiros'),
          SliverPadding(padding: EdgeInsets.only(bottom: 20)),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              DetailsCard(
                items: [
                  DetailItem(
                      title: 'Data da primeira compra:',
                      description: (cliente.dTPRCOMP != 'null')
                          ? cliente.dTPRCOMP
                              .substring(0, (cliente.dTPRCOMP.length - 8))
                          : ''),
                  DetailItem(
                      title: 'Data da última compra:',
                      description: (cliente.dTULTCOMP != 'null')
                          ? cliente.dTULTCOMP
                              .substring(0, (cliente.dTULTCOMP.length - 8))
                          : ''),
                  DetailItem(
                      title: 'Data da última visita:',
                      description: (cliente.dTULTVISITA != 'null')
                          ? cliente.dTULTVISITA
                              .substring(0, (cliente.dTULTVISITA.length - 8))
                          : ''),
                ],
              ),
              DetailsCard(
                items: [
                  DetailItem(
                      title: 'Quantidade de duplicatas pagas:',
                      description: cliente.qTDUPPG.toString()),
                  DetailItem(
                      title: 'Saldo atual a pagar :',
                      description:
                          (cliente.sDATUAL != 'null') ? cliente.sDATUAL : '0'),
                  DetailItem(
                      title: 'Valor em atraso:',
                      description: cliente.vLRATRASOS.toString()),
                  DetailItem(
                      title: 'Valor acumulado de vendas:',
                      description: (cliente.vLRACUMVE != 'null')
                          ? cliente.vLRACUMVE
                          : '0'),
                  DetailItem(
                      title: 'Valor da maior fatura: ',
                      description: (cliente.vLRMAFAT != 'null')
                          ? cliente.vLRMAFAT
                          : '0'),
                  DetailItem(
                      title: 'Número de pagamento em atraso:',
                      description: cliente.nROPGATR.toString()),
                ],
              ),
            ],
          )),
          SliverPadding(padding: EdgeInsets.only(bottom: 20)),
        ],
      ),
    );
  }
}
