//
//  QRViewController.h
//  passwordmatrix
//
//  Created by Chris Comeau on 10-02-15.
//  Copyright 2010 Games Montreal. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "passwordmatrixAppDelegate.h"

@interface QRViewController : UIViewController 
{
	//passwordmatrixAppDelegate *appDelegate;

	//IBOutlet UIBarButtonItem *doneButton;
	IBOutlet UIButton *doneButton;
    IBOutlet UITextView *textView;
    IBOutlet UIImageView *imageViewQR;
	//IBOutlet UIWebView *webView;
	id appDelegate;
    IBOutlet UITextView *appTextView;
    IBOutlet UIButton *appImageButton;
    IBOutlet UIButton *appTextButton;
}

//@property(nonatomic,retain) IBOutlet UIBarButtonItem *doneButton;
@property(nonatomic,retain) IBOutlet UIButton *doneButton;
@property(nonatomic,retain) IBOutlet UITextView *textView;
@property(nonatomic,retain) IBOutlet UIImageView *imageViewQR;
@property(nonatomic,retain) IBOutlet UITextView *appTextView;
@property(nonatomic,retain) IBOutlet UIButton *appImageButton;
@property(nonatomic,retain) IBOutlet UIButton *appTextButton;
//@property(nonatomic,retain) IBOutlet UIWebView *webView;


@end
