import 'package:flutter/material.dart';
import 'package:flutter_aliplayer/flutter_aliplayer_factory.dart';

import 'flutter_aliplayer.dart';
export 'flutter_aliplayer.dart';

class FlutterAliListPlayer extends FlutterAliplayer {
  String playerId = 'listPlayerDefault';

  FlutterAliListPlayer.init(String id) : super.init(id);

  @override
  Future<void> create() async {
    return FlutterAliPlayerFactory.methodChannel.invokeMethod(
        'createAliPlayer', wrapWithPlayerId(arg: PlayerType.PlayerType_List));
  }

  Future<void> setPreloadCount(int count) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setPreloadCount", wrapWithPlayerId(arg: count));
  }

  Future<void> addVidSource({@required vid, @required uid}) async {
    Map<String, dynamic> info = {'vid': vid, 'uid': uid};
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("addVidSource", wrapWithPlayerId(arg: info));
  }

  Future<void> addUrlSource({@required url, @required uid}) async {
    Map<String, dynamic> info = {'url': url, 'uid': uid};
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("addUrlSource", wrapWithPlayerId(arg: info));
  }

  Future<void> removeSource(String uid) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("removeSource", wrapWithPlayerId(arg: uid));
  }

  Future<dynamic> getCurrentUid() {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("getCurrentUid", wrapWithPlayerId());
  }

  Future<void> clear() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("clear", wrapWithPlayerId());
  }

  Future<void> setMaxPreloadMemorySizeMB(int size) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setMaxPreloadMemorySizeMB", wrapWithPlayerId(arg: size));
  }

  Future<void> moveToNext(
      {String? accId, String? accKey, String? token, String? region}) async {
    Map<String, dynamic> info = {
      'accId': accId,
      'accKey': accKey,
      'token': token,
      'region': region
    };
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("moveToNext", wrapWithPlayerId(arg: info));
  }

  Future<void> moveToPre({
    String? accId,
    String? accKey,
    String? token,
    String? region,
  }) async {
    Map<String, dynamic> info = {
      'accId': accId,
      'accKey': accKey,
      'token': token,
      'region': region
    };
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("moveToPre", wrapWithPlayerId(arg: info));
  }

  ///???????????????????????????????????????,url???????????????????????????uid???sts???????????????????????????sts??????
  ///uid ???????????????uid????????????????????????????????????
  Future<void> moveTo(
      {@required String? uid,
      String? accId,
      String? accKey,
      String? token,
      String? region}) async {
    Map<String, dynamic> info = {
      'uid': uid,
      'accId': accId,
      'accKey': accKey,
      'token': token,
      'region': region
    };
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("moveTo", wrapWithPlayerId(arg: info));
  }
}
