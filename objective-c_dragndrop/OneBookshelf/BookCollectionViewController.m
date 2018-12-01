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
                                            UICollectionViewDelegateFlowLayout,
                                            UICollectionViewDragDelegate,
                                            UICollectionViewDropDelegate>
@property (nonatomic) NSArray<Book *> *books;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation BookCollectionViewController

static NSString *cellIdentifier = @"BookCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:cellIdentifier bundle:[NSBundle bundleForClass:self.class]];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];

    // drag & drop
    self.collectionView.dragDelegate = self;
    self.collectionView.dropDelegate = self;
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

// this part works
//---------------
//- (void)collectionView:(UICollectionView *)collectionView performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator {
//    NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath ? coordinator.destinationIndexPath: [NSIndexPath indexPathForItem:self.books.count inSection:0];
//    [coordinator.session loadObjectsOfClass:UIImage.self completion:^(NSArray<__kindof id<NSItemProviderReading>> * _Nonnull objects) {
//        for(UIImage *image in objects) {
//
//            [self.collectionView performBatchUpdates:^{
//                Book *newBook = [[Book alloc] initWithTitle:@"unknown" Author:@"unknow" CoverImage:(UIImage *)image];
//
//                [self.bookshelf insertBook:newBook At:0];
//                self.books = self.bookshelf.bookList;
//                [self.collectionView insertItemsAtIndexPaths:@[destinationIndexPath]];
//            } completion:nil];
//        }
//    }];
//}
//---------------

- (BOOL)collectionView:(UICollectionView *)collectionView canHandleDropSession:(id<UIDropSession>)session {
    return true;
}

- (UICollectionViewDropProposal *)collectionView:(UICollectionView *)collectionView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(nullable NSIndexPath *)destinationIndexPath {
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator {
        NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath ? coordinator.destinationIndexPath: [NSIndexPath indexPathForItem:self.books.count inSection:0];
    
    switch (coordinator.proposal.operation) {
        case UIDropOperationCopy:
            // Receiving items from another app.
            [self loadAndInsertItemsAt:destinationIndexPath with:coordinator];
        case UIDropOperationMove:
            // Moving item from somewhere else in this app
            [self movesItemsTo:destinationIndexPath with:coordinator];
        default:
            return;
    }
}

- (void)loadAndInsertItemsAt:(NSIndexPath *)destinationIndexPath with:(id<UICollectionViewDropCoordinator>)coordinator {

    for (id<UICollectionViewDropItem> item in coordinator.items) {
        UIDragItem *dragItem = item.dragItem;
        if(![dragItem.itemProvider canLoadObjectOfClass:UIImage.self]) {continue;}

        // Start loading the image for this drag item.
        [dragItem.itemProvider loadObjectOfClass:(UIImage.self) completionHandler:^(id<NSItemProviderReading>  _Nullable droppedImage, NSError * _Nullable error) {
            if([droppedImage isKindOfClass:UIImage.self]) {
                Book *newBook = [[Book alloc] initWithTitle:@"unknown" Author:@"unknow" CoverImage:(UIImage *)droppedImage];

                [self.bookshelf insertBook:newBook At:destinationIndexPath.item];
            }
        }];
        Book *newBook = [[Book alloc] initWithTitle:@"unknown" Author:@"unknow" CoverImage:(UIImage *)dragItem.localObject];

        [self.bookshelf insertBook:newBook At:0/*destination.indexPath.row*/];
        self.books = self.bookshelf.bookList;
        UICollectionViewDropPlaceholder * placeholder = [[UICollectionViewDropPlaceholder alloc] initWithInsertionIndexPath:destinationIndexPath reuseIdentifier:@"BookCollectionViewCell"];
        [placeholder cellUpdateHandler];

        [coordinator dropItem:dragItem toPlaceholder:placeholder];
    }

    // Disable the system progress indicator as we are displaying the progress of drag items in the placeholder cells.
    coordinator.session.progressIndicatorStyle = UIDropSessionProgressIndicatorStyleNone;
}

- (void)movesItemsTo:(NSIndexPath *)destinationIndexPath with:(id<UICollectionViewDropCoordinator>)coordinator {
    for (id<UICollectionViewDropItem> item in coordinator.items) {

        if(![item.dragItem.localObject isKindOfClass:UIImage.class]) {
            continue;
        }
        UIImage *image = item.dragItem.localObject;
        Book *newBook = [[Book alloc] initWithTitle:@"unknown" Author:@"unknow" CoverImage:image];

        [_collectionView performBatchUpdates:^{
            [self.bookshelf insertBook:newBook At:0];
            self.books = self.bookshelf.bookList;
            [self.collectionView insertItemsAtIndexPaths:@[destinationIndexPath]];
        } completion:nil];
    }
}

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
