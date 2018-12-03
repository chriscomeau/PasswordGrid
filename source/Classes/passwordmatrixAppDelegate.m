//
//  passwordmatrixAppDelegate.m
//  passwordmatrix
//
//  Created by Chris Comeau on 15/05/09.
//  Copyright Skyriser Media 2009. All rights reserved.
//

#import "passwordmatrixAppDelegate.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#import "Reachability.h"
#import "UncaughtExceptionHandler.h"
#import "NSDate-Utilities.h"
#import "PDKeychainBindingsController.h"
//#import "Analytics/Analytics.h"

#include <sys/types.h>
#include <sys/sysctl.h>

//#import <AudioToolbox/AudioToolbox.h>
//#import "UAirship.h"
//#import "UATagUtils.h"
#if USE_TESTFLIGHT
#import "TestFlight.h"
#endif

#import "iRate.h"
//#import "iVersion.h"
#import "iNotify.h"
//#import "TapForTap.h"
//#import "SecureUDID.h"

//#import "SHK.h"
//#import "SHKConfiguration.h"
//#import "SHKFacebook.h"
//#import "ShareKitDemoConfigurator.h"
#import "UIAlertView+Errors.h"

#import <Crashlytics/Crashlytics.h>

//#import "SubscribeAlertView.h"
#import "AFNetworking.h"
//#import "QRTools.h"

//#import "UITabBarControllerCategory.h"


@implementation passwordmatrixAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize matrixArray;
@synthesize keyString;
@synthesize textBackColor;
@synthesize qrImage;
@synthesize prefOpened;
@synthesize prefRemember;
@synthesize prefUppercase;
@synthesize prefSymbols;
@synthesize prefRated;
@synthesize prefNumbers;
@synthesize prefDefaultConvert;
@synthesize prefAutocopy;
@synthesize prefPlaySound;
@synthesize prefRunCount;
@synthesize prefNumApps;
@synthesize prefVersion;
@synthesize prefTap;
@synthesize showedAlertRate;
@synthesize showingHelp;
@synthesize alertKeyVisible;
@synthesize enteredForegroundConvert;
@synthesize lastTimeSince70;
@synthesize alreadyLoaded;
@synthesize splash;
@synthesize alreadyFadeDefault;
@synthesize isOnline;
@synthesize savedAdImage;
@synthesize currentAdId;
@synthesize currentAdUrl;
@synthesize currentAdId2;
@synthesize convertViewController;
@synthesize products;
@synthesize productRemoveAds;
@synthesize prefPurchasedRemoveAds;
@synthesize inReview;
@synthesize prefMailchimpCount;
@synthesize prefMailchimpShown;

NSRecursiveLock *lock1;
NSRecursiveLock *lock2;
NSRecursiveLock *lock3;
NSRecursiveLock *lock4;
NSRecursiveLock *lock5;
NSRecursiveLock *lock6;
NSRecursiveLock *lock7;

SystemSoundID audioEffect;

+ (void)initialize
{
    //qrImage = nil;
    
    
	//configure iRate
	[iRate sharedInstance].appStoreID = 359807331;
    [iRate sharedInstance].daysUntilPrompt = 3;
    [iRate sharedInstance].usesUntilPrompt = 3;
	//[iRate sharedInstance].debug = YES; 
    
	
    //configure iNotify
	[iNotify sharedInstance].notificationsPlistURL = @"???";
	//[iNotify sharedInstance].debug = YES;
     
}


/*- (void)awakeFromNib
{
	
	// add our custom button to show our modal view controller
	//UIButton* modalViewButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	//[modalViewButton addTarget:self action:@selector(modalViewAction:) forControlEvents:UIControlEventTouchUpInside];
	//UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:modalViewButton];
	//self.navigationItem.rightBarButtonItem = modalButton;
	//[modalViewButton release];
	
}
*/



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Crashlytics startWithAPIKey:@"???"];
    
    if([Helpers isDebug])
    {
        //InstallUncaughtExceptionHandler();
        NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    }
    
    self.buttonTextColor = RGBA(36,36,36, 255);//[UIColor darkGrayColor];

	//lastTime = nil;
        
    //force wait, show default longer, ugly but good enough for now
    //[NSThread sleepForTimeInterval:0.5];

    //tab color
    //tabBarController.tabBar.tintColor = RGBA(0, 30, 0, 245);
    
    // Setup Parse
    /*[Parse setApplicationId:@"parseAppId" clientKey:@"parseClientKey"];
    [Parse setApplicationId: kParseApplicationID
                  clientKey:kParseClientKey];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];*/
    
    
    //notification
    UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
        [self processNotification:localNotif];
    }

    [self setupNotifications];


    //ios7 tint color
    if(kIsIOS7)
        window.tintColor = RGBA(114,178,39, 255);

    lock1 = [[NSRecursiveLock alloc] init];
    lock2 = [[NSRecursiveLock alloc] init];
    lock3 = [[NSRecursiveLock alloc] init];
    lock4 = [[NSRecursiveLock alloc] init];
    lock5 = [[NSRecursiveLock alloc] init];
    lock6 = [[NSRecursiveLock alloc] init];
    lock7 = [[NSRecursiveLock alloc] init];


    //qr
    qrImage = nil;
    NSString *qrString = @"http://itunes.apple.com/app/id359807331"; //appsto.re/passwordgrid
    //qrImage = [QREncoder encode:qrString size:qrSize correctionLevel: QRCorrectionLevelLow];
    //[qrImage retain];
	//qrImage = [QRTools qrFromString:qrString withSize:500];
    qrImage = [self generateQRCodeWithString:qrString scale:1.0f];
    
	
    //cache, caching
    //1024*1024*10 = 10 MB
    int cacheSizeMemory = 4*1024*1024; // 4MB
    int cacheSizeDisk = 32*1024*1024; // 32MB
    //[[NSURLCache sharedURLCache] setMemoryCapacity:1024*1024*4]; //4mb
	//[[NSURLCache sharedURLCache] setDiskCapacity:1024*1024*32]; //32mb
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:sharedCache];
	//fix leak?
	//[[NSURLCache sharedURLCache] setMemoryCapacity:0];
	//[[NSURLCache sharedURLCache] setDiskCapacity:0];
	
	alertKeyVisible = NO;
	showedAlertRate = NO;
    enteredForegroundConvert = NO;
    alreadyLoaded = false;
    showingHelp = false;
	
    numAppsDownloaded = NO;
    numApps = 0;
    prefRunCount = 0;
    prefNumApps = 0;
    prefPurchasedRemoveAds = NO;
    savedAdImage = nil;
    adArray = nil;
    currentAdId = 0;
    currentAdUrl = @"";
    currentAdId2 = @"";
    inReview = YES;
    prefMailchimpCount = 0;
    prefMailchimpShown = YES;

	//title: On iPad devices, the UIStatusBarStyleDefault and UIStatusBarStyleBlackTranslucent styles default to the UIStatusBarStyleBlackOpaque appearance. 
    
	//if(isIpad())
    //if([Helpers isIpad])
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //else
    /*{
        if(SYSTEM_VERSION_LESS_THAN(@"7"))
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        }
        else
        {
            //UIStatusBarStyleDefault,UIStatusBarStyleLightContent
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }
    }
    */
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
       
    /*if(false)
    {
        
        //notifications
        [[UIApplication sharedApplication]
         registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                             UIRemoteNotificationTypeSound |
                                             UIRemoteNotificationTypeAlert)];
    }
     */
    
    isOnline = [self checkOnline];
    
    //testflight
#if USE_TESTFLIGHT
    if([self isTestflight])
	{
        [TestFlight takeOff:@"???"];
    }
