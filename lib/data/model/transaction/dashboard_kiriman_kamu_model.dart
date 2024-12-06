class DashboardKirimanKamuModel {
  int totalPantau;
  List<num> pantauChart;
  int totalCod;
  num codAmount;
  int totalCodOngkir;
  num codOngkirAmount;
  int totalNonCod;
  num ongkirNonCodAmount;
  int dalamPeninjauan;
  num dalamPeninjauanPercentage;
  int suksesDiterima;
  num suksesDiterimaPercentage;

  DashboardKirimanKamuModel({
    this.totalPantau = 0,
    List<num>? pantauChart,
    this.totalCod = 0,
    this.codAmount = 0,
    this.totalCodOngkir = 0,
    this.codOngkirAmount = 0,
    this.totalNonCod = 0,
    this.ongkirNonCodAmount = 0,
    this.dalamPeninjauan = 0,
    this.dalamPeninjauanPercentage = 0,
    this.suksesDiterima = 0,
    this.suksesDiterimaPercentage = 0,
  }) : pantauChart = pantauChart ?? [];

  // Example: Method to update percentages safely
  void calculatePercentages() {
    dalamPeninjauanPercentage =
        totalPantau > 0 ? dalamPeninjauan / totalPantau * 100 : 0;
    suksesDiterimaPercentage =
        totalPantau > 0 ? suksesDiterima / totalPantau * 100 : 0;
  }
}
