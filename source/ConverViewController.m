//
//  ConverViewController.m
//  passwordmatrix
//
//  Created by Chris Comeau on 10-02-12.
//  Copyright 2010 Games Montreal. All rights reserved.
//

#import "ConverViewController.h"
#if USE_TESTFLIGHT
#import "TestFlight.h"
#endif
#import <QuartzCore/QuartzCore.h>
//#import "TapForTap.h"
#import "passwordmatrixAppDelegate.h"
#import "passwordmatrixIAPHelper.h"
#import <StoreKit/StoreKit.h>
#import "UIAlertView+Errors.h"

@implementation ConverViewController

@synthesize convert1Text;
@synthesize convert2Text;
@synthesize convertButton;
@synthesize clipButton;
@synthesize emailButton;
@synthesize helpButton;
@synthesize enteredForegroundConvert;
@synthesize timer;
@synthesize label1;
@synthesize label2;
@synthesize imageViewDot;
@synthesize adButton;
@synthesize closeButton;
@synthesize HUD;

NSRecursiveLock *lock8;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    lock8 = [[NSRecursiveLock alloc] init];

    
    [self.view setMultipleTouchEnabled:YES];
	
	appDelegate = (passwordmatrixAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setConvertViewController:self];

    doHud = NO;
	closed = NO;
    enteredForegroundConvert = false;
    isVisible = false;
    rotating = NO;



    //set font
    UIFont* tempFont = [UIFont fontWithName:@"Century Gothic" size:17] ; 
	[label1 setFont:tempFont];
	[label2 setFont:tempFont];
    
	[convert1Text setFont:tempFont];

    tempFont = [UIFont fontWithName:@"Consolas" size:17] ;
	[convert2Text setFont:tempFont];

    tempFont = kButtonFont;

	clipButton.titleLabel.font = tempFont;
	emailButton.titleLabel.font = tempFont;
    
    //auto resize
    convert1Text.adjustsFontSizeToFitWidth = YES;
    convert1Text.minimumFontSize = 5.0;
    convert2Text.adjustsFontSizeToFitWidth = convert1Text.adjustsFontSizeToFitWidth;
    convert2Text.minimumFontSize = convert1Text.minimumFontSize;

    //ads
    [closeButton addTarget:self action:@selector(actionClose:) forControlEvents:UIControlEventTouchUpInside];
	[adButton addTarget:self action:@selector(actionAd:) forControlEvents:UIControlEventTouchUpInside];

    //banner
    self.bannerView.delegate = self;
    self.bannerView.hidden = YES;
	self.closeButton.hidden = YES;
    self.adButton.hidden = YES;

    //[self updateBanner:YES];


    //if([appDelegate isTapForTap])
    /*if(false)
    {
        //tapfortap
        //http://developer.tapfortap.com/sdk

        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        int heightOfAd = 50;
        int heightOfMenu = 20;
        //int heightOfNav = 44;
        int heightOfBar = 49; //tabViewController.tabBar.frame.size.height? [[appDelegate tabBarController] tabBar]]
        int spacing = 5;
        int tapHeight = 0;
        
        tapHeight = screenHeight - heightOfAd - heightOfBar - heightOfMenu - spacing ; //bottom
        tapHeight = 0 + spacing; //top
        
        //TapForTapAdView *adView = [[TapForTapAdView alloc] initWithFrame: CGRectMake(0, 0, 320, 50)];
        TapForTapAdView *adView = [[TapForTapAdView alloc] initWithFrame: CGRectMake(0, tapHeight, screenWidth, heightOfAd)];
        [self.view addSubview: adView];

        // You don't have to do this if you set the default app ID in your app delegate
        adView.appId = @"f510dca0-6b8f-012f-b566-4040fb5b0b0c";

        [adView loadAds];

        // If you do not use ARC then release the adView.
        //[adView release];
    }*/
    
    
	
	/*[NSNotificationCenter defaultCenter addObserver:self
	 selector:@selector(textFieldTextDidChange:)
	 name:@"UITextFieldTextDidChangeNotification" object:nil];*/
	
	
	
	//[appDelegate setupSeed];
	
	convert1Text.placeholder = NSLocalizedString(@"<enter text to convert>", nil);
	
	//convert1Text.backgroundColor = [UIColor whiteColor];
	//convert1Text.borderStyle = UITextBorderStyleBezel;
	//convert1Text.backgroundColor = [appDelegate textBackColor];
	//convert1Text.borderStyle = UITextBorderStyleBezel;
	convert1Text.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
	convert1Text.keyboardType = UIKeyboardTypeDefault;
	convert1Text.returnKeyType = UIReturnKeyDone;
	convert1Text.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
	convert1Text.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
	//convert1Text.scrollEnabled = YES;
	
	[convert1Text addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	
	//convert2Text.backgroundColor = [UIColor whiteColor];
	//convert2Text.backgroundColor = [appDelegate textBackColor];
	
	//convert2Text.borderStyle = UITextBorderStyleNone;
	//convert2Text.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
	convert2Text.keyboardType = UIKeyboardTypeDefault;
	convert2Text.returnKeyType = UIReturnKeyDone;
	convert2Text.clearButtonMode = UITextFieldViewModeNever ;	// has a clear 'x' button to the right
	convert2Text.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
	//convert2Text.scrollEnabled = YES;
	
	convert1Text.text = @"";
	convert2Text.text = @"";
	
	
	[clipButton addTarget:self action:@selector(actionCopy:) forControlEvents:UIControlEventTouchUpInside];
	
	
	[emailButton addTarget:self action:@selector(actionEmail:) forControlEvents:UIControlEventTouchUpInside];
	
	
	[helpButton addTarget:self action:@selector(actionHelp:) forControlEvents:UIControlEventTouchUpInside];
	helpButton.hidden = TRUE;
	
	
	
	[self becomeFirstResponder];
	
    
	[self setupUI];
    
	[self startTimer];
    
    //rotation
    if([Helpers isIpad])
    {
        //[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    }
	
    //corner
    [appDelegate cornerView:self.view];
    
    //delay?
    if([appDelegate isOnline])
        [appDelegate performSelector:@selector(updateAd) withObject:nil afterDelay:0.5];

}

- (void)notifyForeground
{
    //update
    [appDelegate setIsOnline:[appDelegate checkOnline]];


    //enteredForegroundConvert = true;
        
	[self setupUI];
    
    //enteredForegroundConvert = false;
    
    [self startTimer];
    
    [self updateBanner:YES];

    //switch ad
    //if([appDelegate isOnline] && !closed && !self.adButton.hidden)
    //    [appDelegate performSelector:@selector(updateAd) withObject:nil afterDelay:0.5];

}

- (void)notifyBackground
{
    convert1Text.text = @"";
	convert2Text.text = @"";
    
   // enteredForegroundConvert = true;
	//[self setupUI];
    
   // enteredForegroundConvert = false;
    
    [self stopTimer];
}

- (void)setupUI
{
	[appDelegate loadState];
	
	//convert1Text.text = @"";
	//convert2Text.text = @"";
	
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	

	/*NSTimeInterval timeInterval = [[appDelegate lastTime] timeIntervalSinceNow];
    int minutes = abs(floor(timeInterval/60));
    
    //set time now
    [appDelegate setLastTime:[NSDate date] ];
    [appDelegate saveState];
    */
    
    double current70 = [[NSDate date] timeIntervalSince1970];
    int minutes  = (current70 - [appDelegate lastTimeSince70]) / 60;
    [appDelegate setLastTimeSince70:current70];
    
    int minutesUntilHide = 5; //define?
    
    if([[appDelegate keyString]  length] == 0 && ([appDelegate prefRemember] == NO))
    {
        //no warning?
        convert1Text.text = @"";
        convert2Text.text = @"";
    }
	else if([[appDelegate keyString]  length] == 0)
	{
		[appDelegate alertKey];
		
		convert1Text.text = @"";
		convert2Text.text = @"";
	}
    /*else if (enteredForegroundConvert == YES || [appDelegate enteredForegroundConvert])
	{
        convert1Text.text = @"";
		convert2Text.text = @"";
    }*/
    
    else if(minutes > minutesUntilHide) //more than minutes, hide
    {
        convert1Text.text = @"";
		convert2Text.text = @"";
    }
    else
	{
		convert2Text.text = [appDelegate convert:convert1Text.text];
		
		//copy
		if([appDelegate prefAutocopy] == YES)
		{	
			[self copyToPasteBoard];
		}
		
		//sound
		//[appDelegate playSound:nil];		
	}
	
    
	if( [convert1Text.text length] == 0)
	{
		convert1Text.placeholder =  NSLocalizedString(@"<enter text to convert>", nil);

	}
	
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	[self becomeFirstResponder];
	
    //google analytics
    [Helpers setupGoogleAnalyticsForView:[[self class] description]];

    //for in-app confirm
    [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(inAppAlertAppeared:) 
                                               name:UIApplicationWillResignActiveNotification 
                                             object:nil];


    //iap
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];

    //check online
    [appDelegate setIsOnline:[appDelegate checkOnline]];

    //rotation
    if([Helpers isIpad])
    {
        //[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    }
	
	[self setupUI];
    
    //if([Helpers isIpad])
    {
        [self updateUIOrientation];
    }
    
    //[self showAd:YES];
        
    //switch ad
    //if([appDelegate isOnline] && !closed && !self.adButton.hidden)
    //    [appDelegate performSelector:@selector(updateAd) withObject:nil afterDelay:0.5];
    
    [self updateBanner:YES];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backgroundNotification:)
                                                 name:kBackgroundNotification
                                               object:nil];

	//fade
	[appDelegate fadeDefault];

    isVisible = true;
	
    rotating = NO;
    
    
	//notify
	if([appDelegate backgroundSupported])
	{
		[[NSNotificationCenter  defaultCenter] addObserver:self
												  selector:@selector(notifyForeground)
													  name:UIApplicationWillEnterForegroundNotification
													object:nil]; 
        
    
        
        /*UIDevice *currentDevice = [UIDevice currentDevice];
        
        if( [currentDevice respondsToSelector:@selector(isMultitaskingSupported)] && 
           [currentDevice isMultitaskingSupported])
        {
            [[NSNotificationCenter defaultCenter] addObserver:self 
                                                     selector:@selector(notifyBackground:)
                                                         name:UIApplicationDidEnterBackgroundNotification
                                                       object:nil];
        }*/

        
        
        /*[[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(notifyBackground:) 
                                                     name: UIApplicationDidEnterBackgroundNotification 
                                                   object: nil];*/
        
       /* [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(notifyBackground:) 
                                                     name: @"didEnterBackground" 
                                                   object: nil];*/

	}
   
    //[self showAd:YES];

	
}

