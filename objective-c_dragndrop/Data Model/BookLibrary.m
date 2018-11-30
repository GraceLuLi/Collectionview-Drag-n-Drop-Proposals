//
//  BookLibrary.m
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/22/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import "BookLibrary.h"
#import "Book.h"
#import "Bookshelf.h"

@implementation BookLibrary

+ (instancetype)sharedInstance {
    static BookLibrary *bookLibrary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bookLibrary = [[self alloc] init];
    });
    return bookLibrary;
}

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        NSURL *plistURL = [[NSBundle mainBundle] URLForResource:@"BookLibary" withExtension:@"plist"];
        
        NSArray<NSDictionary *> *bookLibrary = (NSArray<NSDictionary *> *)[NSArray arrayWithContentsOfURL:plistURL];
        
        NSMutableArray<Bookshelf *> *mutable_bookshelves = [NSMutableArray array];
        
        for(NSDictionary *bookshelfDictionary in bookLibrary) {
            Bookshelf *bookshelf = [[Bookshelf alloc] initWithDictionary:bookshelfDictionary];
            [mutable_bookshelves addObject:bookshelf];
        }
        _bookshelves = mutable_bookshelves;
    }
    return self;
}

- (void)insertBook:(Book *)book toBookshelf:(NSInteger)bookshelfIndex atRow:(NSInteger)rowIndex {
    [self.bookshelves[bookshelfIndex] insertBook:book At:rowIndex];
}

@end
