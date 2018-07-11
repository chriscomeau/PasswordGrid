//
//  Config.h
//
//  Created by Chris Comeau on 2013-10-29.
//

#import <Foundation/Foundation.h>
#define kGoogleAdMobId @"???"
#define kGoogleAnalyticsTrackingID @"???"
#define kMailChimpAPIKey @"???"
#define kMailChimpListID @"???" // Skyriser Media Updates
#define kMailChimpShowMax 2

//parse, new
#define kParseApplicationID @"???"
#define kParseClientKey @"???"


//cleanup svn
//find . -type d -name '.svn' -print0 | xargs -0 rm -rdf
//find . -type d -name '.git' -print0 | xargs -0 rm -rdf
//find . -name ".DS_Store" -depth -exec rm {} \;

//strings
#define kStringCopied @"Password copied"

#define kFeedbackType FeedbackType_Selection

//links
#define URL_API_NUM_APPS @"???"

//sounds
#define SOUND_LOCK @"lock2"

#define USE_ANALYTICS 1
#define CONNECTION_TIMEOUT 15

//color
#define STATUS_BAR_HEIGHT 20
#define NAV_BAR_HEIGHT 44
#define TAB_BAR_HEIGHT 49

#define MAX_HUD_TIME 30
#define MIN_HUD_TIME 1

#define kButtonFont  [UIFont fontWithName:@"Century Gothic" size:14];

//ads
#define URL_API_AD_LIST @"???"

#define URL_API_IN_REVIEW @"???"

#define FACEBOOK_APP_ID @"???"

typedef enum {
    APP_ID_PASSGRID = 0,
    APP_ID_DAILYWALL = 1,
    APP_ID_QRLOCK = 2,
    APP_ID_QUOTE = 3,
    APP_ID_GOLF = 4,
    
    APP_ID_COINY = 5,

} APP_ID;

#define APP_ID_CURRENT APP_ID_PASSGRID

//IAP
#define IAP_SECRET @"???"
#define IAP_ID_REMOVEADS @"???"
#define IAP_URL_VERIFY @"https://sandbox.itunes.apple.com/verifyReceipt" //{"status":21000}

#define kBackgroundNotification @"kBackgroundNotification"



#define NUMSYMBOLS 18