#endif
    
    //inits
    [Helpers initGoogleAnalytics];
    [Helpers initMailChimp:self];
    
    //segment.io
    // If you want to see debug logs from inside the SDK.
    //[Analytics debug:YES];
    // Initialize the Analytics instance with the
    // write key for skyriser/passwordgrid

    
    //facebook 
    //facebook = [[Facebook alloc] initWithAppId:@"???" andDelegate:self];
    
    
    /*
     When a tester passes a level, or adds a new todo item, you can pass a checkpoint. The checkpoint progress is used to provide insight into how your testers are testing your apps. The passed checkpoints are also attached to crashes, which can help when creating steps to replicate.
     
     [TestFlight passCheckpoint:@"CHECKPOINT_NAME"]; Use passCheckpoint: to track when a user performs certain tasks in your application. This can be useful for making sure testers are hitting all parts of your application, as well as tracking which testers are being thorough.

     To launch unguided feedback call the openFeedbackView method. We recommend that you call this from a GUI element.
     
     -(IBAction)launchFeedback {
     [TestFlight openFeedbackView];
     }
     
     Once users have submitted feedback from inside of the application you can view it in the feedback area of your build page.

     
      
    */
      
    /*
     Device Token=<7e6a5272 16576f16 5143b8c4 64163f6e a07db394 d97696ba ef2cdfb0 302e258d>
     
     
     7e6a527216576f165143b8c464163f6ea07db394d97696baef2cdfb0302e258d
     */
    
    
    //urban airship
    /*if(USE_AIRSHIP == 1)
    {
        //iphone: 15aa6d35e8f3899fede650bc613eb6f4cfe9df9d
        
        //Init Airship launch options
        NSMutableDictionary *takeOffOptions = [[[NSMutableDictionary alloc] init] autorelease];
        [takeOffOptions setValue:launchOptions forKey:UAirshipTakeOffOptionsLaunchOptionsKey];
        
        // Create Airship singleton that's used to talk to Urban Airship servers.
        // Please populate AirshipConfig.plist with your info from http://go.urbanairship.com
        [UAirship takeOff:takeOffOptions];
        
        
    }    */

    
    
	//pool = [[NSAutoreleasePool alloc] init];
	
	//matrixArray = [NSMutableArray arrayWithCapacity: 36];
	matrixArray = [NSMutableArray arrayWithCapacity: (36 + NUMSYMBOLS)];
	//[matrixArray retain];
	
	textBackColor = [UIColor colorWithRed:245/255.f green:250/255.f blue:217/255.f alpha:255/255.f ];	
	//[textBackColor retain];
	
	
	[self loadState];
	
	if(!prefRemember)
	{
		keyString = @"";
		[self saveState];
	}
	
    
    
    //tapfortap, after loadstate
    /*if([self isTapForTap])
    {
        [TapForTap setDefaultAppId: @"f510dca0-6b8f-012f-b566-4040fb5b0b0c"]; //to validate
        [TapForTap checkIn];
    }*/
    
    //modals
    //convertViewController = [[ConverViewController alloc] initWithNibName:@"ConvertView" bundle:nil];
    modalHelp = [[WelcomeViewController alloc] initWithNibName:@"WelcomeView" bundle:nil];
    modalQR = [[QRViewController alloc] initWithNibName:@"QRView" bundle:nil];
    modalKey = [[KeyViewController alloc] initWithNibName:@"KeyView" bundle:nil];
    
    //force
    //convertViewController.view.hidden = NO;

   
   // http://stackoverflow.com/questions/1941103/can-i-give-a-uitoolbar-a-custom-background-in-my-iphone-app
    
    
	//wait, show default longer, ugly but good enough for now
    //http://stackoverflow.com/questions/5618163/displaying-splash-screen-for-longer-than-default-seconds
    //[NSThread sleepForTimeInterval:1.0];
    

	//ping
	//[self ping];
   	
	//analytics
    
    if(USE_ANALYTICS == 1)
	{
		// NSLog(@"USE_ANALYTICS == 1");
		//events:
		//[[LocalyticsSession sharedLocalyticsSession] tagEvent:@"INTERESTING_EVENT"];
		//http://wiki.localytics.com/doku.php?id=iphone_integration
		
		//[[LocalyticsSession sharedLocalyticsSession] startSession:@"6e83a32d665c8e73adc48fc-f58a711e-2ba2-11df-15ed-004a79fcdfe1"];
        //[FlurryAnalytics startSession:@"1ZTKR7ZQ6S12C4PH8T6B"];
		
	}
	else
	{
		NSLog(@"USE_ANALYTICS == 0");
	}
    
    //sharekit setup
    /*DefaultSHKConfigurator *configurator = [[ShareKitDemoConfigurator alloc] init];
    [SHKConfiguration sharedInstanceWithConfigurator:configurator];
    [SHK flushOfflineQueue]; //offline
    */
    
    //ui
	[self setupUI];
    
    if([[self keyString]  length] == 0 && ([self prefRemember] == NO)) //switch to settings
    {
        self.tabBarController.selectedIndex = 2;
    }
    else if(prefDefaultConvert) //switch to convert
    {
        self.tabBarController.selectedIndex = 1;
    }
    
    //wait?
    //force wait, show default longer, ugly but good enough for now
    //[NSThread sleepForTimeInterval:0.2];

    //[self performSelectorOnMainThread:@selector(checkLaunchOrientation:) withObject:nil waitUntilDone:NO];

       
    //test, force exception
    //[NSException raise:@"Test" format:@"Testing"];

    //facebook login
    //[self facebookLogin];
    
    //badge
    [self updateNumAppsBadge];
    
     //IAP
	[self loadIAP];
    
    [self updateInReview];
    
     // Add the tab bar controller's current view as a subview of the window
    //[window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
    //window.rootViewController = tabBarController;
    [window setRootViewController: tabBarController];

    //can do help now    
    //[firstViewController setupUI];
	
	[self fadeDefaultSetup];
    
    //mailchimp
    [Helpers shouldShowMailChimp];
    
    tabBarController.delegate = self;
    
    return YES;
}

-(void) applicationWillEnterForeground:(UIApplication *)application
{
    if(USE_ANALYTICS == 1)
	{
        //[[LocalyticsSession sharedLocalyticsSession] resume];
        //[[LocalyticsSession sharedLocalyticsSession] upload];
    }
    
    isOnline = [self checkOnline];
    
	//causeing boris bug?
    //alreadyLoaded = false;
	
	enteredForegroundConvert = true;
    
	if(!prefRemember)
	{
		keyString = @"";
		[self saveState];
	}
	
	
	[self setupUI];
	
	//coming from background

	//[self saveState];
    
    //notification
    //[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}


-(void) applicationDidEnterBackground:(UIApplication *)application
{
    alreadyLoaded = false;
    
	//going to background
    
    if(!prefRemember)
    {
		keyString = @"";
	}
    
	[self saveState];
	
	
	if(USE_ANALYTICS == 1)
	{
		// Close Localytics Session
		//[[LocalyticsSession sharedLocalyticsSession] close];
		//[[LocalyticsSession sharedLocalyticsSession] upload];
	}
	
	
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self applicationDidEnterBackground:application];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kBackgroundNotification
                                                        object:self
                                                      userInfo:nil];

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self applicationWillEnterForeground:application];
    
     //notifications
    [self setupNotifications];
    
    //track facebook app install ads
    //[FBSettings setDefaultAppID:FACEBOOK_APP_ID];
    //[FBAppEvents activateApp];

}

-(BOOL)backgroundSupported
{
	UIDevice* device = [UIDevice currentDevice];
	BOOL tempBackgroundSupported = NO;
	if ([device respondsToSelector:@selector(isMultitaskingSupported)])
		tempBackgroundSupported = device.multitaskingSupported;
	
	return tempBackgroundSupported;
}


