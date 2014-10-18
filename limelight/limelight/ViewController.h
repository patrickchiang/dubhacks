//
//  ViewController.h
//  limelight
//
//  Created by Patrick on 10/17/14.
//  Copyright (c) 2014 Patrick Chiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSSpritz/OSSpritzLabel.h"
#import "OSSpritz/OSSpritz.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet OSSpritzLabel *spritzLabel;
@property (weak, nonatomic) IBOutlet UISlider *wpmSlider;
@property (weak, nonatomic) IBOutlet UIButton *wpmLabel;
@property (weak, nonatomic) IBOutlet UIView *sliderView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;
@property (weak, nonatomic) IBOutlet UIView *sectionsView;
@property (weak, nonatomic) IBOutlet UIImageView *guardianLogo;
@property (weak, nonatomic) IBOutlet UIImageView *usatodayLogo;
@property (weak, nonatomic) IBOutlet UIView *logoBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *activityView;
@property (weak, nonatomic) IBOutlet UIImageView *tutorialLabel;

- (IBAction)wpmSlider:(UISlider *)sender;
- (IBAction)wpmTouch:(id)sender;
- (IBAction)playClick:(UIButton *)sender;
- (IBAction)pauseClick:(UIButton *)sender;
- (IBAction)forwardClick:(id)sender;
- (IBAction)backClick:(id)sender;
- (IBAction)swipeLeft:(id)sender;
- (IBAction)swipeRight:(id)sender;
- (IBAction)hamburgerButton:(id)sender;
- (IBAction)swipeLogo:(id)sender;

- (IBAction)topNewsClick:(id)sender;
- (IBAction)newsOnlyClick:(id)sender;
- (IBAction)worldClick:(id)sender;
- (IBAction)nationClick:(id)sender;
- (IBAction)techClick:(id)sender;
- (IBAction)healthClick:(id)sender;
- (IBAction)weatherClick:(id)sender;
- (IBAction)moneyClick:(id)sender;

@property (strong, nonatomic) NSMutableArray *titles;
@property (strong, nonatomic) NSMutableArray *articles;
@property (assign, nonatomic) NSUInteger currentMarker;
@property (assign, nonatomic) BOOL usingUSAToday;

@end

