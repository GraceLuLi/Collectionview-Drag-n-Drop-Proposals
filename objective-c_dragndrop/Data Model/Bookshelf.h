//
//  BookSelf.h
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/25/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Book;

NS_ASSUME_NONNULL_BEGIN

@interface Bookshelf : NSObject

@property(nonatomic) NSArray<Book *> *bookList;
@property(nonatomic) NSString *category;

- (instancetype) initWithCategoryName:(NSString *)category;

- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSObject *> *)initDictionary;

- (void)insertBook:(Book *)book At:(NSInteger)destinationIndex;

@end

NS_ASSUME_NONNULL_END
