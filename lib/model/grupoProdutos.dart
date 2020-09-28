class GrupoProdutos {
  String cPRODPALM;
  String gRUPO;
  String iNTR;
  String vERSION;

  GrupoProdutos({this.cPRODPALM, this.gRUPO, this.iNTR, this.vERSION});

  GrupoProdutos.fromJson(Map<String, dynamic> json) {
    cPRODPALM = json['C_PROD_PALM'];
    gRUPO = json['GRUPO'];
    iNTR = json['INTR'];
    vERSION = json['VERSION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['C_PROD_PALM'] = this.cPRODPALM;
    data['GRUPO'] = this.gRUPO;
    data['INTR'] = this.iNTR;
    data['VERSION'] = this.vERSION;
    return data;
  }
}
