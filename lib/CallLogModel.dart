import 'package:call_log/call_log.dart';

class CallLogModel {
  /// contact name
  String? name;

  /// contact number
  String? number;

  /// formatted number based on phone locales
  String? formattedNumber;

  /// type of call entry. see CallType
  CallType? callType;

  /// duration in seconds
  int? duration;

  /// unix timestamp of call start
  int? timestamp;

  int? cachedNumberType;

  String? cachedNumberLabel;

  String? cachedMatchedNumber;

  /// SIM display name
  String? simDisplayName;

  /// PHONE account id
  String? phoneAccountId;

  CallLogModel(
      this.name,
      this.number,
      this.formattedNumber,
      this.callType,
      this.duration,
      this.timestamp,
      this.cachedNumberType,
      this.cachedNumberLabel,
      this.cachedMatchedNumber,
      this.simDisplayName,
      this.phoneAccountId);

  CallLogModel.FromJson(Map<String, dynamic> json) {
    name = json["name"];
    number = json["number"];
    formattedNumber = json["formattedNumber"];
    callType = json["callType"];
    duration = json["duration"];
    timestamp = json["timestamp"];
    cachedNumberType = json["cachedNumberType"];
    cachedNumberLabel = json["cachedNumberLabel"];
    cachedMatchedNumber = json["cachedMatchedNumber"];
    simDisplayName = json["simDisplayName"];
    phoneAccountId = json["phoneAccountId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["number"] = this.number;
    data["formattedNumber"] = this.formattedNumber;
    data["callType"] = this.callType;
    data["duration"] = this.duration;
    data["timestamp"] = this.timestamp;
    data["cachedNumberType"] = this.cachedNumberType;
    data["cachedNumberLabel"] = this.cachedNumberLabel;
    data["cachedMatchedNumber"] = this.cachedMatchedNumber;
    data["simDisplayName"] = this.simDisplayName;
    data["NphoneAccountIdme"] = this.phoneAccountId;
    return data;
  }
}
