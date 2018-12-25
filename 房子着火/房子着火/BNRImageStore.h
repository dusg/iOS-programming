//
//  BNRImageStore.h
//  房子着火
//
//  Created by Du Carl on 2018/12/25.
//  Copyright © 2018 杜. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

NS_ASSUME_NONNULL_BEGIN

@interface BNRImageStore : NSObject
+ (instancetype)sharedInstance;

-(void)setImage:(UIImage *)image forKey:(NSString *)key;
-(UIImage *)imageForKey:(NSString *)key;
-(void)deleteImageForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