- (void)viewWillDisappear:(BOOL)animated {
    
    isVisible = false;
    
	[self resignFirstResponder];
	
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kBackgroundNotification object:nil];

    
	//[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	
    
   /* UIDevice *currentDevice = [UIDevice currentDevice];
    if( [currentDevice respondsToSelector:@selector(isMultitaskingSupported)] && 
       [currentDevice isMultitaskingSupported])
    {

        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];
    }*/
    
    //rotation
    //[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];

    
	[super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
    rotating = NO;	
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   /*
    // Remove old red circles on screen
    NSArray *subviews = [self.view subviews];
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
    
    // Enumerate over all the touches and draw a red dot on the screen where the touches were
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        // Get a single touch and it's location
        UITouch *touch = obj;
        CGPoint touchPoint = [touch locationInView:self.view];
        
        // Draw a red circle where the touch occurred
        UIView *touchView = [[UIView alloc] init];
        [touchView setBackgroundColor:[UIColor redColor]];
        touchView.frame = CGRectMake(touchPoint.x, touchPoint.y, 30, 30);
        touchView.layer.cornerRadius = 15;
        [self.view addSubview:touchView];
        [touchView release];
    }];
    */
    
    //reset timer
    [self startTimer];
}


-(void) orientationChanged:(NSNotification *) notification
{
    NSLog(@"ConvertViewController::orientationChanged");
    //if([Helpers isIpad])
    {
        
        [self updateUIOrientation];
    }
}

