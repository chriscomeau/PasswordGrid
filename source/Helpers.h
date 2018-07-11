//
//  Helpers.m
//
//  Created by Chris Comeau on 2013-10-29.
//

#import <Foundation/Foundation.h>
//#import <FacebookSDK/FacebookSDK.h>
#import "passwordmatrixAppDelegate.h"

#import "GAI.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

#define kAppDelegate ((passwordmatrixAppDelegate *)[[UIApplication sharedApplication] delegate])
//System Versioning Preprocessor Macros
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//wobble
#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
#define WOBBLE_DEGREES 1
#define WOBBLE_SPEED 0.2 //0.25

//analytics

#define kIsIOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

//color
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


@interface Helpers : NSObject

//UI
+(void) offsetTextField:(UITextField*)textField;

//analytics
+(void) setupGoogleAnalyticsForView:(NSString*)viewName;
+(void) sendGoogleAnalyticsEventWithView:(NSString*)viewName andEvent:(NSString*)eventName;

//alerts
+(void) showAlertWithTitle:(NSString*)title andMessage:(NSString*)message;
+(void) showErrorHud:(NSString*)error;
+(void) showMessageHud:(NSString*)message;

//system
+ (BOOL) isDebug;
+ (BOOL) isRetina;
+ (BOOL) isIpad;
+(BOOL) checkOnline;
+(BOOL) isIphone5;
+(BOOL) isSimulator;

//image
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withImage:(UIImage*)sourceImage;


//strings

//math
+ (double)randomFloatBetween:(double)smallNumber andBig:(double)bigNumber;

//init
+ (void)initGoogleAnalytics;
+ (void)initMailChimp:(id)sender;
+ (void)showMailChimp;
+ (void)shouldShowMailChimp;

@end
