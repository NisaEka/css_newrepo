import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_detail_model.dart';

class TransactionModel {
  TransactionModel({
    String? awb,
    String? taxValue,
    String? itemType,
    String? hsCode,
    String? npwp,
    String? lastUpdate,
    String? awbType,
    String? registrationId,
    num? deliveryPrice,
    num? insuranceAmount,
    String? destinationDesc,
    String? originDesc,
    String? packingkayuFlag,
    String? goodsType,
    String? shipperAddr,
    String? receiverAddr,
    String? transactionId,
    String? tempId,
    String? dateMintaDijemput,
    String? pickupCity,
    String? serviceCode,
    String? shipperCity,
    String? pickupDate,
    String? pickupPicPhone,
    String? shipperZip,
    String? orderId,
    String? courierId,
    String? destinationCode,
    dynamic deliveryAmountPublish,
    String? statusName,
    String? specialIns,
    String? courierName,
    String? pickupVehicle,
    String? shipperContact,
    String? statusDesc,
    String? responseJob,
    String? receiverContact,
    String? pickupName,
    String? receiverAddr2,
    num? isRetail,
    String? responseLive,
    String? dateSerahTerima,
    num? apiStatus,
    String? codFlag,
    num? goodsAmount,
    String? receiverCity,
    String? branch,
    String? responsePickup,
    String? pickupDistrict,
    String? printFlag,
    String? receiverCountry,
    String? shipperAddr3,
    String? receiverName,
    String? shipperAddr2,
    String? lon,
    num? deliveryPricePublish,
    String? codOngkir,
    String? shipperAddr1,
    String? receiverDistrict,
    String? pickupAddress,
    String? pickupTime,
    String? shipperCountry,
    num? insuranceAdm,
    String? shipperName,
    String? petugasEntry,
    num? codAmount,
    String? receiverSubdistrict,
    String? receiverAddr3,
    String? receiverAddr1,
    String? shipperPhone,
    String? merchantId,
    String? apiType,
    String? receiverZip,
    String? pickupService,
    num? qty,
    String? idSerahTerima,
    num? weight,
    String? noSerahTerima,
    String? receiverPhone,
    String? timeSerahTerima,
    String? custId,
    String? insuranceFlag,
    String? goodsDesc,
    num? ammountDelivery,
    String? type,
    String? createdDateSearch,
    String? originCode,
    String? lat,
    String? shipperRegion,
    String? pickupPic,
    String? createdDate,
    String? receiverRegion,
    String? inputType,
    String? accountName,
    String? accountNumber,
    String? accountService,
    String? accountType,
    String? statusAwb,
    String? pickupStatus,
    TransAccountModel? account,
    PantauPaketmuDetailModel? transactionDetail,
    DestinationModel? destination,
  }) {
    _awb = awb;
    _taxValue = taxValue;
    _itemType = itemType;
    _hsCode = hsCode;
    _npwp = npwp;
    _lastUpdate = lastUpdate;
    _awbType = awbType;
    _registrationId = registrationId;
    _deliveryPrice = deliveryPrice;
    _insuranceAmount = insuranceAmount;
    _destinationDesc = destinationDesc;
    _originDesc = originDesc;
    _packingkayuFlag = packingkayuFlag;
    _goodsType = goodsType;
    _shipperAddr = shipperAddr;
    _receiverAddr = receiverAddr;
    _transactionId = transactionId;
    _tempId = tempId;
    _dateMintaDijemput = dateMintaDijemput;
    _pickupCity = pickupCity;
    _serviceCode = serviceCode;
    _shipperCity = shipperCity;
    _pickupDate = pickupDate;
    _pickupPicPhone = pickupPicPhone;
    _shipperZip = shipperZip;
    _orderId = orderId;
    _courierId = courierId;
    _destinationCode = destinationCode;
    _deliveryAmountPublish = deliveryAmountPublish;
    _statusName = statusName;
    _specialIns = specialIns;
    _courierName = courierName;
    _pickupVehicle = pickupVehicle;
    _shipperContact = shipperContact;
    _statusDesc = statusDesc;
    _responseJob = responseJob;
    _receiverContact = receiverContact;
    _pickupName = pickupName;
    _receiverAddr2 = receiverAddr2;
    _isRetail = isRetail;
    _responseLive = responseLive;
    _dateSerahTerima = dateSerahTerima;
    _apiStatus = apiStatus;
    _codFlag = codFlag;
    _goodsAmount = goodsAmount;
    _receiverCity = receiverCity;
    _branch = branch;
    _responsePickup = responsePickup;
    _pickupDistrict = pickupDistrict;
    _printFlag = printFlag;
    _receiverCountry = receiverCountry;
    _shipperAddr3 = shipperAddr3;
    _receiverName = receiverName;
    _shipperAddr2 = shipperAddr2;
    _lon = lon;
    _deliveryPricePublish = deliveryPricePublish;
    _codOngkir = codOngkir;
    _shipperAddr1 = shipperAddr1;
    _receiverDistrict = receiverDistrict;
    _pickupAddress = pickupAddress;
    _pickupTime = pickupTime;
    _shipperCountry = shipperCountry;
    _insuranceAdm = insuranceAdm;
    _shipperName = shipperName;
    _petugasEntry = petugasEntry;
    _codAmount = codAmount;
    _receiverSubdistrict = receiverSubdistrict;
    _receiverAddr3 = receiverAddr3;
    _receiverAddr1 = receiverAddr1;
    _shipperPhone = shipperPhone;
    _merchantId = merchantId;
    _apiType = apiType;
    _receiverZip = receiverZip;
    _pickupService = pickupService;
    _qty = qty;
    _idSerahTerima = idSerahTerima;
    _weight = weight;
    _noSerahTerima = noSerahTerima;
    _receiverPhone = receiverPhone;
    _timeSerahTerima = timeSerahTerima;
    _custId = custId;
    _insuranceFlag = insuranceFlag;
    _goodsDesc = goodsDesc;
    _ammountDelivery = ammountDelivery;
    _type = type;
    _createdDateSearch = createdDateSearch;
    _originCode = originCode;
    _lat = lat;
    _shipperRegion = shipperRegion;
    _pickupPic = pickupPic;
    _createdDate = createdDate;
    _receiverRegion = receiverRegion;
    _inputType = inputType;
    _accountName = accountName;
    _accountNumber = accountNumber;
    _accountService = accountService;
    _accountType = accountType;
    _statusAwb = statusAwb;
    _pickupStatus = pickupStatus;
    _account = account;
    _transactionDetail = transactionDetail;
    _destination = destination;
  }

