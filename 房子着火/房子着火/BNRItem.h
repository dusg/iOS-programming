//
// Created by Du Carl on 2018-12-12.
// Copyright (c) 2018 杜... All rights reserved.
//

@import Foundation;


@interface BNRItem : NSObject
@property(nonatomic, copy) NSString *itemName;

@property(nonatomic, copy) NSString *serialNumber;

@property(nonatomic) int valueInDollars;

@property(nonatomic, readonly, strong) NSDate *dateCreated;

@property (nonatomic, copy) NSString *itemKey;

+(instancetype)randomItem;
+ (instancetype)itemWithItemName:(NSString *)itemName;

- (instancetype)initWithItemName:(NSString *)name serialNumber:(NSString *)number valueInDollars:(int)value;

- (instancetype)initWithItemName:(NSString *)itemName;

@end