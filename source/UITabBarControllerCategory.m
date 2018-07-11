#import "UITabBarControllerCategory.h"

@implementation UITabBarController (UITabBarControllerCategory)



-(NSUInteger)supportedInterfaceOrientations
{
    //new
    //if([appDelegate isIpad])
    if(false)
    {
        return UIInterfaceOrientationMaskAll;
    }
    else
    {
        //return UIDeviceOrientationPortrait;
        //return UIInterfaceOrientationPortrait;
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
}


- (BOOL)shouldAutorotate
{
    //new
    //if([appDelegate isIpad])
    if(false)
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
    //old
    //if([appDelegate isIpad])
    if(false)
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
