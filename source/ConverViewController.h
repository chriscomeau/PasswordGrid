//
//  ConverViewController.h
//  passwordmatrix
//
//  Created by Chris Comeau on 10-02-12.
//  Copyright 2010 Games Montreal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#import <GoogleMobileAds/GADRequest.h>
#import <GoogleMobileAds/GADBannerView.h>

@interface ConverViewController : UIViewController <UITextFieldDelegate, MBProgressHUDDelegate, UIActionSheetDelegate, GADBannerViewDelegate> {
	id appDelegate;
	
	IBOutlet UITextField *convert1Text;
	IBOutlet UITextField *convert2Text;
	IBOutlet UIButton *convertButton;
	IBOutlet UIButton *clipButton;
	IBOutlet UIButton *emailButton;
	IBOutlet UIButton *helpButton;
    
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    IBOutlet UIImageView *imageViewDot;

    BOOL enteredForegroundConvert;
    
    NSTimer *timer;
    
    bool isVisible;
    BOOL rotating;
    BOOL closed;
	UIAlertView *alertRemoveAd;
    
    MBProgressHUD *HUD;
    bool doHud;

}

@property(nonatomic,retain) IBOutlet UITextField *convert1Text;
@property(nonatomic,retain) IBOutlet UITextField *convert2Text;
@property(nonatomic,retain) IBOutlet UIButton *convertButton;
@property(nonatomic,retain) IBOutlet UIButton *clipButton;
@property(nonatomic,retain) IBOutlet UIButton *emailButton;
@property(nonatomic,retain) IBOutlet UIButton *helpButton;
@property(nonatomic,retain) IBOutlet NSTimer *timer;

@property(nonatomic,retain) IBOutlet UILabel *label1;
@property(nonatomic,retain) IBOutlet UILabel *label2;

@property (assign, nonatomic) BOOL enteredForegroundConvert;
@property(nonatomic,retain) IBOutlet UIImageView *imageViewDot;
@property(nonatomic,retain) IBOutlet UIButton *adButton;
@property(nonatomic,retain)  IBOutlet UIButton *closeButton;
@property(nonatomic,retain)  MBProgressHUD *HUD;

@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;

- (void)copyToPasteBoard;
- (void)setupUI;
- (void)notifyForeground;
- (void)notifyBackground;

- (void)startTimer;
- (void)stopTimer;
- (void)timerTick:(NSTimer *)timer;
- (void)showAd:(BOOL)show;
- (void)hideAd;

@end
