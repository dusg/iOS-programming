//
//  BNRImageStore.m
//  房子着火
//
//  Created by Du Carl on 2018/12/25.
//  Copyright © 2018 杜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameplayKit/GameplayKit.h>
#import "BNRImageStore.h"

@interface BNRImageStore()
@property(nonatomic, strong) NSMutableDictionary *dictionary;
@end

@implementation BNRImageStore
+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] initPrivate];
    });

    return _sharedInstance;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    self.dictionary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key {
    return self.dictionary[key];
}

- (void)deleteImageForKey:(NSString *)key {
    if (!key) {
        return;
    }

    [self.dictionary removeObjectForKey:key];
}


- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use+[BNRImageStore sharedInstance]"
                                 userInfo:nil];
}
- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}
@end