  TransactionModel.fromJson(dynamic json) {
    _awb = json['awb'];
    _taxValue = json['taxValue'];
    _itemType = json['itemType'];
    _hsCode = json['hsCode'];
    _npwp = json['npwp'];
    _lastUpdate = json['lastUpdate'];
    _awbType = json['awbType'];
    _registrationId = json['registrationId'];
    _deliveryPrice = json['deliveryPrice'];
    _insuranceAmount = json['insuranceAmount'];
    _destinationDesc = json['destinationDesc'];
    _originDesc = json['originDesc'];
    _packingkayuFlag = json['packingkayuFlag'];
    _goodsType = json['goodsType'];
    _shipperAddr = json['shipperAddr'];
    _receiverAddr = json['receiverAddr'];
    _transactionId = json['transactionId'];
    _tempId = json['tempId'];
    _dateMintaDijemput = json['dateMintaDijemput'];
    _pickupCity = json['pickupCity'];
    _serviceCode = json['serviceCode'];
    _shipperCity = json['shipperCity'];
    _pickupDate = json['pickupDate'];
    _pickupPicPhone = json['pickupPicPhone'];
    _shipperZip = json['shipperZip'];
    _orderId = json['orderId'];
    _courierId = json['courierId'];
    _destinationCode = json['destinationCode'];
    _deliveryAmountPublish = json['deliveryAmountPublish'];
    _statusName = json['statusName'];
    _specialIns = json['specialIns'];
    _courierName = json['courierName'];
    _pickupVehicle = json['pickupVehicle'];
    _shipperContact = json['shipperContact'];
    _statusDesc = json['statusDesc'];
    _responseJob = json['responseJob'];
    _receiverContact = json['receiverContact'];
    _pickupName = json['pickupName'];
    _receiverAddr2 = json['receiverAddr2'];
    _isRetail = json['isRetail'];
    _responseLive = json['responseLive'];
    _dateSerahTerima = json['dateSerahTerima'];
    _apiStatus = json['apiStatus'];
    _codFlag = json['codFlag'];
    _goodsAmount = json['goodsAmount'];
    _receiverCity = json['receiverCity'];
    _branch = json['branch'];
    _responsePickup = json['responsePickup'];
    _pickupDistrict = json['pickupDistrict'];
    _printFlag = json['printFlag'];
    _receiverCountry = json['receiverCountry'];
    _shipperAddr3 = json['shipperAddr3'];
    _receiverName = json['receiverName'];
    _shipperAddr2 = json['shipperAddr2'];
    _lon = json['lon'];
    _deliveryPricePublish = json['deliveryPricePublish'];
    _codOngkir = json['codOngkir'];
    _shipperAddr1 = json['shipperAddr1'];
    _receiverDistrict = json['receiverDistrict'];
    _pickupAddress = json['pickupAddress'];
    _pickupTime = json['pickupTime'];
    _shipperCountry = json['shipperCountry'];
    _insuranceAdm = json['insuranceAdm'];
    _shipperName = json['shipperName'];
    _petugasEntry = json['petugasEntry'];
    _codAmount = json['codAmount'];
    _receiverSubdistrict = json['receiverSubdistrict'];
    _receiverAddr3 = json['receiverAddr3'];
    _receiverAddr1 = json['receiverAddr1'];
    _shipperPhone = json['shipperPhone'];
    _merchantId = json['merchantId'];
    _apiType = json['apiType'];
    _receiverZip = json['receiverZip'];
    _pickupService = json['pickupService'];
    _qty = json['qty'];
    _idSerahTerima = json['idSerahTerima'];
    _weight = json['weight'];
    _noSerahTerima = json['noSerahTerima'];
    _receiverPhone = json['receiverPhone'];
    _timeSerahTerima = json['timeSerahTerima'];
    _custId = json['custId'];
    _insuranceFlag = json['insuranceFlag'];
    _goodsDesc = json['goodsDesc'];
    _ammountDelivery = json['ammountDelivery'];
    _type = json['type'];
    _createdDateSearch = json['createdDateSearch'];
    _originCode = json['originCode'];
    _lat = json['lat'];
    _shipperRegion = json['shipperRegion'];
    _pickupPic = json['pickupPic'];
    _createdDate = json['createdDate'];
    _receiverRegion = json['receiverRegion'];
    _inputType = json['inputType'];
    _accountName = json['accountName'];
    _accountNumber = json['accountNumber'];
    _accountService = json['accountService'];
    _accountType = json['accountType'];
    _statusAwb = json['statusAwb'];
    _pickupStatus = json['pickupStatus'];
    _account = json['account'] != null
        ? TransAccountModel.fromJson(json['account'])
        : null;
    _transactionDetail != null
        ? PantauPaketmuDetailModel.fromJson(json['transactionDetail'])
        : null;
    _destination = json['destination'] != null
        ? DestinationModel.fromJson(json['destination'])
        : null;
  }

