//
//  Book.h
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/22/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject

@property(nonatomic) NSString *title;
@property(nonatomic) NSString *author;
@property(nonatomic) UIImage *cover;

- (instancetype)initWithTitle:(NSString *)title Author:(NSString *)author CoverImage:(UIImage *)image;
- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSObject *> *) initDictionary;

@end

NS_ASSUME_NONNULL_END
