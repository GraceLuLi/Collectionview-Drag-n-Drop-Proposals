//
//  BookCollectionViewController.m
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/20/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import "BookCollectionViewController.h"
#import "BookCollectionViewCell.h"

@interface BookCollectionViewController () <UICollectionViewDataSource,
     UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *collectionArray;

@end

@implementation BookCollectionViewController

static NSString *cellIdentifier = @"BookCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionArray = @[@"book1", @"book2", @"book3"];
    
    UINib *cellNib = [UINib nibWithNibName:cellIdentifier bundle:[NSBundle bundleForClass:self.class]];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    self.title = @"BookCollection";
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.title.text = self.collectionArray[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.bounds.size.width, 50);
}

@end