  String? _awb;
  String? _taxValue;
  String? _itemType;
  String? _hsCode;
  String? _npwp;
  String? _lastUpdate;
  String? _awbType;
  String? _registrationId;
  num? _deliveryPrice;
  num? _insuranceAmount;
  String? _destinationDesc;
  String? _originDesc;
  String? _packingkayuFlag;
  String? _goodsType;
  String? _shipperAddr;
  String? _receiverAddr;
  String? _transactionId;
  String? _tempId;
  String? _dateMintaDijemput;
  String? _pickupCity;
  String? _serviceCode;
  String? _shipperCity;
  String? _pickupDate;
  String? _pickupPicPhone;
  String? _shipperZip;
  String? _orderId;
  String? _courierId;
  String? _destinationCode;
  dynamic _deliveryAmountPublish;
  String? _statusName;
  String? _specialIns;
  String? _courierName;
  String? _pickupVehicle;
  String? _shipperContact;
  String? _statusDesc;
  String? _responseJob;
  String? _receiverContact;
  String? _pickupName;
  String? _receiverAddr2;
  num? _isRetail;
  String? _responseLive;
  String? _dateSerahTerima;
  num? _apiStatus;
  String? _codFlag;
  num? _goodsAmount;
  String? _receiverCity;
  String? _branch;
  String? _responsePickup;
  String? _pickupDistrict;
  String? _printFlag;
  String? _receiverCountry;
  String? _shipperAddr3;
  String? _receiverName;
  String? _shipperAddr2;
  String? _lon;
  num? _deliveryPricePublish;
  String? _codOngkir;
  String? _shipperAddr1;
  String? _receiverDistrict;
  String? _pickupAddress;
  String? _pickupTime;
  String? _shipperCountry;
  num? _insuranceAdm;
  String? _shipperName;
  String? _petugasEntry;
  num? _codAmount;
  String? _receiverSubdistrict;
  String? _receiverAddr3;
  String? _receiverAddr1;
  String? _shipperPhone;
  String? _merchantId;
  String? _apiType;
  String? _receiverZip;
  String? _pickupService;
  num? _qty;
  String? _idSerahTerima;
  num? _weight;
  String? _noSerahTerima;
  String? _receiverPhone;
  String? _timeSerahTerima;
  String? _custId;
  String? _insuranceFlag;
  String? _goodsDesc;
  num? _ammountDelivery;
  String? _type;
  String? _createdDateSearch;
  String? _originCode;
  String? _lat;
  String? _shipperRegion;
  String? _pickupPic;
  String? _createdDate;
  String? _receiverRegion;
  String? _inputType;
  String? _accountName;
  String? _accountNumber;
  String? _accountService;
  String? _accountType;
  String? _statusAwb;
  String? _pickupStatus;
  TransAccountModel? _account;
  PantauPaketmuDetailModel? _transactionDetail;
  DestinationModel? _destination;

