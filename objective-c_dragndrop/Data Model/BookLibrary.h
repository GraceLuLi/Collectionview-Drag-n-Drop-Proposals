//
//  BookLibrary.h
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/22/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Bookshelf;
@class Book;

@interface BookLibrary : NSObject

@property (nonatomic) NSArray<Bookshelf *> *bookshelves;

+ (instancetype)sharedInstance;

- (void)insertBook:(Book *)book toBookshelf:(NSInteger)bookshelfIndex atRow:(NSInteger)rowIndex;

@end

NS_ASSUME_NONNULL_END
