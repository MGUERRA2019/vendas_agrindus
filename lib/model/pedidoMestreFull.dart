class PedidoMestreFull {
  String nUMEROSFA;
  DateTime dTPED;
  String cLIENTE;
  String vLRPED;
  String cARGATOTAL;

  PedidoMestreFull(
      {this.nUMEROSFA, this.dTPED, this.cLIENTE, this.vLRPED, this.cARGATOTAL});

  PedidoMestreFull.fromJson(Map<String, dynamic> json) {
    nUMEROSFA = json['NUMERO_SFA'];
    dTPED = DateTime.tryParse(json['DT_PED']);
    cLIENTE = json['CLIENTE'];
    vLRPED = json['VLR_PED'];
    cARGATOTAL = json['CARGA_TOTAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NUMERO_SFA'] = this.nUMEROSFA;
    data['DT_PED'] = this.dTPED;
    data['CLIENTE'] = this.cLIENTE;
    data['VLR_PED'] = this.vLRPED;
    data['CARGA_TOTAL'] = this.cARGATOTAL;
    return data;
  }
}
