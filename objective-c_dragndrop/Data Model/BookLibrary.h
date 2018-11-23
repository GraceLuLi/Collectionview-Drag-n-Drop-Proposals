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

+ (instancetype)sharedInstance;

@property (nonatomic) NSArray<Book *> *books;

@end

NS_ASSUME_NONNULL_END
