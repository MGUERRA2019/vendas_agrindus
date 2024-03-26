import 'package:vendasagrindus/data_helper.dart';
import 'package:vendasagrindus/utilities/string_utils.dart';

class ListaPreco {
  String vENDEDOR = stringEmpty;
  int nROLISTA = 0;
  String cPROD = stringEmpty;
  String cPRODPALM = stringEmpty;
  String uNIDADE = stringEmpty;
  double pRECO = 0;
  String dTVIGDE = stringEmpty;
  String iNTR = stringEmpty;
  int vERSION = 0;

  ListaPreco(
      this.vENDEDOR,
      this.nROLISTA,
      this.cPROD,
      this.cPRODPALM,
      this.uNIDADE,
      this.pRECO,
      this.dTVIGDE,
      this.iNTR,
      this.vERSION);

  ListaPreco.fromJson(Map<String, dynamic> json) {
    vENDEDOR = json['VENDEDOR'];
    nROLISTA = json['NRO_LISTA'];
    cPROD = json['C_PROD'];
    cPRODPALM = json['C_PROD_PALM'];
    uNIDADE = json['UNIDADE'];
    pRECO = DataHelper.brNumber.parse(json['PRECO']).toDouble();
    dTVIGDE = json['DT_VIG_DE'];
    iNTR = json['INTR'];
    vERSION = json['VERSION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VENDEDOR'] = this.vENDEDOR;
    data['NRO_LISTA'] = this.nROLISTA;
    data['C_PROD'] = this.cPROD;
    data['C_PROD_PALM'] = this.cPRODPALM;
    data['UNIDADE'] = this.uNIDADE;
    data['PRECO'] = this.pRECO;
    data['DT_VIG_DE'] = this.dTVIGDE;
    data['INTR'] = this.iNTR;
    data['VERSION'] = this.vERSION;
    return data;
  }
}
