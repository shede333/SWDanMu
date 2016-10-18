//
//  BMReuseManager.m
//  SWDanMuDemo
//
//  Created by shaowei on 18/10/2016.
//  Copyright © 2016 shaowei. All rights reserved.
//

#import "BMReuseManager.h"

@interface BMReuseManager()

@property (nonatomic, strong) NSMutableDictionary *reusableIDs;
@property (nonatomic, strong) NSMutableDictionary *reusableItems;

@end

@implementation BMReuseManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.reusableIDs = [NSMutableDictionary dictionaryWithCapacity:2];
        self.reusableItems = [NSMutableDictionary dictionaryWithCapacity:2];
    }
    return self;
}

#pragma mark - Function - Public

- (void)registerClass:(Class)itemClass forReuseIdentifier:(NSString *)identifier{
    _reusableIDs[identifier] = NSStringFromClass(itemClass);
}

- (id)dequeueReusableWithIdentifier:(NSString *)identifier{
    if (identifier == nil) {
        return nil;
    }
    
    id reuseObj = nil;
    
    NSMutableArray *tmpReuseItems = _reusableItems[identifier];
    if (tmpReuseItems == nil) {
        tmpReuseItems = [NSMutableArray arrayWithCapacity:2];
        _reusableItems[identifier] = tmpReuseItems;
    }
    
    if ([tmpReuseItems count] == 0) {
        //无可用的item
        NSString *className = _reusableIDs[identifier];
        if (className) {
            //创建一个新的itm
            Class classObj = NSClassFromString(className);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
            if ([classObj instancesRespondToSelector:@selector(initWithIdentifier:)]) {
                reuseObj = [[classObj alloc] performSelector:@selector(initWithIdentifier:)
                                                  withObject:identifier];
            }else{
                reuseObj = [[classObj alloc] init];
            }
#pragma clang diagnostic pop
        }
    }else{
        reuseObj = [tmpReuseItems firstObject];
        [tmpReuseItems removeObjectAtIndex:0];
    }
    
    return reuseObj;
}

- (void)recycleItem:(id)item identifier:(NSString *)identifier{
    if (identifier == nil) {
        return;
    }
    NSMutableArray *tmpReuseItems = _reusableItems[identifier];
    if (tmpReuseItems == nil) {
        tmpReuseItems = [NSMutableArray arrayWithCapacity:2];
        _reusableItems[identifier] = tmpReuseItems;
    }
    
    [tmpReuseItems addObject:item];
}

@end
