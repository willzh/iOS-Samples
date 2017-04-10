//
//  NSObject+KVOBlock.m
//
//  Created by  on 4/7/17.
//  Copyright © 2017. All rights reserved.
//

#import "NSObject+KVOBlock.h"
#import <objc/runtime.h>


@implementation NSObject (KVOBlock)



#pragma mark - Public Methods
- (void)addObserverForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(KVOBlock)block
{
    [self addObserverForKeyPaths:@[keyPath] options:options block:block];
}

- (void)addObserverForKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options block:(KVOBlock)block
{
    NSMutableSet *set = self.kvoInfos;
    for (NSString *kp in keyPaths)
    {
        KVOInfo *info = [[KVOInfo alloc] init];
        info.keyPath  = kp;
        info.block    = block;
        
        [set addObject:info];
        
        [self addObserver:self forKeyPath:kp options:options context:NULL];
    }
    
    if (keyPaths.count) [self swizzle];
    // NSLog(@"self.kvoInfos:%@", self.kvoInfos);
}

- (void)removeAllObserver
{
    NSMutableSet *set = self.kvoInfos;
    // if (set) NSLog(@"self.kvoInfos:%@", self.kvoInfos);
    
    for (KVOInfo *info in set) {
        [self removeObserver:self forKeyPath:info.keyPath];
    }
    [set removeAllObjects];
}

- (void)removeObserverForKeyPath:(NSString *)keyPath
{
    NSMutableSet *set = self.kvoInfos;
    for (KVOInfo *info in set)
    {
        if (info.keyPath == keyPath)
        {
            [self removeObserver:self forKeyPath:keyPath];
            [set removeObject:info];
            break;
        }
    }
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (nil == object || 0 == keyPath.length) {
        return;
    }
    
    NSMutableSet *set = self.kvoInfos;
    for (KVOInfo *info in set)
    {
        if ([info.keyPath isEqualToString:keyPath]) {
            if (info.block) info.block(self, keyPath, change);
        }
    }
    
}





#pragma mark - runtime
- (NSMutableSet *)kvoInfos
{
    NSMutableSet *set = (NSMutableSet *)objc_getAssociatedObject(self, "kvoInfos");
    if (!set)
    {
        set = [NSMutableSet set];
        self.kvoInfos = set;
    }
    return set;
}

- (void)setKvoInfos:(NSMutableSet *)kvoInfos {
    objc_setAssociatedObject(self, "kvoInfos", kvoInfos, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)removeAssociationObjects {
    objc_removeAssociatedObjects(self);
}

- (void)swizzle
{
    // 替换 dealloc 方法, 仅执行一次
    /*
     这部分初始化代码不能直接添加到 +load 方法中。
     因为:
     1.这个 category 是附加到 NSObject 类，而NSObject 是所有类的基类，
     2.交换了 dealloc 方法，每个类都会调用 dealloc。而此处 dealloc 中添加了 removeAllObserver 方法
     如果添加到 +load 中，会造成所有的类都调用 removeAllObserver，从而在所有类中都添加一个 kvoInfos，严重时会造成 App 卡死。
     */
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
        Method method2 = class_getInstanceMethod([self class], @selector(zs_dealloc));
        method_exchangeImplementations(method1, method2);
    });
}


- (void)zs_dealloc
{
    [self removeAllObserver]; // dealloc 中移除所有观察者(observer)
    [self removeAssociationObjects]; // 删除动态添加的属性
    
    [self zs_dealloc]; // 调用 dealloc。因为已经在 +load 方法中替换了 dealloc。
}



@end










@implementation KVOInfo



- (NSString *)description {
    return [NSString stringWithFormat:@"KVOInfo---keyPath:%@", _keyPath];
}



@end