  TransactionModel copyWith({
    String? awb,
    String? taxValue,
    String? itemType,
    String? hsCode,
    String? npwp,
    String? lastUpdate,
    String? awbType,
    String? registrationId,
    num? deliveryPrice,
    num? insuranceAmount,
    String? destinationDesc,
    String? originDesc,
    String? packingkayuFlag,
    String? goodsType,
    String? shipperAddr,
    String? receiverAddr,
    String? transactionId,
    String? tempId,
    String? dateMintaDijemput,
    String? pickupCity,
    String? serviceCode,
    String? shipperCity,
    String? pickupDate,
    String? pickupPicPhone,
    String? shipperZip,
    String? orderId,
    String? courierId,
    String? destinationCode,
    String? deliveryAmountPublish,
    String? statusName,
    String? specialIns,
    String? courierName,
    String? pickupVehicle,
    String? shipperContact,
    String? statusDesc,
    String? responseJob,
    String? receiverContact,
    String? pickupName,
    String? receiverAddr2,
    num? isRetail,
    String? responseLive,
    String? dateSerahTerima,
    num? apiStatus,
    String? codFlag,
    num? goodsAmount,
    String? receiverCity,
    String? branch,
    String? responsePickup,
    String? pickupDistrict,
    String? printFlag,
    String? receiverCountry,
    String? shipperAddr3,
    String? receiverName,
    String? shipperAddr2,
    String? lon,
    num? deliveryPricePublish,
    String? codOngkir,
    String? shipperAddr1,
    String? receiverDistrict,
    String? pickupAddress,
    String? pickupTime,
    String? shipperCountry,
    num? insuranceAdm,
    String? shipperName,
    String? petugasEntry,
    num? codAmount,
    String? receiverSubdistrict,
    String? receiverAddr3,
    String? receiverAddr1,
    String? shipperPhone,
    String? merchantId,
    String? apiType,
    String? receiverZip,
    String? pickupService,
    num? qty,
    String? idSerahTerima,
    num? weight,
    String? noSerahTerima,
    String? receiverPhone,
    String? timeSerahTerima,
    String? custId,
    String? insuranceFlag,
    String? goodsDesc,
    num? ammountDelivery,
    String? type,
    String? createdDateSearch,
    String? originCode,
    String? lat,
    String? shipperRegion,
    String? pickupPic,
    String? createdDate,
    String? receiverRegion,
    String? inputType,
    String? accountName,
    String? accountNumber,
    String? accountService,
    String? accountType,
    String? statusAwb,
    String? pickupStatus,
    TransAccountModel? account,
    PantauPaketmuDetailModel? transactionDetail,
    DestinationModel? destination,
  }) =>
      TransactionModel(
        awb: awb ?? _awb,
        taxValue: taxValue ?? _taxValue,
        itemType: itemType ?? _itemType,
        hsCode: hsCode ?? _hsCode,
        npwp: npwp ?? _npwp,
        lastUpdate: lastUpdate ?? _lastUpdate,
        awbType: awbType ?? _awbType,
        registrationId: registrationId ?? _registrationId,
        deliveryPrice: deliveryPrice ?? _deliveryPrice,
        insuranceAmount: insuranceAmount ?? _insuranceAmount,
        destinationDesc: destinationDesc ?? _destinationDesc,
        originDesc: originDesc ?? _originDesc,
        packingkayuFlag: packingkayuFlag ?? _packingkayuFlag,
        goodsType: goodsType ?? _goodsType,
        shipperAddr: shipperAddr ?? _shipperAddr,
        receiverAddr: receiverAddr ?? _receiverAddr,
        transactionId: transactionId ?? _transactionId,
        tempId: tempId ?? _tempId,
        dateMintaDijemput: dateMintaDijemput ?? _dateMintaDijemput,
        pickupCity: pickupCity ?? _pickupCity,
        serviceCode: serviceCode ?? _serviceCode,
        shipperCity: shipperCity ?? _shipperCity,
        pickupDate: pickupDate ?? _pickupDate,
        pickupPicPhone: pickupPicPhone ?? _pickupPicPhone,
        shipperZip: shipperZip ?? _shipperZip,
        orderId: orderId ?? _orderId,
        courierId: courierId ?? _courierId,
        destinationCode: destinationCode ?? _destinationCode,
        deliveryAmountPublish: deliveryAmountPublish ?? _deliveryAmountPublish,
        statusName: statusName ?? _statusName,
        specialIns: specialIns ?? _specialIns,
        courierName: courierName ?? _courierName,
        pickupVehicle: pickupVehicle ?? _pickupVehicle,
        shipperContact: shipperContact ?? _shipperContact,
        statusDesc: statusDesc ?? _statusDesc,
        responseJob: responseJob ?? _responseJob,
        receiverContact: receiverContact ?? _receiverContact,
        pickupName: pickupName ?? _pickupName,
        receiverAddr2: receiverAddr2 ?? _receiverAddr2,
        isRetail: isRetail ?? _isRetail,
        responseLive: responseLive ?? _responseLive,
        dateSerahTerima: dateSerahTerima ?? _dateSerahTerima,
        apiStatus: apiStatus ?? _apiStatus,
        codFlag: codFlag ?? _codFlag,
        goodsAmount: goodsAmount ?? _goodsAmount,
        receiverCity: receiverCity ?? _receiverCity,
        branch: branch ?? _branch,
        responsePickup: responsePickup ?? _responsePickup,
        pickupDistrict: pickupDistrict ?? _pickupDistrict,
        printFlag: printFlag ?? _printFlag,
        receiverCountry: receiverCountry ?? _receiverCountry,
        shipperAddr3: shipperAddr3 ?? _shipperAddr3,
        receiverName: receiverName ?? _receiverName,
        shipperAddr2: shipperAddr2 ?? _shipperAddr2,
        lon: lon ?? _lon,
        deliveryPricePublish: deliveryPricePublish ?? _deliveryPricePublish,
        codOngkir: codOngkir ?? _codOngkir,
        shipperAddr1: shipperAddr1 ?? _shipperAddr1,
        receiverDistrict: receiverDistrict ?? _receiverDistrict,
        pickupAddress: pickupAddress ?? _pickupAddress,
        pickupTime: pickupTime ?? _pickupTime,
        shipperCountry: shipperCountry ?? _shipperCountry,
        insuranceAdm: insuranceAdm ?? _insuranceAdm,
        shipperName: shipperName ?? _shipperName,
        petugasEntry: petugasEntry ?? _petugasEntry,
        codAmount: codAmount ?? _codAmount,
        receiverSubdistrict: receiverSubdistrict ?? _receiverSubdistrict,
        receiverAddr3: receiverAddr3 ?? _receiverAddr3,
        receiverAddr1: receiverAddr1 ?? _receiverAddr1,
        shipperPhone: shipperPhone ?? _shipperPhone,
        merchantId: merchantId ?? _merchantId,
        apiType: apiType ?? _apiType,
        receiverZip: receiverZip ?? _receiverZip,
        pickupService: pickupService ?? _pickupService,
        qty: qty ?? _qty,
        idSerahTerima: idSerahTerima ?? _idSerahTerima,
        weight: weight ?? _weight,
        noSerahTerima: noSerahTerima ?? _noSerahTerima,
        receiverPhone: receiverPhone ?? _receiverPhone,
        timeSerahTerima: timeSerahTerima ?? _timeSerahTerima,
        custId: custId ?? _custId,
        insuranceFlag: insuranceFlag ?? _insuranceFlag,
        goodsDesc: goodsDesc ?? _goodsDesc,
        ammountDelivery: ammountDelivery ?? _ammountDelivery,
        type: type ?? _type,
        createdDateSearch: createdDateSearch ?? _createdDateSearch,
        originCode: originCode ?? _originCode,
        lat: lat ?? _lat,
        shipperRegion: shipperRegion ?? _shipperRegion,
        pickupPic: pickupPic ?? _pickupPic,
        createdDate: createdDate ?? _createdDate,
        receiverRegion: receiverRegion ?? _receiverRegion,
        inputType: inputType ?? _inputType,
        accountName: accountName ?? _accountName,
        accountNumber: accountNumber ?? _accountNumber,
        accountService: accountService ?? _accountService,
        accountType: accountType ?? _accountType,
        statusAwb: statusAwb ?? _statusAwb,
        pickupStatus: pickupStatus ?? _pickupStatus,
        account: account ?? _account,
        destination: destination ?? _destination,
        transactionDetail: transactionDetail ?? _transactionDetail,
      );

