class DashboardKirimanKamuModel {
  int totalKiriman;
  List<num> lineChart;
  int totalCod;
  num codAmount;
  int totalCodOngkir;
  num codOngkirAmount;
  int totalNonCod;
  num ongkirNonCodAmount;
  int onProcess;
  num onProcessPercentage;
  int suksesDiterima;
  num suksesDiterimaPercentage;
  int totalCancel;

  DashboardKirimanKamuModel({
    this.totalKiriman = 0,
    List<num>? pantauChart,
    this.totalCod = 0,
    this.codAmount = 0,
    this.totalCodOngkir = 0,
    this.codOngkirAmount = 0,
    this.totalNonCod = 0,
    this.ongkirNonCodAmount = 0,
    this.onProcess = 0,
    this.onProcessPercentage = 0,
    this.suksesDiterima = 0,
    this.suksesDiterimaPercentage = 0,
    this.totalCancel = 0,
  }) : lineChart = pantauChart ?? [];

  // Example: Method to update percentages safely
  void calculatePercentages() {
    onProcessPercentage = totalKiriman > 0 ? onProcess / totalKiriman * 100 : 0;
    suksesDiterimaPercentage =
        totalKiriman > 0 ? suksesDiterima / totalKiriman * 100 : 0;
  }
}
