//
//  CreditsViewController.h
//  passwordmatrix
//
//  Created by Chris Comeau on 10-02-15.
//  Copyright 2010 Games Montreal. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "passwordmatrixAppDelegate.h"

@interface CreditsViewController : UIViewController 
{
	//passwordmatrixAppDelegate *appDelegate;
    
	//IBOutlet UIBarButtonItem *doneButton;
	IBOutlet UIButton *doneButton;
    IBOutlet UITextView *textView;
	//IBOutlet UIWebView *webView;
	id appDelegate;
    
}

//@property(nonatomic,retain) IBOutlet UIBarButtonItem *doneButton;
@property(nonatomic,retain) IBOutlet UIButton *doneButton;
@property(nonatomic,retain) IBOutlet UITextView *textView;

//@property(nonatomic,retain) IBOutlet UIWebView *webView;


@end