//https://gist.github.com/1323251
- (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

- (NSString *) platformString{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    
	if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5";

    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (CDMA)";

    //ipad 4
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4";
    
    //ipad mini
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad mini (Wifi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad mini";

    //sim
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}

- (BOOL) isTestflight
{
    return NO;
}

- (NSString *) getSecureID
{
    /*NSString *domain     = @"com.skyriser.passwordgrid";
    NSString *key        = @"8gjh8f67dgydfjd";
    NSString *identifier = @[SecureUDID UDIDForDomain:domain usingKey:key];
    // The returned identifier is a 36 character (128 byte + 4 dashes) string that is unique for that domain, key, and device tuple
    
    return identifier;*/
    
    return @"?";
}

- (BOOL) isTapForTap
{
    BOOL value = false;
    //value =  prefTap && ![Helpers isIpad]; //iphone only, no ipad
    
    //value =  prefTap; //all
    
    return value;
 }


-(void) setupUI
{
	
	[self setupSeed];
	
	//count
	prefRunCount++;
	if(prefRunCount >= 10000)
		prefRunCount= 10000;
	
	[self saveState];
	
	if(false)
	//if(true)
	//if(prefRunCount == 5 && (prefRated == NO))
	{
		
		[self alertRate];
		showedAlertRate = YES;
	}	
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    //empty cache
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
     //#import "UIAlertView+Errors.h"
    //if([Helpers isDebug])
    //    [UIAlertView showError:@"applicationDidReceiveMemoryWarning" withTitle:@"Error"];
    NSLog(@"applicationDidReceiveMemoryWarning");
}

/*-(void)checkLaunchOrientation:(id)sender{

     UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;    
     BOOL isLandscape = UIDeviceOrientationIsLandscape(self.interfaceOrientation);

     if (UIInterfaceOrientationIsLandscape(orientation) || isLandscape) {
       //do stuff here
     }
}*/


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken 
{
    // Updates the device token and registers the token with UA
    /*if(USE_AIRSHIP == 1)
	{
        UALOG(@"APN device token: %@", deviceToken);
        
        // Set some commonly used tags by OR'ing UATagType values
        NSArray *tags = [UATagUtils createTags:
                         (UATagTypeTimeZoneAbbreviation
                          | UATagTypeLanguage
                          | UATagTypeCountry
                          | UATagTypeDeviceType)];
        
        NSDictionary *info = [[NSMutableDictionary alloc] initWithObjectsAndKeys:tags, @"tags", nil];
        
        // Updates the device token and registers the token with UA
        [[UAirship shared] registerDeviceToken:deviceToken withExtraInfo:info];
        
        //[[UAirship shared] registerDeviceToken:deviceToken];
    }*/
    
    
    
    
   // NSString *str = [NSString stringWithFormat:@"Device Token=%@",deviceToken];
    
    //NSLog(@"%@", str);
}


- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    for (id key in userInfo) {
        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
	if(USE_ANALYTICS == 1)
	{
		// Close Localytics Session
		//[[LocalyticsSession sharedLocalyticsSession] close];
		//[[LocalyticsSession sharedLocalyticsSession] upload];
	}
    
    /*if(USE_AIRSHIP == 1)
	{
        [UAirship land];
    }*/
}

-(void) playSound:(NSString*)filename
{
    //disabled
    return;
    
	if(!prefPlaySound)
		return;
    
    //invalid filename
    if( (filename == nil) || ([filename length] <= 0 ) || [filename isEqualToString:@""])
        return;
	
    //http://www.iphonedevsdk.com/forum/iphone-sdk-development/2940-help-please-playing-short-sound-tutorial-not-working.html
    //http://blogs.x2line.com/al/archive/2011/05/19/3831.aspx
    //http://iphone-dev-tips.alterplay.com/2009/12/shortest-way-to-play-sound-effect-on.html
    //http://stackoverflow.com/questions/818515/iphone-how-to-make-key-click-sound-for-custom-keypad
    
    
    
    NSString *path  = [[NSBundle mainBundle] pathForResource : filename ofType :@"wav"];
    if ([[NSFileManager defaultManager] fileExistsAtPath : path])
    {
        NSURL *pathURL = [NSURL fileURLWithPath : path];
        //AudioServicesCreateSystemSoundID((CFURLRef) pathURL, &audioEffect);
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);

        AudioServicesPlaySystemSound(audioEffect);
    }
    else
    {
        NSLog(@"error, file not found: %@", path);
    }
    
    
}



// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    [HapticHelper generateFeedback:kFeedbackType];
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)loadState
{
    if(alreadyLoaded)
        return;
    
    alreadyLoaded= true;
    
    
	//prefs
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
    //set defaults
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:NO], @"prefTap",
                                 [NSNumber numberWithBool:YES], @"prefPlaySound",
                                 [NSNumber numberWithBool:YES], @"prefRemember",
                                 [NSNumber numberWithBool:NO], @"prefUppercase",
                                 [NSNumber numberWithBool:NO], @"prefSymbols",
                                 [NSNumber numberWithBool:NO], @"prefRated",
                                 [NSNumber numberWithBool:YES], @"prefNumbers",
                                 [NSNumber numberWithBool:NO], @"prefDefaultConvert",
                                 [NSNumber numberWithBool:NO], @"prefAutocopy",
                                 [NSString stringWithFormat:@""], @"keyString",
                                 [NSString stringWithFormat:@""], @"prefVersion",
                                 [NSNumber numberWithDouble:0], @"lastTimeSince70",
                                 [NSNumber numberWithDouble:0], @"prefRunCount",
                                 [NSNumber numberWithDouble:0], @"prefNumApps",
                                 [NSNumber numberWithBool:NO], @"prefPurchasedRemoveAds",
                                 [NSNumber numberWithDouble:APP_ID_DAILYWALL], @"currentAdId",
                                 [NSNumber numberWithDouble:0], @"prefMailchimpCount",
                                 [NSNumber numberWithBool:NO], @"prefMailchimpShown",

                                 nil];

    [prefs registerDefaults:appDefaults];
		
	prefOpened = [prefs boolForKey:@"prefOpened"];

    #ifdef DEBUG
        //force
        //prefOpened = NO;
    #endif

	if(prefOpened == NO)
	{
		[self saveStateDefault];
	}
	else
	{
        prefPurchasedRemoveAds = [prefs boolForKey:@"prefPurchasedRemoveAds"];
		prefRunCount = [prefs integerForKey:@"prefRunCount"];
		prefNumApps = [prefs integerForKey:@"prefNumApps"];
		//prefRunCount = 2;
		prefRemember = [prefs boolForKey:@"prefRemember"];
		prefUppercase = [prefs boolForKey:@"prefUppercase"];
		prefSymbols = [prefs boolForKey:@"prefSymbols"];
		prefRated = [prefs boolForKey:@"prefRated"];
		prefNumbers = [prefs boolForKey:@"prefNumbers"];
		prefDefaultConvert = [prefs boolForKey:@"prefDefaultConvert"];
        currentAdId = [prefs integerForKey:@"currentAdId"];

        prefMailchimpCount = [prefs integerForKey:@"prefMailchimpCount"];
        prefMailchimpShown = [prefs boolForKey:@"prefMailchimpShown"];
		prefAutocopy = NO;
		prefPlaySound = [prefs boolForKey:@"prefPlaySound"];
       
        //prefTap = YES;
        prefTap = [prefs boolForKey:@"prefTap"];
        
		keyString = [prefs stringForKey:@"keyString"];
		
        lastTimeSince70 = [prefs doubleForKey:@"lastTimeSince70"];
        
        if(prefRemember == NO)
		{
			keyString = @"";
		}
        
        NSString *newPrefVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];

        prefVersion = newPrefVersion;
        
	}
    
    //prefs encrypted
    PDKeychainBindings *prefs2 = [PDKeychainBindings sharedKeychainBindings];
    
    NSString * tempString = [prefs2 stringForKey:@"keyString"];
    if(tempString != nil)
        keyString = tempString;
    
    

}

/*
- (void)facebookLogin
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharerAuthorized:) name:@"SHKAuthDidFinish" object:nil];

     //login
    SHKSharer *service = [[SHKFacebook alloc] init];
    [service authorize];


}*/

/*- (void)sharerAuthorized:(NSNotification *)notification {

     NSLog(@"AppDelegate::sharerAuthorized");
    
}
*/


- (BOOL)handleOpenURL:(NSURL*)url
{
     NSLog(@"AppDelegate::handleOpenURL");

	/*(NSString* scheme = [url scheme];
    if ([scheme hasPrefix:[NSString stringWithFormat:@"fb%@", SHKCONFIG(facebookAppId)]])
        return [SHKFacebook handleOpenURL:url];
    */
    
    //return [facebook handleOpenURL:url]; 
    
    return YES;
}

- (BOOL)application:(UIApplication *)application 
            openURL:(NSURL *)url 
  sourceApplication:(NSString *)sourceApplication 
         annotation:(id)annotation 
{
     NSLog(@"AppDelegate::openURL");

    return [self handleOpenURL:url];
    
    //return YES;
    
}

- (BOOL)application:(UIApplication *)application 
      handleOpenURL:(NSURL *)url 
{
     NSLog(@"AppDelegate::handleOpenURL");

    return [self handleOpenURL:url];  
}

/*- (void)fbDidLogin {

     NSLog(@"AppDelegate::facebook:fbDidLogin");

    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    //[defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    //[defaults synchronize];
    
    //get data
    [facebook requestWithGraphPath:@"me?fields=id,name" andDelegate:self];  
    
    //test
    //NSLog(@"AppDelegate::fbDidLogin: user:%@", [facebook id] );

    //[facebook logout];
}
*/
/*
- (void)request:(FBRequest *)request didLoad:(id)result {

  NSLog(@"AppDelegate::facebook:request:didLoad: Result: %@", result);
  NSDictionary *userInfo = (NSDictionary *)result;
  facebook_name = [userInfo objectForKey:@"name"];
  facebook_id = [userInfo objectForKey:@"id"];
  
  NSLog(@"facebook_id: %@", facebook_id);
  NSLog(@"facebook_name: %@", facebook_name);
}
*/
/*
- (void) fbDidLogout {
     NSLog(@"AppDelegate::facebook:fbDidLogout");

    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
}
*/
/*
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"received response");
     NSLog(@"AppDelegate::facebook:request:didReceiveResponse");
    
}
*/
/*
-(void)fbDidNotLogin:(BOOL)cancelled 
{
     NSLog(@"AppDelegate::fbDidNotLogin");
    //[pendingApiCallsController userDidNotGrantPermission];
}
*/
/*
-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
   
    NSLog(@"AppDelegate::facebook:fbDidExtendToken");
    //NSLog(@"token extended");
    //[self storeAuthData:accessToken expiresAt:expiresAt];
}
*/
/*
- (void)fbSessionInvalidated {

    NSLog(@"AppDelegate::facebook:fbSessionInvalidated");


    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception"
                              message:@"Your session has expired."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    [alertView release];
    [self fbDidLogout];
}
*/



- (void)saveState
{
   
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setBool:prefOpened forKey:@"prefOpened"];
	
	[prefs setBool:prefRemember forKey:@"prefRemember"];
	/*if(prefRemember)
		[prefs setObject:keyString forKey:@"keyString"];
	else 
		[prefs setObject:@"" forKey:@"keyString"];*/
    
    //always empty, now encrypted
    [prefs setObject:@"" forKey:@"keyString"];

    
    prefVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [prefs setObject:prefVersion forKey:@"prefVersion"];
    
	[prefs setBool:prefRemember forKey:@"prefRemember"];
	[prefs setBool:prefUppercase forKey:@"prefUppercase"];
	[prefs setBool:prefSymbols forKey:@"prefSymbols"];
	[prefs setBool:prefRated forKey:@"prefRated"];
	
	[prefs setBool:prefNumbers forKey:@"prefNumbers"];
	[prefs setBool:prefDefaultConvert forKey:@"prefDefaultConvert"];
    
	[prefs setBool:prefAutocopy forKey:@"prefAutocopy"];
	[prefs setBool:prefPlaySound forKey:@"prefPlaySound"];
	[prefs setInteger:prefRunCount forKey:@"prefRunCount"];
	[prefs setInteger:prefNumApps forKey:@"prefNumApps"];
    [prefs setInteger:currentAdId forKey:@"currentAdId"];
    [prefs setBool:prefPurchasedRemoveAds forKey:@"prefPurchasedRemoveAds"];

    [prefs setInteger:prefMailchimpCount forKey:@"prefMailchimpCount"];
    [prefs setBool:prefMailchimpShown forKey:@"prefMailchimpShown"];

    //prefTap?
    
    if(lastTimeSince70 == 0)
        lastTimeSince70 = [[NSDate date] timeIntervalSince1970];
    
    [prefs setDouble:lastTimeSince70 forKey:@"lastTimeSince70"];
	
   
	[prefs synchronize];
    
    
    //prefs encrypted
    PDKeychainBindings *prefs2 = [PDKeychainBindings sharedKeychainBindings];
    if(prefRemember)
		[prefs2 setObject:keyString forKey:@"keyString"];
	else 
		[prefs2 setObject:@"" forKey:@"keyString"];
	
}

