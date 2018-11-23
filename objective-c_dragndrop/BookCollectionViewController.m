//
//  BookCollectionViewController.m
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/20/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import "BookCollectionViewController.h"
#import "BookCollectionViewCell.h"
#import "Data Model/BookLibrary.h"
#import "Data Model/Book.h"

@interface BookCollectionViewController () <UICollectionViewDataSource,
     UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSArray<Book *> *books;
@property (nonatomic) BookLibrary *bookLibrary;

@end

@implementation BookCollectionViewController

static NSString *cellIdentifier = @"BookCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:cellIdentifier bundle:[NSBundle bundleForClass:self.class]];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    self.title = @"BookCollection";
    
    self.bookLibrary = BookLibrary.sharedInstance;
    self.books = self.bookLibrary.books;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.title.text = self.books[indexPath.item].title;
    cell.author.text = self.books[indexPath.item].author;
    cell.coverImage.image = self.books[indexPath.item].cover;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.books.count;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(self.collectionView.bounds.size.width, 50);
//}

@end
