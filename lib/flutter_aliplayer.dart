import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aliplayer/flutter_aliplayer_factory.dart';
import 'package:flutter_aliplayer/flutter_avpdef.dart';

import 'flutter_avpdef.dart';

export 'flutter_avpdef.dart';

typedef OnPrepared = void Function(String playerId);
typedef OnRenderingStart = void Function(String playerId);
typedef OnVideoSizeChanged = void Function(
    int width, int height, int rotation, String playerId);
typedef OnSnapShot = void Function(String path, String playerId);
typedef OnSeekComplete = void Function(String playerId);
typedef OnSeiData = void Function(int type, String data, String playerId);

typedef OnLoadingBegin = void Function(String playerId);
typedef OnLoadingProgress = void Function(
    int percent, double netSpeed, String playerId);
typedef OnLoadingEnd = void Function(String playerId);

typedef OnStateChanged = void Function(int newState, String playerId);

typedef OnSubtitleExtAdded = void Function(
    int trackIndex, String url, String playerId);
typedef OnSubtitleShow = void Function(
    int trackIndex, int subtitleID, String subtitle, String playerId);
typedef OnSubtitleHide = void Function(
    int trackIndex, int subtitleID, String playerId);
typedef OnSubtitleHeader = void Function(
    int trackIndex, String head, String playerId);
typedef OnTrackReady = void Function(String playerId);

typedef OnInfo = void Function(
    int? infoCode, int? extraValue, String? extraMsg, String playerId);
typedef OnError = void Function(
    int errorCode, String? errorExtra, String? errorMsg, String playerId);
typedef OnCompletion = void Function(String playerId);

typedef OnTrackChanged = void Function(dynamic value, String playerId);

typedef OnThumbnailPreparedSuccess = void Function(String playerId);
typedef OnThumbnailPreparedFail = void Function(String playerId);

typedef OnThumbnailGetSuccess = void Function(
    Uint8List bitmap, Int64List range, String playerId);
typedef OnThumbnailGetFail = void Function(String playerId);

typedef OnSeekLiveCompletion = void Function(int playTime, String playerId);
typedef OnTimeShiftUpdater = void Function(
    int currentTime, int shiftStartTime, int shiftEndTime, String playerId);

typedef OnEventReportParams = void Function(Map params, String playerId);

class FlutterAliplayer {
  OnLoadingBegin? onLoadingBegin;
  OnLoadingProgress? onLoadingProgress;
  OnLoadingEnd? onLoadingEnd;
  OnPrepared? onPrepared;
  OnRenderingStart? onRenderingStart;
  OnVideoSizeChanged? onVideoSizeChanged;
  OnSeekComplete? onSeekComplete;
  OnStateChanged? onStateChanged;
  OnInfo? onInfo;
  OnCompletion? onCompletion;
  OnTrackReady? onTrackReady;
  OnError? onError;
  OnSeiData? onSeiData;
  OnSnapShot? onSnapShot;
  OnTrackChanged? onTrackChanged;
  OnThumbnailPreparedSuccess? onThumbnailPreparedSuccess;
  OnThumbnailPreparedFail? onThumbnailPreparedFail;

  OnThumbnailGetSuccess? onThumbnailGetSuccess;
  OnThumbnailGetFail? onThumbnailGetFail;

  //????????????
  OnSubtitleExtAdded? onSubtitleExtAdded;
  OnSubtitleHide? onSubtitleHide;
  OnSubtitleShow? onSubtitleShow;
  OnSubtitleHeader? onSubtitleHeader;

  //????????????
  OnSeekLiveCompletion? onSeekLiveCompletion;
  OnTimeShiftUpdater? onTimeShiftUpdater;

  //??????
  OnEventReportParams? onEventReportParams;

  // static MethodChannel channel = new MethodChannel('flutter_aliplayer');
  EventChannel eventChannel = EventChannel("flutter_aliplayer_event");

  String playerId = 'default';

  FlutterAliplayer.init(String? id) {
    if (id != null) {
      playerId = id;
    }
    FlutterAliPlayerFactory.instanceMap[playerId] = this;
    register();
  }

