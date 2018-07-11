//
//  FirstViewController.m
//  passwordmatrix
//
//  Created by Chris Comeau on 15/05/09.
//  Copyright Skyriser Media 2009. All rights reserved.
//

#import "FirstViewController.h"
#import "passwordmatrixAppDelegate.h"
//#import "TapForTap.h"
#import "UIView+MWParallax.h"

@implementation FirstViewController

@synthesize text1;
@synthesize text2;
@synthesize text3;
@synthesize text4;
@synthesize text5;
@synthesize text6;
@synthesize text7;
@synthesize text8;
@synthesize text9;
@synthesize text10;
@synthesize text11;
@synthesize text12;
@synthesize text13;
@synthesize text14;
@synthesize text15;
@synthesize text16;
@synthesize text17;
@synthesize text18;
@synthesize text19;
@synthesize text20;
@synthesize text21;
@synthesize text22;
@synthesize text23;
@synthesize text24;
@synthesize text25;
@synthesize text26;
@synthesize text27;
@synthesize text28;
@synthesize text29;
@synthesize text30;
@synthesize text31;
@synthesize text32;
@synthesize text33;
@synthesize text34;
@synthesize text35;
@synthesize text36;

@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;
@synthesize label5;
@synthesize label6;
@synthesize label7;
@synthesize label8;
@synthesize label9;
@synthesize label10;
@synthesize label11;
@synthesize label12;
@synthesize label13;
@synthesize label14;
@synthesize label15;
@synthesize label16;
@synthesize label17;
@synthesize label18;
@synthesize label19;
@synthesize label20;
@synthesize label21;
@synthesize label22;
@synthesize label23;
@synthesize label24;
@synthesize label25;
@synthesize label26;
@synthesize label27;
@synthesize label28;
@synthesize label29;
@synthesize label30;
@synthesize label31;
@synthesize label32;
@synthesize label33;
@synthesize label34;
@synthesize label35;
@synthesize label36;

@synthesize helpButton;
@synthesize imageTitle;
@synthesize imageTitle2;
@synthesize imageBack;
@synthesize labelTap;

/*
- (void)awakeFromNib
{
}
*/

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
- (void)notifyForeground
{
	[self setupUI];
}

