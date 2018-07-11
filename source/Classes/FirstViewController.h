//
//  FirstViewController.h
//  passwordmatrix
//
//  Created by Chris Comeau on 15/05/09.
//  Copyright Skyriser Media 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXLabel.h"
//#import "passwordmatrixAppDelegate.h"


@interface FirstViewController : UIViewController <UIActionSheetDelegate>{
	
	NSMutableArray *matrixArray_old;
	NSString *keyString;
	//NSAutoreleasePool *pool;
	//passwordmatrixAppDelegate *appDelegate;
	id appDelegate;
	
	//IBOutlet UITextView *gridText;
	
	IBOutlet FXLabel *text1;
	IBOutlet FXLabel *text2;
	IBOutlet FXLabel *text3;
	IBOutlet FXLabel *text4;
	IBOutlet FXLabel *text5;
	IBOutlet FXLabel *text6;
	IBOutlet FXLabel *text7;
	IBOutlet FXLabel *text8;
	IBOutlet FXLabel *text9;
	IBOutlet FXLabel *text10;
	IBOutlet FXLabel *text11;
	IBOutlet FXLabel *text12;
	IBOutlet FXLabel *text13;
	IBOutlet FXLabel *text14;
	IBOutlet FXLabel *text15;
	IBOutlet FXLabel *text16;
	IBOutlet FXLabel *text17;
	IBOutlet FXLabel *text18;
	IBOutlet FXLabel *text19;
	IBOutlet FXLabel *text20;
	IBOutlet FXLabel *text21;
	IBOutlet FXLabel *text22;
	IBOutlet FXLabel *text23;
	IBOutlet FXLabel *text24;
	IBOutlet FXLabel *text25;
	IBOutlet FXLabel *text26;
	IBOutlet FXLabel *text27;
	IBOutlet FXLabel *text28;
	IBOutlet FXLabel *text29;
	IBOutlet FXLabel *text30;
	IBOutlet FXLabel *text31;
	IBOutlet FXLabel *text32;
	IBOutlet FXLabel *text33;
	IBOutlet FXLabel *text34;
	IBOutlet FXLabel *text35;
	IBOutlet FXLabel *text36;
    
    IBOutlet FXLabel *label1;
	IBOutlet FXLabel *label2;
	IBOutlet FXLabel *label3;
	IBOutlet FXLabel *label4;
	IBOutlet FXLabel *label5;
	IBOutlet FXLabel *label6;
	IBOutlet FXLabel *label7;
	IBOutlet FXLabel *label8;
	IBOutlet FXLabel *label9;
	IBOutlet FXLabel *label10;
	IBOutlet FXLabel *label11;
	IBOutlet FXLabel *label12;
	IBOutlet FXLabel *label13;
	IBOutlet FXLabel *label14;
	IBOutlet FXLabel *label15;
	IBOutlet FXLabel *label16;
	IBOutlet FXLabel *label17;
	IBOutlet FXLabel *label18;
	IBOutlet FXLabel *label19;
	IBOutlet FXLabel *label20;
	IBOutlet FXLabel *label21;
	IBOutlet FXLabel *label22;
	IBOutlet FXLabel *label23;
	IBOutlet FXLabel *label24;
	IBOutlet FXLabel *label25;
	IBOutlet FXLabel *label26;
	IBOutlet FXLabel *label27;
	IBOutlet FXLabel *label28;
	IBOutlet FXLabel *label29;
	IBOutlet FXLabel *label30;
	IBOutlet FXLabel *label31;
	IBOutlet FXLabel *label32;
	IBOutlet FXLabel *label33;
	IBOutlet FXLabel *label34;
	IBOutlet FXLabel *label35;
	IBOutlet FXLabel *label36;
	
	IBOutlet UIButton *helpButton;
    IBOutlet UIImageView *imageTitle;
    IBOutlet UIImageView *imageTitle2;
    IBOutlet UIImageView *imageBack;
    IBOutlet UILabel *labelTap;

}

//@property(nonatomic,retain) IBOutlet UIlabelView *gridlabel;