- (void)saveStateDefault
{
	//prefOpened = YES;
	keyString = @"";
	prefRemember = YES;
	prefUppercase = NO;
	prefSymbols = NO;
	prefRated = NO;
	prefNumbers = YES;
    prefDefaultConvert = NO;
	//prefAutocopy  = YES;	
	prefAutocopy  = NO;	
	prefPlaySound = YES;
	//prefPlaySound = NO;
	prefRunCount = 0;
    prefNumApps = 0;
    prefTap = NO;
    prefPurchasedRemoveAds = NO;

    //version
    prefVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    //lastTime = [NSDate date];
    if(lastTimeSince70 == 0)
        lastTimeSince70 = [[NSDate date] timeIntervalSince1970];
    
	[self saveState];
}

- (void)alertHelpFirstTime
{
    NSLog(@"alertHelpFirstTime");

	[self setShowingHelp:YES];

    [self alertHelp:YES];
}

- (void)alertHelp:(BOOL)isAnimated
{
    NSLog(@"alertHelp");

	if(USE_ANALYTICS == 1)
	{
		//[[LocalyticsSession sharedLocalyticsSession] tagEvent:@"alertHelp"];
        //[FlurryAnalytics logEvent:@"alertHelp"];

	}
		
    //return;
   	//force orientation
    /*if([Helpers isIpad])
    {
        [[self tabBarController] presentViewController:modalHelp animated:NO completion:NULL];

        [[self tabBarController] dismissViewControllerAnimated:NO completion:nil];
    }*/
    
    [[self tabBarController] presentViewController:modalHelp animated:isAnimated completion:NULL];
    //[[self tabBarController]  presentModalViewController:modalHelp animated:YES];

}


- (void)alertQR:(BOOL)isAnimated
{
	
	if(USE_ANALYTICS == 1)
	{
		//[[LocalyticsSession sharedLocalyticsSession] tagEvent:@"alerQR"];
        //[FlurryAnalytics logEvent:@"alerQR"];

	}
	
	//force orientation
    /*if([Helpers isIpad])
    {
        [[self tabBarController] presentViewController:modalQR animated:NO completion:NULL];

        [[self tabBarController] dismissViewControllerAnimated:NO completion:nil];
    }*/
    
    [[self tabBarController] presentViewController:modalQR animated:isAnimated completion:NULL];
}

- (void)alertAskKey
{
    NSLog(@"alertAskKey");
    
    //force orientation
    /*if([Helpers isIpad])
    {
        [[self tabBarController] presentViewController:modalKey animated:NO completion:NULL];

        [[self tabBarController] dismissViewControllerAnimated:NO completion:nil];
    }*/
    
    [[self tabBarController] presentViewController:modalKey animated:NO completion:NULL];
}

- (void)alertKey
{
    NSLog(@"alertKey");

    /*if(!prefRemember) //don't annoy
    {
        //go to settings
        alertKeyVisible = false;
        //self.tabBarController.selectedIndex = 2;
        return;
    }*/
    
	if(alertKeyVisible)
		return;
	
	// open a alert with an OK and cancel button
	alertKeyVisible = true;
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Key is empty!" 
						message:@"You must enter a Key in the Settings section to generate a Grid."
						delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
    
    [HapticHelper generateFeedback:kFeedbackType];

	//[alert release];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    //if (buttonIndex == 1) {
        // do stuff
    //}
	
	alertKeyVisible = false;
    
    //go to settings
    self.tabBarController.selectedIndex = 2;
}



- (void)alertEmpty
{
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nothing to copy!" 
													message:@"You must enter a password to be able to copy it."
												   delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	//[alert release];
	
}



- (void)alertComingSoon
{
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Coming soon!" 
													message:@"This feature is not yet available."
												   delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	//[alert release];
}

- (void)alertMoreDone
{
	[ [self tabBarController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertHelpDone
{
    NSLog(@"alertHelpDone");

    [ [self tabBarController] dismissViewControllerAnimated:YES completion:nil];

}

- (void)alertHelpDoneFirstTime
{
    NSLog(@"alertHelpDoneFirstTime");

    [ [self tabBarController] dismissViewControllerAnimated:NO completion:nil];
    
	//ask key, after help
	[self alertAskKey];
}

- (void)alertHelpDoneNotAnimated
{
	[ [self tabBarController] dismissViewControllerAnimated:NO completion:nil];
}


- (void)alertRate
{
    return;
    
    /*
	if(USE_ANALYTICS == 1)
	{
		[[LocalyticsSession sharedLocalyticsSession] tagEvent:@"alertRate"];
	}
	
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Like This App?" 
													//message:@"Please rate it in the App Store!"
                                                message:@"Please rate it in the App Store, so we can keep making more great apps!"
                                                delegate:self cancelButtonTitle:@"No Thanks" 
												otherButtonTitles:@"Rate It!", nil];
    
    [alert show];
	[alert release];
     */
}

- (void) alertView:(UIAlertView*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		NSLog(@"cancel");
	}
	else
	{
		NSLog(@"ok");
		//	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.skyriser.com/iphone"]];
		//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.com/app/app_name"]];
		//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.com/app/ScanLife"]];
		//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://phobos.com/app/ScanLife"]];

		//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.com/app/PasswordGrid"]];
		
		[self gotoReviews];
	}
	
	showedAlertRate = NO;
}

- (void)gotoQRScannerApp
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/en/app/scan/id411206394?mt=8"]];
}

- (void)gotoTwitter
{
    
    //if ([self openURL:[NSURL URLWithString:@"tweetie:///user?screen_name=PasswordGrid"]]) //tweetie
    //    return;
    
     //if ([self openURL:[NSURL URLWithString:@"tweetbot://user_profile/PasswordGrid"]]) //tweetbot
     //   return;
    
    //if ([self openURL:[NSURL URLWithString:@"twitter:///user?screen_name=PasswordGrid"]]) //twitter
    //   return;
        
    //[self openURL:[NSURL URLWithString:@"http://twitter.com/PasswordGrid"]]; //web

	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/passwordgrid"]];

}

- (void)gotoFacebook
{
	/*	
	 <a href="http://www.facebook.com/pages/Password-Grid/169115183113120"  target='_blank'>Facebook</a>
	 
	 <iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.facebook.com%2Fpages%2FPassword-Grid%2F169115183113120&amp;layout=button_count&amp;show_faces=true&amp;width=450&amp;action=like&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:100px; height:21px;" allowTransparency="true"></iframe>
	 
	*/
	
	//fb://profile/passwordgrid
	//fb://profile/210227459693
	
	//NSURL *fanPageURL = [NSURL URLWithString:@"fb://passwordgrid"];
	
	//if(true)
	//if (![[UIApplication sharedApplication] openURL: fanPageURL]) 
	{
        //fanPageURL failed to open.  Open the website in Safari instead
        //NSURL *webURL = [NSURL URLWithString:@"http://www.facebook.com/pages/Password-Grid/169115183113120"];
		
		NSURL *webURL = [NSURL URLWithString:@"http://www.facebook.com/PasswordGrid"];
        [[UIApplication sharedApplication] openURL: webURL];
	}
	

}

- (void)gotoReviews
{
	if(USE_ANALYTICS == 1)
	{
		//[[LocalyticsSession sharedLocalyticsSession] tagEvent:@"gotoReviews"];
        //[FlurryAnalytics logEvent:@"gotoReviews"];

	}
	
    /*NSString *str = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa";
    str = [NSString stringWithFormat:@"%@/wa/viewContentsUserReviews?", str]; 
    str = [NSString stringWithFormat:@"%@type=Purple+Software&id=", str];
	
    // Here is the app id from itunesconnect
    str = [NSString stringWithFormat:@"%@289382458", str]; 
	
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
	*/
	
	prefRated = YES;
	[self saveState];
	
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=359807331&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8"]];
}

/*- (void)openAppStore:(id)sender {

    //test
    if(!currentAdId2 || [currentAdId2 length] == 0)
        return;
    
    // Initialize Product View Controller
    SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
 
    // Configure View Controller
    [storeProductViewController setDelegate:self];
    [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : currentAdId2} completionBlock:^(BOOL result, NSError *error) {
        if (error) {
            NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
 
        } else {
            // Present Store Product View Controller
            [tabBarController presentViewController:storeProductViewController animated:YES completion:nil];
        }
    }];
}*/

/*- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [tabBarController dismissViewControllerAnimated:YES completion:nil];
}*/


- (void)gotoAd
{
    //[self openAppStore:nil];
    
    if(currentAdUrl == nil || [currentAdUrl length] <= 0)
        return;

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:currentAdUrl]];
}

/*- (void)gotoGift
{
	if(USE_ANALYTICS == 1)
	{
		[[LocalyticsSession sharedLocalyticsSession] tagEvent:@"gotoGift"];
	}
	
	[self saveState];
	
	
    //http://stackoverflow.com/questions/5197035/gift-app-from-inside-the-app
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/giftSongsWizard?gift=1&salableAdamId=359807331&productType=C&pricingParameter=STDQ"]];
}*/