- (void)updateUIOrientation
{
    [lock8 lock];
    
     NSLog(@"ConvertViewController::updateUIOrientation");

    //if([Helpers isIpad])
    {
        //move start
        CGRect imageView1Frame = imageViewDot.frame;
        imageView1Frame.origin.x = convert1Text.frame.origin.x - 30;
        imageView1Frame.origin.y = convert1Text.frame.origin.y - 0;
        imageViewDot.frame = imageView1Frame;
        
        int xoffset = 10;
		int yoffset = 0;
        CGRect tempFrame;
		
		//move close button
		tempFrame = closeButton.frame;
        tempFrame.origin.x = adButton.frame.origin.x - closeButton.frame.size.width/2 + xoffset;
        tempFrame.origin.y = adButton.frame.origin.y - closeButton.frame.size.height/2 + yoffset;
        closeButton.frame = tempFrame;
        
        //only move on iphone, for ad and keyboard position
        if(![Helpers isIpad])
        {
            //move buttons
            if([Helpers isIphone5])
                yoffset = 65;
            else
                yoffset = 30;

            tempFrame = clipButton.frame;
            tempFrame.origin.y = convert2Text.frame.origin.y + convert2Text.frame.size.height + yoffset;
            clipButton.frame = tempFrame;

            if([Helpers isIphone5])
                yoffset = 25;
            else
                yoffset = 20;
            
            tempFrame = emailButton.frame;
            tempFrame.origin.y = clipButton.frame.origin.y + clipButton.frame.size.height + yoffset;
            emailButton.frame = tempFrame;

        }
       

        
        //keep updating
        //if(rotating)
        //    [self performSelector:@selector(updateUIOrientation) withObject:nil afterDelay:0.01];
    }
    
    [lock8 unlock];
}

