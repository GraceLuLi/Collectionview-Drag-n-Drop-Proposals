//
//  Book.m
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/22/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import "Book.h"

@interface Book ()

@property(nonatomic) NSString *coverImageName;

@end

@implementation Book

- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSObject *> *) initDictionary {
    self = [super init];
    
    if(self != nil) {
        _title = (NSString *)initDictionary[@"title"];
        _author = (NSString *)initDictionary[@"author"];
        _coverImageName = (NSString *)initDictionary[@"coverImageName"];
        _cover = [UIImage imageNamed:_coverImageName];
    }
    return self;
}

@end
