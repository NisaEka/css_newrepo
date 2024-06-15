class RequestPickupModel {

  String _awb =  "";
  String get awb => _awb;

  String _name = "";
  String get name => _name;

  String _transactionType = "";
  String get transactionType => _transactionType;

  String _transactionService = "";
  String get transactionService => _transactionService;

  String _transactionDate = "";
  String get transactionDate => _transactionDate;

  String _status = "";
  String get status => _status;

  RequestPickupModel({
    String awb = "",
    String name = "",
    String transactionType = "",
    String transactionService = "",
    String transactionDate = "",
    String status = ""
  }) {
    _awb = awb;
    _name = name;
    _transactionType = transactionType;
    _transactionService = transactionService;
    _transactionDate = transactionDate;
    _status = status;
  }

  List<RequestPickupModel> getExamples() {
    final List<RequestPickupModel> dataList = [];

    dataList.add(RequestPickupModel(
      awb: "CSS20240614123401",
      name: "Arjun",
      transactionType: "COD",
      transactionService: "REG",
      transactionDate: "14 Jun 2024 12:34",
      status: "Dijemput"
    ));

    dataList.add(RequestPickupModel(
        awb: "CSS20240614123402",
        name: "Arkahan",
        transactionType: "COD",
        transactionService: "REG",
        transactionDate: "14 Jun 2024 12:34",
        status: "Dijemput"
    ));

    dataList.add(RequestPickupModel(
        awb: "CSS20240614123403",
        name: "Ananda",
        transactionType: "NON COD",
        transactionService: "SS",
        transactionDate: "14 Jun 2024 12:34",
        status: "Belum Dijemput"
    ));

    dataList.add(RequestPickupModel(
        awb: "CSS20240614123404",
        name: "Gifhar",
        transactionType: "NON COD",
        transactionService: "YES",
        transactionDate: "14 Jun 2024 12:34",
        status: "Belum Dijemput"
    ));

    dataList.add(RequestPickupModel(
        awb: "CSS20240614123405",
        name: "Ucup",
        transactionType: "COD",
        transactionService: "JTR",
        transactionDate: "14 Jun 2024 12:34",
        status: "Belum Dijemput"
    ));

    return dataList;
  }

}