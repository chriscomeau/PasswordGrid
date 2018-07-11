// CustomUITabBarController.m

#import "CustomUITabBarController.h"
#import "passwordmatrixAppDelegate.h"

@implementation CustomUITabBarController


- (void)viewDidLoad {

    [super viewDidLoad];
        
    appDelegate = (passwordmatrixAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //doesn't work in ios5?
    if(SYSTEM_VERSION_LESS_THAN(@"5"))
    {
        
        CGRect frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, 48);
        UIView *v = [[UIView alloc] initWithFrame:frame];
        //[v setBackgroundColor:[[UIColor alloc] initWithRed:0.1  green:0.6  blue:0.1 alpha:0.5]];
        [v setBackgroundColor:[[UIColor alloc] initWithRed:0.2  green:0.6  blue:0.2 alpha:0.3]];

        [v setAlpha:0.5];
        //[[self tabBar] addSubview:v];
        [[self tabBar] insertSubview:v atIndex:0];
        //[v release];
    }
    else if(kIsIOS7)
    {
        //ios7
        //[[UITabBar appearance] setTintColor:RGBA(114,178,39, 255)]; ///same as switch
        [[UITabBar appearance] setTintColor:RGBA(95,156,24, 255)]; ///same as switch
        
        if(![Helpers isIpad])
        {
            //[[UITabBar appearance] setBarTintColor:RGBA(211,218,171, 255)]; //normal background
            //[[UITabBar appearance] setBarTintColor:RGBA(193,201,146, 255)]; //darker
            [[UITabBar appearance] setBarTintColor:RGBA(219,225,179, 255)]; //same as bg
        }
        
        //[self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"item_seleted.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"item_unselected.png"]];

    }
    else
    {   
        //ios5
        self.tabBar.tintColor = RGBA(0, 30, 0, 245);   //green
        self.tabBar.selectedImageTintColor = RGBA(110,153,59, 245);   //green
        
    }
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
