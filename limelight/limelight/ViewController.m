//
//  ViewController.m
//  limelight
//
//  Created by Patrick on 10/17/14.
//  Copyright (c) 2014 Patrick Chiang. All rights reserved.
//

#import "ViewController.h"
#import "HTML/HTMLReader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.spritzLabel.text = @"In publishing and graphic design, lorem ipsum is a filler text commonly used to demonstrate the graphic elements of a document or visual presentation. Replacing meaningful content that could be distracting with placeholder text may allow viewers to focus on graphic aspects such as font, typography, and page layout.";
    self.spritzLabel.text = @"1 2 3 4. 5 6 7 8. 9 10 11 12. 13 14 15 16.";

    [self fetchStories:@"home"];
}

- (void)fetchStories:(NSString *)sectionName {
    NSError *error;
    
    NSURL *usatodayUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.usatoday.com/open/articles/topnews/%@?count=10&days=2&page=5&encoding=json&api_key=2rayqzgxndkf9xtgp4jfa5d9", sectionName]];
    NSString *htmlString = [NSString stringWithContentsOfURL:usatodayUrl encoding:NSUTF8StringEncoding error:&error];
    
    NSData* data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    self.titles = [[NSMutableArray alloc] init];
    self.articles = [[NSMutableArray alloc] init];
    
    NSArray *array = [dict objectForKey:@"stories"];
    for(int i = 0; i < array.count; i++) {
        NSString *title = [[array objectAtIndex:i] objectForKey:@"description"];
        [self.titles addObject:title];
        
        NSString *articleLink = [[array objectAtIndex:i] objectForKey:@"link"];
        NSURL *articleURL = [NSURL URLWithString:articleLink];
        NSString *articleString = [NSString stringWithContentsOfURL:articleURL encoding:NSUTF8StringEncoding error:&error];
        
        HTMLDocument *document = [HTMLDocument documentWithString:articleString.description];
        NSArray *pNodes = [document nodesMatchingSelector:@".double-wide > p"];
        
        NSString *paragraph = @"";
        for(int i = 0 ; i < pNodes.count; i++){
            paragraph = [NSString stringWithFormat:@"%@ %@", paragraph, ((HTMLElement*)[pNodes objectAtIndex:i]).textContent];
        }
        [self.articles addObject:paragraph];
    }
    
    self.headlineLabel.text = [self.titles objectAtIndex:0];
    self.spritzLabel.text = [self.articles objectAtIndex:0];
    self.currentMarker = 0;
    
    [self.sectionsView setHidden:YES];
    
    self.spritzLabel.layer.cornerRadius = 10;
    self.spritzLabel.layer.masksToBounds = YES;
    
    [self.sliderView setHidden:YES];
    [self.spritzLabel pause];
    [self.pauseButton setHidden:YES];
    [self.playButton setHidden:NO];
    
    //self.activitySpinner.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)wpmSlider:(UISlider *)sender {
    [self.wpmLabel setTitle:[NSString stringWithFormat:@"%.f WPM", sender.value] forState:UIControlStateNormal];
    [self.wpmLabel setTitle:[NSString stringWithFormat:@"%.f WPM", sender.value] forState:UIControlStateHighlighted];
    [self.spritzLabel setWordsPerMinute:sender.value];
}

- (IBAction)wpmTouch:(id)sender {
    [self.sliderView setHidden:!self.sliderView.isHidden];
}

- (IBAction)playClick:(UIButton *)sender {
    [self.spritzLabel start];
    [sender setHidden:YES];
    [self.pauseButton setHidden:NO];
}

- (IBAction)pauseClick:(UIButton *)sender {
    [self.spritzLabel pause];
    [sender setHidden:YES];
    [self.playButton setHidden:NO];
}

