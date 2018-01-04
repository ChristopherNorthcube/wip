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
    UIView *circle;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    circle.layer.cornerRadius = circle.frame.size.height / 2;
}

- (void)initialize {
    circle = [[UIView alloc] init];
    circle.translatesAutoresizingMaskIntoConstraints = NO;
    circle.clipsToBounds = YES;
    
    [self addSubview:circle];
    
    [circle autoPinEdgeToSuperviewMargin:ALEdgeTop];
    [circle autoPinEdgeToSuperviewMargin:ALEdgeBottom];
    [circle autoPinEdgeToSuperviewMargin:ALEdgeRight];
    [circle autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView: circle];
    
    
    dateNumberLabel = [[UILabel alloc] init];
    dateNumberLabel.textAlignment = NSTextAlignmentCenter;
    dateNumberLabel.numberOfLines = 1;
    dateNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIFont *f = dateNumberLabel.font;
    dateNumberLabel.font = [f fontWithSize:14.0];
    
    [circle addSubview:dateNumberLabel];
    [dateNumberLabel autoCenterInSuperview];
}

- (void)setup:(NSDate *)d exists:(BOOL)exists {
    self.backgroundColor = UIColor.blackColor;
    
    NSDate *now = [[NSDate alloc] init];
    if ([d isLaterThan:now] || !exists) {
        circle.backgroundColor = [UIColor grayColor];
        dateNumberLabel.textColor = [UIColor lightGrayColor];
    } else {
        circle.backgroundColor = [UIColor colorWithHue:drand48() saturation:1.0 brightness:1.0 alpha:1.0];
        dateNumberLabel.textColor = UIColor.blackColor;
    }
    
    dateNumberLabel.text = [NSString stringWithFormat:@"%li", (long)[d day]];
}

@end
