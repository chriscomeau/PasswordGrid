//
//  MyTabBarController.m
//  passwordmatrix
//
//  Created by Chris Comeau on 11-06-26.
//  Copyright 2011 Skyriser Media. All rights reserved.
//

#import "MyTabBarController.h"
#import "passwordmatrixAppDelegate.h"

@implementation MyTabBarController


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
   
    if([appDelegate isIpad])
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
