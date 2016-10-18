//
//  BMDanMuModelManager.h
//  SWDanMuDemo
//
//  Created by shaowei on 18/10/2016.
//  Copyright © 2016 shaowei. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 可选，管理用于弹幕“BMDanMuController”的model资源
 */
@interface BMDanMuModelManager : NSObject


/**
 重置model资源

 @param arr 新的model资源
 */
- (void)resetResourceWithArray:(NSArray *)arr;


/**
 按照顺序，获取循环队列的下一个model，循环往复

 @return model
 */
- (id)getNextModel;

/**
 将model放在本次循环的队列末尾

 @param model 新插入的model
 */
- (void)addModelToQueueEnd:(id)model;


/**
 将model放在本次循环的队首，下次调用“getNextModel”即可获取该model

 @param model 新插入的model
 */
- (void)addModelToQueueFirst:(id)model;

//- (void)addModelToArrayEnd:(id)model;
//
//- (void)addModelToArrayFirst:(id)model;

@end