  void register() {
    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  void setOnPrepared(OnPrepared prepared) {
    this.onPrepared = prepared;
  }

  void setOnRenderingStart(OnRenderingStart renderingStart) {
    this.onRenderingStart = renderingStart;
  }

  void setOnVideoSizeChanged(OnVideoSizeChanged videoSizeChanged) {
    this.onVideoSizeChanged = videoSizeChanged;
  }

  void setOnSnapShot(OnSnapShot snapShot) {
    this.onSnapShot = snapShot;
  }

  void setOnSeekComplete(OnSeekComplete seekComplete) {
    this.onSeekComplete = seekComplete;
  }

  void setOnError(OnError onError) {
    this.onError = onError;
  }

  void setOnSeiData(OnSeiData seiData) {
    this.onSeiData = seiData;
  }

  void setOnLoadingStatusListener(
      {required OnLoadingBegin loadingBegin,
      required OnLoadingProgress loadingProgress,
      required OnLoadingEnd loadingEnd}) {
    this.onLoadingBegin = loadingBegin;
    this.onLoadingProgress = loadingProgress;
    this.onLoadingEnd = loadingEnd;
  }

  void setOnStateChanged(OnStateChanged stateChanged) {
    this.onStateChanged = stateChanged;
  }

  void setOnInfo(OnInfo info) {
    this.onInfo = info;
  }

  void setOnCompletion(OnCompletion completion) {
    this.onCompletion = completion;
  }

  void setOnTrackReady(OnTrackReady onTrackReady) {
    this.onTrackReady = onTrackReady;
  }

  void setOnTrackChanged(OnTrackChanged onTrackChanged) {
    this.onTrackChanged = onTrackChanged;
  }

  void setOnThumbnailPreparedListener(
      {required OnThumbnailPreparedSuccess preparedSuccess,
      required OnThumbnailPreparedFail preparedFail}) {
    this.onThumbnailPreparedSuccess = preparedSuccess;
    this.onThumbnailPreparedFail = preparedFail;
  }

  void setOnThumbnailGetListener(
      {required OnThumbnailGetSuccess onThumbnailGetSuccess,
      required OnThumbnailGetFail onThumbnailGetFail}) {
    this.onThumbnailGetSuccess = onThumbnailGetSuccess;
    this.onThumbnailGetSuccess = onThumbnailGetSuccess;
  }

  void setOnSubtitleShow(OnSubtitleShow onSubtitleShow) {
    this.onSubtitleShow = onSubtitleShow;
  }

  void setOnSubtitleHide(OnSubtitleHide onSubtitleHide) {
    this.onSubtitleHide = onSubtitleHide;
  }

  void setOnSubtitleHeader(OnSubtitleHeader onSubtitleHeader) {
    this.onSubtitleHeader = onSubtitleHeader;
  }

  void setOnSubtitleExtAdded(OnSubtitleExtAdded onSubtitleExtAdded) {
    this.onSubtitleExtAdded = onSubtitleExtAdded;
  }

  void setOnSeekLiveCompletion(OnSeekLiveCompletion seekLiveCompletion) {
    this.onSeekLiveCompletion = seekLiveCompletion;
  }

  void setOnTimeShiftUpdater(OnTimeShiftUpdater timeShiftUpdater) {
    this.onTimeShiftUpdater = timeShiftUpdater;
  }

  void setOnEventReportParams(OnEventReportParams eventReportParams) {
    this.onEventReportParams = eventReportParams;
  }

  ///????????????
  wrapWithPlayerId({arg = ''}) {
    var map = {"arg": arg, "playerId": this.playerId.toString()};
    return map;
  }

  Future<void> create() async {
    return FlutterAliPlayerFactory.methodChannel.invokeMethod(
        'createAliPlayer', wrapWithPlayerId(arg: PlayerType.PlayerType_Single));
  }

  Future<void> setPlayerView(int viewId) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('setPlayerView', wrapWithPlayerId(arg: viewId));
  }