- (void) mailComposeController:(MFMailComposeViewController*)controller
		   didFinishWithResult:(MFMailComposeResult)result
						 error:(NSError*)error
{
	if(result == MFMailComposeResultSent)
	{
		NSLog(@"mail sent");
	}
	
	
	[tabBarController dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendEmailTo:(NSString *)to withSubject:(NSString *)subject withBody:(NSString *)body withView:(UIViewController*)theView
{
    
    //todo: test if mail account
    if (![MFMailComposeViewController canSendMail])
    {
        return;
    }

        
	//old way
	
	/*
	 NSString *mailString = [NSString stringWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
	 [to stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding], 
	 [subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding], 
	 [body stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	 
	 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
	 */
	
	//new way 
	
	NSArray *recipients = [[NSArray alloc] initWithObjects:to, nil];
	NSArray *recipientEmpty = [[NSArray alloc] init];
	
	
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	[controller setSubject:subject];
	[controller setMessageBody:body isHTML:NO];
    
    //color
    //[[controller navigationBar] setTintColor:[UIColor blackColor]];
    //[[controller navigationBar] setTintColor:tabBarController.tabBar.tintColor];
    //[[controller navigationBar] setTintColor:tabBarController.tabBar.selectedImageTintColor];
    //self.tabBar.tintColor = RGBA(0, 30, 0, 245);   //green
    // self.tabBar.selectedImageTintColor = RGBA(110,153,59, 245);   //green

    
	if([to  length] == 0)
		[controller setToRecipients: recipientEmpty];
	else
		[controller setToRecipients: recipients];
	
    [ theView presentViewController:controller animated:YES completion:NULL];
    
	//[controller release];
	
	//[recipients release];
	//[recipientEmpty release];
	
}


- (void)setupSeed
{
	//NSLog(@"setupSeed");
	
	mSeed = [[self string_to_ascii:keyString] intValue];
	
	srand(mSeed);
	//srand(time(NULL));
	
	//matrixArray = [NSMutableArray arrayWithCapacity: 36];
	//[matrixArray retain];
	
	//[]
	[matrixArray removeAllObjects];
	
	for(int i=0; i<(36+NUMSYMBOLS); i++)
	{	
		[matrixArray addObject: [self getRandom]];

	}
	
	
}

-(void) testFlightFeedback
{
#if USE_TESTFLIGHT
    if([self isTestflight])
	{
      [TestFlight openFeedbackView];
    }
#endif
}


-(void) ping
{
	
	NSLog(@"ping triggered");
	
	/*
	//NSAutoreleasePool *tempPool = [[NSAutoreleasePool alloc] init];
	
	NSURL *url=[NSURL URLWithString:@"???"];
	//NSString *content = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
	
	NSString *data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
	//NSData *data = [[NSData alloc] stringWithContentsOfURL:url];
	
	
	//[url release];
	//[data release];
	
	//[tempPool drain];
	//[tempPool release];
	
	//NSLog(content);
	 */
}

- (NSString*) getRandom
{
    NSString *returnString = nil;

	//if([keyString  isEqualToString: @""])
	if([keyString  length] == 0)
	{
		//return @"? ?";
        returnString = [NSString stringWithFormat: @"? ?"];
	}
	else
	{
	
        NSString *first  = [self getRandomLetter];
        NSString *second  = [self getRandomLetter];
        
        //if not different
        if([first  isEqualToString: second])
        {
            //return([self getRandom]);
            returnString = [self getRandom];
        }
        else
        {	//return [first stringByAppendingString: second];
            //returnString = [first stringByAppendingString: second];
            //returnString = [NSString stringWithFormat: @"%@ %@", first, second]; //space
            returnString = [NSString stringWithFormat: @"%@%@", first, second]; //no space
        }
    }
    
    return returnString;
}


- (NSString *)getGridString
{
	NSString *tempString = @"";
	NSString *spacing = @"   ";
	
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"a:%@%@", [self convert:@"a"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"b:%@%@", [self convert:@"b"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"c:%@%@", [self convert:@"c"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"d:%@%@", [self convert:@"d"], spacing]];
	tempString = [tempString stringByAppendingString: @"\n"];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"e:%@%@", [self convert:@"e"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"f:%@%@", [self convert:@"f"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"g:%@%@", [self convert:@"g"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"h:%@%@", [self convert:@"h"], spacing]];
	tempString = [tempString stringByAppendingString: @"\n"];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"i:%@%@", [self convert:@"i"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"j:%@%@", [self convert:@"j"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"k:%@%@", [self convert:@"k"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"l:%@%@", [self convert:@"l"], spacing]];
	tempString = [tempString stringByAppendingString: @"\n"];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"m:%@%@", [self convert:@"m"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"n:%@%@", [self convert:@"n"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"o:%@%@", [self convert:@"o"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"p:%@%@", [self convert:@"p"], spacing]];
	tempString = [tempString stringByAppendingString: @"\n"];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"q:%@%@", [self convert:@"q"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"r:%@%@", [self convert:@"r"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"s:%@%@", [self convert:@"s"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"t:%@%@", [self convert:@"t"], spacing]];
	tempString = [tempString stringByAppendingString: @"\n"];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"u:%@%@", [self convert:@"u"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"v:%@%@", [self convert:@"v"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"w:%@%@", [self convert:@"w"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"x:%@%@", [self convert:@"x"], spacing]];
	tempString = [tempString stringByAppendingString: @"\n"];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"y:%@%@", [self convert:@"y"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"z:%@%@", [self convert:@"z"], spacing]];

	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"0:%@%@", [self convert:@"0"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"1:%@%@", [self convert:@"1"], spacing]];
	tempString = [tempString stringByAppendingString: @"\n"];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"2:%@%@", [self convert:@"2"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"3:%@%@", [self convert:@"3"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"4:%@%@", [self convert:@"4"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"5:%@%@", [self convert:@"5"], spacing]];
	tempString = [tempString stringByAppendingString: @"\n"];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"6:%@%@", [self convert:@"6"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"7:%@%@", [self convert:@"7"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"8:%@%@", [self convert:@"8"], spacing]];
	tempString = [tempString stringByAppendingString: [NSString stringWithFormat: @"9:%@%@", [self convert:@"9"], spacing]];

	
	return tempString;
}

- (NSString *)randomCase:(NSString*)string
{
	NSString *tempString = string;
		
	
	if(prefUppercase == YES)
	{
		int randomNumber = 0;
		randomNumber = rand()%2;
		//NSLog(@"%d, ", randomNumber);
		
		if(randomNumber == 1)
		{
			tempString = [tempString uppercaseString];
		}
		
	}
	
	
	return tempString;
}

- (NSString*)getRandomLetter
{
	
	//if($seed == "")
	//	return "?"; 
	
	//if(false) 
	//	$number = rand(0,25); //letters
	//else if (true)
	NSString *returnString = @"";
	
	int randomNumber = 0;
	
	
	
	if(prefSymbols == NO)
	{
		randomNumber = rand()%35; //letters + numbers
	}
	else
	{
		randomNumber = rand()%(35+NUMSYMBOLS); //letters + numbers

	}
	
	
	if(!prefNumbers)
	{
		while((randomNumber >= 26) && (randomNumber <= 35))
		{
		
			if(prefSymbols == NO)
			{
				randomNumber = rand()%35; //letters + numbers
			}
			else
			{
				randomNumber = rand()%(35+NUMSYMBOLS); //letters + numbers
				
			}
		}
	}
	
	
	switch(randomNumber)
	{
			//letters
		case 0: returnString = @"a"; break;
		case 1: returnString = @"b"; break;
		case 2: returnString = @"c"; break;
		case 3: returnString = @"d"; break;
		case 4: returnString = @"e"; break;
		case 5: returnString = @"f"; break;
		case 6: returnString = @"g"; break;
		case 7: returnString = @"h"; break;
		case 8: returnString = [self getRandomLetter]; break; //"i"; break; 
		case 9: returnString = @"j"; break;
		case 10: returnString = @"j"; break;
		case 11: returnString = [self getRandomLetter]; break; //"l"; break;
		case 12: returnString = @"m"; break;
		case 13: returnString = @"n"; break;
		case 14: returnString = [self getRandomLetter]; break; //"o"; break;
		case 15: returnString = @"p"; break;
		case 16: returnString = @"q"; break;
		case 17: returnString = @"r"; break;
		case 18: returnString = @"s"; break;
		case 19: returnString = @"t"; break;
		case 20: returnString = @"u"; break;
		case 21: returnString = @"v"; break;
		case 22: returnString = @"w"; break;
		case 23: returnString = @"x"; break;
		case 24: returnString = @"y"; break;
		case 25: returnString = @"z"; break;
			
			//numbers
		case 26: returnString = [self getRandomLetter]; break; //"0"; break;
		case 27: returnString = [self getRandomLetter]; break; //"1"; break;
		case 28: returnString = @"2"; break;
		case 29: returnString = @"3"; break;
		case 30: returnString = @"4"; break;
		case 31: returnString = @"5"; break;
		case 32: returnString = @"6"; break;
		case 33: returnString = @"7"; break;
		case 34: returnString = @"8"; break;
		case 35: returnString = @"9"; break;
		
		//symbols
		case 36: returnString = @"#"; break;
		case 37: returnString = @"-"; break;
		case 38: returnString = @"@"; break;
		case 39: returnString = @"?"; break;
		case 40: returnString = @"%"; break;
			
		case 41: returnString = @"."; break;
		case 42: returnString = @"$"; break;
		case 43: returnString = @"&"; break;
		case 44: returnString = @"*"; break;
		case 45: returnString = @"+"; break;
			
		case 46: returnString = @"~"; break;
		case 47: returnString = @"{"; break;
		case 48: returnString = @"}"; break;
		case 49: returnString = @"/"; break;
		case 50: returnString = @":"; break;
			
		case 51: returnString = @"+"; break;
		case 52: returnString = @"="; break;
		case 53: returnString = @"!"; break;
			
			
		default: returnString = @"?"; break;
			
	}
	
	//uppercase
	if(randomNumber <= 25 )
	{
		returnString = [self randomCase:returnString];
	}
	
	return returnString;
}


- (void)setKey:(NSString*)string
{
	keyString = string;
}

- (NSString *)convert:(NSString*)string
{
    if(USE_ANALYTICS == 1)
	{
		//[[LocalyticsSession sharedLocalyticsSession] tagEvent:@"convert"];
        //[FlurryAnalytics logEvent:@"convert"];

	}
    
#if USE_TESTFLIGHT
    if([self isTestflight])
	{
        [TestFlight passCheckpoint:@"passwordmatrixAppDelegate:convert"];
    }
#endif
    
    NSString *returnString = @"";
    
    NSString *lower = @"";
    
    //lower case first
	lower=[string lowercaseString];
	
	for (int i = 0; i < [lower length]; i++)
	{									  	
		//$output = $output.getArray($input[$i]);
		returnString = [returnString stringByAppendingString: 
						[NSString stringWithFormat: @"%@", [self getArray:[lower characterAtIndex:i]]]];

	}
	
	return returnString;
}

-(NSString *)getArray:(int)index
{
	NSString *output = @"";
	
	switch(index)
	{
			//letters
		case 'a'	: 
		case 'b'	: 
		case 'c'	: 
		case 'd'	: 
		case 'e'	: 
		case 'f'	: 
		case 'g'	: 
		case 'h'	: 
		case 'i'	: 
		case 'j'	: 
		case 'k'	: 
		case 'l'	: 
		case 'm'	: 
		case 'n'	: 
		case 'o'	: 
		case 'p'	: 
		case 'q'	: 
		case 'r'	: 
		case 's'	: 
		case 't'	: 
		case 'u'	: 
		case 'v'	: 
		case 'w'	: 
		case 'x'	: 
		case 'y'	: 
		case 'z'	: 
			//$output = $matrixArray[ord($char)-97 ]; 
			//output = [output stringByAppendingString: @"%@", matrixArray[index-97]];
			
			output = [output stringByAppendingString: 
					  [NSString stringWithFormat: @"%@", [matrixArray objectAtIndex:(index-97)] ]];
			
			
			//output = [output stringByAppendingString: 
			//		  [NSString stringWithFormat: @"%@", @"ab" ]];
			
			
			//[NSString stringWithFormat: @"%@", [self getArray:[string characterAtIndex:i]]]];


			//$output = (ord($char)-97)."_"; 
			//$output = $matrixArray[0];
			//$output = $matrixArray[0]; 
			//$output = $char; 
			break;
			
			
			//numbers
		case '0'	: 
		case '1'	: 
		case '2'	: 
		case '3'	: 
		case '4'	: 
		case '5'	: 
		case '6'	: 
		case '7'	: 
		case '8'	: 
		case '9'	: 
			//$output = $matrixArray[ord($char)-48+26]; 
			//output = [output stringByAppendingString: matrixArray[index-48+26]];
			
			output = [output stringByAppendingString: 
					  [NSString stringWithFormat: @"%@", [matrixArray objectAtIndex:(index-48+26)] ]];

			//$output = $matrixArray[1]; 
			//$output = $char; 
			//$output = "?";
			break;
			
			//default: $output = "?"; 
		default: 
			//output = ""; 
			
			break;
			
	}
	
	return output;
	}

/*
function getArray($char)
{
	global $matrixArray;
	
	$output = "";
	//$output  = $char;
	//return $output ;
	
	//echo "<br>getArray: in: ".$char."<br>";		
	
	switch($char)
	{
			//letters
		case "a"	: 
		case "b"	: 
		case "c"	: 
		case "d"	: 
		case "e"	: 
		case "f"	: 
		case "g"	: 
		case "h"	: 
		case "i"	: 
		case "j"	: 
		case "l"	: 
		case "l"	: 
		case "m"	: 
		case "n"	: 
		case "o"	: 
		case "p"	: 
		case "q"	: 
		case "r"	: 
		case "s"	: 
		case "t"	: 
		case "u"	: 
		case "v"	: 
		case "w"	: 
		case "x"	: 
		case "y"	: 
		case "z"	: 
			$output = $matrixArray[ord($char)-97 ]; 
			//$output = (ord($char)-97)."_"; 
			//$output = $matrixArray[0];
			//$output = $matrixArray[0]; 
			//$output = $char; 
			break;
			
			
			//numbers
		case "0"	: 
		case "1"	: 
		case "2"	: 
		case "3"	: 
		case "4"	: 
		case "5"	: 
		case "6"	: 
		case "7"	: 
		case "8"	: 
		case "9"	: 
			$output = $matrixArray[ord($char)-48+26]; 
			//$output = $matrixArray[1]; 
			//$output = $char; 
			//$output = "?";
			break;
			
			//default: $output = "?"; 
		default: $output = ""; 
			
			break;
			
	}
	
	return $output;
	
	//echo "<br>getArray: out: ".$char."<br>";		
	
	
}
*/


- (NSString *)string_to_ascii:(NSString*)string
{
	NSString *returnString = @"";
	int  tempInt = 0;
	
	for(int i=0;i < [string length]; i++)
	{
		int c=[string characterAtIndex:i];
		//NSString *tempString = [NSString stringWithFormat: @"%d", i];
		
		tempInt = tempInt + c;
		//returnString = [returnString stringByAppendingString: [NSString stringWithFormat: @"%d", c]];
		
	}
	
	returnString = [NSString stringWithFormat: @"%d", tempInt];
	
	/*	$ascii = NULL;
	 
	 for ($i = 0; $i < strlen($string); $i++)
	 {
	 //$ascii += ord($string[$i]);
	 
	 $ascii = $ascii.ord($string[$i]);
	 }
	 
	 //echo "<br><br>string_to_ascii: in: ".$string."<br><br>";		
	 //echo "<br><br>string_to_ascii: out: ".$ascii."<br><br>";		
	 
	 return($ascii);
	 */
	return(returnString);
}

- (void)dealloc {
    //[tabBarController release];
    //[window release];
	
	//[matrixArray release];
	//[pool release];
	//[textBackColor release];
	
	//[keyString release];
	//[prefOpened release];
	//[prefRemember release];
	//[prefUppercase release];
	//[prefSymbols release];
	//[prefAutocopy release];
	
	//[modalHelp release];
    //[modalCredits release];
	//[modalKey release];
			
	//[navigationController release];
	
    //sounds
   AudioServicesDisposeSystemSoundID(audioEffect);
    
    
    //[super dealloc];
    
    //[qrImage release];
    
}

/*
-(int) genSize:(NSString *) myString; {
    
    int version = 4;
	int len = [myString length];
    
    if (len > 0 && len <19){
        version=2;
    }
    
    else if (len >= 19 && len <33){
        version=2;
    }
    
    else if (len >= 33 && len <54){
        version=3;
    }
    
    else if (len >= 54 && len <79){
        version=4;
    }
    
    else if (len >= 79 && len <107){
        version=5;
    }
    
    else if (len >= 107 && len <135){
        version=6;
    }
    
    else if (len >= 135 && len <155){
        version=9;
    }
    
    //#define MAX_URL_LEN 193
    else if (len >= 155 && len <193){
        version=9;
    }
    
    return version;
    
}
 */

-(UIImage*) getQRImage
{
    assert(qrImage);
    return qrImage;
}

- (UIImage*) createMaskWithImage: (UIImage*) inputImage
{
    CGImageRef image = inputImage.CGImage;
    
    int maskWidth               = CGImageGetWidth(image);
    int maskHeight              = CGImageGetHeight(image);
    //  round bytesPerRow to the nearest 16 bytes, for performance's sake
    int bytesPerRow             = (maskWidth + 15) & 0xfffffff0;
    int bufferSize              = bytesPerRow * maskHeight;
    
    //  allocate memory for the bits 
    CFMutableDataRef dataBuffer = CFDataCreateMutable(kCFAllocatorDefault, 0);
    CFDataSetLength(dataBuffer, bufferSize);
    
    //  the data will be 8 bits per pixel, no alpha
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef ctx            = CGBitmapContextCreate(CFDataGetMutableBytePtr(dataBuffer),
                                                        maskWidth, maskHeight,
                                                        8, bytesPerRow, colourSpace, kCGImageAlphaNone);
    //  drawing into this context will draw into the dataBuffer.
    CGContextDrawImage(ctx, CGRectMake(0, 0, maskWidth, maskHeight), image);
    CGContextRelease(ctx);
    
    //  now make a mask from the data.
    CGDataProviderRef dataProvider  = CGDataProviderCreateWithCFData(dataBuffer);
    CGImageRef mask                 = CGImageMaskCreate(maskWidth, maskHeight, 8, 8, bytesPerRow,
                                                        dataProvider, NULL, FALSE);
    
    CGDataProviderRelease(dataProvider);
    CGColorSpaceRelease(colourSpace);
    CFRelease(dataBuffer);
    
    UIImage *returnImage = [UIImage imageWithCGImage:mask];
    CGImageRelease(mask);
    return returnImage;
}


- (UIImage*) maskImage:(UIImage *)inputImage withMask:(UIImage *)inputMaskImage {
    
	//return inputImage;
    
    //http://stackoverflow.com/questions/2776747/masking-a-uiimage
    
    /*
     CGImageRef maskRef = inputMaskImage.CGImage; 
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([inputImage CGImage], mask);
    CGImageRelease(mask);
    
    UIImage *maskedImage = [UIImage imageWithCGImage:masked];
    
    return maskedImage;*/
    
    
    
    //http://stackoverflow.com/questions/1133248/any-idea-why-this-image-masking-code-does-not-work
    
    CGImageRef masked = CGImageCreateWithMask([inputImage CGImage], [[self createMaskWithImage: inputMaskImage] CGImage]);
    
    UIImage *returnImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    return returnImage;
}

/*
-(UIImage *)changeWhiteColorTransparent: (UIImage *)image
{
    CGImageRef rawImageRef=image.CGImage;
    
    const float colorMasking[6] = {222, 255, 222, 255, 222, 255};
    
    UIGraphicsBeginImageContext(image.size);
    CGImageRef maskedImageRef=CGImageCreateWithMaskingColors(rawImageRef, colorMasking);
    {
        //if in iphone
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0, image.size.height);
        CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0); 
    }
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height), maskedImageRef);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(maskedImageRef);
    UIGraphicsEndImageContext();    
    return result;
    
}
*/

-(UIImage *)colorizeImage: (UIImage *)image

{

    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(image.size);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    
    //UIColor *color = [UIColor colorWithRed:205.0f/255.0f green:222.0f/255.0f blue:177.0f/255.0f alpha:1.0f];
    UIColor *color = [UIColor colorWithRed:0.0f/255.0f green:73.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
      [color setFill];
      
      // translate/flip the graphics context (for transforming from CG* coords to UI* coords
      CGContextTranslateCTM(context, 0, image.size.height);
      CGContextScaleCTM(context, 1.0, -1.0);
      
      // set the blend mode to color burn, and the original image
    //CGContextSetBlendMode(context, kCGBlendModeMultiply);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
      
  /*
   
   kCGBlendModeNormal,
   kCGBlendModeMultiply,
   kCGBlendModeScreen,
   kCGBlendModeOverlay,
   kCGBlendModeDarken,
   kCGBlendModeLighten,
   kCGBlendModeColorDodge,
   kCGBlendModeColorBurn,
   kCGBlendModeSoftLight,
   kCGBlendModeHardLight,
   kCGBlendModeDifference,
   kCGBlendModeExclusion,
   kCGBlendModeHue,
   kCGBlendModeSaturation,
   kCGBlendModeColor,
   kCGBlendModeLuminosity,
   
   */
  
  
  
  CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
  CGContextDrawImage(context, rect, image.CGImage);
  
  // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
  CGContextClipToMask(context, rect, image.CGImage);
  CGContextAddRect(context, rect);
  CGContextDrawPath(context,kCGPathFill);
  
  // generate a new UIImage from the graphics context we drew onto
  UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
    
    return coloredImg;
}

- (BOOL)openURL:(NSURL*)url
{
    //BrowserViewController *bvc = [[BrowserViewController alloc] initWithUrls:url];
    //[self.navigationController pushViewController:bvc animated:YES];
   // [bvc release];
    
    //force wait, for sheet anim
    [NSThread sleepForTimeInterval:0.3];


    [[UIApplication sharedApplication] openURL:url];
    
    //[super openURL:url];
    
    //[[UIApplication sharedApplication] canOpenURL:
    //[NSURL URLWithString:@"googlechrome://"]];


    return YES;
}

//BOOL HasConnection()
- (BOOL)HasConnection
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];    
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if (internetStatus == NotReachable) 
    {
        //offline
        NSLog(@"AppDelegate::HasConnection: no");

        return false;
    }
    //else if (internetStatus == ReachableViaWiFi || internetStatus == ReachableViaWWAN)
    else
    {
        //online
        NSLog(@"AppDelegate::HasConnection: yes");

        return true;
    }
}

void uncaughtExceptionHandler(NSException *exception) 
{

    NSString *errorString = [NSString stringWithFormat:@"%s %@", __PRETTY_FUNCTION__, exception.description];
    NSLog(@"%@", errorString);
    
    //flurry
    //+ (void)logError:(NSString *)errorID message:(NSString *)message exception:(NSException *)exception;
    //+ (void)logError:(NSString *)errorID message:(NSString *)message error:(NSError *)error;
    if(USE_ANALYTICS == 1)
	{
        //ß[FlurryAnalytics logError:@"Uncaught" message:errorString exception:exception];
    }
    
    
    //alert
    //if([Helpers isDebug])
    #ifdef DEBUG
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                        message:errorString
                                                       delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    #endif        
}

- (NSString*) getUserAgent
{
    //append version
    NSString *agent = [NSString stringWithFormat:@"PasswordGrid-iOS-%@", [self getVersionString2]];
    return agent; 
}

- (NSString*)getVersionString
{
    NSString *debugString = [NSString stringWithFormat:@"%@", [Helpers isDebug]?@" (debug)":@""]; //add debug string
    NSString *output = [NSString stringWithFormat:@"%@%@",
						[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"], debugString];
	//NSLog(@"%@", [NSString stringWithFormat:@"getVersionString: %@", getVersionString2);
	
	return output;
}
- (NSString*)getVersionString2
{
    NSString *debugString = [NSString stringWithFormat:@"%@", [Helpers isDebug]?@" (debug)":@""]; //add debug string
	NSString *output = [NSString stringWithFormat:@"%@ (%@)%@",
						[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] ,
						[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
						debugString];
    
	//NSLog(@"%@", [NSString stringWithFormat:@"getVersionString2: %@", getVersionString2);
	
	return output;
}

-(void)cornerView:(UIView*)inView
{
    //disabled
    return;
    
    float radius = 0.0f;
    if([Helpers isIpad])
        radius = 5.0f;
    else
        radius = 5.0f;
    
    inView.layer.backgroundColor = [UIColor blackColor].CGColor;
    [inView.layer setMasksToBounds:YES];
    [inView.layer setCornerRadius:radius]; //5.0f or 8.0f?
    //inView.clipsToBounds = YES;
    //inView.layer.masksToBounds = YES;
}

-(void)updateNumAppsBadge
{
    int tempNumApps = [self getNumApps];
    int tabIndex = 3;
    
    //force
    //tempNumApps = 4;
    //[[ [tabBarController tabBar].items objectAtIndex:tabIndex] setBadgeValue:[NSString stringWithFormat:@"%d", tempNumApps]];
    //return;
    
    //ignore
    if(tempNumApps <=  prefNumApps)
    {
        [[ [tabBarController tabBar].items objectAtIndex:tabIndex] setBadgeValue:nil];
        return;
    }
    
    if([self getNumApps] > 0)
        [[ [tabBarController tabBar].items objectAtIndex:tabIndex] setBadgeValue:[NSString stringWithFormat:@"%d", tempNumApps]];
     else
        [[ [tabBarController tabBar].items objectAtIndex:tabIndex] setBadgeValue:nil];
}

-(void)hideNumAppsBadge
{
    int tabIndex = 3;
    [[ [tabBarController tabBar].items objectAtIndex:tabIndex] setBadgeValue:nil];
    
    //save
    if(numApps > prefNumApps)
    {
        prefNumApps = numApps;
        [self saveState];
    }
}

-(int)getNumApps
{
    if(![self HasConnection])
    {
        numApps = 0;
    }
    else
    {
        if(!numAppsDownloaded) //not yet updated
        {
            NSURL *datasourceURL = [NSURL URLWithString:URL_API_NUM_APPS];
            NSURLRequest *request = [NSURLRequest requestWithURL:datasourceURL];
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                        
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation* operation, id responseObject){
            
                //convert data to string, then string to int
                NSData* data =  [operation responseData];
                NSString* responseString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                numApps = [responseString intValue];
                numApps--; //dont count myself
                if(numApps < 0)
                    numApps = 0;
                else if(numApps > 99)
                    numApps = 99;
                
                numAppsDownloaded = YES;
                [self updateNumAppsBadge];

                
            }failure:^(AFHTTPRequestOperation* operation, NSError* error){
                numAppsDownloaded = NO;
                numApps = 0;
            }];
        
            [operation start];
            
            return 0;
        }
    }
    
    return numApps;
}

- (void)fadeDefaultSetup
{
    if([Helpers isIpad])
    {
        splash = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Default-Portrait" ofType:@"png"]]];
        CGRect tempRect = splash.frame;
        tempRect.origin.y = STATUS_BAR_HEIGHT;
        splash.frame = tempRect;
    }
    else if([Helpers isIphone5])
        splash = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Default-568h@2x" ofType:@"png"]]];
    else if([Helpers isRetina])
        splash = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Default@2x" ofType:@"png"]]];
    else
        splash = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Default" ofType:@"png"]]];
	
	splash.alpha = 1.0f;
	splash.hidden = NO;
	[self.window addSubview:splash];
	[[self window] bringSubviewToFront:splash];
}

- (void)fadeDefault
{
	if(alreadyFadeDefault)
		return;
    
	if(splash == nil)
        return;
    
	alreadyFadeDefault = YES;
	
	//wait?
    //force wait, show default longer, ugly but good enough for now
    //[NSThread sleepForTimeInterval:0.2];
	
    //fade
    //if(true)
    {
        //iphone
        //UIImageView *splash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
		/*if(splash == nil)
		 splash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
		 
		 splash.alpha = 1.0f;
		 splash.hidden = NO;
		 [self.window addSubview:splash];
		 [[self window] bringSubviewToFront:splash];*/
		
        [UIView animateWithDuration:0.4f
                         animations:^{
                             splash.alpha = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             [splash removeFromSuperview];
                             splash = nil;
                         }];
	}
}

- (BOOL) isShowDefault
{
	//force hide = YES, for Default.png
	return NO;
}

- (void)startWobble:(UIView *)view
{
    //disabled
    return;
    
     view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-WOBBLE_DEGREES));

     [UIView animateWithDuration:WOBBLE_SPEED
          delay:0.0 
          options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse)
          animations:^ {
           view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(WOBBLE_DEGREES));
          }
          completion:NULL
     ];
}

- (void)stopWobble:(UIView *)view
{
    //disabled
    return;
    
     [UIView animateWithDuration:WOBBLE_SPEED
          delay:0.0 
          options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear)
          animations:^ {
           view.transform = CGAffineTransformIdentity;
          }
          completion:NULL
      ];
}


- (BOOL) checkOnline
{
   [lock6 lock];
    
    //forced
    //return true;

    //not ready yet
    //if(![self isDoneLaunching])
     //   return NO;
    
    BOOL tempOnline = YES;
    

    if(![self HasConnection])
        tempOnline = NO;
    
        return tempOnline;
    
    [lock6 unlock];
}

-(void) updateAd
{
    NSLog(@"updateAd");

    //disabled
    return;
    
    //[self updateBanner:YES];
    //return;
    
    if(![self isOnline])
        return;
    
    savedAdImage = nil;
        
    //get list
    NSURL * url_afn = [NSURL URLWithString:URL_API_AD_LIST];
    
    NSURLRequest *request_afn = [[NSURLRequest alloc] initWithURL:url_afn];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
       AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request_afn
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
        {
            //save it
            adArray = JSON;
            [self updateAd2];
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
        {
            adArray = nil;
            NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
        }];
    
    [operation setShouldExecuteAsBackgroundTaskWithExpirationHandler:^{
            //timed out
        }];
    [operation start];
}

-(void) updateAd2
{
    NSLog(@"updateAd2");

    if(adArray == nil || [adArray count] == 0)
        return;
    
    NSMutableArray *ad_array_id = [[NSMutableArray alloc] initWithObjects:nil];
    NSMutableArray *ad_array_id2 = [[NSMutableArray alloc] initWithObjects:nil];
    NSMutableArray *ad_array_url_appstore = [[NSMutableArray alloc] initWithObjects:nil];
    NSMutableArray *ad_array_url_image = [[NSMutableArray alloc] initWithObjects:nil];
    
    for(NSDictionary *dict in adArray)
    {
        NSString *tempString = nil;
        NSNumber *tempNum = nil;
        
        tempNum = [NSNumber numberWithInt:[[dict objectForKey:@"app_id"] integerValue]];
        [ad_array_id addObject:tempNum];
        
        tempNum = [NSNumber numberWithInt:[[dict objectForKey:@"app_id2"] integerValue]];
        [ad_array_id2 addObject:tempNum];
        
        tempString = [dict objectForKey:@"url_appstore"];
        [ad_array_url_appstore addObject:tempString];
        
        tempString = [dict objectForKey:@"url_image"];
        [ad_array_url_image addObject:tempString];
        
    }
    
    //next
    currentAdId++;
    
    //loop
    if(currentAdId >= [ad_array_id count])
        currentAdId = 0;

    if([ad_array_id[currentAdId] intValue] == APP_ID_CURRENT)
        currentAdId++;
    
    //loop again
    if(currentAdId >= [ad_array_id count])
        currentAdId = 0;
    
    currentAdUrl = ad_array_url_appstore[currentAdId];
    currentAdId2 = [ad_array_id2[currentAdId] stringValue];
    
    [self saveState];

    //connection
    NSString  *url = ad_array_url_image[currentAdId];
    //NSURL * imageURL = [NSURL URLWithString:url];
    NSLog(@"url: %@", url);
         
    //savedAdImage = nil;
    AFImageRequestOperation *operationImage =
            [AFImageRequestOperation imageRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]
            success:^(UIImage *image)
            {
                savedAdImage = image;
                if(savedAdImage != nil)
                    [convertViewController showAd:YES];
                else
                    [convertViewController showAd:NO];
            }
           ];
    
     [operationImage setShouldExecuteAsBackgroundTaskWithExpirationHandler:^{
            NSLog(@"updatAd2 expired");
        }];
    [operationImage start];

    //[[UIApplication sharedApplication] endBackgroundTask:taskId];
}

- (void)loadIAP
{
    products = nil;
    
    //disabled
   //if([Helpers isDebug] && ![self isSimulator])
   //   return;
    
	//offline
	if(![self checkOnline])
		return;
			
	[passwordmatrixIAPHelper sharedInstance];

    [[passwordmatrixIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *newProducts) {
        if (success) {
            products = newProducts;
			if(products != nil && [products count]>0)
				productRemoveAds = products[0];
        }
    }];
}


-(void)updateInReview
{
    [self setInReview:YES];
	
	if(![self isOnline])
		return;
	
	//get list
    NSURL * url_afn = [NSURL URLWithString:URL_API_IN_REVIEW];
    NSURLRequest *request_afn = [[NSURLRequest alloc] initWithURL:url_afn];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request_afn
																						success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
										 {
											//save it
											if([JSON count] == 1)
											{
																								
												int newValue = [[JSON[0] objectForKey:@"value"] integerValue];
												
                                                //not in review
                                                if(newValue == 0)
                                                    [self setInReview:NO];
												
											}
											

										 }
										
                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
										 {
											 NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
										 }];
    
    [operation setShouldExecuteAsBackgroundTaskWithExpirationHandler:^{
							NSLog(@"Request timed out.");
	}];
    [operation start];
}


