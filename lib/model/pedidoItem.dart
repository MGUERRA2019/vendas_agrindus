class PedidoItem {
  int eMPRESA;
  int fILIAL;
  String nUMEROSFA;
  String sEQUENCIA;
  String cPRODPALM;
  String cODBARRA;
  String dESCRICAO;
  String qTDE;
  String iMAGE;
  String pESO;
  String lIVRE;
  String vLRUNIT;
  String vLRTOTAL;
  String dTENTREGA;
  String uNIDADE;
  String tES;
  String lOCAL;
  String pORCDESC;
  String vLRICMS;
  String vLRIPI;
  String gRUPO;
  String nROLISTA;
  String uNIDALT;
  String qTDEALT;
  int rESERVADO1;
  String rESERVADO2;
  String rESERVADO3;
  String rESERVADO4;
  String rESERVADO5;
  String rESERVADO6;
  String rESERVADO7;
  String rESERVADO8;
  String rESERVADO9;
  String rESERVADO10;
  String rESERVADO11;
  String rESERVADO12;
  String rESERVADO13;
  String rESERVADO14;
  String rESERVADO15;
  String rESERVADO16;
  String iNTR;
  String oPERADOR;
  String dATAALTER;
  String hORAALTER;
  String tIMESTAMP;
  String vERSION;

  PedidoItem(
      {this.eMPRESA,
      this.fILIAL,
      this.nUMEROSFA,
      this.sEQUENCIA,
      this.cPRODPALM,
      this.cODBARRA,
      this.iMAGE,
      this.pESO,
      this.dESCRICAO,
      this.qTDE,
      this.lIVRE,
      this.vLRUNIT,
      this.vLRTOTAL,
      this.dTENTREGA,
      this.uNIDADE,
      this.tES,
      this.lOCAL,
      this.pORCDESC,
      this.vLRICMS,
      this.vLRIPI,
      this.gRUPO,
      this.nROLISTA,
      this.uNIDALT,
      this.qTDEALT,
      this.rESERVADO1,
      this.rESERVADO2,
      this.rESERVADO3,
      this.rESERVADO4,
      this.rESERVADO5,
      this.rESERVADO6,
      this.rESERVADO7,
      this.rESERVADO8,
      this.rESERVADO9,
      this.rESERVADO10,
      this.rESERVADO11,
      this.rESERVADO12,
      this.rESERVADO13,
      this.rESERVADO14,
      this.rESERVADO15,
      this.rESERVADO16,
      this.iNTR,
      this.oPERADOR,
      this.dATAALTER,
      this.hORAALTER,
      this.tIMESTAMP,
      this.vERSION});

  PedidoItem.fromJson(Map<String, dynamic> json) {
    eMPRESA = json['EMPRESA'];
    fILIAL = json['FILIAL'];
    nUMEROSFA = json['NUMERO_SFA'];
    sEQUENCIA = json['SEQUENCIA'];
    cPRODPALM = json['C_PROD_PALM'];
    qTDE = json['QTDE'];
    lIVRE = json['LIVRE'];
    vLRUNIT = json['VLR_UNIT'];
    vLRTOTAL = json['VLR_TOTAL'];
    dTENTREGA = json['DT_ENTREGA'];
    uNIDADE = json['UNIDADE'];
    tES = json['TES'];
    lOCAL = json['LOCAL'];
    pORCDESC = json['PORC_DESC'];
    vLRICMS = json['VLR_ICMS'];
    vLRIPI = json['VLR_IPI'];
    gRUPO = json['GRUPO'];
    nROLISTA = json['NRO_LISTA'];
    uNIDALT = json['UNID_ALT'];
    qTDEALT = json['QTDE_ALT'];
    rESERVADO1 = json['RESERVADO1'];
    rESERVADO2 = json['RESERVADO2'];
    rESERVADO3 = json['RESERVADO3'];
    rESERVADO4 = json['RESERVADO4'];
    rESERVADO5 = json['RESERVADO5'];
    rESERVADO6 = json['RESERVADO6'];
    rESERVADO7 = json['RESERVADO7'];
    rESERVADO8 = json['RESERVADO8'];
    rESERVADO9 = json['RESERVADO9'];
    rESERVADO10 = json['RESERVADO10'];
    rESERVADO11 = json['RESERVADO11'];
    rESERVADO12 = json['RESERVADO12'];
    rESERVADO13 = json['RESERVADO13'];
    rESERVADO14 = json['RESERVADO14'];
    rESERVADO15 = json['RESERVADO15'];
    rESERVADO16 = json['RESERVADO16'];
    iNTR = json['INTR'];
    oPERADOR = json['OPERADOR'];
    dATAALTER = json['DATA_ALTER'];
    hORAALTER = json['HORA_ALTER'];
    tIMESTAMP = json['TIME_STAMP'];
    vERSION = json['VERSION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMPRESA'] = this.eMPRESA;
    data['FILIAL'] = this.fILIAL;
    data['NUMERO_SFA'] = this.nUMEROSFA;
    data['SEQUENCIA'] = this.sEQUENCIA;
    data['C_PROD_PALM'] = this.cPRODPALM;
    data['COD_BARRA'] = this.cODBARRA;
    data['IMAGE'] = this.iMAGE;
    data['PESO'] = this.pESO;
    data['DESCRICAO'] = this.dESCRICAO;
    data['QTDE'] = this.qTDE;
    data['LIVRE'] = this.lIVRE;
    data['VLR_UNIT'] = this.vLRUNIT;
    data['VLR_TOTAL'] = this.vLRTOTAL;
    data['DT_ENTREGA'] = this.dTENTREGA;
    data['UNIDADE'] = this.uNIDADE;
    data['TES'] = this.tES;
    data['LOCAL'] = this.lOCAL;
    data['PORC_DESC'] = this.pORCDESC;
    data['VLR_ICMS'] = this.vLRICMS;
    data['VLR_IPI'] = this.vLRIPI;
    data['GRUPO'] = this.gRUPO;
    data['NRO_LISTA'] = this.nROLISTA;
    data['UNID_ALT'] = this.uNIDALT;
    data['QTDE_ALT'] = this.qTDEALT;
    data['RESERVADO1'] = this.rESERVADO1;
    data['RESERVADO2'] = this.rESERVADO2;
    data['RESERVADO3'] = this.rESERVADO3;
    data['RESERVADO4'] = this.rESERVADO4;
    data['RESERVADO5'] = this.rESERVADO5;
    data['RESERVADO6'] = this.rESERVADO6;
    data['RESERVADO7'] = this.rESERVADO7;
    data['RESERVADO8'] = this.rESERVADO8;
    data['RESERVADO9'] = this.rESERVADO9;
    data['RESERVADO10'] = this.rESERVADO10;
    data['RESERVADO11'] = this.rESERVADO11;
    data['RESERVADO12'] = this.rESERVADO12;
    data['RESERVADO13'] = this.rESERVADO13;
    data['RESERVADO14'] = this.rESERVADO14;
    data['RESERVADO15'] = this.rESERVADO15;
    data['RESERVADO16'] = this.rESERVADO16;
    data['INTR'] = this.iNTR;
    data['OPERADOR'] = this.oPERADOR;
    data['DATA_ALTER'] = this.dATAALTER;
    data['HORA_ALTER'] = this.hORAALTER;
    data['TIME_STAMP'] = this.tIMESTAMP;
    data['VERSION'] = this.vERSION;
    return data;
  }
}
