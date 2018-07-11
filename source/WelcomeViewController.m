//
//  WelcomeViewController.m


#import "WelcomeViewController.h"
#import "passwordmatrixAppDelegate.h"
//#import "FlurryAnalytics.h"
#import "WelcomePageView.h"

/*

Welcome to Password Grid!
A secure password generator for iPhone.

Choosing and remembering a strong password is complicated. It's easier to remember an simple password and convert it to a secure one.

This is exactly what Password Grid does. It helps you generate a random grid of characters, based on a key you choose.

With the grid, you can visually convert an easy to remember password (like "secret") to something safer (like "8A2sN34v2s5T").

•You can have your converted password copied to your clipboard or emailed to you for quick access.

•You can customize the grid generation complexity, with uppercase letters, numbers and symbols, which makes your encrypted passwords much more secure.



Settings:

Key: to seed to generate the random grid. Choose something easy to remember like your name or email, if you need to regenerate the grid.

Remember Key: Disable this to have the app forget your key when you quit.

Numbers: inserts numbers in the grid.

Letters: (coming soon)

Uppercase: inserts uppercase letters in the grid.

Symbols: inserts symbols (like $ * / @ !) to the grid.

Sounds: toggle user interface sounds.

Convert at Launch: starts the app on the "Convert" tab instead of the "Grid" tab.


Let us know if you have any feedback, thanks!

Proudly made in Montreal, Canada!


*/

@implementation WelcomeViewController

@synthesize buttonTest;
@synthesize buttonSkip;
@synthesize labelSkip;
@synthesize pagingScrollView;
@synthesize navImage;
@synthesize mainImage;
@synthesize isDone;
@synthesize pageControl;
@synthesize labelTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"WelcomeViewController::viewDidLoad");

    [super viewDidLoad];

    appDelegate = (passwordmatrixAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    currentState = welcomeViewState1;
    isDone = YES;
    
    //scroll
    numPages = 4;

   // pagingScrollView.previewInsets = UIEdgeInsetsMake(0, 50, 0, 50);
	[pagingScrollView reloadPages];
    
    pagingScrollView.scrollsToTop = NO;

	pageControl.currentPage = 0;
	pageControl.numberOfPages = numPages;
        
    
    //skip
    [buttonSkip addTarget:self action:@selector(actionSkip) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] bringSubviewToFront:buttonSkip];
    buttonSkip.hidden = NO;
    buttonSkip.userInteractionEnabled = YES;

    UIFont* tempFont = [UIFont fontWithName:@"Century Gothic" size:18];
    //UIFont* tempFont = [UIFont fontWithName:@"PTSans-Bold" size:20];
    [labelSkip setFont: tempFont];
    labelSkip.text = [NSString stringWithFormat:STR_WELCOME_BUTTON_1];
    labelSkip.textColor = [appDelegate buttonTextColor]; //[UIColor whiteColor];

    [[self view] bringSubviewToFront:labelSkip];
    
    //title
    /*labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.font = [UIFont fontWithName:@"A.C.M.E. Secret Agent" size:20] ;
    labelTitle.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    labelTitle.textAlignment = UITextAlignmentCenter;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.text = @"Password Grid";*/

    //corner
    [appDelegate cornerView:self.view];
    
    pageControl.hidden = NO;
    navImage.hidden = YES;

}

 - (void)actionSkip
{
    NSLog(@"WelcomeViewController::actionSkip");
    [self hide];
}
 
- (void)hide
{
    NSLog(@"WelcomeViewController::hide");
    
    /*if(USE_ANALYTICS == 1)
	{
        [FlurryAnalytics logEvent:@"WelcomeViewController::hide"];
	}*/

    //already hidding
    if(isDone)
        return;

    isDone = YES;
	
    //marked as not 1st time
    [appDelegate setPrefOpened:YES];
    [appDelegate saveState];

	//if([[appDelegate keyString]  length] == 0)
	if([appDelegate showingHelp] == YES)
	{
		//first time
		[appDelegate alertHelpDoneFirstTime];

        //[self dismissModalViewControllerAnimated:YES];
        //[kAppDelegate alertAskKey];

	}
	else
	{
		[appDelegate alertHelpDone];
        //[self dismissModalViewControllerAnimated:YES];
	}

    
    //switch back
    //[[appDelegate mainViewController] showMain];

    /*
    BOOL fade = YES;
    
    if(fade)
    {
        //fade welcome
        [UIView animateWithDuration:SPLASH_FADE_TIME
                         animations:^{
                             [self view].alpha = 0.0;
                         }
                         completion:^(BOOL finished) {
                             
                            buttonTest.hidden = YES;
                            buttonTest.userInteractionEnabled = NO;
                            [self view].hidden = YES;

                            [appDelegate checkOnline];

                            currentState = welcomeViewState1;
                            isDone = YES;
                            
                            [appDelegate setPrefOpened:YES];
                            [appDelegate saveState];

                             
                         }];
    }
    else
    {
    
        //disable
        buttonTest.hidden = YES;
        buttonTest.userInteractionEnabled = NO;
        [self view].hidden = YES;

        [appDelegate checkOnline];

        currentState = welcomeViewState1;
        isDone = YES;
        
        [appDelegate setPrefOpened:YES];
        [appDelegate saveState];

    }
    */
}