//tethering, in-call
- (void)statusBarWillChangeFrame:(id)sender
{
    NSLog(@"ArchiveViewController: statusBarWillChangeFrame");
	
	[self showAd:YES];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"ConvertViewController::didRotateFromInterfaceOrientation");

    //if([Helpers isIpad])
    {
        rotating = NO;
    
        [self updateUIOrientation];
        
    }
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"ConvertViewController::willRotateToInterfaceOrientation");

    if([Helpers isIpad])
    {
        rotating = YES;
    
        [self updateUIOrientation];
    }
}

//Call This to Start timer, will tick every second
-(void) startTimer
{
    //return;
    
    [timer invalidate];
    int interval = 60;// * 2; //seconds
    //int interval = 10;// * 2; //seconds
    timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

//Event called every time the NSTimer ticks.
- (void)timerTick:(NSTimer *)timer
{
    //reset?
    //sound
    if(isVisible && [convert1Text.text length] > 0)
    {
        [appDelegate playSound:SOUND_LOCK];	
    }
    
    //force reset, only if key
    if([[appDelegate keyString]  length] > 0)
    {
        [appDelegate setLastTimeSince70:0];
        [self setupUI];
    }
    
    
    /*timeSec++;
    if (timeSec == 60)
    {
        timeSec = 0;
        timeMin++;
    }
    //Format the string 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    //Display on your label
    [timeLabel setStringValue:timeNow];*/
}

//Call this to stop the timer event(could use as a 'Pause' or 'Reset')
- (void) stopTimer
{
    [timer invalidate];
    /*timeSec = 0; 
    timeMin = 0;
    //Since we reset here, and timerTick won't update your label again, we need to refresh it again.
    //Format the string in 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    //Display on your label
    [timeLabel setStringValue:timeNow];*/
}

- (void)actionHelp:(id)sender
{
	[appDelegate alertHelp:YES];
}

- (void)keyboardWillShow:(NSNotification *)aNotification 
{
	// the keyboard is showing so resize the table's height
	/*CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.size.height -= keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];*/
}

/*
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    // the keyboard is hiding reset the table's height
	CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.size.height += keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}
 */


/*
 - (UIButton *)grayButton
 {	
 if (grayButton == nil)
 {
 // create the UIButtons with various background images
 // white button:
 UIImage *buttonBackground = [UIImage imageNamed:@"whiteButton.png"];
 UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"blueButton.png"];
 
 CGRect frame = CGRectMake(182.0, 5.0, kStdButtonWidth, kStdButtonHeight);
 
 grayButton = [ButtonsViewController buttonWithTitle:@"Gray"
 target:self
 selector:@selector(action:)
 frame:frame
 image:buttonBackground
 imagePressed:buttonBackgroundPressed
 darkTextColor:YES];
 
 grayButton.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
 }
 return grayButton;
 }
 
 */

- (void)actionCopy:(id)sender
{
#if USE_TESTFLIGHT
    if([appDelegate isTestflight])
       [TestFlight passCheckpoint:@"ConvertViewController:actionCopy"];
#endif
    
    [HapticHelper generateFeedback:kFeedbackType];

    //close keyboard
    [self textFieldShouldReturn:convert1Text];

    if([convert1Text.text length] == 0)
    {
        return;
    }
    
    [self startTimer];
    
	if([[appDelegate keyString]  length] == 0)
	{
		[appDelegate alertKey];
	}

	else
	{
        if(isVisible && [convert1Text.text length] > 0)
        {
            [self copyToPasteBoard];
        
       
            //sound
            [appDelegate playSound:SOUND_LOCK];
            
            //hud
            //[Helpers showAlertWithTitle:@"Password Grid" andMessage:kStringCopied];
            [Helpers showMessageHud:kStringCopied];

        }
	}
}

- (void)actionEmail:(id)sender
{
#if USE_TESTFLIGHT
    if([appDelegate isTestflight])
        [TestFlight passCheckpoint:@"ConvertViewController:actionEmail"];
#endif    

    //close keyboard
    [self textFieldShouldReturn:convert1Text];
    
    if([convert1Text.text length] == 0)
    {
        return;
    }

    [self startTimer];
    
	if(USE_ANALYTICS == 1)
	{
		//[[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Convert: actionEmail"];
        //[FlurryAnalytics logEvent:@"Convert: actionEmail"];

	}
	
	
	if([[appDelegate keyString]  length] == 0)
	{
		[appDelegate alertKey];
	}
	
	else
	{
		//[appDelegate alertHelp];
		//NSString* bodyString = @"Check out this application:\n\nhttp://itunes.com/app/PasswordGrid";
		
		
		//NSString *bodyString = [NSString stringWithFormat: @"Here is your converted password for '%@', using the key '%@':\n\n%@\n\n\nPassword Grid: http://passwordgrid.com/", convert1Text.text, [appDelegate keyString], convert2Text.text];
		NSString *bodyString = [NSString stringWithFormat: @"Here is your converted password for '%@':\n\n%@\n\n\nPassword Grid for iOS\nhttp://itunes.apple.com/app/id359807331", convert1Text.text, convert2Text.text];
		
            [bodyString stringByAppendingString: [appDelegate getGridString] ];
		
		
		[appDelegate sendEmailTo:@"" withSubject: @"My Password Grid converted password" withBody:bodyString  withView:self];
	}
}

- (void)copyToPasteBoard
{
    
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	[pasteboard setValue: convert2Text.text forPasteboardType:@"public.utf8-plain-text"];
}

- (void) didReceiveMemoryWarning 
{
	NSLog(@"didReceiveMemoryWarning");
	[super didReceiveMemoryWarning];
}


- (void)textFieldDidChange:(id)sender
{
    UITextField *textField = sender;
	
	if(textField == convert1Text)
	{
		if([[appDelegate keyString]  length] == 0)
		{
			//[appDelegate alertKey];
			convert2Text.text = @"";
		}
		else
		{
			convert2Text.text = [appDelegate convert:textField.text];
		}
	}   
    
    
    [self startTimer];
}
	

#define MAX_LENGTH 50

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= MAX_LENGTH && range.length == 0)
    {
        return NO; // return NO to not change text
    }
    else
    {return YES;}
}


