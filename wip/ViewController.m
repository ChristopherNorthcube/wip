//
//  ViewController.m
//  wip
//
//  Created by Christopher Eliasson on 2018-01-02.
//  Copyright © 2018 Christopher. All rights reserved.
//

#import "ViewController.h"

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
    
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:l];
    cv.translatesAutoresizingMaskIntoConstraints = NO;
    cv.backgroundColor = [UIColor grayColor];
    cv.dataSource = self;
    cv.delegate = self;
    
    [cv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    
    [self.view addSubview:cv];
    [cv autoPinEdgesToSuperviewEdges];
}

#pragma mark UICollectionViewDelegate and UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50.0, 50.0);
}

@end