- (void)setupUI
{
    if([appDelegate showingHelp] == TRUE)
        return;
            
	//[appDelegate loadState];
	
	
	//self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
		
	[helpButton addTarget:self action:@selector(actionHelp:) forControlEvents:UIControlEventTouchUpInside];
	helpButton.hidden = TRUE;
	
	//first time?
	//NSString *tempKey = [appDelegate keyString];
	//if([tempKey length] == 0 || [tempKey  isEqualToString: @"demo"]) 
	
    if([appDelegate prefOpened] == NO) //1st time only
	{
		[appDelegate setKey: @""];
		[appDelegate setShowingHelp:YES];
		
        //force wait, for sheet anim
        //[NSThread sleepForTimeInterval:0.3];

        [appDelegate performSelector:@selector(alertHelpFirstTime) withObject:nil afterDelay:0.3f];

	}
	
	else
	{
        [appDelegate setShowingHelp:NO];
	}
		
	
	[self setupGrid];
	
	//alert
	
	if( ([[appDelegate keyString]  length] == 0) 
	   && ([appDelegate showedAlertRate] == NO)
	   && ([appDelegate showingHelp] == NO)
       && [appDelegate prefRemember] == YES)
	   
	{
		[appDelegate alertKey];
	}
	
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	//pool = [[NSAutoreleasePool alloc] init];

	[super viewDidLoad];
	
    appDelegate = (passwordmatrixAppDelegate *)[[UIApplication sharedApplication] delegate];
    //[appDelegate setFirstViewController:self];
    
    //back
    /*if([Helpers isIphone5])
    {
        [imageBack setImage:[UIImage imageNamed:@"background-green_iphone5.png"]];
    }*/
    	
    //set font
    //UIFont* tempFont = [UIFont fontWithName:@"Century Gothic" size:17] ;
    UIFont* tempFont = [UIFont fontWithName:@"Consolas" size:17] ;
    //UIFont* tempFont = [UIFont systemFontOfSize:17];
    
    NSArray *textArray = [[NSArray alloc] initWithObjects:
        text1,text2,text3,text4,text5,text6,text7,text8,text9,text10,
        text11,text12,text13,text14,text15,text16,text17,text18,text19,text20,
        text21,text22,text23,text24,text25,text26,text27,text28,text29,text30,
        text31,text32,text33,text34,text35,text36, nil
    ];
    
    int parallaxIntensity = 5;
    BOOL parallaxEnabled = NO;
    
    if(parallaxEnabled)
        imageTitle.iOS6ParallaxIntensity = parallaxIntensity;

    for (UILabel *text in textArray) {
        [text setFont:tempFont];
        [text setText:@""];
        text.textColor = RGB(0,0,0);
        text.frame = CGRectMake(text.frame.origin.x, text.frame.origin.y, 40, 21);
        
        if(parallaxEnabled)
            text.iOS6ParallaxIntensity = parallaxIntensity;
        
    }
        
    //set font
    //tempFont = [UIFont fontWithName:@"CenturyGothic-Bold" size:17] ;
     tempFont = [UIFont fontWithName:@"Consolas-Bold" size:17] ;
    //tempFont = [UIFont boldSystemFontOfSize:17] ;

    NSArray *labelArray = [[NSArray alloc] initWithObjects:
        label1,label2,label3,label4,label5,label6,label7,label8,label9,label10,
        label11,label12,label13,label14,label15,label16,label17,label18,label19,label20,
        label21,label22,label23,label24,label25,label26,label27,label28,label29,label30,
        label31,label32,label33,label34,label35,label36,nil
    ];
    
    for (UILabel *label in labelArray) {
        [label setFont:tempFont];
        label.textColor = RGB(113,138,84);
        
        if(parallaxEnabled)
            label.iOS6ParallaxIntensity = parallaxIntensity;

    }
    
    
    /*if([appDelegate isTapForTap])
    {
        //hide title image
        imageTitle.hidden = YES;
        imageTitle2.hidden = YES;
        labelTap.hidden = NO;
        
        //tapfortap
        //http://developer.tapfortap.com/sdk
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        //CGFloat screenHeight = screenRect.size.height;
        int adHeight = 50;
        int adWidth = 320;
        //int heightOfMenu = 20;
        //int heightOfBar = 49; //tabViewController.tabBar.frame.size.height? [[appDelegate tabBarController] tabBar]]
        int tapHeight = 0;
        
        int spacing = 5;
        
        if([Helpers isIpad])
        {
            spacing = 40;
        }
        else
        {
            spacing = 18;
        }
        
        
        
        //tapHeight = screenHeight - adHeight - heightOfBar - heightOfMenu - spacing ; //bottom
        tapHeight = 0 + spacing; //top
        
        int adX = (screenWidth - adWidth) / 2;
        int adY = tapHeight;
        
        //TapForTapAdView *adView = [[TapForTapAdView alloc] initWithFrame: CGRectMake(0, 0, 320, 50)];
        TapForTapAdView *adView = [[TapForTapAdView alloc] initWithFrame: CGRectMake(adX, adY, adWidth, adHeight)];
        
        
        //autosizing
       

        //adView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        //adView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin;
        adView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        //adView.autoresizingMask = UIViewAutoresizingNone;
        //adView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        [self.view addSubview: adView];
        
        // You don't have to do this if you set the default app ID in your app delegate
        adView.appId = @"f510dca0-6b8f-012f-b566-4040fb5b0b0c";
        
        [adView loadAds];
        
        // If you do not use ARC then release the adView.
        //[adView release];
    }
    else*/
    {
        //show title image
        imageTitle.hidden = NO;
        imageTitle2.hidden = YES; //disabled
        labelTap.hidden = YES;
        
         //title ad cicked
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] 
                                          initWithTarget:self action:@selector(titlePressed:)] ;
                                          
        [imageTitle2 addGestureRecognizer:tapGesture1];
    }
    
    
    
    //test unused
    //NSString *secureid = [appDelegate getSecureID];
    //NSLog(@"%@", secureid);
	
    [self becomeFirstResponder];
  
    //corner
    [appDelegate cornerView:self.view];
    
	//[self setupUI];
    

    [appDelegate setIsOnline:[appDelegate checkOnline]];

}

- (void)titlePressed:(UITapGestureRecognizer *)gesture 
{
    //todo:
    [appDelegate playSound:SOUND_LOCK];	    
}

- (void)actionHelp:(id)sender
{
    [HapticHelper generateFeedback:kFeedbackType];

	[appDelegate alertHelp:YES];
}

/*
- (void)dialogOKCancelAction
{
	// open a dialog with an OK and cancel button
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"UIActionSheet <title>"
															 delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"OK" otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	[actionSheet release];
}

- (void)alertOKCancelAction
{
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to Password Grid" message:@"Don't forget to enter a custom key in the Settings"
												   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

- (void)alertOKCancelAction2
{
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to Password Grid" message:@"Don't forget to enter a custom key in the Settings"
												   delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	//[alert release];
}
*/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self becomeFirstResponder];

    //google analytics
    [Helpers setupGoogleAnalyticsForView:[[self class] description]];

	//notify
	if([appDelegate backgroundSupported])
	{
		[[NSNotificationCenter  defaultCenter] addObserver:self
							    selector:@selector(notifyForeground)
								name:UIApplicationWillEnterForegroundNotification
								object:nil]; 
	}
    
   //[self performSelector:@selector(presentStartUpModal) withObject:nil afterDelay:0.0]; //what was this fixing? 1st run?
   //[self presentStartUpModal];
    
    [self setupUI];
		
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[self becomeFirstResponder];
	
	[appDelegate fadeDefault];
    
    //mailchimp test
    //[Helpers showMailChimp];
}

/*- (void) presentStartUpModal
{
    [self setupUI];
}*/


