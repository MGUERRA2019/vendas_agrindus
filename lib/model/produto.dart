class Produto {
  String cPRODPALM;
  String dESCRICAO;
  String uNIDADE;
  int pORCICM;
  int pORCIPI;
  String pESOBRUTO;
  String qDTEPEMBAL;
  String pRAZOENTREGA;
  String pORCCOMISSAO;
  String cODBARRA;
  int rESERVADO8;
  String pOSICAOESTQ;
  String pRECOVENDA;
  int rESERVADO3;
  int rESERVADO4;
  String rESERVADO9;
  String rESERVADO10;
  String fATORUNI;
  int rESERVADO7;
  String iNTR;
  String vERSION;
  String gRUPO;
  String gRUPODESC;
  double pRECO;
  String iMAGEMURL;
  String dESCEXTENSO;

  Produto(
      {this.cPRODPALM,
      this.dESCRICAO,
      this.uNIDADE,
      this.pORCICM,
      this.pORCIPI,
      this.pESOBRUTO,
      this.qDTEPEMBAL,
      this.pRAZOENTREGA,
      this.pORCCOMISSAO,
      this.cODBARRA,
      this.rESERVADO8,
      this.pOSICAOESTQ,
      this.pRECOVENDA,
      this.rESERVADO3,
      this.rESERVADO4,
      this.rESERVADO9,
      this.rESERVADO10,
      this.fATORUNI,
      this.rESERVADO7,
      this.iNTR,
      this.vERSION,
      this.gRUPO});

  Produto.fromJson(Map<String, dynamic> json) {
    cPRODPALM = json['C_PROD_PALM'];
    dESCRICAO = json['DESCRICAO'];
    uNIDADE = json['UNIDADE'];
    pORCICM = json['PORC_ICM'];
    pORCIPI = json['PORC_IPI'];
    pESOBRUTO = json['PESO_BRUTO'];
    qDTEPEMBAL = json['QDTE_P_EMBAL'];
    pRAZOENTREGA = json['PRAZO_ENTREGA'];
    pORCCOMISSAO = json['PORC_COMISSAO'];
    cODBARRA = json['COD_BARRA'];
    rESERVADO8 = json['RESERVADO8'];
    pOSICAOESTQ = json['POSICAO_ESTQ'];
    pRECOVENDA = json['PRECO_VENDA'];
    rESERVADO3 = json['RESERVADO3'];
    rESERVADO4 = json['RESERVADO4'];
    rESERVADO9 = json['RESERVADO9'];
    rESERVADO10 = json['RESERVADO10'];
    fATORUNI = json['FATOR_UNI'];
    rESERVADO7 = json['RESERVADO7'];
    iNTR = json['INTR'];
    vERSION = json['VERSION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['C_PROD_PALM'] = this.cPRODPALM;
    data['DESCRICAO'] = this.dESCRICAO;
    data['UNIDADE'] = this.uNIDADE;
    data['PORC_ICM'] = this.pORCICM;
    data['PORC_IPI'] = this.pORCIPI;
    data['PESO_BRUTO'] = this.pESOBRUTO;
    data['QDTE_P_EMBAL'] = this.qDTEPEMBAL;
    data['PRAZO_ENTREGA'] = this.pRAZOENTREGA;
    data['PORC_COMISSAO'] = this.pORCCOMISSAO;
    data['COD_BARRA'] = this.cODBARRA;
    data['RESERVADO8'] = this.rESERVADO8;
    data['POSICAO_ESTQ'] = this.pOSICAOESTQ;
    data['PRECO_VENDA'] = this.pRECOVENDA;
    data['RESERVADO3'] = this.rESERVADO3;
    data['RESERVADO4'] = this.rESERVADO4;
    data['RESERVADO9'] = this.rESERVADO9;
    data['RESERVADO10'] = this.rESERVADO10;
    data['FATOR_UNI'] = this.fATORUNI;
    data['RESERVADO7'] = this.rESERVADO7;
    data['INTR'] = this.iNTR;
    data['VERSION'] = this.vERSION;
    return data;
  }
}