  String? get awb => _awb;

  String? get taxValue => _taxValue;

  String? get itemType => _itemType;

  String? get hsCode => _hsCode;

  String? get npwp => _npwp;

  String? get lastUpdate => _lastUpdate;

  String? get awbType => _awbType;

  String? get registrationId => _registrationId;

  num? get deliveryPrice => _deliveryPrice;

  num? get insuranceAmount => _insuranceAmount;

  String? get destinationDesc => _destinationDesc;

  String? get originDesc => _originDesc;

  String? get packingkayuFlag => _packingkayuFlag;

  String? get goodsType => _goodsType;

  String? get shipperAddr => _shipperAddr;

  String? get receiverAddr => _receiverAddr;

  String? get transactionId => _transactionId;

  String? get tempId => _tempId;

  String? get dateMintaDijemput => _dateMintaDijemput;

  String? get pickupCity => _pickupCity;

  String? get serviceCode => _serviceCode;

  String? get shipperCity => _shipperCity;

  String? get pickupDate => _pickupDate;

  String? get pickupPicPhone => _pickupPicPhone;

  String? get shipperZip => _shipperZip;

  String? get orderId => _orderId;

  String? get courierId => _courierId;

  String? get destinationCode => _destinationCode;

  String? get deliveryAmountPublish => _deliveryAmountPublish;