/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == convert1Text)
	{
		//convert2Text.text = [appDelegate convert:textField.text];
		//convert2Text.text = [appDelegate convert:string];
		convert2Text.text = [appDelegate convert:[convert2Text.text stringByAppendingString: string]];

		//copy
		if([appDelegate prefAutocopy] == YES)
		{	
			[self copyToPasteBoard];
		}
	}
	
	return YES;


}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];

	
	if(textField == convert1Text)
	{
		
		if([[appDelegate keyString]  length] == 0)
		{
			[appDelegate alertKey];
			
			convert2Text.text = @"";
		}
		else
		{
			convert2Text.text = [appDelegate convert:textField.text];
			
			//copy
			if([appDelegate prefAutocopy] == YES)
			{	
				[self copyToPasteBoard];
                
                [Helpers showMessageHud:kStringCopied];

			}
			
			//sound
			//[appDelegate playSound:nil];		
		}
        
        //update ad
        [self updateBanner:YES];
				
	}
	
	//force
	[self becomeFirstResponder];
	
	
	return YES;
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(BOOL)canBecomeFirstResponder
{
	return YES;
}

//accelerometer, shake
/*
 - (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
	if(event.type == UIEventSubtypeMotionShake)
	{
		convert1Text.text = @"";
		convert2Text.text = @"";
	}
}

*/

