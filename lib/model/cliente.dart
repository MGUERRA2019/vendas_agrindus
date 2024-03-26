import 'package:vendasagrindus/model/condPagto.dart';
import 'package:vendasagrindus/model/tipoMovimento.dart';
import '../utilities/string_utils.dart';

class Cliente {
  int eMPRESA = 0;
  int fILIAL = 0;
  String vENDEDOR = stringEmpty;
  String cLIENTE = stringEmpty;
  String cLIENTEALFA = stringEmpty;
  String fILIALALFA = stringEmpty;
  String lOJA = stringEmpty;
  String rAZSOCIAL = stringEmpty;
  String nOMFANTASIA = stringEmpty;
  String eNDERECO = stringEmpty;
  String cIDADE = stringEmpty;
  String eSTADO = stringEmpty;
  String bAIRRO = stringEmpty;
  String cEP = stringEmpty;
  String tELEFONE = stringEmpty;
  String tELEFAX = stringEmpty;
  String fISJURID = stringEmpty;
  String cGCCPF = stringEmpty;
  String iNSCRESTAD = stringEmpty;
  String iNSCRMUNIC = stringEmpty;
  String tIPOCLI = stringEmpty;
  TipoMovimento tIPOMOVIMENTO;
  String tERR1 = stringEmpty;
  String cONDPAGTO = stringEmpty;
  CondPagto cONDPAGTOobj = CondPagto();
  int dESCONTO = 0;
  int pRIORIDADE = 0;
  int rISCO = 0;
  int lMCREDITO = 0;
  String dTVENCTOLM = stringEmpty;
  int cLASSE = 0;
  String vLRMACOM = stringEmpty;
  int mDATRASO = 0;
  String vRMAACUM = stringEmpty;
  String nROCOMPRAS = stringEmpty;
  String dTPRCOMP = stringEmpty;
  String dTULTCOMP = stringEmpty;
  String dTULTVISITA = stringEmpty;
  int qTDUPPG = 0;
  String sDATUAL = stringEmpty;
  String sDCARTPDLIB = stringEmpty;
  String sDCARTPD = stringEmpty;
  int vLRATRASOS = 0;
  String vLRACUMVE = stringEmpty;
  int qTDPPGCART = 0;
  String dTULTDEV = stringEmpty;
  int qTCHEQDV = 0;
  String dTCHDEV = stringEmpty;
  int mAATR = 0;
  String vLRMAFAT = stringEmpty;
  int nROPGATR = 0;
  String rG = stringEmpty;
  String dTNASC = stringEmpty;
  String eMAIL = stringEmpty;
  int tPOCONSULT = 0;
  String fLAGCLIENTE = stringEmpty;
  int fLAGCONDPGTO = 0;
  String rESERVADO1 = stringEmpty;
  String rESERVADO2 = stringEmpty;
  String rESERVADO3 = stringEmpty;
  String rESERVADO4 = stringEmpty;
  String rESERVADO5 = stringEmpty;
  String rESERVADO6 = stringEmpty;
  String rESERVADO7 = stringEmpty;
  String rESERVADO8 = stringEmpty;
  String rESERVADO9 = stringEmpty;
  String rESERVADO10 = stringEmpty;
  String rESERVADO11 = stringEmpty;
  String rESERVADO12 = stringEmpty;
  String rESERVADO13 = stringEmpty;
  String rESERVADO14 = stringEmpty;
  String rESERVADO15 = stringEmpty;
  String rESERVADO16 = stringEmpty;
  String iNTR = stringEmpty;
  String oPERADOR = stringEmpty;
  String dATAALTER = stringEmpty;
  String hORAALTER = stringEmpty;
  String tIMESTAMP = stringEmpty;
  int vERSION = 0;

