//
//  MyApplication.m


#import "MyApplication.h"

@implementation MyApplication


-(BOOL)openURL:(NSURL *)url{
    //id appDelegate = (passwordmatrixAppDelegate *)[[UIApplication sharedApplication] delegate];


    /*if  ([appDelegate openURL:url])
        return YES;
    else
        return [super openURL:url];*/
   
    //return [appDelegate openURL:url];
    return [super openURL:url];
}


@end
