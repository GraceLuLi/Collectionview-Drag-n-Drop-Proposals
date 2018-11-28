//
//  BookCollectionViewController.m
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/20/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import "BookCollectionViewController.h"
#import "BookCollectionViewCell.h"
#import "../Data Model/BookLibrary.h"
#import "../Data Model/Bookshelf.h"
#import "../Data Model/Book.h"

@interface BookCollectionViewController () <UICollectionViewDataSource,
                                            UICollectionViewDelegateFlowLayout>
                                            //UICollectionViewDragDelegate>
                                            //UICollectionViewDropDelegate>

@property (nonatomic) NSArray<Book *> *books;
@property (nonatomic) BookLibrary *bookLibrary;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation BookCollectionViewController

static NSString *cellIdentifier = @"BookCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:cellIdentifier bundle:[NSBundle bundleForClass:self.class]];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];

    // drag & drop
    //self.collectionView.dragDelegate = self;
    //self.collectionView.dropDelegate = self;
    }

#pragma mark update data
- (void)setBookshelf:(Bookshelf *)bookshelf {
    
    _books = bookshelf.bookList;
    _bookshelf = bookshelf;
    [_collectionView reloadData];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.title.text = self.books[indexPath.item].title;
    cell.author.text = self.books[indexPath.item].author;
    cell.coverImage.image = self.books[indexPath.item].cover;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  3;//self.books.count;
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

//- (void)collectionView:(UICollectionView *)collectionView performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator {
//    NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath ? coordinator.destinationIndexPath: [NSIndexPath indexPathForItem:self.books.count inSection:0];
//    [coordinator.session loadObjectsOfClass:UIImage.self completion:^(NSArray<__kindof id<NSItemProviderReading>> * _Nonnull objects) {
//        for(UIImage *image in objects) {
//
//            [self.collectionView performBatchUpdates:^{
//                Book *newBook = [[Book alloc] initWithTitle:@"unknown" Author:@"unknow" CoverImage:(UIImage *)image];
//                [self.bookLibrary insertBook:newBook At:0];
//                self.books = self.bookLibrary.books;
//                [self.collectionView insertItemsAtIndexPaths:@[destinationIndexPath]];
//            } completion:nil];
//        }
//    }];
//}

//
//- (void)loadAndInsertItemsAt:(NSIndexPath *)destinationIndexPath with:(id<UICollectionViewDropCoordinator>)coordinator {
//
//    for (id<UICollectionViewDropItem> item in coordinator.items) {
//        UIDragItem *dragItem = item.dragItem;
//        if(![dragItem.itemProvider canLoadObjectOfClass:UIImage.self]) {continue;}
//
//        // Start loading the image for this drag item.
//        [dragItem.itemProvider loadObjectOfClass:(UIImage.self) completionHandler:^(id<NSItemProviderReading>  _Nullable droppedImage, NSError * _Nullable error) {
//            if([droppedImage isKindOfClass:UIImage.self]) {
//                Book *newBook = [[Book alloc] initWithTitle:@"unknown" Author:@"unknow" CoverImage:(UIImage *)droppedImage];
//
//                [self.bookLibrary insertBook:newBook At:destinationIndexPath.item];
//            }
//        }];
//        Book *newBook = [[Book alloc] initWithTitle:@"unknown" Author:@"unknow" CoverImage:(UIImage *)dragItem.localObject];
//
//        [self.bookLibrary insertBook:newBook At:destinationIndexPath.item];
//        self.books = self.bookLibrary.books;
//        UICollectionViewDropPlaceholder * placeholder = [[UICollectionViewDropPlaceholder alloc] initWithInsertionIndexPath:destinationIndexPath reuseIdentifier:@"BookCollectionViewCell"];
//        [placeholder cellUpdateHandler];
//
//        [coordinator dropItem:dragItem toPlaceholder:placeholder];
//    }
//
//    // Disable the system progress indicator as we are displaying the progress of drag items in the placeholder cells.
//    coordinator.session.progressIndicatorStyle = UIDropSessionProgressIndicatorStyleNone;
//}
//
//- (void)movesItemsTo:(NSIndexPath *)destinationIndexPath with:(id<UICollectionViewDropCoordinator>)coordinator {
//    for (id<UICollectionViewDropItem> item in coordinator.items) {
//
//        UIImage *image = [UIImage imageNamed:@"book2Cover"];//item.dragItem.localObject;
//        Book *newBook = [[Book alloc] initWithTitle:@"unknown" Author:@"unknow" CoverImage:image];
//
//        [_collectionView performBatchUpdates:^{
//            [self.bookLibrary insertBook:newBook At:destinationIndexPath.item];
//            self.books = self.bookLibrary.books;
//            [self.collectionView insertItemsAtIndexPaths:@[destinationIndexPath]];
//        } completion:nil];
//    }
//}
//
//- (void)reorder:(id<UICollectionViewDropItem>)item to:(NSIndexPath *)destinationIndexPath with:(id<UICollectionViewDropCoordinator>)coordinator {
//
//    [_collectionView performBatchUpdates:^{
//        [self.bookLibrary moveBookFrom:item.sourceIndexPath.item to: destinationIndexPath.item];
//        [self.collectionView deleteItemsAtIndexPaths:@[item.sourceIndexPath]];
//        [self.collectionView insertItemsAtIndexPaths:@[destinationIndexPath]];
//    } completion:nil];
//
//    [coordinator dropItem:item.dragItem toItemAtIndexPath:destinationIndexPath];
//}

@end