  String? get statusName => _statusName;

  String? get specialIns => _specialIns;

  String? get courierName => _courierName;

  String? get pickupVehicle => _pickupVehicle;

  String? get shipperContact => _shipperContact;

  String? get statusDesc => _statusDesc;

  String? get responseJob => _responseJob;

  String? get receiverContact => _receiverContact;

  String? get pickupName => _pickupName;

  String? get receiverAddr2 => _receiverAddr2;

  num? get isRetail => _isRetail;

  String? get responseLive => _responseLive;

  String? get dateSerahTerima => _dateSerahTerima;

  num? get apiStatus => _apiStatus;

  String? get codFlag => _codFlag;

  num? get goodsAmount => _goodsAmount;

  String? get receiverCity => _receiverCity;

  String? get branch => _branch;

  String? get responsePickup => _responsePickup;

  String? get pickupDistrict => _pickupDistrict;

  String? get printFlag => _printFlag;

  String? get receiverCountry => _receiverCountry;

  String? get shipperAddr3 => _shipperAddr3;

  String? get receiverName => _receiverName;

  String? get shipperAddr2 => _shipperAddr2;

  String? get lon => _lon;

  num? get deliveryPricePublish => _deliveryPricePublish;

  String? get codOngkir => _codOngkir;

  String? get shipperAddr1 => _shipperAddr1;

