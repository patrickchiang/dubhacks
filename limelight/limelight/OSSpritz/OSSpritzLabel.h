//
//  OSSpritzLabel.h
//  OpenSpritzDemo
//
//  Created by Francesco Mattia on 08/03/14.
//  Copyright (c) 2014 Fr4ncis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSSpritzLabel : UIView

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSInteger wordsPerMinute;

- (float)progress;
- (void)start;
- (void)pause;
- (void)gotoWordAtLocation:(int)location;
- (void)setProgressWithWord:(int)wordIndex Char:(int)charLocation;

@end

@protocol OSSpritzLabelDelegate <NSObject>

- (void)highlightRange:(NSRange)range;
- (void)didMoveToCurrentWord:(NSUInteger)currentWord Char:(NSUInteger)currentChar;

@end

@interface OSSpritzLabel ()

@property (nonatomic, strong) id<OSSpritzLabelDelegate> delegate;

@end