  Future<void> setUrl(String url) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('setUrl', wrapWithPlayerId(arg: url));
  }

  Future<void> prepare() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('prepare', wrapWithPlayerId());
  }

  Future<void> play() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('play', wrapWithPlayerId());
  }

  Future<void> pause() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('pause', wrapWithPlayerId());
  }

  Future<void> clearScreen() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('clearScreen', wrapWithPlayerId());
  }

  Future<dynamic> snapshot(String path) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('snapshot', wrapWithPlayerId(arg: path));
  }

  Future<void> stop() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('stop', wrapWithPlayerId());
  }

  Future<void> destroy() async {
    FlutterAliPlayerFactory.instanceMap.remove(playerId);
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('destroy', wrapWithPlayerId());
  }

  Future<void> seekTo(int position, int seekMode) async {
    var map = {"position": position, "seekMode": seekMode};
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("seekTo", wrapWithPlayerId(arg: map));
  }

  Future<void> setMaxAccurateSeekDelta(int delta) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setMaxAccurateSeekDelta", wrapWithPlayerId(arg: delta));
  }

  Future<dynamic> isLoop() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('isLoop', wrapWithPlayerId());
  }

  Future<void> setLoop(bool isloop) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('setLoop', wrapWithPlayerId(arg: isloop));
  }

  Future<dynamic> isAutoPlay() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('isAutoPlay', wrapWithPlayerId());
  }

  Future<void> setAutoPlay(bool isAutoPlay) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('setAutoPlay', wrapWithPlayerId(arg: isAutoPlay));
  }

  Future<void> setFastStart(bool fastStart) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setFastStart", wrapWithPlayerId(arg: fastStart));
  }

  Future<dynamic> isMuted() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('isMuted', wrapWithPlayerId());
  }

  Future<void> setMuted(bool isMuted) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('setMuted', wrapWithPlayerId(arg: isMuted));
  }

  Future<dynamic> enableHardwareDecoder() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('enableHardwareDecoder', wrapWithPlayerId());
  }

  Future<void> setEnableHardwareDecoder(bool isHardWare) async {
    return FlutterAliPlayerFactory.methodChannel.invokeMethod(
        'setEnableHardwareDecoder', wrapWithPlayerId(arg: isHardWare));
  }

  Future<void> setVidSts(
      {String? vid,
      String? region,
      String? accessKeyId,
      String? accessKeySecret,
      String? securityToken,
      String? previewTime,
      List<String>? definitionList,
      String quality = "",
      bool forceQuality = false,
      playerId}) async {
    Map<String, dynamic> stsInfo = {
      "vid": vid,
      "region": region,
      "accessKeyId": accessKeyId,
      "accessKeySecret": accessKeySecret,
      "securityToken": securityToken,
      "definitionList": definitionList,
      "previewTime": previewTime,
      "quality": quality,
      "forceQuality": forceQuality
    };
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setVidSts", wrapWithPlayerId(arg: stsInfo));
  }

  Future<void> setVidAuth(
      {String? vid,
      String? region,
      String? playAuth,
      String? previewTime,
      List<String>? definitionList,
      String quality = "",
      bool forceQuality = false,
      playerId}) async {
    Map<String, dynamic> authInfo = {
      "vid": vid,
      "region": region,
      "playAuth": playAuth,
      "definitionList": definitionList,
      "previewTime": previewTime,
      "quality": quality,
      "forceQuality": forceQuality
    };
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setVidAuth", wrapWithPlayerId(arg: authInfo));
  }

  Future<void> setVidMps(Map<String, dynamic> mpsInfo) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setVidMps", wrapWithPlayerId(arg: mpsInfo));
  }

  Future<void> setLiveSts(
      {String? url,
      String? accessKeyId,
      String? accessKeySecret,
      String? securityToken,
      String? region,
      String? domain,
      String? app,
      String? stream,
      EncryptionType? encryptionType,
      List<String>? definitionList,
      playerId}) async {
    Map<String, dynamic> liveStsInfo = {
      "url": url,
      "accessKeyId": accessKeyId,
      "accessKeySecret": accessKeySecret,
      "securityToken": securityToken,
      "region": region,
      "domain": domain,
      "app": app,
      "stream": stream,
      "encryptionType": encryptionType?.index.toString(),
      "definitionList": definitionList,
    };
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setLiveSts", wrapWithPlayerId(arg: liveStsInfo));
  }

  Future<dynamic> updateLiveStsInfo(
      String accId, String accKey, String token, String region) async {
    Map<String, String> liveStsInfo = {
      "accId": accId,
      "accKey": accKey,
      "token": token,
      "region": region,
    };
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('updateLiveStsInfo', wrapWithPlayerId(arg: liveStsInfo));
  }

  Future<dynamic> getRotateMode() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getRotateMode', wrapWithPlayerId());
  }

  Future<void> setRotateMode(int mode) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('setRotateMode', wrapWithPlayerId(arg: mode));
  }

  Future<dynamic> getScalingMode() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getScalingMode', wrapWithPlayerId());
  }

  Future<void> setScalingMode(int mode) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('setScalingMode', wrapWithPlayerId(arg: mode));
  }

  Future<dynamic> getMirrorMode() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getMirrorMode', wrapWithPlayerId());
  }

  Future<void> setMirrorMode(int mode) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('setMirrorMode', wrapWithPlayerId(arg: mode));
  }

  Future<dynamic> getRate() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getRate', wrapWithPlayerId());
  }

  Future<void> setRate(double mode) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('setRate', wrapWithPlayerId(arg: mode));
  }

  Future<void> setVideoBackgroundColor(var color) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('setVideoBackgroundColor', wrapWithPlayerId(arg: color));
  }

  Future<dynamic> getVideoWidth() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getVideoWidth', wrapWithPlayerId());
  }

  Future<dynamic> getVideoHeight() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getVideoHeight', wrapWithPlayerId());
  }

  Future<dynamic> getVideoRotation() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getVideoRotation', wrapWithPlayerId());
  }

  Future<void> setVolume(double volume) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('setVolume', wrapWithPlayerId(arg: volume));
  }

  Future<dynamic> getVolume() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getVolume', wrapWithPlayerId());
  }

  Future<dynamic> getDuration() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getDuration', wrapWithPlayerId());
  }

  Future<dynamic> getCurrentPosition() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getCurrentPosition', wrapWithPlayerId());
  }

  Future<dynamic> getCurrentUtcTime() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getCurrentUtcTime', wrapWithPlayerId());
  }

  Future<dynamic> getLocalCacheLoadedSize() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getLocalCacheLoadedSize', wrapWithPlayerId());
  }

  Future<dynamic> getCurrentDownloadSpeed() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getCurrentDownloadSpeed', wrapWithPlayerId());
  }

  Future<dynamic> getBufferedPosition() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('getBufferedPosition', wrapWithPlayerId());
  }

  Future<dynamic> getConfig() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("getConfig", wrapWithPlayerId());
  }

  Future<void> setConfig(Map map) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setConfig", wrapWithPlayerId(arg: map));
  }

  Future<dynamic> getCacheConfig() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("getCacheConfig", wrapWithPlayerId());
  }

  Future<void> setCacheConfig(Map map) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setCacheConfig", wrapWithPlayerId(arg: map));
  }

  Future<void> setFilterConfig(String configJson) async {
    print("abc : setFilterConfig flutter");
    // configJson??????: "[{"target":"<target1>", "options":["<options_key>"]}, {"target":"<target2>", "options":<null>},...]"
    // options_key ???????????????"sharp"???"sr"
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setFilterConfig", wrapWithPlayerId(arg: configJson));
  }

  Future<void> updateFilterConfig(String target, Map options) async {
    var map = {'target': target, 'options': options};
    // options??????: {"key":"<options_key>", "value": "<options_value>"}
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("updateFilterConfig", wrapWithPlayerId(arg: map));
  }

  Future<void> setFilterInvalid(String target, String invalid) async {
    var map = {'target': target, 'invalid': invalid};
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setFilterInvalid", wrapWithPlayerId(arg: map));
  }

  Future<dynamic> getCacheFilePath(String url) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("getCacheFilePath", wrapWithPlayerId(arg: url));
  }

  Future<dynamic> getCacheFilePathWithVid(
      String vid, String format, String definition) async {
    var map = {'vid': vid, 'format': format, 'definition': definition};
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("getCacheFilePathWithVid", wrapWithPlayerId(arg: map));
  }

  Future<dynamic> getCacheFilePathWithVidAtPreviewTime(
      String vid, String format, String definition, String previewTime) async {
    var map = {
      'vid': vid,
      'format': format,
      'definition': definition,
      'previewTime': previewTime
    };
    return FlutterAliPlayerFactory.methodChannel.invokeMethod(
        "getCacheFilePathWithVidAtPreviewTime", wrapWithPlayerId(arg: map));
  }

  Future<dynamic> getMediaInfo() {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("getMediaInfo", wrapWithPlayerId());
  }

  Future<dynamic> getCurrentTrack(int trackIdx) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("getCurrentTrack", wrapWithPlayerId(arg: trackIdx));
  }

  Future<dynamic> createThumbnailHelper(String thumbnail) {
    return FlutterAliPlayerFactory.methodChannel.invokeMethod(
        "createThumbnailHelper", wrapWithPlayerId(arg: thumbnail));
  }

  Future<dynamic> requestBitmapAtPosition(int position) {
    return FlutterAliPlayerFactory.methodChannel.invokeMethod(
        "requestBitmapAtPosition", wrapWithPlayerId(arg: position));
  }

  // ??????traceID???????????????????????????onEventReportParams
  Future<dynamic> setTraceID(String traceID) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setTraceID", wrapWithPlayerId(arg: traceID));
  }

  Future<void> addExtSubtitle(String url) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("addExtSubtitle", wrapWithPlayerId(arg: url));
  }

  Future<void> selectExtSubtitle(int trackIndex, bool enable) {
    var map = {'trackIndex': trackIndex, 'enable': enable};
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("selectExtSubtitle", wrapWithPlayerId(arg: map));
  }

  Future<void> setDefaultBandWidth(int parse) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setDefaultBandWidth", wrapWithPlayerId(arg: parse));
  }

  // accurate 0 ????????????  1 ?????????  ???????????????
  Future<void> selectTrack(
    int trackIdx, {
    int accurate = -1,
  }) {
    var map = {
      'trackIdx': trackIdx,
      'accurate': accurate,
    };
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("selectTrack", wrapWithPlayerId(arg: map));
  }

  Future<void> setPrivateService(Int8List data) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setPrivateService", data);
  }

  Future<void> setPreferPlayerName(String playerName) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setPreferPlayerName", wrapWithPlayerId(arg: playerName));
  }

  Future<dynamic> getPlayerName() {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("getPlayerName", wrapWithPlayerId());
  }

  Future<void> sendCustomEvent(String args) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("sendCustomEvent", wrapWithPlayerId(arg: args));
  }

  Future<void> setStreamDelayTime(int trackIdx, int time) {
    var map = {'index': trackIdx, 'time': time};
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setStreamDelayTime", map);
  }

  Future<void> reload() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod('reload', wrapWithPlayerId());
  }

  Future<dynamic> getOption(AVPOption key) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("getOption", wrapWithPlayerId(arg: key.index.toString()));
  }

  Future<dynamic> getPropertyString(AVPPropertyKey key) {
    return FlutterAliPlayerFactory.methodChannel.invokeMethod(
        "getPropertyString", wrapWithPlayerId(arg: key.index.toString()));
  }

  Future<dynamic> setEventReportParamsDelegate(int argt) {
    return FlutterAliPlayerFactory.methodChannel.invokeMethod(
        "setEventReportParamsDelegate", wrapWithPlayerId(arg: argt.toString()));
  }

  ///????????????
  static Future<dynamic> getSDKVersion() async {
    return FlutterAliPlayerFactory.methodChannel.invokeMethod("getSDKVersion");
  }

  static Future<dynamic> getDeviceUUID() async {
    return FlutterAliPlayerFactory.methodChannel.invokeMethod("getDeviceUUID");
  }

  static Future<void> enableMix(bool enable) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("enableMix", enable);
  }

  static Future<void> enableConsoleLog(bool enable) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("enableConsoleLog", enable);
  }

  static Future<void> setLogLevel(int level) async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setLogLevel", level);
  }

  static Future<dynamic> getLogLevel() {
    return FlutterAliPlayerFactory.methodChannel.invokeMethod(
      "getLogLevel",
    );
  }

  static Future<void> setUseHttp2(bool use) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setUseHttp2", use);
  }

  static Future<void> enableHttpDns(bool enable) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("enableHttpDns", enable);
  }

  static Future<void> setIpResolveType(AVPIpResolveType type) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setIpResolveType", type.index.toString());
  }

  static Future<void> setFairPlayCertIDForIOS(String certID) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setFairPlayCertIDForIOS", certID);
  }

  static Future<void> enableHWAduioTempo(bool enable) {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("enableHWAduioTempo", enable);
  }

  static Future<void> forceAudioRendingFormat(
      String force, String fmt, String channels, String sample_rate) {
    var map = {
      'force': force,
      'fmt': fmt,
      'channels': channels,
      'sample_rate': sample_rate
    };
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("forceAudioRendingFormat", map);
  }

  static Future<void> netWorkReConnect() {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("netWorkReConnect");
  }

  ///????????????
  static Future<void> enableLocalCache(bool enable, String maxBufferMemoryKB,
      String localCacheDir, DocTypeForIOS docTypeForIOS) {
    var map = {
      'enable': enable,
      'maxBufferMemoryKB': maxBufferMemoryKB,
      'localCacheDir': localCacheDir,
    };

    if (Platform.isIOS) {
      // docTypeForIOS??????????????????????????????????????? "0":Documents, "1":Library, "2":Caches, ??????:Documents
      map['docTypeForIOS'] = docTypeForIOS.index.toString();
    } else {
      // ??????????????????docType???????????????localCacheDir
    }

    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("enableLocalCache", map);
  }

  ///?????????????????????????????????????????????
  static Future<void> setCacheFileClearConfig(
      String expireMin, String maxCapacityMB, String freeStorageMB) {
    var map = {
      'expireMin': expireMin,
      'maxCapacityMB': maxCapacityMB,
      'freeStorageMB': freeStorageMB,
    };
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("setCacheFileClearConfig", map);
  }

  ///???????????????????????????????????????????????????????????????????????????
  static Future<void> clearCaches() {
    return FlutterAliPlayerFactory.methodChannel.invokeMethod("clearCaches");
  }

  ///return deviceInfo
  static Future<dynamic> createDeviceInfo() async {
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("createDeviceInfo");
  }

  ///type : {FlutterAvpdef.BLACK_DEVICES_H264 / FlutterAvpdef.BLACK_DEVICES_HEVC}
  static Future<void> addBlackDevice(String type, String model) async {
    var map = {
      'black_type': type,
      'black_device': model,
    };
    return FlutterAliPlayerFactory.methodChannel
        .invokeMethod("addBlackDevice", map);
  }

  ///????????????
  void _onEvent(dynamic event) {
    String method = event[EventChanneldef.TYPE_KEY];
    String playerId = event['playerId'] ?? '';
    FlutterAliplayer player =
        FlutterAliPlayerFactory.instanceMap[playerId] ?? this;
    switch (method) {
      case "onPrepared":
        if (player.onPrepared != null) {
          player.onPrepared!(playerId);
        }
        break;
      case "onRenderingStart":
        if (player.onRenderingStart != null) {
          player.onRenderingStart!(playerId);
        }
        break;
      case "onVideoSizeChanged":
        if (player.onVideoSizeChanged != null) {
          int width = event['width'];
          int height = event['height'];
          int rotation = event['rotation'];
          player.onVideoSizeChanged!(width, height, rotation, playerId);
        }
        break;
      case "onSnapShot":
        if (player.onSnapShot != null) {
          String snapShotPath = event['snapShotPath'];
          player.onSnapShot!(snapShotPath, playerId);
        }
        break;
      case "onChangedSuccess":
        break;
      case "onChangedFail":
        break;
      case "onSeekComplete":
        if (player.onSeekComplete != null) {
          player.onSeekComplete!(playerId);
        }
        break;
      case "onSeiData":
        if (player.onSeiData != null) {
          String data = event['data'];
          int type = event['type'];
          player.onSeiData!(type, data, playerId);
        }
        break;
      case "onLoadingBegin":
        if (player.onLoadingBegin != null) {
          player.onLoadingBegin!(playerId);
        }
        break;
      case "onLoadingProgress":
        int percent = event['percent'];
        double netSpeed = event['netSpeed'];
        if (player.onLoadingProgress != null) {
          player.onLoadingProgress!(percent, netSpeed, playerId);
        }
        break;
      case "onLoadingEnd":
        if (player.onLoadingEnd != null) {
          print("onLoadingEnd");
          player.onLoadingEnd!(playerId);
        }
        break;
      case "onStateChanged":
        if (player.onStateChanged != null) {
          int newState = event['newState'];
          player.onStateChanged!(newState, playerId);
        }
        break;
      case "onInfo":
        if (player.onInfo != null) {
          int? infoCode = event['infoCode'];
          int? extraValue = event['extraValue'];
          String? extraMsg = event['extraMsg'];
          player.onInfo!(infoCode, extraValue, extraMsg, playerId);
        }
        break;
      case "onError":
        if (player.onError != null) {
          int errorCode = event['errorCode'];
          String? errorExtra = event['errorExtra'];
          String? errorMsg = event['errorMsg'];
          player.onError!(errorCode, errorExtra, errorMsg, playerId);
        }
        break;
      case "onCompletion":
        if (player.onCompletion != null) {
          player.onCompletion!(playerId);
        }
        break;
      case "onTrackReady":
        if (player.onTrackReady != null) {
          player.onTrackReady!(playerId);
        }
        break;
      case "onTrackChanged":
        if (player.onTrackChanged != null) {
          dynamic info = event['info'];
          player.onTrackChanged!(info, playerId);
        }
        break;
      case "thumbnail_onPrepared_Success":
        if (player.onThumbnailPreparedSuccess != null) {
          player.onThumbnailPreparedSuccess!(playerId);
        }
        break;
      case "thumbnail_onPrepared_Fail":
        if (player.onThumbnailPreparedFail != null) {
          player.onThumbnailPreparedFail!(playerId);
        }
        break;
      case "onThumbnailGetSuccess":
        dynamic bitmap = event['thumbnailbitmap'];
        dynamic range = event['thumbnailRange'];
        if (player.onThumbnailGetSuccess != null) {
          if (Platform.isIOS) {
            range = Int64List.fromList(range.cast<int>());
          }
          player.onThumbnailGetSuccess!(bitmap, range, playerId);
        }
        break;
      case "onThumbnailGetFail":
        if (player.onThumbnailGetFail != null) {
          player.onThumbnailGetFail!(playerId);
        }
        break;
      case "onSubtitleExtAdded":
        if (player.onSubtitleExtAdded != null) {
          int trackIndex = event['trackIndex'];
          String url = event['url'];
          player.onSubtitleExtAdded!(trackIndex, url, playerId);
        }
        break;
      case "onSubtitleShow":
        if (player.onSubtitleShow != null) {
          int trackIndex = event['trackIndex'];
          int subtitleID = event['subtitleID'];
          String subtitle = event['subtitle'];
          player.onSubtitleShow!(trackIndex, subtitleID, subtitle, playerId);
        }
        break;
      case "onSubtitleHide":
        if (player.onSubtitleHide != null) {
          int trackIndex = event['trackIndex'];
          int subtitleID = event['subtitleID'];
          player.onSubtitleHide!(trackIndex, subtitleID, playerId);
        }
        break;
      case "onSubtitleHeader":
        if (player.onSubtitleHeader != null) {
          int trackIndex = event['trackIndex'];
          String header = event['header'];
          player.onSubtitleHeader!(trackIndex, header, playerId);
        }
        break;
      case "onUpdater":
        if (player.onTimeShiftUpdater != null) {
          var currentTime = event['currentTime'];
          var shiftStartTime = event['shiftStartTime'];
          var shiftEndTime = event['shiftEndTime'];
          player.onTimeShiftUpdater!(
              currentTime, shiftStartTime, shiftEndTime, playerId);
        }
        break;
      case "onSeekLiveCompletion":
        if (player.onSeekLiveCompletion != null) {
          var playTime = event['playTime'];
          player.onSeekLiveCompletion!(playTime, playerId);
        }
        break;
      case "onEventReportParams":
        if (player.onEventReportParams != null) {
          var params = event['params'];
          player.onEventReportParams!(params, playerId);
        }
    }
  }

  void _onError(dynamic error) {}
}

