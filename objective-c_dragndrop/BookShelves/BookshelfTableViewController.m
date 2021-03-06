//
//  BookSelfTableViewController.m
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/25/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import "BookshelfTableViewController.h"
#import "BookshelfTableViewCell.h"
#import "../OneBookshelf/BookCollectionViewController.h"
#import "../Data Model/BookLibrary.h"
#import "../Data Model/Bookshelf.h"
#import "../Data Model/Book.h"

@interface BookshelfTableViewController ()

@property (nonatomic) NSArray<Bookshelf *> *bookshelves;
@property (nonatomic) BookLibrary *bookLibrary;

@end

@implementation BookshelfTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    self.bookLibrary = BookLibrary.sharedInstance;
    self.bookshelves = self.bookLibrary.bookshelves;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookshelves.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookshelfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookshelfTableViewCell" forIndexPath:indexPath];
    
    Bookshelf *bookshelf = self.bookshelves[indexPath.item];
    cell.category.text = bookshelf.category;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BookCollectionViewController *bookCollectionViewController = [((UINavigationController *)self.splitViewController.viewControllers[1]).viewControllers firstObject];
    ;
    //TODO(graceluli): fix the indexPath.row == nil
    bookCollectionViewController.bookshelf = self.bookshelves[0];
}


@end
