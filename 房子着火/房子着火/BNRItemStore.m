//
//  BNRItemStore.m
//  房子着火
//
//  Created by Du Carl on 2018/12/19.
//  Copyright © 2018 杜. All rights reserved.
//

#import <CloudKit/CloudKit.h>
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore()
@property(nonatomic, strong) NSMutableArray *privateItems;
@end

@implementation BNRItemStore
+ (instancetype)sharedStore {
    static BNRItemStore *sharedStore = nil;

    if (sharedStore == nil) {
        sharedStore = [[BNRItemStore alloc] initPrivate];
    }
    return sharedStore;
}

- (BNRItem *)createItem {
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];

    return item;
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

- (NSArray *)itemsBigger {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (BNRItem *item in self.allItems) {
        if (item.valueInDollars > 50) {
            [items addObject:item];
        }
    }
    return items;
}

- (NSArray *)itemsLittle {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (BNRItem *item in self.allItems) {
        if (item.valueInDollars <= 50) {
            [items addObject:item];
        }
    }
    return items;
}
@end