@property(nonatomic,retain) IBOutlet UILabel *text1;
@property(nonatomic,retain) IBOutlet UILabel *text2;
@property(nonatomic,retain) IBOutlet UILabel *text3;
@property(nonatomic,retain) IBOutlet UILabel *text4;
@property(nonatomic,retain) IBOutlet UILabel *text5;
@property(nonatomic,retain) IBOutlet UILabel *text6;
@property(nonatomic,retain) IBOutlet UILabel *text7;
@property(nonatomic,retain) IBOutlet UILabel *text8;
@property(nonatomic,retain) IBOutlet UILabel *text9;
@property(nonatomic,retain) IBOutlet UILabel *text10;
@property(nonatomic,retain) IBOutlet UILabel *text11;
@property(nonatomic,retain) IBOutlet UILabel *text12;
@property(nonatomic,retain) IBOutlet UILabel *text13;
@property(nonatomic,retain) IBOutlet UILabel *text14;
@property(nonatomic,retain) IBOutlet UILabel *text15;
@property(nonatomic,retain) IBOutlet UILabel *text16;
@property(nonatomic,retain) IBOutlet UILabel *text17;
@property(nonatomic,retain) IBOutlet UILabel *text18;
@property(nonatomic,retain) IBOutlet UILabel *text19;
@property(nonatomic,retain) IBOutlet UILabel *text20;
@property(nonatomic,retain) IBOutlet UILabel *text21;
@property(nonatomic,retain) IBOutlet UILabel *text22;
@property(nonatomic,retain) IBOutlet UILabel *text23;
@property(nonatomic,retain) IBOutlet UILabel *text24;
@property(nonatomic,retain) IBOutlet UILabel *text25;
@property(nonatomic,retain) IBOutlet UILabel *text26;
@property(nonatomic,retain) IBOutlet UILabel *text27;
@property(nonatomic,retain) IBOutlet UILabel *text28;
@property(nonatomic,retain) IBOutlet UILabel *text29;
@property(nonatomic,retain) IBOutlet UILabel *text30;
@property(nonatomic,retain) IBOutlet UILabel *text31;
@property(nonatomic,retain) IBOutlet UILabel *text32;
@property(nonatomic,retain) IBOutlet UILabel *text33;
@property(nonatomic,retain) IBOutlet UILabel *text34;
@property(nonatomic,retain) IBOutlet UILabel *text35;
@property(nonatomic,retain) IBOutlet UILabel *text36;

@property(nonatomic,retain) IBOutlet UILabel *label1;
@property(nonatomic,retain) IBOutlet UILabel *label2;
@property(nonatomic,retain) IBOutlet UILabel *label3;
@property(nonatomic,retain) IBOutlet UILabel *label4;
@property(nonatomic,retain) IBOutlet UILabel *label5;
@property(nonatomic,retain) IBOutlet UILabel *label6;
@property(nonatomic,retain) IBOutlet UILabel *label7;
@property(nonatomic,retain) IBOutlet UILabel *label8;
@property(nonatomic,retain) IBOutlet UILabel *label9;
@property(nonatomic,retain) IBOutlet UILabel *label10;
@property(nonatomic,retain) IBOutlet UILabel *label11;
@property(nonatomic,retain) IBOutlet UILabel *label12;
@property(nonatomic,retain) IBOutlet UILabel *label13;
@property(nonatomic,retain) IBOutlet UILabel *label14;
@property(nonatomic,retain) IBOutlet UILabel *label15;
@property(nonatomic,retain) IBOutlet UILabel *label16;
@property(nonatomic,retain) IBOutlet UILabel *label17;
@property(nonatomic,retain) IBOutlet UILabel *label18;
@property(nonatomic,retain) IBOutlet UILabel *label19;
@property(nonatomic,retain) IBOutlet UILabel *label20;
@property(nonatomic,retain) IBOutlet UILabel *label21;
@property(nonatomic,retain) IBOutlet UILabel *label22;
@property(nonatomic,retain) IBOutlet UILabel *label23;
@property(nonatomic,retain) IBOutlet UILabel *label24;
@property(nonatomic,retain) IBOutlet UILabel *label25;
@property(nonatomic,retain) IBOutlet UILabel *label26;
@property(nonatomic,retain) IBOutlet UILabel *label27;
@property(nonatomic,retain) IBOutlet UILabel *label28;
@property(nonatomic,retain) IBOutlet UILabel *label29;
@property(nonatomic,retain) IBOutlet UILabel *label30;
@property(nonatomic,retain) IBOutlet UILabel *label31;
@property(nonatomic,retain) IBOutlet UILabel *label32;
@property(nonatomic,retain) IBOutlet UILabel *label33;
@property(nonatomic,retain) IBOutlet UILabel *label34;
@property(nonatomic,retain) IBOutlet UILabel *label35;
@property(nonatomic,retain) IBOutlet UILabel *label36;

@property(nonatomic,retain) IBOutlet UIButton *helpButton;
@property(nonatomic,retain) IBOutlet UIImageView *imageTitle;
@property(nonatomic,retain) IBOutlet UIImageView *imageTitle2;
@property(nonatomic,retain) IBOutlet UIImageView *imageBack;
@property(nonatomic,retain) IBOutlet UILabel *labelTap;

- (void)setupUI;
- (void)notifyForeground;
- (void)setupGrid;

//- (void)alertOKCancelAction;
//- (void)alertOKCancelAction2;

@end