- (void)viewWillDisappear:(BOOL)animated {

	
    [self resignFirstResponder];
    
	
	[super viewWillDisappear:animated];
    
	//notify
	if([appDelegate backgroundSupported])
	{
		[[NSNotificationCenter defaultCenter] removeObserver:self]; 
	}
	
	
	[super viewWillDisappear:animated];
	
}

-(void)showGrid:(BOOL)visible
{
    [text1 setHidden:!visible];
    [text2 setHidden:!visible];
	[text3 setHidden:!visible];
	[text4 setHidden:!visible];
	[text5 setHidden:!visible];
	[text6 setHidden:!visible];
	[text7 setHidden:!visible];
	[text8 setHidden:!visible];
	[text9 setHidden:!visible];
	[text10 setHidden:!visible];
	[text11 setHidden:!visible];
	[text12 setHidden:!visible];
	[text13 setHidden:!visible];
	[text14 setHidden:!visible];
	[text15 setHidden:!visible];
	[text16 setHidden:!visible];
	[text17 setHidden:!visible];
	[text18 setHidden:!visible];
	[text19 setHidden:!visible];
	[text20 setHidden:!visible];
	[text21 setHidden:!visible];
	[text22 setHidden:!visible];
	[text23 setHidden:!visible];
	[text24 setHidden:!visible];
	[text25 setHidden:!visible];
	[text26 setHidden:!visible];
	[text27 setHidden:!visible];
	[text28 setHidden:!visible];
	[text29 setHidden:!visible];
	[text30 setHidden:!visible];
	[text31 setHidden:!visible];
	[text32 setHidden:!visible];
	[text33 setHidden:!visible];
	[text34 setHidden:!visible];
	[text35 setHidden:!visible];
	[text36 setHidden:!visible];
    
    [label1 setHidden:!visible];
    [label2 setHidden:!visible];
	[label3 setHidden:!visible];
	[label4 setHidden:!visible];
	[label5 setHidden:!visible];
	[label6 setHidden:!visible];
	[label7 setHidden:!visible];
	[label8 setHidden:!visible];
	[label9 setHidden:!visible];
	[label10 setHidden:!visible];
	[label11 setHidden:!visible];
	[label12 setHidden:!visible];
	[label13 setHidden:!visible];
	[label14 setHidden:!visible];
	[label15 setHidden:!visible];
	[label16 setHidden:!visible];
	[label17 setHidden:!visible];
	[label18 setHidden:!visible];
	[label19 setHidden:!visible];
	[label20 setHidden:!visible];
	[label21 setHidden:!visible];
	[label22 setHidden:!visible];
	[label23 setHidden:!visible];
	[label24 setHidden:!visible];
	[label25 setHidden:!visible];
	[label26 setHidden:!visible];
	[label27 setHidden:!visible];
	[label28 setHidden:!visible];
	[label29 setHidden:!visible];
	[label30 setHidden:!visible];
	[label31 setHidden:!visible];
	[label32 setHidden:!visible];
	[label33 setHidden:!visible];
	[label34 setHidden:!visible];
	[label35 setHidden:!visible];
	[label36 setHidden:!visible];
}

- (void)setupGrid
{
    //force hide for default.png
    //[self showGrid:NO];
	
	if([appDelegate isShowDefault])
	{
		[self showGrid:NO];
		return;
	}
    
    //when modals aren't called
    //[appDelegate setKey: @"test"];
	//[appDelegate saveState];
	[appDelegate setupSeed];   
	     
    
	//set labels
	int i = 0;
    [text1 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text2 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text3 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text4 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text5 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text6 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text7 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text8 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text9 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text10 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text11 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text12 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text13 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text14 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text15 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text16 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text17 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text18 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text19 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text20 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text21 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text22 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text23 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text24 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text25 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text26 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text27 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text28 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text29 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text30 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text31 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text32 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text33 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text34 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text35 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	[text36 setText: [[appDelegate matrixArray] objectAtIndex: i++]];
	
	//[gridText setText: outputString];
	
	//NSLog(@"outputString: %@", outputString);
	
}


- (void) didReceiveMemoryWarning 
{
	NSLog(@"didReceiveMemoryWarning");
	[super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
   
	
	/*[text1 release];
	[helpButton release];
	[text2 release];
	[text3 release];
	[text4 release];
	[text5 release];
	[text6 release];
	[text7 release];
	[text8 release];
	[text9 release];
	[text10 release];
	[text11 release];
	[text12 release];
	[text13 release];
	[text14 release];
	[text15 release];
	[text16 release];
	[text17 release];
	[text18 release];
	[text19 release];
	[text20 release];
	[text21 release];
	[text22 release];
	[text23 release];
	[text24 release];
	[text25 release];
	[text26 release];
	[text27 release];
	[text28 release];
	[text29 release];
	[text30 release];
	[text31 release];
	[text32 release];
	[text33 release];
	[text34 release];
	[text35 release];
	[text36 release];*/
	
	
	
	//[super dealloc];
	
	//[matrixArray_old release];
	//[pool release];
}


@end