- (IBAction)forwardClick:(id)sender {
//    NSLog(@"%.2f", [self.spritzLabel progress]);
    NSRange next = [[self.spritzLabel.text substringFromIndex:[self.spritzLabel progress]] rangeOfString:@"[\\.,-\\/#!$%\\^&\\*;:{}=\\-_`~()]" options:NSRegularExpressionSearch];
    
//    NSLog(@"%zd", (int)(next.location + [self.spritzLabel progress]));
    
    [self.spritzLabel gotoWordAtLocation:(int)(next.location + [self.spritzLabel progress] + 1)];
    
    [self.spritzLabel pause];
    [self.pauseButton setHidden:YES];
    [self.playButton setHidden:NO];
}

- (IBAction)backClick:(id)sender {
    NSString *current = [self.spritzLabel.text substringToIndex:[self.spritzLabel progress]];
    NSRange interest = NSMakeRange(NSNotFound, 0);
    NSRange searchRange = NSMakeRange(0,current.length);
    NSRange foundRange;
    while (searchRange.location < current.length) {
        searchRange.length = current.length-searchRange.location;
        foundRange = [current rangeOfString:@"[\\.,-\\/#!$%\\^&\\*;:{}=\\-_`~()]" options:NSRegularExpressionSearch range:searchRange];
        if (foundRange.location != NSNotFound) {
            // found an occurrence of the substring! do stuff here
            searchRange.location = foundRange.location+foundRange.length;
            interest = searchRange;
            NSLog(@"%zd", (int)(interest.location));
        } else {
            break;
        }
    }

    if (interest.location != NSNotFound) {
        [self.spritzLabel gotoWordAtLocation:(int)(interest.location - 1)];
    } else {
        [self.spritzLabel gotoWordAtLocation: 0];
    }
    
    [self.spritzLabel pause];
    [self.pauseButton setHidden:YES];
    [self.playButton setHidden:NO];
}

- (IBAction)swipeLeft:(id)sender {
    NSLog(@"%zd", self.currentMarker);
    if (self.currentMarker < self.titles.count - 1){
        
        self.currentMarker++;
        self.headlineLabel.text = [self.titles objectAtIndex:self.currentMarker];
        self.spritzLabel.text = [self.articles objectAtIndex:self.currentMarker];
        [self.spritzLabel pause];
        [self.pauseButton setHidden:YES];
        [self.playButton setHidden:NO];
        if ([[self.articles objectAtIndex:self.currentMarker] length] != 0)
            [self.spritzLabel gotoWordAtLocation:0];
    }
}

- (IBAction)swipeRight:(id)sender {
    if (self.currentMarker > 0){
        self.currentMarker--;
        self.headlineLabel.text = [self.titles objectAtIndex:self.currentMarker];
        self.spritzLabel.text = [self.articles objectAtIndex:self.currentMarker];
        [self.spritzLabel pause];
        [self.pauseButton setHidden:YES];
        [self.playButton setHidden:NO];
        if ([[self.articles objectAtIndex:self.currentMarker] length] != 0)
            [self.spritzLabel gotoWordAtLocation:0];
    }
}

- (IBAction)hamburgerButton:(id)sender {
    [self.sectionsView setHidden:![self.sectionsView isHidden]];
}

- (IBAction)topNewsClick:(id)sender {
    [self.sectionsView setHidden:YES];
    [self fetchStories:@"home"];
}

- (IBAction)newsOnlyClick:(id)sender {
    [self.sectionsView setHidden:YES];
    [self fetchStories:@"news"];
}

- (IBAction)worldClick:(id)sender {
    [self.sectionsView setHidden:YES];
    [self fetchStories:@"world"];
}

- (IBAction)nationClick:(id)sender {
    [self.sectionsView setHidden:YES];
    [self fetchStories:@"nation"];
}

- (IBAction)techClick:(id)sender {
    [self.sectionsView setHidden:YES];
    [self fetchStories:@"tech"];
}

- (IBAction)healthClick:(id)sender {
    [self.sectionsView setHidden:YES];
    [self fetchStories:@"health"];
}

- (IBAction)weatherClick:(id)sender {
    [self.sectionsView setHidden:YES];
    [self fetchStories:@"sports"];
}

- (IBAction)moneyClick:(id)sender {
    [self.sectionsView setHidden:YES];
    [self fetchStories:@"money"];
}

@end
