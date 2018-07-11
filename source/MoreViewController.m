//
//  MoreViewController.m
//  passwordmatrix
//
//  Created by Chris Comeau on 10-02-12.
//  Copyright 2010 Games Montreal. All rights reserved.
//


#import "MoreViewController.h"
#import "passwordmatrixAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

#if USE_TESTFLIGHT
    #import "TestFlight.h"
#endif

@implementation MoreViewController

@synthesize webView;
@synthesize spin;
@synthesize error_text;
@synthesize doneButton;
@synthesize skip;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
	[self becomeFirstResponder];
    
    //for orientation fix
    if(skip)
        return;
        
    //web
    
    //NSString *urlAddress = @"http://www.skyriser.com/news_iphone_transparent.php";
    NSString *urlAddress = @"http://www.skyriser.com/iphone_small_transparent.php";
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //to test
    [self setWebView: webView];
    [webView setDelegate: self];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
    
    //hud
    UIView* tempView = self.view;
    
    
    HUD = [[MBProgressHUD alloc] initWithView:tempView];
    
	[tempView addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    HUD.userInteractionEnabled = NO;
    
    //HUD.detailsLabelText = @"updating news";
    //HUD.square = YES;
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
	[self resignFirstResponder];
		
	
	[super viewWillDisappear:animated];
    
    
    if ([webView isLoading])
        [webView stopLoading];
    
    doHud = false;
    
    //if(HUD)
    [HUD hide:YES];
    
    if(USE_ANALYTICS == 1)
	{
		[[LocalyticsSession sharedLocalyticsSession] tagEvent:@"MoreView"];
        [FlurryAnalytics logEvent:@"MoreView"];
	}

}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	appDelegate = (passwordmatrixAppDelegate *)[[UIApplication sharedApplication] delegate];
		//force
	[self becomeFirstResponder];
    
    doHud = false;
    
    alreadyLoading = false;
    
    UIFont* tempFont = [UIFont fontWithName:@"CenturyGothic-Bold" size:13] ;
	doneButton.titleLabel.font = tempFont;

	[doneButton addTarget:self action:@selector(actionDone:) forControlEvents:UIControlEventTouchUpInside];

    //corner
    [appDelegate cornerView:self.view];
}

- (void)viewWillAppear:(BOOL)animated 
{
    
    if(alreadyLoading)
        return;
    
    //spin.hidden= FALSE;   
        
    //[webView reload];
   
    alreadyLoading = true;
    
    error_text.hidden = TRUE;
    error_text.opaque = NO;
    error_text.backgroundColor = [UIColor clearColor];
    error_text.userInteractionEnabled = NO;

    
    
    //bounce
    /*
     for (id subview in webView.subviews)
        if ([[subview class] isSubclassOfClass: [UIScrollView class]])
            ((UIScrollView *)subview).bounces = NO;
    */
    
    //disable bounce shadow
    webView.backgroundColor = [UIColor whiteColor];
    for (UIView* subView in [webView subviews])
    {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            for (UIView* shadowView in [subView subviews])
            {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    [shadowView setHidden:YES];
                }
            }
        }
    }

    
    
    //clear it
    webView.hidden = FALSE;
    //[webView loadHTMLString:@"<html><head></head><body></body></html>" baseURL:nil];
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML = \"\";"];
    
    webView.opaque = NO;
    webView.backgroundColor = [UIColor clearColor];
    
       
} 

//open links in safari instead of built in
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webViewIn
{
	//show spin
    //spin.hidden = FALSE; 
    
    //title
    UIApplication* app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = YES;
    
    //hud
    doHud = true;
    [self showHud];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webViewIn
{
	//hide spin
    // spin.hidden = TRUE; 
    
    //title
    UIApplication* app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = NO;
    doHud = false;
    [HUD hide:YES];
    alreadyLoading = false;
    
}

- (void)webView:(UIWebView *)webViewIn didFailLoadWithError:(NSError *)error
{
    NSString *error_desc = [error localizedDescription];
    NSLog(@"%@", error_desc);
    
    //hide spin
    //spin.hidden = TRUE; 
    
    //title
    UIApplication* app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = NO;
    doHud = false;
    [HUD hide:YES];
    alreadyLoading = false;
    
    //show error
    //[webView loadHTMLString:@"<html><head><meta name='viewport' content='initial-scale = 1.0,maximum-scale = 1.0' /></head><body><p align='center'><br><br><br>Could not load news, please make sure you have an internet connection and try again later.</p></body></html>" baseURL:nil];
    
    [webView loadHTMLString:@"<html><head></head><body></body></html>" baseURL:nil];
    webView.hidden = TRUE;
    
    error_text.hidden = FALSE;
    
    if(USE_ANALYTICS == 1)
	{
		[[LocalyticsSession sharedLocalyticsSession] tagEvent:@"MoreView: webview error"];
        [FlurryAnalytics logEvent:@"MoreView: webview error"];
	}
    
}


-(BOOL)canBecomeFirstResponder
{
	return YES;
}

//accelerometer, shake
 - (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
 {
	 if(event.type == UIEventSubtypeMotionShake)
	 {
	 
	 }
 }


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)showHud
{
    
    	
    [HUD showWhileExecuting:@selector(hudTask) onTarget:self withObject:nil animated:YES];
}


- (void)hudTask 
{
    //sleep(1);
    
    int hudTimeStart = [[NSDate date] timeIntervalSince1970];
    while(doHud)
    {
        int hudTimeCurrent =  [[NSDate date] timeIntervalSince1970];
       
        //more than 5 secs
        if( (hudTimeCurrent - hudTimeStart) > 50000) //in 1000ths or seconds?
        {
            doHud = false;
            [HUD hide:YES];
        }
    }
}

- (void)hudWasHidden {
    
    doHud = false;

	// Remove HUD from screen when the HUD was hidden
	//[HUD removeFromSuperview];
	//[HUD release];
}

- (void)dealloc {
	

	[HUD removeFromSuperview];
	//[HUD release];
    
    //[super dealloc];
}

- (void)actionDone:(id)sender
{
		[appDelegate alertMoreDone];
        
    
#if USE_TESTFLIGHT
    if([appDelegate isTestflight])
        [TestFlight passCheckpoint:@"MoreViewController:actionDone"];
#endif
}



@end
