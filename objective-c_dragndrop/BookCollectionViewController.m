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
                                            UICollectionViewDelegateFlowLayout,
                                            UICollectionViewDragDelegate,
                                            UICollectionViewDropDelegate>

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
    
    // drag & drop
    self.collectionView.dragDelegate = self;
    self.collectionView.dropDelegate = self;
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

#pragma mark drag
- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath {

    Book * book = [self.books objectAtIndex:indexPath.item];
    UIImage *coverImage = book.cover;
    
    NSItemProvider *provider = [[NSItemProvider alloc] initWithObject:coverImage];
    UIDragItem *dragItem = [[UIDragItem alloc] initWithItemProvider:provider];
    dragItem.localObject = coverImage;
    return @[dragItem];
}

#pragma mark drop

- (void)collectionView:(UICollectionView *)collectionView performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator {
    NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath ? coordinator.destinationIndexPath: [NSIndexPath indexPathForItem:self.books.count inSection:0];
    [coordinator.session loadObjectsOfClass:UIImage.self completion:^(NSArray<__kindof id<NSItemProviderReading>> * _Nonnull objects) {
        for(UIImage *image in objects) {

            [self.collectionView performBatchUpdates:^{
                Book *newBook = [[Book alloc] initWithTitle:@"unknown" Author:@"unknow" CoverImage:(UIImage *)image];
                [self.bookLibrary insertBook:newBook At:0];
                self.books = self.bookLibrary.books;
                [self.collectionView insertItemsAtIndexPaths:@[destinationIndexPath]];
            } completion:nil];
        }
    }];
}
@end
