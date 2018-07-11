//
//  TapForTapAdView.h
//  TapForTapAds
//
//  Created by Sami Samhuri on 12-02-06.
//  Copyright (c) 2012 Beta Street Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class TapForTapAdView;

@protocol TapForTapAdViewDelegate
@optional

- (void) tapForTapAdViewDidReceiveAd: (TapForTapAdView *)adView;
- (void) tapForTapAdView: (TapForTapAdView *)adView didFailToReceiveAd: (NSString *)reason;

@end

////

typedef enum {
    NONE = -1,
    MALE = 0,
    FEMALE = 1
} TapForTapGender;

@interface TapForTapAdView : UIView <NSURLConnectionDelegate>

@property (nonatomic, assign) NSObject<TapForTapAdViewDelegate> *delegate;
@property (nonatomic, retain) NSString *appId;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, assign) TapForTapGender gender;
@property (nonatomic, retain) CLLocation *location;

- (void) loadAds;

@end
