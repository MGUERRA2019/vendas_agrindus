import 'package:vendasagrindus/model/pedidoItem.dart';

class PedidoMestre {
  int eMPRESA;
  int fILIAL;
  int nUMERO;
  double pESOTOTAL;
  String nUMEROSFA;
  String cLIENTE;
  String nOMECLIENTE;
  String lOJACLI;
  String tIPOPED;
  String cONDPAGTO;
  String vENDEDOR;
  String tEXTOESP;
  String dTPED;
  String nROLISTA;
  String tIPOCLI;
  String sTATUS;
  int aSSINA;
  int eMITENF;
  String eMISSAO;
  String nFISCAL;
  String sERIE;
  String nUMEROINTEG;
  String dTLIVRE;
  String nRDUP;
  double vLRPED;
  String vLRFAT;
  String pORCDESC1;
  String pORCDESC2;
  String pORCDESC3;
  double cARGATOTAL;
  // int rESERVADO1;
  int rESERVADO2;
  // int rESERVADO3;
  // int rESERVADO4;
  // String rESERVADO5;
  // String rESERVADO6;
  // String rESERVADO7;
  // int rESERVADO8;
  // String rESERVADO9;
  // String rESERVADO10;
  // String rESERVADO11;
  // String rESERVADO12;
  // String rESERVADO13;
  // String rESERVADO14;
  // String rESERVADO15;
  // String rESERVADO16;
  String iNTR;
  String oPERADOR;
  String dATAALTER;
  int hORAALTER;
  int tIMESTAMP;
  int vERSION;
  List<PedidoItem> iTENSDOPEDIDO;

  PedidoMestre(
      {this.eMPRESA,
      this.fILIAL,
      this.nUMERO,
      this.pESOTOTAL,
      this.nUMEROSFA,
      this.cLIENTE,
      this.nOMECLIENTE,
      this.lOJACLI,
      this.tIPOPED,
      this.cONDPAGTO,
      this.vENDEDOR,
      this.tEXTOESP,
      this.dTPED,
      this.nROLISTA,
      this.tIPOCLI,
      this.sTATUS,
      this.aSSINA,
      this.eMITENF,
      this.eMISSAO,
      this.nFISCAL,
      this.sERIE,
      this.nUMEROINTEG,
      this.dTLIVRE,
      this.nRDUP,
      this.vLRPED,
      this.vLRFAT,
      this.pORCDESC1,
      this.pORCDESC2,
      this.pORCDESC3,
      this.cARGATOTAL,
      // this.rESERVADO1,
      this.rESERVADO2,
      // this.rESERVADO3,
      // this.rESERVADO4,
      // this.rESERVADO5,
      // this.rESERVADO6,
      // this.rESERVADO7,
      // this.rESERVADO8,
      // this.rESERVADO9,
      // this.rESERVADO10,
      // this.rESERVADO11,
      // this.rESERVADO12,
      // this.rESERVADO13,
      // this.rESERVADO14,
      // this.rESERVADO15,
      // this.rESERVADO16,
      this.iNTR,
      this.oPERADOR,
      this.dATAALTER,
      this.hORAALTER,
      this.tIMESTAMP,
      this.vERSION,
      this.iTENSDOPEDIDO});