- (void)reset
{
    [self show1];
    
     //scroll
    //[pageView setPageIndex:0];
    pageControl.currentPage = 0;
    [pagingScrollView selectPageAtIndex:0 animated:NO];
    [pagingScrollView reloadPages];
}

- (void)show1
{
    NSLog(@"WelcomeViewController::show1");
    
    /*if(USE_ANALYTICS == 1)
	{
        [FlurryAnalytics logEvent:@"WelcomeViewController::show1"];
	}*/
    
    currentState = welcomeViewState1;

    //switch image
    [navImage setImage:[UIImage imageNamed:@"welcome_nav1.png"] ];
    
    isDone = NO;
    
    mainImage.hidden = YES;
    //navImage.hidden = NO;
    
    //navImage.contentMode = UIViewContentModeCenter; //UIViewContentModeScaleAspectFit
    //mainImage.contentMode = UIViewContentModeCenter;
    
    [self view].hidden = NO;
    [self view].alpha = 1.0;
    
   if([appDelegate prefOpened])
        labelSkip.text = [NSString stringWithFormat:STR_WELCOME_BUTTON_3];
    else
        labelSkip.text = [NSString stringWithFormat:STR_WELCOME_BUTTON_1];
}

- (void)show2
{
    NSLog(@"WelcomeViewController::show2");
    
    /*if(USE_ANALYTICS == 1)
	{
        [FlurryAnalytics logEvent:@"WelcomeViewController::show2"];
	}*/
    
    currentState = welcomeViewState2;
    
    //switch image
    [navImage setImage:[UIImage imageNamed:@"welcome_nav2.png"] ];
    
    //navImage.contentMode = UIViewContentModeCenter; //UIViewContentModeScaleAspectFit
    //mainImage.contentMode = UIViewContentModeCenter;


    if([appDelegate prefOpened])
        labelSkip.text = [NSString stringWithFormat:STR_WELCOME_BUTTON_3];
    else
        labelSkip.text = [NSString stringWithFormat:STR_WELCOME_BUTTON_1];


}

- (void)show3
{
    NSLog(@"WelcomeViewController::show3");
    
    /*if(USE_ANALYTICS == 1)
	{
        [FlurryAnalytics logEvent:@"WelcomeViewController::show3"];
	}*/
    
    currentState = welcomeViewState3;
    
    //switch image
    [navImage setImage:[UIImage imageNamed:@"welcome_nav3.png"] ];
    
    //navImage.contentMode = UIViewContentModeCenter; //UIViewContentModeScaleAspectFit
    //mainImage.contentMode = UIViewContentModeCenter;


    if([appDelegate prefOpened])
        labelSkip.text = [NSString stringWithFormat:STR_WELCOME_BUTTON_3];
    else
        labelSkip.text = [NSString stringWithFormat:STR_WELCOME_BUTTON_1];

}

- (void)show4
{
    NSLog(@"WelcomeViewController::show4");
    
    /*if(USE_ANALYTICS == 1)
	{
        [FlurryAnalytics logEvent:@"WelcomeViewController::show4"];
	}*/
    
    currentState = welcomeViewState4;
    
    //switch image
    [navImage setImage:[UIImage imageNamed:@"welcome_nav4.png"] ];
    
    //navImage.contentMode = UIViewContentModeCenter; //UIViewContentModeScaleAspectFit
    //mainImage.contentMode = UIViewContentModeCenter;


     if([appDelegate prefOpened])
        labelSkip.text = [NSString stringWithFormat:STR_WELCOME_BUTTON_3];
    else
        labelSkip.text = [NSString stringWithFormat:STR_WELCOME_BUTTON_2];


}

- (IBAction)pageTurn
{
	[pagingScrollView selectPageAtIndex:pageControl.currentPage animated:YES];
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

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[pagingScrollView beforeRotation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[pagingScrollView afterRotation];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)theScrollView
{
	pageControl.currentPage = [pagingScrollView indexOfSelectedPage];
	[pagingScrollView scrollViewDidScroll];
    
    
   switch(pageControl.currentPage)
    {
        case 0:
            [self show1];
            break;
            
        case 1:
            [self show2];
            break;
            
        case 2:
            [self show3];
            break;
            
        case 3:
            [self show4];
            break;

         case 4:
            //[self hide];
            break;
            
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //google analytics
    [Helpers setupGoogleAnalyticsForView:[[self class] description]];

    [self reset];
	
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[self becomeFirstResponder];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)theScrollView
{
    
    if ([pagingScrollView indexOfSelectedPage] == numPages - 1)
	{
        NSLog(@"WelcomeViewController::scrollViewDidEndDecelerating: end?");
	}
    
}

#pragma mark - MHPagingScrollViewDelegate

- (NSInteger)numberOfPagesInPagingScrollView:(MHPagingScrollView *)pagingScrollView
{
	return numPages;
}

- (UIView *)pagingScrollView:(MHPagingScrollView *)thePagingScrollView pageForIndex:(NSInteger)index
{
	WelcomePageView *pageView = (WelcomePageView *)[thePagingScrollView dequeueReusablePage];
	if (pageView == nil)
		pageView = [[WelcomePageView alloc] init];

	[pageView setPageIndex:index];
	return pageView;
}

- (void)didReceiveMemoryWarning
{
	[pagingScrollView didReceiveMemoryWarning];
}

    
@end
