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

- (void)removeItem:(BNRItem *)item {
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    BNRItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
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

@end
