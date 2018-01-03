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

@implementation ViewController {
    NSDictionary *data;
    NSCalendar *calendar;
    NSDateComponents *components;
    NSDateFormatter *formatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Overview";
    
    calendar = NSCalendar.currentCalendar;
    formatter = [[NSDateFormatter alloc] init];
    
    [self createData];
    [self createCollectionView];
}

- (void)setupComponentsOnValue: (int)v {
    components = [NSDateComponents new];
    components = [NSDateComponents new];
    components.day = v % 100;
    components.month = (v / 100) % 100;
    components.year = (v / 10000);
}

- (void)createData {
    data = @{@"201802": @[@20180201, @20180205, @20180210, @20180211, @20180212, @20180225, @20180226],
             @"201801": @[@20180101, @20180102, @20180103],
             @"201712": @[@20171202, @20171203, @20171204, @20171208, @20171210, @20171211, @20171213],
             @"201711": @[@20171106, @20171107, @20171108, @20171120],
             @"201710": @[@20171001, @20171002, @20171005, @20171007],
             @"201709": @[@20170920, @20170922, @20170923, @20170927, @20170928, @20170929],
             @"201708": @[@20170802, @20170804, @20170806, @20170807, @20170809]
             };
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

- (NSArray *)sortKeys {
    NSArray *keys = [data allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        return [a intValue] > [b intValue];
    }];
    
    return sortedKeys;
}

- (int)buildDateKeyForIndexPath:(NSIndexPath *)ip {
    NSString *row = ip.row < 10 ? [NSString stringWithFormat:@"0%li", (long)ip.row + 1] : [NSString stringWithFormat:@"%li", (long)ip.row + 1];
    NSArray *sortedData = [self sortKeys];
    NSString *value = [NSString stringWithFormat:@"%@%@", sortedData[ip.section], row];
    
    return [value intValue];
}

- (BOOL)doesValueExist:(int)value forIndexPath:(NSIndexPath *)ip {
    NSArray *sortedData = [self sortKeys];
    NSString *key = [NSString stringWithFormat:@"%@", sortedData[ip.section]];
    NSArray *values = data[key];
    
    for (int i=0; i<values.count; i++) {
        if ([values[i] intValue] == value)
            return YES;
    }
    
    return NO;
}

#pragma mark UICollectionViewDelegate and UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSArray *sortedData = [self sortKeys];
    NSString *key = [NSString stringWithFormat:@"%@", sortedData[section]];
    [self setupComponentsOnValue: [key intValue]];
    
    NSDate *d = [calendar dateFromComponents:components];
    NSRange r = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:d];
    
    return r.length;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    int currentValue = [self buildDateKeyForIndexPath:indexPath];
    [self setupComponentsOnValue: currentValue];
    NSDate *d = [calendar dateFromComponents:components];
    
    DateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    [cell setup:d exists:[self doesValueExist:currentValue forIndexPath:indexPath]];

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
    int currentValue = [self buildDateKeyForIndexPath:indexPath];
    [self setupComponentsOnValue: currentValue];
    NSDate *d = [calendar dateFromComponents:components];
    
    [formatter setDateFormat:@"MMM YYY"];
    NSString *text = [formatter stringFromDate:d].uppercaseString;
    
    HeaderCollectionReusableView* v = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    [v setup:text];
    
    return v;
}

@end
