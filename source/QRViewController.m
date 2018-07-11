//
//  QRViewController.m
//  passwordmatrix
//
//  Created by Chris Comeau on 10-02-15.
//  Copyright 2010 Games Montreal. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "QRViewController.h"
#import "passwordmatrixAppDelegate.h"
#if USE_TESTFLIGHT
#import "TestFlight.h"
#endif


@implementation QRViewController

@synthesize doneButton;
@synthesize textView;
@synthesize imageViewQR;
@synthesize appTextView;
@synthesize appImageButton;
@synthesize appTextButton;

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

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
    //google analytics
    [Helpers setupGoogleAnalyticsForView:[[self class] description]];
    
    //button
    if([appDelegate showingHelp] == YES)
	{
		//doneButton.text = @"Next";
		
		[doneButton setTitle:@"Next" forState:UIControlStateNormal];
		[doneButton setTitle:@"Next" forState:UIControlStateHighlighted];
		[doneButton setTitle:@"Next" forState:UIControlStateDisabled];
		[doneButton setTitle:@"Next" forState:UIControlStateSelected];
	}
	else
	{
		//doneButton.text = @"Done";
		
		[doneButton setTitle:@"Done" forState:UIControlStateNormal];
		[doneButton setTitle:@"Done" forState:UIControlStateHighlighted];
		[doneButton setTitle:@"Done" forState:UIControlStateDisabled];
		[doneButton setTitle:@"Done" forState:UIControlStateSelected];
	}	
    
    
    //scroll bars
	[textView flashScrollIndicators];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	appDelegate = (passwordmatrixAppDelegate *)[[UIApplication sharedApplication] delegate];
    
	 //set font
    UIFont* tempFont = [UIFont fontWithName:@"Century Gothic" size:13] ; 
	[textView setFont:tempFont];
    
    tempFont = kButtonFont; 
	doneButton.titleLabel.font = tempFont;
    
    tempFont = [UIFont fontWithName:@"Century Gothic" size:10] ;
    [appTextView setFont:tempFont];


	[doneButton addTarget:self action:@selector(actionDone:) forControlEvents:UIControlEventTouchUpInside];
	[appImageButton addTarget:self action:@selector(actionApp:) forControlEvents:UIControlEventTouchUpInside];
	[appTextButton addTarget:self action:@selector(actionApp:) forControlEvents:UIControlEventTouchUpInside];
    
    //qr
    UIImage* image = NULL;
    /*NSString *qrString = @"http://itunes.apple.com/app/id359807331";
    image = [QREncoder encode:qrString size:qrSize correctionLevel: QRCorrectionLevelLow];*/
   
    image = [appDelegate getQRImage];
    
    //null?
    
    UIImage *maskedImg = nil;
    if (SYSTEM_VERSION_LESS_THAN(@"4.2")) 
    {        
        maskedImg = [appDelegate maskImage:image withMask:image]; //[UIImage copyWithZone:]: unrecognized selector before 4.2
    }
    else
    {
        maskedImg = [appDelegate maskImage:image withMask:[image copy]];   
    }
    
    
    UIImage *coloredImg = [appDelegate colorizeImage:maskedImg];
    
    UIImage *newImage = coloredImg;

    
    assert(newImage);
    
    //http://stackoverflow.com/questions/1367994/uiimageview-resize
    
    
    //imageViewQR.autoresizingMask = ( UIViewAutoresizingFlexibleWidth );
    
    //google charts
    /*NSURL *imageURL = [NSURL URLWithString:@"http://chart.apis.google.com/chart?cht=qr&chs=200x200&chl=http://itunes.apple.com/app/id359807331"];
     
     UIImage *image = [[UIImage alloc] initWithData: [NSData dataWithContentsOfURL:imageURL]]; 
     
     */
    
    
    if(newImage)
    {
        [imageViewQR setAlpha:0.8];
        [imageViewQR layer].magnificationFilter = kCAFilterNearest;
        [imageViewQR setImage:newImage];
        
    }
    
	//corner
    [appDelegate cornerView:self.view];

}

- (void)actionApp:(id)sender
{
    if(USE_ANALYTICS == 1)
	{
		//[[LocalyticsSession sharedLocalyticsSession] tagEvent:@"actionDone"];
	}

    [appDelegate gotoQRScannerApp];
}


- (void)actionDone:(id)sender
{
	//passwordmatrixAppDelegate *appDelegate = (passwordmatrixAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	//if([[appDelegate keyString]  length] == 0)
	if([appDelegate showingHelp] == YES)
	{
		//first time
		[appDelegate alertHelpDoneFirstTime];
	}
	else 
	{
		[appDelegate alertHelpDone];

	}
    
#if USE_TESTFLIGHT
    if([appDelegate isTestflight])
        [TestFlight passCheckpoint:@"QRViewController:actionDone"];
#endif
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
    
	//[doneButton release];
	//[doneButton release];
	//[webView release];

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
