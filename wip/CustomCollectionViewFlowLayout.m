//
//  CustomCollectionViewFlowLayout.m
//  wip
//
//  Created by Christopher Eliasson on 2018-01-04.
//  Copyright © 2018 Christopher. All rights reserved.
//

#import "CustomCollectionViewFlowLayout.h"

@implementation CustomCollectionViewFlowLayout {
    CGFloat cellSpacing;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        cellSpacing = 0.0;
    }
    return self;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray * original   = [super layoutAttributesForElementsInRect:rect];
    NSArray * attributesInRect = [[NSArray alloc] initWithArray:original copyItems:YES];
    
    for (int i=0; i<attributesInRect.count; i++) {
        if (i == 0) { continue; }
        
        UICollectionViewLayoutAttributes* attr = attributesInRect[i];
        UICollectionViewLayoutAttributes* prevAttr = attributesInRect[i-1];
        CGFloat origin = CGRectGetMaxX(prevAttr.frame);
        if (origin + cellSpacing + attr.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = CGRectMake(origin + cellSpacing, attr.frame.origin.y, attr.frame.size.width, attr.frame.size.height);
            attr.frame = frame;
        }
    }

    return attributesInRect;
}

@end
