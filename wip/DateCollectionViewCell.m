//
//  DateCollectionViewCell.m
//  wip
//
//  Created by Christopher Eliasson on 2018-01-03.
//  Copyright © 2018 Christopher. All rights reserved.
//

#import "DateCollectionViewCell.h"
#import <PureLayout.h>
#import <DateTools.h>

@implementation DateCollectionViewCell {
    UILabel *dateNumberLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    dateNumberLabel = [[UILabel alloc] init];
    dateNumberLabel.textAlignment = NSTextAlignmentCenter;
    dateNumberLabel.numberOfLines = 1;
    
    UIFont *f = dateNumberLabel.font;
    dateNumberLabel.font = [f fontWithSize:14.0];
    
    [self addSubview:dateNumberLabel];
    [dateNumberLabel autoCenterInSuperview];
}

- (void)setup:(NSDate *)d {
    NSDate *now = [[NSDate alloc] init];
    if ([d isLaterThan:now]) {
        self.backgroundColor = [UIColor grayColor];
        dateNumberLabel.textColor = [UIColor lightGrayColor];
    } else {
        self.backgroundColor = [UIColor colorWithHue:drand48() saturation:1.0 brightness:1.0 alpha:1.0];
    }
    
    dateNumberLabel.text = [NSString stringWithFormat:@"%li", (long)[d day]];
}

@end
