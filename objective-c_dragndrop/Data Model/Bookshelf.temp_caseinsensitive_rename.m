//
//  BookSelf.m
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/25/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import "Bookshelf.h"

@implementation Bookshelf

- (instancetype) initWithCategoryName:(NSString *)category {
    self.category = category;
    self.bookList = [[NSArray alloc] init];
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSObject *> *)initDictionary {
    self = [self init];
    //some code
    return self;
}
@end
