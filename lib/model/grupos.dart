class Grupos {
  String gRUPO;
  String dESCRICAO;
  String iNTR;
  String vERSION;

  Grupos({this.gRUPO, this.dESCRICAO, this.iNTR, this.vERSION});

  Grupos.fromJson(Map<String, dynamic> json) {
    gRUPO = json['GRUPO'];
    dESCRICAO = json['DESCRICAO'];
    iNTR = json['INTR'];
    vERSION = json['VERSION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GRUPO'] = this.gRUPO;
    data['DESCRICAO'] = this.dESCRICAO;
    data['INTR'] = this.iNTR;
    data['VERSION'] = this.vERSION;
    return data;
  }
}