  PedidoMestre.fromJson(Map<String, dynamic> json) {
    eMPRESA = json['EMPRESA'];
    fILIAL = json['FILIAL'];
    nUMERO = json['NUMERO'];
    nUMEROSFA = json['NUMERO_SFA'];
    cLIENTE = json['CLIENTE'];
    lOJACLI = json['LOJA_CLI'];
    tIPOPED = json['TIPO_PED'];
    cONDPAGTO = json['COND_PAGTO'];
    vENDEDOR = json['VENDEDOR'];
    tEXTOESP = json['TEXTO_ESP'];
    dTPED = json['DT_PED'];
    nROLISTA = json['NRO_LISTA'];
    tIPOCLI = json['TIPO_CLI'];
    sTATUS = json['STATUS'];
    aSSINA = (json['ASSINA'] is String)
        ? 0
        : json['ASSINA']; //pode receber como nulo
    eMITENF = (json['EMITE_NF'] is String)
        ? 0
        : json['EMITE_NF']; //pode receber como nulo
    eMISSAO = json['EMISSAO'];
    nFISCAL = json['N_FISCAL'];
    sERIE = json['SERIE'];
    nUMEROINTEG = json['NUMERO_INTEG'];
    dTLIVRE = json['DT_LIVRE'];
    nRDUP = json['NR_DUP'];
    vLRPED = (json['VLR_PED'] is String) ? 0 : json['VLR_PED'];
    vLRFAT = json['VLR_FAT'];
    pORCDESC1 = json['PORC_DESC1'];
    pORCDESC2 = json['PORC_DESC2'];
    pORCDESC3 = json['PORC_DESC3'];
    cARGATOTAL = (json['CARGA_TOTAL'] is String) ? 0 : json['CARGA_TOTAL'];
    // rESERVADO1 = json['RESERVADO1'];
    rESERVADO2 = (json['RESERVADO2'] is String)
        ? 0
        : json['RESERVADO2']; //pode receber como nulo
    // rESERVADO3 = json['RESERVADO3'];
    // rESERVADO4 = json['RESERVADO4'];
    // rESERVADO5 = json['RESERVADO5'];
    // rESERVADO6 = json['RESERVADO6'];
    // rESERVADO7 = json['RESERVADO7'];
    // rESERVADO8 = (json['RESERVADO8'] is String)
    //     ? 0
    //     : json['RESERVADO8']; //pode receber como nulo
    // rESERVADO9 = json['RESERVADO9'];
    // rESERVADO10 = json['RESERVADO10'];
    // rESERVADO11 = json['RESERVADO11'];
    // rESERVADO12 = json['RESERVADO12'];
    // rESERVADO13 = json['RESERVADO13'];
    // rESERVADO14 = json['RESERVADO14'];
    // rESERVADO15 = json['RESERVADO15'];
    // rESERVADO16 = json['RESERVADO16'];
    iNTR = json['INTR'];
    oPERADOR = json['OPERADOR'];
    dATAALTER = json['DATA_ALTER'];
    hORAALTER = (json['HORA_ALTER'] is String) ? 0 : json['HORA_ALTER'];
    tIMESTAMP = (json['TIME_STAMP'] is String) ? 0 : json['TIME_STAMP'];
    vERSION = (json['VERSION'] is String) ? 0 : json['VERSION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMPRESA'] = this.eMPRESA;
    data['FILIAL'] = this.fILIAL;
    data['NUMERO'] = this.nUMERO;
    data['PESO_TOTAL'] = this.pESOTOTAL;
    data['NUMERO_SFA'] = this.nUMEROSFA;
    data['CLIENTE'] = this.cLIENTE;
    data['NOME_CLIENTE'] = this.nOMECLIENTE;
    data['LOJA_CLI'] = this.lOJACLI;
    data['TIPO_PED'] = this.tIPOPED;
    data['COND_PAGTO'] = this.cONDPAGTO;
    data['VENDEDOR'] = this.vENDEDOR;
    data['TEXTO_ESP'] = this.tEXTOESP;
    data['DT_PED'] = this.dTPED;
    data['NRO_LISTA'] = this.nROLISTA;
    data['TIPO_CLI'] = this.tIPOCLI;
    data['STATUS'] = this.sTATUS;
    data['ASSINA'] = this.aSSINA;
    data['EMITE_NF'] = this.eMITENF;
    data['EMISSAO'] = this.eMISSAO;
    data['N_FISCAL'] = this.nFISCAL;
    data['SERIE'] = this.sERIE;
    data['NUMERO_INTEG'] = this.nUMEROINTEG;
    data['DT_LIVRE'] = this.dTLIVRE;
    data['NR_DUP'] = this.nRDUP;
    data['VLR_PED'] = this.vLRPED;
    data['VLR_FAT'] = this.vLRFAT;
    data['PORC_DESC1'] = this.pORCDESC1;
    data['PORC_DESC2'] = this.pORCDESC2;
    data['PORC_DESC3'] = this.pORCDESC3;
    data['CARGA_TOTAL'] = this.cARGATOTAL;
    // data['RESERVADO1'] = this.rESERVADO1;
    data['RESERVADO2'] = this.rESERVADO2;
    // data['RESERVADO3'] = this.rESERVADO3;
    // data['RESERVADO4'] = this.rESERVADO4;
    // data['RESERVADO5'] = this.rESERVADO5;
    // data['RESERVADO6'] = this.rESERVADO6;
    // data['RESERVADO7'] = this.rESERVADO7;
    // data['RESERVADO8'] = this.rESERVADO8;
    // data['RESERVADO9'] = this.rESERVADO9;
    // data['RESERVADO10'] = this.rESERVADO10;
    // data['RESERVADO11'] = this.rESERVADO11;
    // data['RESERVADO12'] = this.rESERVADO12;
    // data['RESERVADO13'] = this.rESERVADO13;
    // data['RESERVADO14'] = this.rESERVADO14;
    // data['RESERVADO15'] = this.rESERVADO15;
    // data['RESERVADO16'] = this.rESERVADO16;
    data['INTR'] = this.iNTR;
    data['OPERADOR'] = this.oPERADOR;
    data['DATA_ALTER'] = this.dATAALTER;
    data['HORA_ALTER'] = this.hORAALTER;
    data['TIME_STAMP'] = this.tIMESTAMP;
    data['VERSION'] = this.vERSION;
    data['ITENS_DO_PEDIDO'] = this.iTENSDOPEDIDO;
    return data;
  }

  DateTime get date {
    return (dTPED == 'null') ? null : DateTime.parse(dTPED);
  }
}
