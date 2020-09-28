class TipoMovimento {
  String tIPOCLI;
  String tIPOMOVTO;
  String dESCRICAO;
  int dTENT;
  String cONDPAGTO;
  String bLOQUEADO;
  String iNTR;
  String vERSION;

  TipoMovimento(
      {this.tIPOCLI,
        this.tIPOMOVTO,
        this.dESCRICAO,
        this.dTENT,
        this.cONDPAGTO,
        this.bLOQUEADO,
        this.iNTR,
        this.vERSION});

  TipoMovimento.fromJson(Map<String, dynamic> json) {
    tIPOCLI = json['TIPO_CLI'];
    tIPOMOVTO = json['TIPO_MOVTO'];
    dESCRICAO = json['DESCRICAO'];
    dTENT = json['DT_ENT'];
    cONDPAGTO = json['COND_PAGTO'];
    bLOQUEADO = json['BLOQUEADO'];
    iNTR = json['INTR'];
    vERSION = json['VERSION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TIPO_CLI'] = this.tIPOCLI;
    data['TIPO_MOVTO'] = this.tIPOMOVTO;
    data['DESCRICAO'] = this.dESCRICAO;
    data['DT_ENT'] = this.dTENT;
    data['COND_PAGTO'] = this.cONDPAGTO;
    data['BLOQUEADO'] = this.bLOQUEADO;
    data['INTR'] = this.iNTR;
    data['VERSION'] = this.vERSION;
    return data;
  }
}
