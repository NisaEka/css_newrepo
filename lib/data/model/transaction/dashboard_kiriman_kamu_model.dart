class DashboardKirimanKamuModel {
  int totalPantau;
  List<num> pantauChart;
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
    this.totalPantau = 0,
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
  }) : pantauChart = pantauChart ?? [];

  // Example: Method to update percentages safely
  void calculatePercentages() {
    onProcessPercentage = totalPantau > 0 ? onProcess / totalPantau * 100 : 0;
    suksesDiterimaPercentage =
        totalPantau > 0 ? suksesDiterima / totalPantau * 100 : 0;
  }
}
