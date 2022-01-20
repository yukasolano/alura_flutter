import 'package:flutter/src/widgets/framework.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/models/package_model.dart';
import 'package:proj/models/producer_model.dart';
import 'package:proj/screens/package_details_screen.dart';

class PackageDetailsArgs {
  final Producer producer;
  final Package package;

  PackageDetailsArgs({this.producer, this.package});

  static PackageDetailsArgs fromJson(Map<String, dynamic> json) {
    return PackageDetailsArgs(
        producer: json['producer'], package: json['package']);
  }
}

class PackageDetailsRoute extends NuRoute<NuRouter, PackageDetailsArgs, String> {
  @override
  String get path => 'package-details';

  @override
  ScreenType get screenType => materialScreenType;

  @override
  ParamsParser<PackageDetailsArgs> get paramsParser => PackageDetailsArgs.fromJson;
  
  @override
  Widget build(BuildContext context, NuRouteSettings<PackageDetailsArgs> settings) {
    return PackageDetailsScreen(
        package: settings.args.package,
        producer: settings.args.producer);
  }
}