/*
 implement a UITextFieldDelegate and do whatever you want to do in - (BOOL)textFieldShouldBeginEditing:(UITextField *)textField or - (void)textFieldDidBeginEditing:(UITextField *)textField
 */

- (void)textFieldDidBeginEditing:(UITextField *)textField { 
    //[self myMethod]; 
    
    [self startTimer];
    
}

/*- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField { 
    //[self myMethod]; 
    
    [self startTimer];
    return YES; 
    
}*/

- (void)dealloc {
    
    //rotation
    //[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];

    //notify
	if([appDelegate backgroundSupported])
	{
		[[NSNotificationCenter defaultCenter] removeObserver:self];
	}
    
	/*[convert1Text release];
	[convert2Text release];
	[convertButton release];
	[clipButton release];
	[emailButton release];
	[helpButton release];
	
	
	[super dealloc];*/
	
	
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event 
{
    if (event.type == UIEventSubtypeMotionShake) 
    {
        
        //sound
        if(isVisible && [convert1Text.text length] > 0)
        {
            [appDelegate playSound:SOUND_LOCK];	
        }

        
        //force reset
        [appDelegate setLastTimeSince70:0];
        [self setupUI];
        
    }
}

-(void)hideAd
{
    adButton.hidden = YES;
    self.bannerView.hidden = YES;
    closeButton.hidden = YES;
}

-(void)showAd:(BOOL)show
{
    //disabled
    /*if(YES && [Helpers isDebug])
    {
        [self hideAd];
        return;
    }*/
    
    NSLog(@"showAd");

    //always hide
    adButton.hidden = YES;

    BOOL exit = NO;

    if(closed)
        exit = YES;

	else if([appDelegate isShowDefault])
        exit = YES;
    
    else if(![appDelegate isOnline] && show)
        exit = YES;
    
    else if([appDelegate prefPurchasedRemoveAds])
         exit = YES;

    else if (![Helpers isDebug] && [[passwordmatrixIAPHelper sharedInstance] productPurchased:[appDelegate productRemoveAds].productIdentifier])
      exit = YES;
        
    //else if([appDelegate savedAdImage] == nil)
    //    exit = YES;
    
   
	//else if(show && adView != nil && adView.hidden == NO)
	//  exit = YES;
	//else if(!show && (adView == nil || adView.hidden == YES))
    //    exit = YES;
    
    
    if(exit)
    {
        [self hideAd];
    	return;
    }
    
	//if(!adDownloaded)
	//	return;
	
			
	if(show)
	{
        
        //cross-fade
        /*[UIView transitionWithView:self.adButton
                  duration:0.3f
                   options:UIViewAnimationOptionTransitionCrossDissolve
                animations:^{
                  [self.adButton setImage:[appDelegate savedAdImage] forState:UIControlStateNormal];
            } completion:nil];
         */

    
		//int adX = 0;
		//int adY = 0;
		//adX = self.adButton.frame.origin.x;
		//adY = self.adButton.frame.origin.y; //0;
		
        //[[self view] bringSubviewToFront:self.adButton];
        [[self view] bringSubviewToFront:self.bannerView];
		[[self view] bringSubviewToFront:self.closeButton];
        
        //self.bannerView.hidden = NO;
        //self.closeButton.hidden = NO;

		
        
        //fade in
        if(self.bannerView.hidden) //only of hidden
        {
            self.closeButton.alpha = 0.0;
            //self.adButton.alpha = 0.0;
            self.bannerView.alpha = 0.0;
            self.closeButton.hidden = NO;
            //self.adButton.hidden = NO;
            self.bannerView.hidden = NO;
            
            [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                            self.closeButton.alpha = 1.0;
                         //self.adButton.alpha = 1.0;
                         self.bannerView.alpha = 1.0;
                        }
                     completion:nil];
        }
        
	}
	else
	{
        adButton.hidden = YES;
        closeButton.hidden = YES;
        self.bannerView.hidden = YES;
		//if(adView != nil)
		//	adView.hidden = YES;
	}
}

