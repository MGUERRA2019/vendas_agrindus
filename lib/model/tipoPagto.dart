class TipoPagto {
  String eMISSOES;
  String dESCRICAO;
  String iNTR;
  String vERSION;

  TipoPagto({this.eMISSOES, this.dESCRICAO, this.iNTR, this.vERSION});

  TipoPagto.fromJson(Map<String, dynamic> json) {
    eMISSOES = json['EMISSOES'];
    dESCRICAO = json['DESCRICAO'];
    iNTR = json['INTR'];
    vERSION = json['VERSION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMISSOES'] = this.eMISSOES;
    data['DESCRICAO'] = this.dESCRICAO;
    data['INTR'] = this.iNTR;
    data['VERSION'] = this.vERSION;
    return data;
  }
}
