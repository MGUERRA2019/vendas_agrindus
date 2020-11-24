import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vendasagrindus/components/alert_button.dart';
import 'package:vendasagrindus/model/cliente.dart';
import 'package:vendasagrindus/model/pedidoMestre.dart';
import 'package:vendasagrindus/screens/pedidos/new_order_screen.dart';
import 'package:vendasagrindus/screens/pedidos/order_details_screen.dart';
import 'package:vendasagrindus/user_data.dart';
import 'package:vendasagrindus/utilities/constants.dart';
import 'client_details_widgets.dart';

class ClientDetailsScreen extends StatelessWidget {
  final Cliente cliente;
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
                    if (cliente.pRIORIDADE != 0 && cliente.pRIORIDADE != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewOrderScreen(cliente)));
                    } else {
                      Alert(
                        context: context,
                        title: 'ERRO',
                        desc: 'Cliente não possui lista de preço registrada.',
                        style: kAlertCardStyle,
                        buttons: [
                          AlertButton(
                              label: 'VOLTAR',
                              onTap: () {
                                Navigator.pop(context);
                              })
                        ],
                      ).show();
                    }
                  })
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                cliente.nOMFANTASIA,
                textAlign: TextAlign.center,
                style: kHeaderText,
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
          DetailsHeader(title: 'Últimos pedidos'),
          SliverPadding(padding: EdgeInsets.only(bottom: 20)),
          FutureBuilder(
            future: Provider.of<UserData>(context, listen: false)
                .getPedidoMestre(cliente.cLIENTE),
            builder: (BuildContext context,
                AsyncSnapshot<List<PedidoMestre>> snapshot) {
              if (snapshot.hasData) {
                List<PedidoMestre> pedidosMestre = snapshot.data;

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return DetailsCard(
                        isInteractive: true,
                        onPressed: () async {
                          var pedidosItem = await Provider.of<UserData>(context,
                                  listen: false)
                              .getPedidoItem(pedidosMestre[index].nUMEROSFA);
                          if (pedidosItem == null) {
                            Alert(
                              context: context,
                              title: 'ERRO',
                              desc:
                                  'Não foi possível localizar os itens do pedido.',
                              style: kAlertCardStyle,
                              buttons: [
                                AlertButton(
                                    label: 'VOLTAR',
                                    onTap: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ).show();
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDetailsScreen(
                                        pedidosMestre[index],
                                        pedidosItem,
                                        cliente)));
                          }
                        },
                        items: [
                          DetailItem(
                              title: 'Código do pedido:',
                              description: pedidosMestre[index].nUMEROSFA),
                          DetailItem(
                              title: 'Emissão:',
                              description: DateFormat('dd/MM/yyyy')
                                  .format(pedidosMestre[index].date)),
                          DetailItem(
                              title: 'Status:',
                              description: pedidosMestre[index].sTATUS),
                        ],
                      );
                    },
                    childCount: pedidosMestre.length,
                  ),
                );
              }
              return SliverFillRemaining(
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/not_found.svg',
                    height: 270,
                    width: 270,
                  ),
                ),
              );
            },
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 75)),
        ],
      ),
    );
  }
}