  String? get receiverDistrict => _receiverDistrict;

  String? get pickupAddress => _pickupAddress;

  String? get pickupTime => _pickupTime;

  String? get shipperCountry => _shipperCountry;

  num? get insuranceAdm => _insuranceAdm;

  String? get shipperName => _shipperName;

  String? get petugasEntry => _petugasEntry;

  num? get codAmount => _codAmount;

  String? get receiverSubdistrict => _receiverSubdistrict;

  String? get receiverAddr3 => _receiverAddr3;

  String? get receiverAddr1 => _receiverAddr1;

  String? get shipperPhone => _shipperPhone;

  String? get merchantId => _merchantId;

  String? get apiType => _apiType;

  String? get receiverZip => _receiverZip;

  String? get pickupService => _pickupService;

  num? get qty => _qty;

  String? get idSerahTerima => _idSerahTerima;

  num? get weight => _weight;

  String? get noSerahTerima => _noSerahTerima;

  String? get receiverPhone => _receiverPhone;

  String? get timeSerahTerima => _timeSerahTerima;

  String? get custId => _custId;

  String? get insuranceFlag => _insuranceFlag;

  String? get goodsDesc => _goodsDesc;

  num? get ammountDelivery => _ammountDelivery;

  String? get type => _type;

  String? get createdDateSearch => _createdDateSearch;

  String? get originCode => _originCode;

  String? get lat => _lat;

  String? get shipperRegion => _shipperRegion;

  String? get pickupPic => _pickupPic;

  String? get createdDate => _createdDate;

  String? get receiverRegion => _receiverRegion;

  String? get inputType => _inputType;

  String? get accountName => _accountName;

  String? get accountNumber => _accountNumber;

  String? get accountService => _accountService;

  String? get accountType => _accountType;

  String? get statusAwb => _statusAwb;

  String? get pickupStatus => _pickupStatus;

  TransAccountModel? get account => _account;

  PantauPaketmuDetailModel? get transactionDetail => _transactionDetail;