  Cliente(
      this.eMPRESA,
      this.fILIAL,
      this.vENDEDOR,
      this.cLIENTE,
      this.cLIENTEALFA,
      this.fILIALALFA,
      this.lOJA,
      this.rAZSOCIAL,
      this.nOMFANTASIA,
      this.eNDERECO,
      this.cIDADE,
      this.eSTADO,
      this.bAIRRO,
      this.cEP,
      this.tELEFONE,
      this.tELEFAX,
      this.fISJURID,
      this.cGCCPF,
      this.iNSCRESTAD,
      this.iNSCRMUNIC,
      this.tIPOCLI,
      this.tERR1,
      this.cONDPAGTO,
      this.dESCONTO,
      this.pRIORIDADE,
      this.rISCO,
      this.lMCREDITO,
      this.dTVENCTOLM,
      this.cLASSE,
      this.vLRMACOM,
      this.mDATRASO,
      this.vRMAACUM,
      this.nROCOMPRAS,
      this.dTPRCOMP,
      this.dTULTCOMP,
      this.dTULTVISITA,
      this.qTDUPPG,
      this.sDATUAL,
      this.sDCARTPDLIB,
      this.sDCARTPD,
      this.vLRATRASOS,
      this.vLRACUMVE,
      this.qTDPPGCART,
      this.dTULTDEV,
      this.qTCHEQDV,
      this.dTCHDEV,
      this.mAATR,
      this.vLRMAFAT,
      this.nROPGATR,
      this.rG,
      this.dTNASC,
      this.eMAIL,
      this.tPOCONSULT,
      this.fLAGCLIENTE,
      this.fLAGCONDPGTO,
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
      this.vERSION);

