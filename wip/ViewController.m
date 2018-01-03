//
//  ViewController.m
//  wip
//
//  Created by Christopher Eliasson on 2018-01-02.
//  Copyright © 2018 Christopher. All rights reserved.
//

#import "ViewController.h"
#import "HeaderCollectionReusableView.h"
#import "DateCollectionViewCell.h"

#import <PureLayout.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Overview";
    
    // create collectionview
    [self createCollectionView];
    
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *l = [[UICollectionViewFlowLayout alloc] init];
    l.minimumInteritemSpacing = 0;
    l.minimumLineSpacing = 0;
    
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:l];
    cv.translatesAutoresizingMaskIntoConstraints = NO;
    cv.backgroundColor = [UIColor whiteColor];
    
    cv.dataSource = self;
    cv.delegate = self;
    
    [cv registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [cv registerClass:[DateCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    
    [self.view addSubview:cv];
    [cv autoPinEdgesToSuperviewEdges];
}

#pragma mark UICollectionViewDelegate and UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    
    [cell setup:[[NSDate alloc] init]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.frame.size.width / 7;
    return CGSizeMake(width, width);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0.0, 30.0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HeaderCollectionReusableView* v = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    [v setup:@"MAY 2015"];
    
    return v;
}

@end
