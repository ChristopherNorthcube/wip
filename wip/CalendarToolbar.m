//
//  CalendarToolbar.m
//  wip
//
//  Created by Christopher Eliasson on 2018-01-05.
//  Copyright © 2018 Christopher. All rights reserved.
//

#import "CalendarToolbar.h"

#import <PureLayout.h>

@implementation CalendarToolbar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    NSArray *daySymbols = formatter.standaloneWeekdaySymbols;
    
    CGFloat fontSize = 14.0;
    NSMutableArray *labels = [[NSMutableArray alloc] initWithCapacity:7];
    
    for (int i=0; i<daySymbols.count; i++) {
        NSString *day = daySymbols[i];
        UILabel *l = [[UILabel alloc] init];
        UIFont *f = l.font;
        
        l.translatesAutoresizingMaskIntoConstraints = NO;
        l.textAlignment = NSTextAlignmentCenter;
        l.font = [f fontWithSize:fontSize];
        l.text = [[day substringToIndex:1] uppercaseString];
        
        [self addSubview:l];
        [labels addObject:l];
        
        if (i == 0) {
            [l autoPinEdgeToSuperviewEdge:ALEdgeLeft];
            [l autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [l autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        } else if (i == daySymbols.count - 1) {
            [l autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:labels[i-1]];
            [l autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [l autoPinEdgeToSuperviewEdge:ALEdgeBottom];;
            [l autoPinEdgeToSuperviewEdge:ALEdgeRight];
            [l autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:labels[i-1]];
        } else {
            [l autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:labels[i-1]];
            [l autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [l autoPinEdgeToSuperviewEdge:ALEdgeBottom];
            [l autoPinEdgeToSuperviewEdge:ALEdgeBottom];
            [l autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:labels[i-1]];
        }
    }
}

@end
