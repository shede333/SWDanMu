//
//  BMReuseManager.h
//  SWDanMuDemo
//
//  Created by shaowei on 18/10/2016.
//  Copyright © 2016 shaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMReuseManager : NSObject

/**
 *  为对应的id注册class，以后使用该id来重用item时，就会使用该class创建对象，
 *  创建item时的初始化方法，会调用“- (instancetype)initWithIdentifier:(NSString *)”
 *  如果上面的方法不存在，就会调用“init”
 *
 *  @param itemClass  注册的Class
 *  @param identifier item的id
 */
- (void)registerClass:(Class)itemClass forReuseIdentifier:(NSString *)identifier;

/**
 *  将缓存/回收的item重新恢复使用；
 *  如果不存在此id对应的可用的对象，那么使用"registerClass:forReuseIdentifier:"注册的类新建一个对象；
 *  如果也没有注册class，那么就返回nil
 *
 *  @param identifier item的id类型，不能为nil
 *
 *  @return 返回item
 */
- (id)dequeueReusableWithIdentifier:(NSString *)identifier;

/**
 *  回收item，将暂时不使用的item回收，留在下次重用
 *
 *  @param item       需要回收的item
 *  @param identifier item的ID
 */
- (void)recycleItem:(id)item identifier:(NSString *)identifier;

@end