- (void)actionClose:(id)sender
{
	//old way
    /*if([Helpers isDebug] && ![Helpers isSimulator])
    {
        [self showAd:NO];
        closed = YES;
        return;
    }*/
    
    //offline ignore
    if(![appDelegate isOnline])
    {
        //message
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"In-App Purchases" message:@"Please try again when you are connected to the internet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show]; 
        return;
	}
    
	/*SKProduct* product = [appDelegate productRemoveAds];

	if(product == nil)
	{
		//todo:chris: check
		[self showAd:NO];
		closed = YES;
		return;
	}*/
	
    
    SKProduct* product = [appDelegate productRemoveAds];

	//price
	NSNumberFormatter * _priceFormatter;
	_priceFormatter = [[NSNumberFormatter alloc] init];
	[_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    // Add to bottom of tableView:cellForRowAtIndexPath (before return cell)
    [_priceFormatter setLocale:product.priceLocale];
    NSString *price = [_priceFormatter stringFromNumber:product.price];

	alertRemoveAd = nil;
    alertRemoveAd = [[UIAlertView alloc] initWithTitle:@"Remove Ads"
											message:[NSString stringWithFormat:@"Do you want to permanently remove all banner ads and encourage an indie app developer? (%@)", price]
										   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	[alertRemoveAd show];
	
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:    (NSInteger)buttonIndex
{
	
    if(alertView == alertRemoveAd)
    {
        if(buttonIndex==0)
        {
            //cancel
        }
        else if(buttonIndex==1)
        {
			[self buyRemoveAds];
        }
	}
}

- (void)actionAd:(id)sender
{
    [appDelegate gotoAd];
}

//iap
- (void)inAppAlertAppeared:(id)sender
{
    NSLog(@"ArchiveViewController inAppAlertAppeared");

	doHud = NO;
}

- (void)buyRemoveAds
{
    //disabled
//    if([Helpers isDebug] && ![Helpers isSimulator])
//        return;
    
     //show hud
    doHud = YES;
    [self showHud:@"Connecting"];
    
	SKProduct* product = [appDelegate productRemoveAds];
	
    NSLog(@"Buying %@...", product.productIdentifier);
    [[passwordmatrixIAPHelper sharedInstance] buyProduct:product];
}

- (void)productPurchased:(NSNotification *)notification {
	
    NSString * productIdentifier = notification.object;
    [[appDelegate products] enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {

            *stop = YES;
            doHud = NO;
			[self showAd:NO];
            [appDelegate setPrefPurchasedRemoveAds:YES];
            [appDelegate saveState];
            
            //message
            [UIAlertView showError:@"Thanks for your support!" withTitle:@"In-App Purchases"];
        }
    }];
}

- (void)showHud:(NSString*)label
{
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.navigationController.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = label;
	
	[HUD showWhileExecuting:@selector(hudTask) onTarget:self withObject:nil animated:YES];
}

- (void)hudTask
{
    NSDate *start = [NSDate date];
    NSTimeInterval timeInterval = ABS([start timeIntervalSinceNow]);
    
    //at least min, at most max
    while( (timeInterval < MIN_HUD_TIME) || (doHud && (timeInterval < MAX_HUD_TIME)) )
    {
       timeInterval = ABS([start timeIntervalSinceNow]);
    }
}



-(void) backgroundNotification:(NSNotification*)notif {
    convert1Text.text = @"";
    convert2Text.text = @"";

}


#pragma mark -
#pragma mark Banner

- (void)updateBanner:(BOOL)reload {
    
    if(![appDelegate isOnline])
    {
        [self hideAd];
        return;
    }
    
    //ad
    if([appDelegate prefPurchasedRemoveAds])
    {
        [self hideAd];
        return;
    }
    
    //force resize
    if(self.bannerView.hidden) {
        [self hideAd];
    }

    GADRequest *request = [GADRequest request];
    // Enable test ads on simulators.
    //request.testDevices = @[ GAD_SIMULATOR_ID ];
    /*request.testDevices = [NSArray arrayWithObjects:
     @"MY_SIMULATOR_IDENTIFIER",
     @"MY_DEVICE_IDENTIFIER",
     nil];*/
    
    self.bannerView.adUnitID = kGoogleAdMobId;
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:request];
    
}


- (void)adViewDidReceiveAd:(GADBannerView *)view {
    NSLog(@"adViewDidReceiveAd");
    
    [self showAd:YES];

    //self.bannerView.hidden = NO;
    //self.closeAdButton.hidden = YES;
    //self.adSpinner.hidden = YES;
    
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    
    NSLog(@"didFailToReceiveAdWithError");
    
    [self showAd:NO];

    //self.bannerView.hidden = YES;
    //self.closeAdButton.hidden = YES;
    //self.adSpinner.hidden = YES;
}

- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}



@end
