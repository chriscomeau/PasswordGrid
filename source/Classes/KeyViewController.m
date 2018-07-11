//
//  KeyViewController.m
//  passwordmatrix
//
//  Created by Chris Comeau on 10-03-01.
//  Copyright 2010 Games Montreal. All rights reserved.
//

#import "KeyViewController.h"
#import "passwordmatrixAppDelegate.h"


@implementation KeyViewController

@synthesize doneButton;
@synthesize keyText;
@synthesize label1;
@synthesize textView;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	appDelegate = (passwordmatrixAppDelegate *)[[UIApplication sharedApplication] delegate];
	    
     //set font
    UIFont* tempFont = [UIFont fontWithName:@"Century Gothic" size:17] ; 
	[label1 setFont:tempFont];

    //tempFont = [UIFont fontWithName:@"Consolas" size:17] ;
	[keyText setFont:tempFont];

    tempFont = [UIFont fontWithName:@"Century Gothic" size:13] ; 
    [textView setFont:tempFont];
    
    tempFont = kButtonFont; 
	doneButton.titleLabel.font = tempFont;
    
    doneButton.enabled = NO;
    
    
	//[doneButton addTarget:self action:@selector(actionDone:)];
	[doneButton addTarget:self action:@selector(actionDone:) forControlEvents:UIControlEventTouchUpInside];
	//doneButton.hidden = TRUE;
	
	keyText.placeholder = @"<enter new key>";
	//keyText.text = keyString;
	
	//keyText.backgroundColor = [appDelegate textBackColor];
	//keyText.borderStyle = UITextBorderStyleBezel;
	keyText.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
	keyText.keyboardType = UIKeyboardTypeDefault;
	keyText.returnKeyType = UIReturnKeyDone;
	keyText.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
	keyText.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
	
	[keyText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    //corner
    [appDelegate cornerView:self.view];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];
	
	/*NSString *keyString = textField.text;
	
	//NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	//[prefs setObject:keyString forKey:@"keyString"];
	
	
	[appDelegate setKey: keyString];
	[appDelegate saveState];
	
	[appDelegate setupSeed];*/
	
	return YES;
}


- (void)textFieldDidChange:(id)sender
{
    UITextField *textField = sender;
	
	if(textField == keyText)
	{
		//convert2Text.text = [appDelegate convert:textField.text];
        if([keyText.text length] > 0)
            doneButton.enabled = YES;
        else
            doneButton.enabled = NO;
    }
}


- (void)actionDone:(id)sender
{
	//passwordmatrixAppDelegate *appDelegate = (passwordmatrixAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSString *keyString = keyText.text;
	
	//NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	//[prefs setObject:keyString forKey:@"keyString"];
	
    //marked as not 1st time
    [appDelegate setPrefOpened:YES];
    [appDelegate saveState];
    
    [appDelegate setKey: keyString];
	[appDelegate saveState];
	
	[appDelegate setupSeed];

	
	
	[appDelegate setShowingHelp:NO];
	
	[appDelegate alertHelpDone];
	//[appDelegate alertHelpDoneNotAnimated];
	
	//also show help
	//[appDelegate alertHelp];
	
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

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
    //google analytics
    [Helpers setupGoogleAnalyticsForView:[[self class] description]];
}

- (void)dealloc {

    //[doneButton release];

	//[super dealloc];
	
}

-(NSUInteger)supportedInterfaceOrientations
{
    if([Helpers isIpad])
    {
        return UIInterfaceOrientationMaskAll;
    }
    else
    {
        //return UIDeviceOrientationPortrait;
        return UIInterfaceOrientationMaskAllButUpsideDown;

    }
}

- (BOOL)shouldAutorotate
{
    if([Helpers isIpad])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if([Helpers isIpad])
    {
        return YES;
    }
    else 
    {
        if(interfaceOrientation == UIDeviceOrientationPortrait) 
            return YES;
        else 
            return NO;
    }
}

@end
