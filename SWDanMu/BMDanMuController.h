//
//  BMDanMuController.h
//  SWDanMuDemo
//
//  Created by shaowei on 18/10/2016.
//  Copyright © 2016 shaowei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMDanMuSpiritView.h"
#import "BMDanMuConfig.h"


typedef NS_ENUM(NSInteger, BMDanMuControllerStatus) {
    BMDanMuControllerStatusOfStop, //停止
    BMDanMuControllerStatusOfRuning, //运行中
    BMDanMuControllerStatusOfSuspend, //挂起、暂停
};


@class BMDanMuController;

@protocol BMDanMuDelegate <NSObject>

/**
 提供弹幕精灵view，会立刻显示到屏幕上
 
 @param danMuController 弹幕控制器
 
 @return 弹幕精灵view
 */
@required
- (BMDanMuSpiritView *)danMuControllerGetSpiritView:(BMDanMuController *)danMuController;

@end


/**
 弹幕控制器，管理弹幕相关的工作
 */
@interface BMDanMuController : NSObject


@property (nonatomic, strong, readonly) UIView *view;
@property (nonatomic, strong, readonly) UIView *backgroundView;
@property (nonatomic, weak) id<BMDanMuDelegate> delegate;

@property (nonatomic, assign, readonly) BMDanMuControllerStatus status;

/**
 注册class，为了复用，参考自UITableView

 @param itemClass  被复用的类对象
 @param identifier 为将来获取对象而设置的ID
 */
- (void)registerClass:(Class)itemClass forCellReuseIdentifier:(NSString *)identifier;

/**
 使用上面注册的ID产生复用的对象

 @param identifier 类对象对应的ID

 @return spirit对象
 */
- (__kindof BMDanMuSpiritView *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

/**
 启动弹幕

 @param config 弹幕相关的配置
 */
- (void)startWithConfig:(BMDanMuConfig *)config;

/**
 停止弹幕
 */
- (void)stop;

//- (void)suspend;
//
//- (void)resume;

@end