typedef void AliPlayerViewCreatedCallback(int viewId);

class AliPlayerView extends StatefulWidget {
  final AliPlayerViewCreatedCallback? onCreated;
  final x;
  final y;
  final width;
  final height;

  AliPlayerView({
    Key? key,
    @required required this.onCreated,
    @required this.x,
    @required this.y,
    @required this.width,
    @required this.height,
  });

  @override
  State<StatefulWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<AliPlayerView> {
  @override
  void initState() {
    super.initState();
    // print("abc : create PlatFormView initState");
  }

  @override
  Widget build(BuildContext context) {
    // print("abc : create PlatFormView build");
    return nativeView();
  }

  nativeView() {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'flutter_aliplayer_render_view',
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParams: <String, dynamic>{
          "x": widget.x,
          "y": widget.y,
          "width": widget.width,
          "height": widget.height,
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      return UiKitView(
        viewType: 'plugins.flutter_aliplayer',
        // viewType: 'flutter_aliplayer_render_view',
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParams: <String, dynamic>{
          "x": widget.x,
          "y": widget.y,
          "width": widget.width,
          "height": widget.height,
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
  }

  Future<void> _onPlatformViewCreated(id) async {
    if (widget.onCreated != null) {
      widget.onCreated!(id);
    }
  }
}
