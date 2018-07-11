//
//  OptionsViewController.m
//  passwordmatrix
//
//  Created by Chris Comeau on 10-02-12.
//  Copyright 2010 Games Montreal. All rights reserved.
//

#import "OptionsViewController.h"
#if USE_TESTFLIGHT
#import "TestFlight.h"
#endif
#import "passwordmatrixAppDelegate.h"


@implementation OptionsViewController

@synthesize keyText;
@synthesize keyButton;
@synthesize helpButton;
@synthesize emailButton;
@synthesize switchUppercase;
@synthesize switchRememberKey;
@synthesize switchSymbols;
@synthesize switchNumbers;
@synthesize switchSound;
@synthesize switchDefaultConvert;
@synthesize backScrollView;
@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;
@synthesize label5;
@synthesize label6;
@synthesize label7;



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];
	
	keyString = textField.text;
	
	//NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	//[prefs setObject:keyString forKey:@"keyString"];
	
	
	[appDelegate setKey: keyString];
	[appDelegate saveState];
	
	[appDelegate setupSeed];
	
	//sound
	[appDelegate playSound:SOUND_LOCK];		
	
	if([[appDelegate keyString]  length] == 0)
	{
		//icon warning.png
		//UIImageView * myView = [[ UIImageView  alloc ]  initWithImage :
		//						[UIImage  imageNamed : @"warning.png" ]];
		//[keyText  setLeftView :myView];
		[keyText   setLeftViewMode: UITextFieldViewModeAlways];
		//[myView release ];
	}
	else
	{
		[keyText   setLeftViewMode: UITextFieldViewModeNever];
	}
	
	
	if([[appDelegate keyString]  length] == 0)
	{
		//[appDelegate alertKey];
	}
	
	return YES;
}

- (void)notifyForeground
{
	[self setupUI];
}

- (void)setupUI
{
	[appDelegate loadState];
	
	keyString = [appDelegate keyString];
	
	
	keyText.text = keyString;
	
	if([[appDelegate keyString]  length] == 0)
	{
		//icon warning.png
		//UIImageView * myView = [[ UIImageView  alloc ]  initWithImage :
		//						[UIImage  imageNamed : @"warning.png" ]];
		//[keyText  setLeftView :myView];
		[keyText   setLeftViewMode: UITextFieldViewModeAlways];
		//[myView release ];
	}
	else
	{
		[keyText   setLeftViewMode: UITextFieldViewModeNever];
	}
	
}

- (void)viewDidAppear:(BOOL)animated
 {
    [super viewWillAppear:animated];
	[self becomeFirstResponder];

    //google analytics
    [Helpers setupGoogleAnalyticsForView:[[self class] description]];
    
	//fade
	[appDelegate fadeDefault];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	
	isVisible = true;
    
	//notify
	if([appDelegate backgroundSupported])
	{
		[[NSNotificationCenter  defaultCenter] addObserver:self
												  selector:@selector(notifyForeground)
													  name:UIApplicationWillEnterForegroundNotification
													object:nil]; 
	}	

	[self setupUI];
		        

}

