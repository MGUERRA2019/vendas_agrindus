class Vendedor {
  int eMPRESA;
  int fILIAL;
  String vENDEDOR;
  String fILIALALFA;
  String nOMECONH;
  String pORCCOMISSAO;
  String sALDO;
  String sENHA;
  String mENS1;
  String mENS2;
  int sTATUS;
  String pEDIDOINI;
  String pEDIDOFIM;
  String pROXIMOPED;
  String cLIENTEINI;
  String cLIENTEFIM;
  String pROXIMOCLI;
  String tRATALIMITE;
  String aSSINAPED;
  String tITULOLIVRE;
  String tIPOLIVRE;
  String tAMLIVRE;
  String dECLIVRE;
  String lOGNUM;
  String lOGSTAT;
  String eMPROCESSO;
  String iNTR;
  String rESERVADO1;
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
  String oPERADOR;
  String dATAALTER;
  String hORAALTER;
  String tIMESTAMP;
  int vERSION;

  Vendedor(
      {this.eMPRESA,
        this.fILIAL,
        this.vENDEDOR,
        this.fILIALALFA,
        this.nOMECONH,
        this.pORCCOMISSAO,
        this.sALDO,
        this.sENHA,
        this.mENS1,
        this.mENS2,
        this.sTATUS,
        this.pEDIDOINI,
        this.pEDIDOFIM,
        this.pROXIMOPED,
        this.cLIENTEINI,
        this.cLIENTEFIM,
        this.pROXIMOCLI,
        this.tRATALIMITE,
        this.aSSINAPED,
        this.tITULOLIVRE,
        this.tIPOLIVRE,
        this.tAMLIVRE,
        this.dECLIVRE,
        this.lOGNUM,
        this.lOGSTAT,
        this.eMPROCESSO,
        this.iNTR,
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
        this.oPERADOR,
        this.dATAALTER,
        this.hORAALTER,
        this.tIMESTAMP,
        this.vERSION});

  Vendedor.fromJson(Map<String, dynamic> json) {
    eMPRESA = json['EMPRESA'];
    fILIAL = json['FILIAL'];
    vENDEDOR = json['VENDEDOR'];
    fILIALALFA = json['FILIAL_ALFA'];
    nOMECONH = json['NOME_CONH'];
    pORCCOMISSAO = json['PORC_COMISSAO'];
    sALDO = json['SALDO'];
    sENHA = json['SENHA'];
    mENS1 = json['MENS1'];
    mENS2 = json['MENS2'];
    sTATUS = json['STATUS'];
    pEDIDOINI = json['PEDIDO_INI'];
    pEDIDOFIM = json['PEDIDO_FIM'];
    pROXIMOPED = json['PROXIMO_PED'];
    cLIENTEINI = json['CLIENTE_INI'];
    cLIENTEFIM = json['CLIENTE_FIM'];
    pROXIMOCLI = json['PROXIMO_CLI'];
    tRATALIMITE = json['TRATA_LIMITE'];
    aSSINAPED = json['ASSINA_PED'];
    tITULOLIVRE = json['TITULO_LIVRE'];
    tIPOLIVRE = json['TIPO_LIVRE'];
    tAMLIVRE = json['TAM_LIVRE'];
    dECLIVRE = json['DEC_LIVRE'];
    lOGNUM = json['LOG_NUM'];
    lOGSTAT = json['LOG_STAT'];
    eMPROCESSO = json['EM_PROCESSO'];
    iNTR = json['INTR'];
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
    data['VENDEDOR'] = this.vENDEDOR;
    data['FILIAL_ALFA'] = this.fILIALALFA;
    data['NOME_CONH'] = this.nOMECONH;
    data['PORC_COMISSAO'] = this.pORCCOMISSAO;
    data['SALDO'] = this.sALDO;
    data['SENHA'] = this.sENHA;
    data['MENS1'] = this.mENS1;
    data['MENS2'] = this.mENS2;
    data['STATUS'] = this.sTATUS;
    data['PEDIDO_INI'] = this.pEDIDOINI;
    data['PEDIDO_FIM'] = this.pEDIDOFIM;
    data['PROXIMO_PED'] = this.pROXIMOPED;
    data['CLIENTE_INI'] = this.cLIENTEINI;
    data['CLIENTE_FIM'] = this.cLIENTEFIM;
    data['PROXIMO_CLI'] = this.pROXIMOCLI;
    data['TRATA_LIMITE'] = this.tRATALIMITE;
    data['ASSINA_PED'] = this.aSSINAPED;
    data['TITULO_LIVRE'] = this.tITULOLIVRE;
    data['TIPO_LIVRE'] = this.tIPOLIVRE;
    data['TAM_LIVRE'] = this.tAMLIVRE;
    data['DEC_LIVRE'] = this.dECLIVRE;
    data['LOG_NUM'] = this.lOGNUM;
    data['LOG_STAT'] = this.lOGSTAT;
    data['EM_PROCESSO'] = this.eMPROCESSO;
    data['INTR'] = this.iNTR;
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
    data['OPERADOR'] = this.oPERADOR;
    data['DATA_ALTER'] = this.dATAALTER;
    data['HORA_ALTER'] = this.hORAALTER;
    data['TIME_STAMP'] = this.tIMESTAMP;
    data['VERSION'] = this.vERSION;
    return data;
  }
}
