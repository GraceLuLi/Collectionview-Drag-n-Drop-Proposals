//
//  BookLibrary.m
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/22/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import "BookLibrary.h"
#import "Book.h"

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
        NSURL *plistURL = [[NSBundle mainBundle] URLForResource:@"Books" withExtension:@"plist"];
        
        NSArray<NSDictionary *> *bookDictionaries = (NSArray<NSDictionary *> *)[NSArray arrayWithContentsOfURL:plistURL];
        
        NSMutableArray<Book *> *bookList = [NSMutableArray array];
        
        for(NSDictionary *bookDictionary in bookDictionaries) {
            Book *book = [[Book alloc] initWithDictionary:bookDictionary];
            [bookList addObject:book];
        }
        
        _books = bookList;
    }
    return self;
}

- (void)moveBookFrom:(NSInteger)sourceIndex to:(NSInteger)destinationIndex {
    NSMutableArray<Book *> *bookList = [self.books copy];
    [bookList exchangeObjectAtIndex:sourceIndex withObjectAtIndex:destinationIndex];
    _books = bookList;
}

- (void)insertBook:(Book *)book At:(NSInteger)destinationIndex {
    NSMutableArray<Book *> *bookList = [NSMutableArray arrayWithArray:self.books];
    [bookList insertObject:book atIndex:0];
    _books = bookList;
}

@end
