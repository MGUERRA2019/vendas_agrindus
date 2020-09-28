class CondPagto {
  String cONDPAGTO;
  String dESCRICAO;
  int cPINTELIGENTE;
  String nROLISTA;
  int fORMAPAGTO;
  int dIASADICENTR;
  int uSADIASADIC;
  String tIPOPAGTO;
  int uSATIPOPAGTO;
  String cODTES;
  int uSATES;
  int vLRMINPED;
  String uSADESC;
  String iNTR;
  String vERSION;

  CondPagto(
      {this.cONDPAGTO,
        this.dESCRICAO,
        this.cPINTELIGENTE,
        this.nROLISTA,
        this.fORMAPAGTO,
        this.dIASADICENTR,
        this.uSADIASADIC,
        this.tIPOPAGTO,
        this.uSATIPOPAGTO,
        this.cODTES,
        this.uSATES,
        this.vLRMINPED,
        this.uSADESC,
        this.iNTR,
        this.vERSION});

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
