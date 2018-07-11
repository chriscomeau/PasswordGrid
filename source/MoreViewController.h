//
//  MoreViewController.h
//  passwordmatrix
//
//  Created by Chris Comeau on 10-02-12.
//  Copyright 2010 Games Montreal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface MoreViewController : UIViewController <UIWebViewDelegate,  MBProgressHUDDelegate> {

    id appDelegate;
    
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *spin;
    IBOutlet UITextView *error_text;
    
    MBProgressHUD *HUD;
    bool doHud;
    bool alreadyLoading;
    BOOL skip;
    
    IBOutlet UIButton *doneButton;

}

@property(nonatomic,retain) IBOutlet UIButton *doneButton;

- (void)hudTask;
- (void)showHud;

@property (assign, nonatomic) BOOL skip;

@property(nonatomic,retain)IBOutlet UIWebView *webView;
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *spin;
@property(nonatomic,retain)IBOutlet UITextView *error_text;

@end
