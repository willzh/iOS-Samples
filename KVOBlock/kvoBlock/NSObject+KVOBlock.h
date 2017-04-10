//
//  NSObject+KVOBlock.m
//
//  Created by  on 4/7/17.
//  Copyright © 2017. All rights reserved.
//


#import <Foundation/Foundation.h>


typedef void(^KVOBlock)(NSObject *observer, NSString *keyPath, NSDictionary<NSString *,id> *change); // kvo block 回调




@interface NSObject (KVOBlock)

@property (nonatomic, strong) NSMutableSet *kvoInfos; //!< 所有 kvo


- (void)addObserverForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(KVOBlock)block;  //!< 添加 observer
- (void)addObserverForKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options block:(KVOBlock)block; //!< 批量添加 observer，可根据 block 中返回的 keyPath 来判断哪个值有变化
- (void)removeAllObserver; //!< 移除所有 observer。一般不需要调用这个方法，在 dealloc 时会自动调用。
- (void)removeObserverForKeyPath:(NSString *)keyPath; //!< 移除 keyPath 对应的 observer

@end





@interface KVOInfo : NSObject

@property (nonatomic, copy) NSString *keyPath; //!< 属性路径
@property (nonatomic, copy) KVOBlock block; //!< 回调

@end
