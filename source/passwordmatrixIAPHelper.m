//
//  passwordmatrixIAPHelper.m
//  
//
//  Created by Chris Comeau on 3/24/13.
//
//


#import "passwordmatrixAppDelegate.h"
#import "passwordmatrixIAPHelper.h"

@implementation passwordmatrixIAPHelper

+ (passwordmatrixIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static passwordmatrixIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      IAP_ID_REMOVEADS,
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
	
    return sharedInstance;
}

@end