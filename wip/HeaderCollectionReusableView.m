//
//  HeaderCollectionReusableView.m
//  wip
//
//  Created by Christopher Eliasson on 2018-01-02.
//  Copyright © 2018 Christopher. All rights reserved.
//

#import "HeaderCollectionReusableView.h"
#import <PureLayout.h>

@implementation HeaderCollectionReusableView {
    UILabel *title;
    UIView *separator;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        title = [[UILabel alloc] init];
        title.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:title];
        
        [title autoSetDimensionsToSize:CGSizeMake(300.0, 20.0)];
        
        separator = [[UIView alloc] init];
        separator.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview: separator];
        
        [separator autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:title];
        [separator autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [separator autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [separator autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [separator autoSetDimension:ALDimensionHeight toSize:1.0];
    }
    return self;
}

- (void)setup:(NSString *)t {
    title.text = t;
    separator.backgroundColor = [UIColor lightGrayColor];
}

@end
