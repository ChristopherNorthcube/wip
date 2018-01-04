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
#import "CustomCollectionViewFlowLayout.h"

#import <PureLayout.h>

@implementation ViewController {
    NSDictionary *data;
    NSCalendar *calendar;
    NSDateComponents *components;
    NSDateFormatter *formatter;
    
    CGFloat cellWidth;
    CGFloat cellHeight;
    UIView *v;
    UIImageView *navBarLine;
    UICollectionView *collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Overview";
    
    calendar = [NSCalendar currentCalendar];
    [calendar setLocale:[NSLocale currentLocale]];
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    
    navBarLine = [self findNavBarLine:self.navigationController.navigationBar];
    [navBarLine setHidden:YES];
    
    [self createData];
    [self createCollectionView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (cellWidth == 0) {
        cellWidth = floorf((self.view.frame.size.width / 7) * 100 + 0.5) / 100; // Round down or we might get too large width causing rows to be incorrect.
        cellHeight = cellWidth;
        [self buildTitleView];
    }
}

-(UIImageView *)findNavBarLine:(UIView *)view {
    if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1.0)
        return (UIImageView *) view;
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findNavBarLine:subview];
        if (imageView)
            return imageView;
    }
    return nil;
}

- (void)buildTitleView {

    v = [[UIView alloc] init];
    v.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:v];
    [v autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [v autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [v autoPinEdgeToSuperviewMargin:ALEdgeTop];
    [v autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:collectionView];
    [v autoSetDimension:ALDimensionHeight toSize:24];
    
    v.backgroundColor = self.navigationController.navigationBar.backgroundColor;

    UIView *line = [[UIView alloc] init];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    line.backgroundColor = UIColor.blackColor;
    
    [v addSubview:line];
   
    [line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [line autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [line autoSetDimension:ALDimensionHeight toSize:1.0];
    
//    UILabel *m = [[UILabel alloc] init];
//    UIFont *font = m.font;
//    CGFloat fontSize = 8.0;
//
//    m.translatesAutoresizingMaskIntoConstraints = NO;
//    m.textAlignment = NSTextAlignmentCenter;
//    m.font = [font fontWithSize:fontSize];
//    m.text = @"M";
//
//    UILabel *tis = [[UILabel alloc] init];
//    tis.translatesAutoresizingMaskIntoConstraints = NO;
//    tis.textAlignment = NSTextAlignmentCenter;
//    tis.font = [font fontWithSize:fontSize];
//    tis.text = @"T";
//
//    UILabel *o = [[UILabel alloc] init];
//    o.translatesAutoresizingMaskIntoConstraints = NO;
//    o.textAlignment = NSTextAlignmentCenter;
//    o.text = @"O";
//    o.font = [font fontWithSize:fontSize];
//
//    UILabel *t = [[UILabel alloc] init];
//    t.translatesAutoresizingMaskIntoConstraints = NO;
//    t.textAlignment = NSTextAlignmentCenter;
//    t.text = @"T";
//    t.font = [font fontWithSize:fontSize];
//
//    UILabel *f = [[UILabel alloc] init];
//    f.translatesAutoresizingMaskIntoConstraints = NO;
//    f.textAlignment = NSTextAlignmentCenter;
//    f.text = @"F";
//    f.font = [font fontWithSize:fontSize];
//
//    UILabel *l = [[UILabel alloc] init];
//    l.translatesAutoresizingMaskIntoConstraints = NO;
//    l.textAlignment = NSTextAlignmentCenter;
//    l.text = @"L";
//    l.font = [font fontWithSize:fontSize];
//
//    UILabel *s = [[UILabel alloc] init];
//    s.translatesAutoresizingMaskIntoConstraints = NO;
//    s.textAlignment = NSTextAlignmentCenter;
//    s.text = @"S";
//    s.font = [font fontWithSize:fontSize];
//
//    [v addSubview:m];
//    [v addSubview:tis];
//    [v addSubview:o];
//    [v addSubview:t];
//    [v addSubview:f];
//    [v addSubview:l];
//    [v addSubview:s];
//
//    [m autoPinEdgeToSuperviewEdge:ALEdgeLeft];
//    [m autoPinEdgeToSuperviewEdge:ALEdgeTop];
//    [m autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:line];
//
//    [tis autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:m];
//    [tis autoPinEdgeToSuperviewEdge:ALEdgeTop];
//    [tis autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:line];
//    [tis autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:m];
//
//    [o autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:tis];
//    [o autoPinEdgeToSuperviewEdge:ALEdgeTop];
//    [o autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:line];
//    [o autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:m];
//
//    [t autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:o];
//    [t autoPinEdgeToSuperviewEdge:ALEdgeTop];
//    [t autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:line];
//    [t autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:m];
//
//    [f autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:t];
//    [f autoPinEdgeToSuperviewEdge:ALEdgeTop];
//    [f autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:line];
//    [f autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:m];
//
//    [l autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:f];
//    [l autoPinEdgeToSuperviewEdge:ALEdgeTop];
//    [l autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:line];
//    [l autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:m];
//
//    [s autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:l];
//    [s autoPinEdgeToSuperviewEdge:ALEdgeTop];
//    [s autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:line];;
//    [s autoPinEdgeToSuperviewEdge:ALEdgeRight];
//    [s autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:m];
}

- (void)setupComponentsOnValue: (int)v {
    components = [NSDateComponents new];
    NSUInteger len = [@(v) stringValue].length;
    int value = v;
    if (len == 6) {
        value = value * 100;
    }
    
    components.day = len == 6 ? 1 : value % 100;
    components.month = (value / 100) % 100;
    components.year = (value / 10000);
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
    CustomCollectionViewFlowLayout *l = [[CustomCollectionViewFlowLayout alloc] init];
    l.minimumInteritemSpacing = 0;
    l.minimumLineSpacing = 0;
    
    collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:l];
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [collectionView registerClass:[DateCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    
    [self.view addSubview:collectionView];
    [collectionView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [collectionView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [collectionView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
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

    CGFloat adjustedWidthForFirstCell = cellWidth;
    if (indexPath.row == 0) {
        int currentValue = [self buildDateKeyForIndexPath:indexPath];
        [self setupComponentsOnValue: currentValue];
        NSDate *d = [calendar dateFromComponents:components];
        NSInteger weekday = [calendar component:NSCalendarUnitWeekday fromDate:d];
        adjustedWidthForFirstCell = weekday * cellWidth; // Adjust the first cells width to "move" the cell to correct position based on weekdays.
    }
    
    return CGSizeMake(adjustedWidthForFirstCell, cellHeight);
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