- (void)viewWillDisappear:(BOOL)animated {
	
	isVisible = false;
    
	//notify
	if([appDelegate backgroundSupported])
	{
		[[NSNotificationCenter defaultCenter] removeObserver:self]; 
	}
	
	
	[super viewWillDisappear:animated];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	appDelegate = (passwordmatrixAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    
    //set font
    UIFont* tempFont = [UIFont fontWithName:@"Century Gothic" size:17] ; 
	[label1 setFont:tempFont];
	[label2 setFont:tempFont];
	[label3 setFont:tempFont];
	[label4 setFont:tempFont];
	[label5 setFont:tempFont];
    [label6 setFont:tempFont];
    [label7 setFont:tempFont];
    
    //tempFont = [UIFont fontWithName:@"Consolas" size:17] ;
	[keyText setFont:tempFont];
    
    tempFont = kButtonFont; 

	emailButton.titleLabel.font = tempFont;
    

    [self.view setMultipleTouchEnabled:YES];

	isVisible = false;
	
	keyText.placeholder = @"<enter new key>"; 
	//keyText.borderStyle = UITextBorderStyleRoundedRect;
	//keyText.textColor = [UIColor blackColor];
	//keyText.font = [UIFont systemFontOfSize:17.0];
	//keyText.tag = kViewTag;		// tag this control so we can remove it later for recycled cells
	
	keyText.text = keyString;
	
	//keyText.backgroundColor = [UIColor whiteColor];
	//keyText.backgroundColor = [UIColor colorWithRed:245/255.f green:250/255.f blue:217/255.f alpha:0/255.f ];
	//textBackColor = [UIColor colorWithRed:245/255.f green:250/255.f blue:217/255.f alpha:0/255.f ];
	//keyText.backgroundColor = [appDelegate textBackColor];
	
	//keyText.borderStyle = UITextBorderStyleBezel;
	keyText.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
	keyText.keyboardType = UIKeyboardTypeDefault;
	keyText.returnKeyType = UIReturnKeyDone;
	keyText.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
	keyText.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed

    //[Helpers offsetTextField:keyText]; //padding
    /*UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, textField.frame.size.height)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;*/

	//icon warning.png
	UIImageView * myView = [[ UIImageView  alloc ]  initWithImage :
							[UIImage  imageNamed : @"warning.png" ]];
	[keyText  setLeftView :myView];
	//[keyText   setLeftViewMode: UITextFieldViewModeAlways];
	[keyText   setLeftViewMode: UITextFieldViewModeNever];
	//[myView release ];

	[keyButton addTarget:self action:@selector(actionKey:) forControlEvents:UIControlEventTouchUpInside];
	
	[helpButton addTarget:self action:@selector(actionHelp:) forControlEvents:UIControlEventTouchUpInside];
    helpButton.hidden = TRUE;

	
	[emailButton addTarget:self action:@selector(actionEmail:) forControlEvents:UIControlEventTouchUpInside];
	//helpButton.hidden = TRUE;
	
     //doesn't work in ios5?
    if(SYSTEM_VERSION_LESS_THAN(@"5"))
    {
    }
    else
    {
        //UIColor *color = [UIColor greenColor];
        UIColor *color = RGBA(114,178,39, 255);

        switchUppercase.onTintColor = color;
        switchRememberKey.onTintColor = color;
        switchSymbols.onTintColor = color;
        switchNumbers.onTintColor = color;
        switchSound.onTintColor = color;
        switchDefaultConvert.onTintColor = color;
	}
	
	switchUppercase.on = [appDelegate prefUppercase];
	[switchUppercase addTarget:self action:@selector(actionUppercase:) forControlEvents:UIControlEventValueChanged];
	
	switchRememberKey.on = [appDelegate prefRemember];
	[switchRememberKey addTarget:self action:@selector(actionRemember:) forControlEvents:UIControlEventValueChanged];
	
	switchSymbols.on = [appDelegate prefSymbols];
	[switchSymbols addTarget:self action:@selector(actionSymbols:) forControlEvents:UIControlEventValueChanged];
	
	switchNumbers.on = [appDelegate prefNumbers];
	[switchNumbers addTarget:self action:@selector(actionNumbers:) forControlEvents:UIControlEventValueChanged];
	
	switchSound.on = [appDelegate prefPlaySound];
	[switchSound addTarget:self action:@selector(actionSound:) forControlEvents:UIControlEventValueChanged];	
    
    switchDefaultConvert.on = [appDelegate prefDefaultConvert];
	[switchDefaultConvert addTarget:self action:@selector(actionDefaultConvert:) forControlEvents:UIControlEventValueChanged];
	

    [self becomeFirstResponder];
    
    //scroll
    int wiggle = 0;
    backScrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+wiggle);

    
	[self setupUI];
	
    //corner
    [appDelegate cornerView:self.view];
}