  Cliente.fromJson(Map<String, dynamic> json) {
    eMPRESA = json['EMPRESA'];
    fILIAL = json['FILIAL'];
    vENDEDOR = json['VENDEDOR'];
    cLIENTE = json['CLIENTE'];
    //cLIENTEALFA = json['CLIENTE_ALFA'];
    // fILIALALFA = json['FILIAL_ALFA'];
    // lOJA = json['LOJA'];
    rAZSOCIAL = json['RAZ_SOCIAL'];
    nOMFANTASIA = json['NOM_FANTASIA'];
    eNDERECO = json['ENDERECO'];
    cIDADE = json['CIDADE'];
    eSTADO = json['ESTADO'];
    bAIRRO = json['BAIRRO'];
    cEP = json['CEP'];
    tELEFONE = json['TELEFONE'];
    // tELEFAX = json['TELEFAX'];
    // fISJURID = json['FIS_JURID'];
    cGCCPF = json['CGC_CPF'];
    iNSCRESTAD = json['INSCR_ESTAD'];
    // iNSCRMUNIC = json['INSCR_MUNIC'];
    tIPOCLI = json['TIPO_CLI'];
    // tERR1 = json['TERR_1'];
    cONDPAGTO = json['COND_PAGTO'];
    // dESCONTO = json['DESCONTO'];
    pRIORIDADE = json['PRIORIDADE'];
    rISCO =
        (json['RISCO'] is String) ? int.tryParse(json['RISCO']) : json['RISCO'];
    // // lMCREDITO = json['LM_CREDITO'];
    // // dTVENCTOLM = json['DT_VENCTO_LM'];
    // //  cLASSE = json['CLASSE'];
    // //  vLRMACOM = json['VLR_MA_COM'];
    // //  mDATRASO = json['MD_ATRASO'];
    // // vRMAACUM = json['VR_MA_ACUM'];
    // // nROCOMPRAS = json['NRO_COMPRAS'];
    dTPRCOMP = json['DT_PR_COMP'];
    dTULTCOMP = json['DT_ULT_COMP'];
    dTULTVISITA = json['DT_ULT_VISITA'];
    qTDUPPG = (json['QT_DUP_PG'] == "null") ? 0 : json['QT_DUP_PG'];
    sDATUAL = json['SD_ATUAL'];
    // // sDCARTPDLIB = json['SD_CART_PD_LIB'];
    // // sDCARTPD = json['SD_CART_PD'];
    vLRATRASOS = (json['VLR_ATRASOS'] == "null") ? 0 : json['VLR_ATRASOS'];
    vLRACUMVE = json['VLR_ACUM_VE'];
    // qTDPPGCART = json['QT_DP_PG_CART'];
    // dTULTDEV = json['DT_ULT_DEV'];
    //  qTCHEQDV = json['QT_CHEQ_DV'];
    // dTCHDEV = json['DT_CH_DEV'];
    // mAATR = json['MA_ATR'];
    vLRMAFAT = json['VLR_MA_FAT'];
    nROPGATR = (json['NRO_PG_ATR'] == "null") ? 0 : json['NRO_PG_ATR'];
    // // rG = json['RG'];
    // dTNASC = json['DT_NASC'];
    eMAIL = json['EMAIL'];
    // tPOCONSULT = json['TPO_CONSULT'];
    // fLAGCLIENTE = json['FLAG_CLIENTE'];
    // fLAGCONDPGTO = json['FLAG_COND_PGTO'];
    // rESERVADO1 = json['RESERVADO1'];
    // rESERVADO2 = json['RESERVADO2'];
    // rESERVADO3 = json['RESERVADO3'];
    // rESERVADO4 = json['RESERVADO4'];
    // rESERVADO5 = json['RESERVADO5'];
    // rESERVADO6 = json['RESERVADO6'];
    // rESERVADO7 = json['RESERVADO7'];
    // rESERVADO8 = json['RESERVADO8'];
    // rESERVADO9 = json['RESERVADO9'];
    // rESERVADO10 = json['RESERVADO10'];
    // rESERVADO11 = json['RESERVADO11'];
    // rESERVADO12 = json['RESERVADO12'];
    // rESERVADO13 = json['RESERVADO13'];
    // rESERVADO14 = json['RESERVADO14'];
    // rESERVADO15 = json['RESERVADO15'];
    // rESERVADO16 = json['RESERVADO16'];
    // iNTR = json['INTR'];
    // oPERADOR = json['OPERADOR'];
    // dATAALTER = json['DATA_ALTER'];
    // hORAALTER = json['HORA_ALTER'];
    // tIMESTAMP = json['TIME_STAMP'];
    // vERSION = json['VERSION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMPRESA'] = this.eMPRESA;
    data['FILIAL'] = this.fILIAL;
    data['VENDEDOR'] = this.vENDEDOR;
    data['CLIENTE'] = this.cLIENTE;
    data['CLIENTE_ALFA'] = this.cLIENTEALFA;
    data['FILIAL_ALFA'] = this.fILIALALFA;
    data['LOJA'] = this.lOJA;
    data['RAZ_SOCIAL'] = this.rAZSOCIAL;
    data['NOM_FANTASIA'] = this.nOMFANTASIA;
    data['ENDERECO'] = this.eNDERECO;
    data['CIDADE'] = this.cIDADE;
    data['ESTADO'] = this.eSTADO;
    data['BAIRRO'] = this.bAIRRO;
    data['CEP'] = this.cEP;
    data['TELEFONE'] = this.tELEFONE;
    data['TELEFAX'] = this.tELEFAX;
    data['FIS_JURID'] = this.fISJURID;
    data['CGC_CPF'] = this.cGCCPF;
    data['INSCR_ESTAD'] = this.iNSCRESTAD;
    data['INSCR_MUNIC'] = this.iNSCRMUNIC;
    data['TIPO_CLI'] = this.tIPOCLI;
    data['TERR_1'] = this.tERR1;
    data['COND_PAGTO'] = this.cONDPAGTO;
    data['DESCONTO'] = this.dESCONTO;
    data['PRIORIDADE'] = this.pRIORIDADE;
    data['RISCO'] = this.rISCO;
    data['LM_CREDITO'] = this.lMCREDITO;
    data['DT_VENCTO_LM'] = this.dTVENCTOLM;
    data['CLASSE'] = this.cLASSE;
    data['VLR_MA_COM'] = this.vLRMACOM;
    data['MD_ATRASO'] = this.mDATRASO;
    data['VR_MA_ACUM'] = this.vRMAACUM;
    data['NRO_COMPRAS'] = this.nROCOMPRAS;
    data['DT_PR_COMP'] = this.dTPRCOMP;
    data['DT_ULT_COMP'] = this.dTULTCOMP;
    data['DT_ULT_VISITA'] = this.dTULTVISITA;
    data['QT_DUP_PG'] = this.qTDUPPG;
    data['SD_ATUAL'] = this.sDATUAL;
    data['SD_CART_PD_LIB'] = this.sDCARTPDLIB;
    data['SD_CART_PD'] = this.sDCARTPD;
    data['VLR_ATRASOS'] = this.vLRATRASOS;
    data['VLR_ACUM_VE'] = this.vLRACUMVE;
    data['QT_DP_PG_CART'] = this.qTDPPGCART;
    data['DT_ULT_DEV'] = this.dTULTDEV;
    data['QT_CHEQ_DV'] = this.qTCHEQDV;
    data['DT_CH_DEV'] = this.dTCHDEV;
    data['MA_ATR'] = this.mAATR;
    data['VLR_MA_FAT'] = this.vLRMAFAT;
    data['NRO_PG_ATR'] = this.nROPGATR;
    data['RG'] = this.rG;
    data['DT_NASC'] = this.dTNASC;
    data['EMAIL'] = this.eMAIL;
    data['TPO_CONSULT'] = this.tPOCONSULT;
    data['FLAG_CLIENTE'] = this.fLAGCLIENTE;
    data['FLAG_COND_PGTO'] = this.fLAGCONDPGTO;
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
