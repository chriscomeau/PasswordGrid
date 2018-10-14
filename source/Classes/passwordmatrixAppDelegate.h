//
//  passwordmatrixAppDelegate.h
//  passwordmatrix
//
//  Created by Chris Comeau on 15/05/09.
//  Copyright Skyriser Media 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>
#import "WelcomeViewController.h"
#import "QRViewController.h"
#import "KeyViewController.h"
#import <MessageUI/MessageUI.h>
//#import "LocalyticsSession.h"
//#import "FlurryAnalytics.h"
//#import "FBConnect.h"
#import "ConverViewController.h"
#import "passwordmatrixIAPHelper.h"
//#import "ChimpKit.h"
#import <StoreKit/StoreKit.h>
#import "HapticHelper.h"


@interface passwordmatrixAppDelegate : NSObject <MFMailComposeViewControllerDelegate, UIAlertViewDelegate, UIApplicationDelegate, UITabBarControllerDelegate, SKStoreProductViewControllerDelegate /*CKAuthViewControllerDelegate, ChimpKitDelegate, FBSessionDelegate, FBRequestDelegate*/>
{
    UIWindow *window;
    UITabBarController *tabBarController;
	//IBOutlet UINavigationController	*navigationController;

	int mSeed;
	NSMutableArray *matrixArray;
	UIColor *textBackColor;
    SystemSoundID audioEffect;
    UIImage *qrImage;
	
	//prefs
	/*NSString *keyString;
	int prefRunCount;
    int prefNumApps;
	BOOL prefOpened;	
	BOOL prefRemember;	
	BOOL prefUppercase;	
	BOOL prefSymbols;
	BOOL prefNumbers;
    BOOL prefDefaultConvert;
    NSString *prefVersion;
	BOOL prefAutocopy;
	BOOL prefPlaySound;
	BOOL prefRated;
    BOOL prefTap;
    BOOL prefPurchasedRemoveAds;
	BOOL showedAlertRate;
	BOOL showingHelp;
	BOOL alertKeyVisible;
    BOOL enteredForegroundConvert;
	//NSDate *lastTime;
    double lastTimeSince70;
    BOOL alreadyLoaded;
    BOOL numAppsDownloaded;
    int numApps;
    BOOL isOnline;*/
    
    BOOL numAppsDownloaded;
    int numApps;

	WelcomeViewController	*modalHelp;
	QRViewController	*modalQR;
	KeyViewController	*modalKey;
    ConverViewController   *convertViewController;

    //facebook
    //Facebook *facebook;
    UIImage *savedAdImage;
    NSMutableArray *adArray;
    int currentAdId;
    NSString *currentAdUrl;
    NSString *currentAdId2;
    
    NSArray *products;
	SKProduct * productRemoveAds;
}  

- (void)setupSeed;
- (void)gotoReviews;
//- (void)gotoGift;
- (void)gotoAd;
- (void)gotoFacebook;
- (void)setupUI;
- (void)gotoTwitter;
- (void)gotoQRScannerApp;
- (NSString*)getRandomLetter;
- (NSString*) getRandom;
- (NSString *)string_to_ascii:(NSString*)string;
- (NSString *)convert:(NSString*)string;
- (NSString *)randomCase:(NSString*)string;
- (void)setKey:(NSString*)string;
- (NSString *)getArray:(int)index;
- (void)alertKey;
- (void)alertEmpty;
- (void)alertAskKey;
- (void)alertHelpFirstTime;
- (void)alertHelp:(BOOL)isAnimated;
- (void)alertQR:(BOOL)isAnimated;
- (void)alertHelpDone;
- (void)alertMoreDone;
- (void)alertHelpDoneFirstTime;
- (void)alertHelpDoneNotAnimated;
- (void)alertRate;
- (void)saveState;
- (void)saveStateDefault;
- (void)loadState;
- (void)sendEmailTo:(NSString *)to withSubject:(NSString *)subject withBody:(NSString *)body withView:(UIViewController*)theView;
- (NSString *)getGridString;
- (void) ping;
- (void) playSound:(NSString*)filename;
- (BOOL)backgroundSupported;
- (NSString *) platform;
- (NSString *) platformString;
- (BOOL)isTestflight;
- (BOOL)isTapForTap;
- (NSString *)getSecureID;
- (void) testFlightFeedback;
- (BOOL)openURL:(NSURL*)url;
- (BOOL)HasConnection;
-(UIImage*) maskImage:(UIImage *)inputImage withMask:(UIImage *)inputMaskImage;
//-(UIImage *)changeWhiteColorTransparent: (UIImage *)image;
-(UIImage *)colorizeImage: (UIImage *)image;
-(UIImage*) createMaskWithImage: (UIImage*) image;
-(UIImage*) getQRImage;
-(NSString*)getVersionString;
-(NSString*)getVersionString2;
-(NSString*)getUserAgent;
-(void)cornerView:(UIView*)inView;
-(void)updateNumAppsBadge;
-(void)hideNumAppsBadge;
-(int)getNumApps;
- (void)fadeDefault;
- (void)fadeDefaultSetup;
- (BOOL) isShowDefault;
- (void)startWobble:(UIView *)view;
- (void)stopWobble:(UIView *)view;
- (BOOL) checkOnline;
- (void) updateAd;
- (void) updateAd2;
-(void)updateInReview;
//- (void)offsetView:(UIView *)view;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) NSMutableArray *matrixArray;
@property (nonatomic, retain) NSString *keyString;
@property (nonatomic, retain) NSString *prefVersion;
@property (nonatomic, retain) UIColor *textBackColor;
@property (nonatomic, retain) UIImage *qrImage;
@property (assign, nonatomic) BOOL prefOpened;
@property (assign, nonatomic) BOOL prefRemember;
@property (assign, nonatomic) BOOL prefUppercase;
@property (assign, nonatomic) BOOL prefSymbols;
@property (assign, nonatomic) BOOL prefRated;
@property (assign, nonatomic) BOOL prefNumbers;
@property (assign, nonatomic) BOOL prefDefaultConvert;
@property (assign, nonatomic) BOOL prefAutocopy;
@property (assign, nonatomic) BOOL prefPlaySound;
@property (assign, nonatomic) BOOL prefTap;
@property (assign, nonatomic) BOOL showedAlertRate;
@property (assign, nonatomic) BOOL showingHelp;
@property (assign, nonatomic) BOOL alertKeyVisible;
@property (assign, nonatomic) BOOL enteredForegroundConvert;
@property (assign, nonatomic) int prefRunCount;
@property (assign, nonatomic) int prefNumApps;
@property (assign, nonatomic) double lastTimeSince70;
@property (assign, nonatomic) BOOL alreadyLoaded;
@property (assign, nonatomic) BOOL alreadyFadeDefault;
@property (strong, nonatomic) UIImageView *splash;
@property (nonatomic, retain) UIColor *buttonTextColor;
@property(nonatomic, assign) BOOL isOnline;
@property (nonatomic, retain) UIImage *savedAdImage;
@property (assign, nonatomic) int currentAdId;
@property (nonatomic, retain) NSString *currentAdUrl;
@property (nonatomic, retain) NSString *currentAdId2;
@property (nonatomic, retain) ConverViewController   *convertViewController;
@property (nonatomic, retain) NSArray *products;
@property (nonatomic, retain) SKProduct * productRemoveAds;
@property (assign, nonatomic) BOOL prefPurchasedRemoveAds;
@property (assign, nonatomic) int prefMailchimpCount;
@property (assign, nonatomic) BOOL prefMailchimpShown;
@property (assign, nonatomic) BOOL inReview;

@end
