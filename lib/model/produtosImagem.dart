class ProdutoImagem {
  String cODIGO;
  String dESCRICAO;
  String uRL;

  ProdutoImagem({this.cODIGO, this.dESCRICAO, this.uRL});

  ProdutoImagem.fromJson(Map<String, dynamic> json) {
    cODIGO = json['CODIGO'];
    dESCRICAO = json['DESCRICAO'];
    uRL = json['URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CODIGO'] = this.cODIGO;
    data['DESCRICAO'] = this.dESCRICAO;
    data['URL'] = this.uRL;
    return data;
  }
}