  DestinationModel? get destination => _destination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['awb'] = _awb;
    map['taxValue'] = _taxValue;
    map['itemType'] = _itemType;
    map['hsCode'] = _hsCode;
    map['npwp'] = _npwp;
    map['lastUpdate'] = _lastUpdate;
    map['awbType'] = _awbType;
    map['registrationId'] = _registrationId;
    map['deliveryPrice'] = _deliveryPrice;
    map['insuranceAmount'] = _insuranceAmount;
    map['destinationDesc'] = _destinationDesc;
    map['originDesc'] = _originDesc;
    map['packingkayuFlag'] = _packingkayuFlag;
    map['goodsType'] = _goodsType;
    map['shipperAddr'] = _shipperAddr;
    map['receiverAddr'] = _receiverAddr;
    map['transactionId'] = _transactionId;
    map['tempId'] = _tempId;
    map['dateMintaDijemput'] = _dateMintaDijemput;
    map['pickupCity'] = _pickupCity;
    map['serviceCode'] = _serviceCode;
    map['shipperCity'] = _shipperCity;
    map['pickupDate'] = _pickupDate;
    map['pickupPicPhone'] = _pickupPicPhone;
    map['shipperZip'] = _shipperZip;
    if (_orderId != null) {
      map['orderId'] = _orderId;
    }
    map['courierId'] = _courierId;
    map['destinationCode'] = _destinationCode;
    map['deliveryAmountPublish'] = _deliveryAmountPublish;
    map['statusName'] = _statusName;
    map['specialIns'] = _specialIns;
    map['courierName'] = _courierName;
    map['pickupVehicle'] = _pickupVehicle;
    map['shipperContact'] = _shipperContact;
    map['statusDesc'] = _statusDesc;
    map['responseJob'] = _responseJob;
    map['receiverContact'] = _receiverContact;
    map['pickupName'] = _pickupName;
    map['receiverAddr2'] = _receiverAddr2;
    map['isRetail'] = _isRetail;
    map['responseLive'] = _responseLive;
    map['dateSerahTerima'] = _dateSerahTerima;
    map['apiStatus'] = _apiStatus;
    map['codFlag'] = _codFlag;
    if (_goodsAmount != null) {
      map['goodsAmount'] = _goodsAmount;
    }
    map['receiverCity'] = _receiverCity;
    map['branch'] = _branch;
    map['responsePickup'] = _responsePickup;
    map['pickupDistrict'] = _pickupDistrict;
    map['printFlag'] = _printFlag;
    map['receiverCountry'] = _receiverCountry;
    map['shipperAddr3'] = _shipperAddr3;
    map['receiverName'] = _receiverName;
    map['shipperAddr2'] = _shipperAddr2;
    map['lon'] = _lon;
    map['deliveryPricePublish'] = _deliveryPricePublish;
    map['codOngkir'] = _codOngkir;
    map['shipperAddr1'] = _shipperAddr1;
    map['receiverDistrict'] = _receiverDistrict;
    map['pickupAddress'] = _pickupAddress;
    map['pickupTime'] = _pickupTime;
    map['shipperCountry'] = _shipperCountry;
    map['insuranceAdm'] = _insuranceAdm;
    map['shipperName'] = _shipperName;
    map['petugasEntry'] = _petugasEntry;
    map['codAmount'] = _codAmount;
    map['receiverSubdistrict'] = _receiverSubdistrict;
    map['receiverAddr3'] = _receiverAddr3;
    map['receiverAddr1'] = _receiverAddr1;
    map['shipperPhone'] = _shipperPhone;
    map['merchantId'] = _merchantId;
    map['apiType'] = _apiType;
    map['receiverZip'] = _receiverZip;
    map['pickupService'] = _pickupService;
    map['qty'] = _qty;
    map['idSerahTerima'] = _idSerahTerima;
    map['weight'] = _weight;
    map['noSerahTerima'] = _noSerahTerima;
    map['receiverPhone'] = _receiverPhone;
    map['timeSerahTerima'] = _timeSerahTerima;
    if (_custId != null) {
      map['custId'] = _custId;
    }
    map['insuranceFlag'] = _insuranceFlag;
    map['goodsDesc'] = _goodsDesc;
    map['ammountDelivery'] = _ammountDelivery;
    map['type'] = _type;
    map['createdDateSearch'] = _createdDateSearch;
    map['originCode'] = _originCode;
    map['lat'] = _lat;
    map['shipperRegion'] = _shipperRegion;
    map['pickupPic'] = _pickupPic;
    map['createdDate'] = _createdDate;
    map['receiverRegion'] = _receiverRegion;
    map['inputType'] = _inputType;
    map['accountName'] = _accountName;
    map['accountNumber'] = _accountNumber;
    map['accountService'] = _accountService;
    map['accountType'] = _accountType;
    map['statusAwb'] = _statusAwb;
    map['pickupStatus'] = _pickupStatus;
    if (_account != null) {
      map['account'] = _account?.toJson();
    }
    if (_destination != null) {
      map['destination'] = _destination.toString();
    }
    if (_transactionDetail != null) {
      map['transactionDetail'] = _transactionDetail?.toJson();
    }
    return map;
  }
}
