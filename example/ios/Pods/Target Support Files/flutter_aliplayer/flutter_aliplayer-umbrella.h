#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AliDownloaderProxy.h"
#import "AliPlayerFactory.h"
#import "AliPlayerProxy.h"
#import "FlutterAliDownloaderPlugin.h"
#import "FlutterAliMediaLoader.h"
#import "FlutterAliplayerPlugin.h"
#import "FlutterAliPlayerView.h"
#import "NSDictionary+ext.h"

FOUNDATION_EXPORT double flutter_aliplayerVersionNumber;
FOUNDATION_EXPORT const unsigned char flutter_aliplayerVersionString[];

