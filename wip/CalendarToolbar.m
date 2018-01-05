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

    UILabel *m = [[UILabel alloc] init];
    UIFont *font = m.font;
    CGFloat fontSize = 14.0;
    
    m.translatesAutoresizingMaskIntoConstraints = NO;
    m.textAlignment = NSTextAlignmentCenter;
    m.font = [font fontWithSize:fontSize];
    m.text = @"M";
    
    UILabel *tis = [[UILabel alloc] init];
    tis.translatesAutoresizingMaskIntoConstraints = NO;
    tis.textAlignment = NSTextAlignmentCenter;
    tis.font = [font fontWithSize:fontSize];
    tis.text = @"T";
    
    UILabel *o = [[UILabel alloc] init];
    o.translatesAutoresizingMaskIntoConstraints = NO;
    o.textAlignment = NSTextAlignmentCenter;
    o.text = @"O";
    o.font = [font fontWithSize:fontSize];
    
    UILabel *t = [[UILabel alloc] init];
    t.translatesAutoresizingMaskIntoConstraints = NO;
    t.textAlignment = NSTextAlignmentCenter;
    t.text = @"T";
    t.font = [font fontWithSize:fontSize];
    
    UILabel *f = [[UILabel alloc] init];
    f.translatesAutoresizingMaskIntoConstraints = NO;
    f.textAlignment = NSTextAlignmentCenter;
    f.text = @"F";
    f.font = [font fontWithSize:fontSize];
    
    UILabel *l = [[UILabel alloc] init];
    l.translatesAutoresizingMaskIntoConstraints = NO;
    l.textAlignment = NSTextAlignmentCenter;
    l.text = @"L";
    l.font = [font fontWithSize:fontSize];
    
    UILabel *s = [[UILabel alloc] init];
    s.translatesAutoresizingMaskIntoConstraints = NO;
    s.textAlignment = NSTextAlignmentCenter;
    s.text = @"S";
    s.font = [font fontWithSize:fontSize];
    
    [self addSubview:m];
    [self addSubview:tis];
    [self addSubview:o];
    [self addSubview:t];
    [self addSubview:f];
    [self addSubview:l];
    [self addSubview:s];
    
    [m autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [m autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [m autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    [tis autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:m];
    [tis autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [tis autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [tis autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [tis autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:m];
    
    [o autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:tis];
    [o autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [o autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [o autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:m];
    
    [t autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:o];
    [t autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [t autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [t autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:m];
    
    [f autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:t];
    [f autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [f autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [f autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:m];
    
    [l autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:f];
    [l autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [l autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [l autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:m];
    
    [s autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:l];
    [s autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [s autoPinEdgeToSuperviewEdge:ALEdgeBottom];;
    [s autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [s autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:m];
}

@end
