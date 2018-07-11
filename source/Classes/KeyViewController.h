//
//  KeyViewController.h
//  passwordmatrix
//
//  Created by Chris Comeau on 10-03-01.
//  Copyright 2010 Games Montreal. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KeyViewController : UIViewController <UITextFieldDelegate>  {

	IBOutlet UIButton *doneButton;
	IBOutlet UITextField *keyText;

    IBOutlet UILabel *label1;
    IBOutlet UITextView *textView;

	IBOutlet UIWebView *webView;
	id appDelegate;
}

@property(nonatomic,retain) IBOutlet UIButton *doneButton;
//@property(nonatomic,retain) IBOutlet UIWebView *webView;
@property(nonatomic,retain) IBOutlet UITextField *keyText;
@property(nonatomic,retain) IBOutlet UILabel *label1;
@property(nonatomic,retain) IBOutlet UITextView *textView;

@end
