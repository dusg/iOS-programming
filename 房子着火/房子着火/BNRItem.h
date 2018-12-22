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

+(instancetype)randomItem;
+ (instancetype)itemWithItemName:(NSString *)itemName;

/**
 * @brief BNRItem类的指定初始化方法
 * @param name nsstring
 * @param number nsstring
 * @param value int
 * @return id
 */
- (instancetype)initWithItemName:(NSString *)name serialNumber:(NSString *)number valueInDollars:(int)value;

- (instancetype)initWithItemName:(NSString *)itemName;

@end