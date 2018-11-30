//
//  BookSelf.m
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/25/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import "Bookshelf.h"
#import "Book.h"

@implementation Bookshelf

- (instancetype) initWithCategoryName:(NSString *)category {
    self.category = category;
    self.bookList = [[NSArray alloc] init];
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSObject *> *)initDictionary {
    self = [self init];
    
    if(self != nil) {
        _category = (NSString *)initDictionary[@"category"];
        NSMutableArray<Book *> *mutable_booklist = [[NSMutableArray alloc] init];
        NSArray<NSDictionary *> *bookDictionaries = (NSArray<NSDictionary *> *) initDictionary[@"books"];
        for(NSDictionary * bookDictionary in bookDictionaries) {
            Book *book = [[Book alloc] initWithDictionary:bookDictionary];
            [mutable_booklist addObject:book];
        }
        _bookList = mutable_booklist;
    }
    return self;
}

- (void)insertBook:(Book *)book At:(NSInteger)destinationIndex {
    NSMutableArray<Book *> *mutable_booklist = [NSMutableArray arrayWithArray:self.bookList];
    [mutable_booklist addObjectsFromArray:@[book]];
    self.bookList = mutable_booklist;
}
@end
