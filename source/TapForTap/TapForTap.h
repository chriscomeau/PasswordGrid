//
//  TapForTap.h
//  TapForTapAds
//
//  Created by Sami Samhuri on 12-03-12.
//  Copyright (c) 2012 Beta Street. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TapForTapAdView.h"

@interface TapForTap : NSObject

+ (NSString *) apiVersion;

+ (NSString *) defaultAppId;
+ (void) setDefaultAppId: (NSString *)appId;

+ (void) checkIn;
+ (void) checkInWithAppId: (NSString *)appId;

@end
