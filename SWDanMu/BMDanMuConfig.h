//
//  BMDanMuConfig.h
//  SWDanMuDemo
//
//  Created by shaowei on 18/10/2016.
//  Copyright © 2016 shaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 弹幕“BMDanMuController”的配置文件
 */
@interface BMDanMuConfig : NSObject

/**
 spirit运行速度，单位：像素/秒，
 */
@property (nonatomic, assign) NSInteger speed;

/**
 两个精灵之间出现的时间间隔，单位：秒
 */
@property (nonatomic, assign) CGFloat timeInterval;


/**
 精灵的高度，这个主要是用于插入精灵时不要超出边界
 */
@property (nonatomic, assign) CGFloat spiritHeight;


@end
