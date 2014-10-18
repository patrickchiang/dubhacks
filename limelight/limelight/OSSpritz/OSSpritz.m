//
//  OSSpritz.m
//  OpenSpritzDemo
//
//  Created by Francesco Mattia on 07/03/14.
//  Copyright (c) 2014 Fr4ncis. All rights reserved.
//

#import "OSSpritz.h"

#import "OSSpritz.h"

@implementation OSSpritz

+ (int)offsetForWord:(NSString*)word
{
    return 9 - [OSSpritz findPivot:word];
}

// pivot finding source, simplified.
+ (int)findPivot:(NSString *)word
{
    if([word length] == 0) return 0;
    
	int wordLength = (int)[word length];
	int pivot = (wordLength + 2) / 4;
	if (pivot > 4)
	{
		pivot = 4;
	}
    
    
	if ([word characterAtIndex:pivot] == ' ')
	{
		pivot--;
	}
    
    
	NSAssert(pivot >= 0 && pivot < 5,@"pivot for word \'%@\' out of range, computed as %i", word, pivot);
	
	return pivot;
};


+ (NSArray*)spritzString:(NSString*)text
{
    NSMutableArray *separated = [[text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \n"]] mutableCopy];
    for (int i = 0; i < [separated count]; i++)
    {
        if ([separated[i] length] > 13)
        {
            int separateAt = floorf([separated[i] length]/2.0);
            NSInteger dashLocation = [separated[i] rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]].location;
            if (dashLocation != NSNotFound) separateAt = (int)dashLocation;
            NSString *firstString = [[separated[i] substringToIndex:separateAt] stringByAppendingString:@"-"];
            NSString *secondString = [separated[i] substringFromIndex:separateAt+(separateAt==dashLocation?1:0)];
            [separated removeObjectAtIndex:i];
            [separated insertObject:firstString atIndex:i];
            [separated insertObject:secondString atIndex:i+1];
        }
    }
    return separated;
}

+ (float)timeForWord:(NSString*)word
{
    NSRange strongRange = [word rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@".:?!"]];
    NSRange weakRange = [word rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@",-("]];
    if (strongRange.location != NSNotFound) return 3;
    if (weakRange.location != NSNotFound) return 2;
    if (word.length >= 8) return 2;
    return 1;
}

@end