//ios 7 offset
/*- (void)offsetView:(UIView *)view
{
    //disabled
    return;
    
    if(kIsIOS7 &&  ![Helpers isIpad] )
    {
        int offset = 20;
        
        NSArray *subviews = [view subviews];
        for (UIView *subview in subviews)
        {
            CGRect frame = subview.frame;
            frame.origin.y += offset;
            subview.frame = frame;
        }
    }
}*/


#pragma mark -
#pragma mark Notifications

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    // Handle the notificaton when the app is running
    [self processNotification:notif];
    [self setupNotifications];
}

- (void) processNotification:(UILocalNotification *)notif {
    
    if(notif) {
        NSLog(@"Recieved Notification %@",notif);
    }
}

- (void)setupNotifications {
 
    //reset
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
 
    //push
    //support ios7-8
    /*
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //ios8
        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        //ios7
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    */
    
    /*
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setLocale:[NSLocale currentLocale]];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate date]];
    
    [components setHour:12]; //12pm
    [components setMinute:0];
    [components setSecond:0];

    //add one month
    NSDate *nextdDate = [gregorian dateFromComponents:components];
    nextdDate = [nextdDate dateByAddingDays:7];
    
    UILocalNotification *notif = [[UILocalNotification alloc] init];
    if (notif == nil)
        return;
    
    notif.fireDate = nextdDate;
    notif.repeatInterval = NSMonthCalendarUnit; //repeat every month
    notif.timeZone = [NSTimeZone defaultTimeZone];
    notif.alertBody = @"You haven't used Password Grid in a while. Please send us some feedback!";
    notif.alertAction = @"View";
    notif.soundName = UILocalNotificationDefaultSoundName;
    notif.applicationIconBadgeNumber = 1;
    
    // Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];/
    
    */
}

