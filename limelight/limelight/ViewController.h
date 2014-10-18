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

- (IBAction)wpmSlider:(UISlider *)sender;
- (IBAction)wpmTouch:(id)sender;
- (IBAction)playClick:(UIButton *)sender;
- (IBAction)pauseClick:(UIButton *)sender;
- (IBAction)forwardClick:(id)sender;
- (IBAction)backClick:(id)sender;
- (IBAction)swipeLeft:(id)sender;
- (IBAction)swipeRight:(id)sender;

@property (strong, nonatomic) NSMutableArray *titles;
@property (strong, nonatomic) NSMutableArray *articles;
@property (assign, nonatomic) NSUInteger currentMarker;
@property (strong, nonatomic) NSArray *newsSections;

@end

