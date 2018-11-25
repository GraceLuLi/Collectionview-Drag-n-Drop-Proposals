//
//  BookLibrary.h
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/22/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Book;

@interface BookLibrary : NSObject

@property (nonatomic) NSArray<Book *> *books;

+ (instancetype)sharedInstance;

- (void)moveBookFrom:(NSInteger)sourceIndex to:(NSInteger)destinationIndex;
- (void)insertBook:(Book *)book At:(NSInteger)destinationIndex;

@end

NS_ASSUME_NONNULL_END