//mailchimp

/*- (void)ckAuthSucceededWithApiKey:(NSString *)apiKey {
    NSLog(@"Auth success - api key is: %@", apiKey);
}

- (void)ckAuthFailedWithError:(NSError *)error {
    NSLog(@"Auth failed - error is: %@", error);
}

- (void)ckAuthUserDismissedView {
    NSLog(@"User dismissed view");
}
*/

/*
- (void)ckRequestSucceeded:(ChimpKit *)ckRequest {
    NSLog(@"HTTP Status Code: %d", [ckRequest responseStatusCode]);
    NSLog(@"Response String: %@", [ckRequest responseString]);
}
 
- (void)ckRequestFailed:(NSError *)error {
    NSLog(@"Response Error: %@", error);
}*/


-(UIImage *) generateQRCodeWithString:(NSString *)string scale:(CGFloat) scale{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding ];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:stringData forKey:@"inputMessage"];
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    // Render the image into a CoreGraphics image
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:[filter outputImage] fromRect:[[filter outputImage] extent]];
    
    //Scale the image usign CoreGraphics
    UIGraphicsBeginImageContext(CGSizeMake([[filter outputImage] extent].size.width * scale, [filter outputImage].extent.size.width * scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *preImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //Cleaning up .
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    
    // Rotate the image
    UIImage *qrImage2 = [UIImage imageWithCGImage:[preImage CGImage]
                                            scale:[preImage scale]
                                      orientation:UIImageOrientationDownMirrored];
    return qrImage2;
}

@end

