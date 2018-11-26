//
//  BookCollectionViewCell.h
//  objective-c_dragndrop
//
//  Created by Lu Li on 11/20/18.
//  Copyright © 2018 GraceLuLi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *author;
@property (strong, nonatomic) IBOutlet UIImageView *coverImage;

@end

NS_ASSUME_NONNULL_END
