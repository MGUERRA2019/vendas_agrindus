import 'package:vendasagrindus/utilities/string_utils.dart';

import 'package:vendasagrindus/utilities/string_utils.dart';

class CondPagto {
  String cONDPAGTO = stringEmpty;
  String dESCRICAO = stringEmpty;
  int cPINTELIGENTE = 0;
  String nROLISTA = stringEmpty;
  int fORMAPAGTO = 0;
  int dIASADICENTR = 0;
  int uSADIASADIC = 0;
  String tIPOPAGTO = stringEmpty;
  int uSATIPOPAGTO = 0;
  String cODTES = stringEmpty;
  int uSATES = 0;
  int vLRMINPED = 0;
  String uSADESC = stringEmpty;
  String iNTR = stringEmpty;
  String vERSION = stringEmpty;

  CondPagto(
      {this.cONDPAGTO = stringEmpty,
      this.dESCRICAO = stringEmpty,
      this.cPINTELIGENTE = 0,
      this.nROLISTA = stringEmpty,
      this.fORMAPAGTO = 0,
      this.dIASADICENTR = 0,
      this.uSADIASADIC = 0,
      this.tIPOPAGTO = stringEmpty,
      this.uSATIPOPAGTO = 0,
      this.cODTES = stringEmpty,
      this.uSATES = 0,
      this.vLRMINPED = 0,
      this.uSADESC = stringEmpty,
      this.iNTR = stringEmpty,
      this.vERSION = stringEmpty});

  CondPagto.fromJson(Map<String, dynamic> json) {
    cONDPAGTO = json['COND_PAGTO'];
    dESCRICAO = json['DESCRICAO'];
    cPINTELIGENTE = json['CP_INTELIGENTE'];
    nROLISTA = json['NRO_LISTA'];
    fORMAPAGTO = json['FORMA_PAGTO'];
    dIASADICENTR = json['DIAS_ADIC_ENTR'];
    uSADIASADIC = json['USA_DIAS_ADIC'];
    tIPOPAGTO = json['TIPO_PAGTO'];
    uSATIPOPAGTO = json['USA_TIPO_PAGTO'];
    cODTES = json['COD_TES'];
    uSATES = json['USA_TES'];
    vLRMINPED = json['VLR_MIN_PED'];
    uSADESC = json['USA_DESC'];
    iNTR = json['INTR'];
    vERSION = json['VERSION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['COND_PAGTO'] = this.cONDPAGTO;
    data['DESCRICAO'] = this.dESCRICAO;
    data['CP_INTELIGENTE'] = this.cPINTELIGENTE;
    data['NRO_LISTA'] = this.nROLISTA;
    data['FORMA_PAGTO'] = this.fORMAPAGTO;
    data['DIAS_ADIC_ENTR'] = this.dIASADICENTR;
    data['USA_DIAS_ADIC'] = this.uSADIASADIC;
    data['TIPO_PAGTO'] = this.tIPOPAGTO;
    data['USA_TIPO_PAGTO'] = this.uSATIPOPAGTO;
    data['COD_TES'] = this.cODTES;
    data['USA_TES'] = this.uSATES;
    data['VLR_MIN_PED'] = this.vLRMINPED;
    data['USA_DESC'] = this.uSADESC;
    data['INTR'] = this.iNTR;
    data['VERSION'] = this.vERSION;
    return data;
  }
}
