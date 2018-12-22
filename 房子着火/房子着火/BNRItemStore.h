//
//  BNRItemStore.h
//  房子着火
//
//  Created by Du Carl on 2018/12/19.
//  Copyright © 2018 杜. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BNRItem;

@interface BNRItemStore : NSObject
@property(nonatomic, readonly) NSArray *allItems;

+(instancetype)sharedStore;
-(BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;
@end

NS_ASSUME_NONNULL_END