- (void)actionUppercase:(id)sender
{
	[appDelegate setPrefUppercase:[sender isOn]];
	[appDelegate saveState];
	[appDelegate setupSeed];

}

- (void)actionRemember:(id)sender
{
    [HapticHelper generateFeedback:kFeedbackType];

	[appDelegate setPrefRemember:[sender isOn]];
	[appDelegate saveState];
	[appDelegate setupSeed];	
}

- (void)actionSwitch:(id)sender
{
	/*if([sender isOn])
	{	
		[self copyToPasteBoard];
	}*/
	
	[appDelegate setPrefAutocopy:[sender isOn]];
	[appDelegate saveState];
}


- (void)actionSymbols:(id)sender
{
    [HapticHelper generateFeedback:kFeedbackType];

	[appDelegate setPrefSymbols:[sender isOn]];
	[appDelegate saveState];
	[appDelegate setupSeed];
	
}

- (void)actionNumbers:(id)sender
{
    [HapticHelper generateFeedback:kFeedbackType];

	[appDelegate setPrefNumbers:[sender isOn]];
	[appDelegate saveState];
	[appDelegate setupSeed];
	
}

- (void)actionSound:(id)sender
{
	[appDelegate setPrefPlaySound:[sender isOn]];
	[appDelegate saveState];
}


- (void)actionDefaultConvert:(id)sender
{
    [HapticHelper generateFeedback:kFeedbackType];

	[appDelegate setPrefDefaultConvert:[sender isOn]];
	[appDelegate saveState];	
}

- (void)actionHelp:(id)sender
{
    [HapticHelper generateFeedback:kFeedbackType];

	[appDelegate alertHelp:YES];
}

- (void)actionEmail:(id)sender
{
#if USE_TESTFLIGHT
    if([appDelegate isTestflight])
        [TestFlight passCheckpoint:@"OptionsViewController:actionEmail"];
#endif
    
    [HapticHelper generateFeedback:kFeedbackType];

	if([[appDelegate keyString]  length] == 0)
	{
		[appDelegate alertKey];
	}
	else
	{
		//[appDelegate alertHelp];
		//NSString* bodyString = @"Check out this application:\n\nhttp://itunes.com/app/PasswordGrid";
		
		//NSString* gridString = @"A:12 B:34 C:56 D:78\nA:12 B:34 C:56 D:78\nA:12 B:34 C:56 D:78\nA:12 B:34 C:56 D:78\nA:12 B:34 C:56 D:78\nA:12 B:34 C:56 D:78\nA:12 B:34 C:56 D:78\nA:12 B:34 C:56 D:78\nA:12 B:34 C:56 D:78\n";
		NSString* gridString = [appDelegate getGridString];
		
		
		//NSString *bodyString = [NSString stringWithFormat: @"Here is your Password Grid, using the key '%@':\n\n%@\n\nPassword Grid: http://passwordgrid.com/", keyString, gridString];
		NSString *bodyString = [NSString stringWithFormat: @"Here is your Password Grid, using the key '%@':\n\n%@\n\nPassword Grid for iOS\nhttp://itunes.apple.com/app/id359807331", keyString, gridString];
		
		//[bodyString stringByAppendingString: [appDelegate getGridString] ];
		
		
		[appDelegate sendEmailTo:@"" withSubject: @"My Password Grid" withBody:bodyString  withView:self];
		
	}
	
}

- (void)actionKey:(id)sender
{
	//[appDelegate keyString] = keyText.text;
	[appDelegate setupSeed];
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
	
	/*[keyText release];
	[keyButton release];
	[helpButton release];
	[emailButton release];
	[switchUppercase release];
	[switchRememberKey release];
	[switchSymbols release];
	[switchSound release];
	
    [super dealloc];*/
}


@end
