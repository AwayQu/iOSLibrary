//
// Created by Away on 18/03/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

#import <pthread.h>
#import "NSThread.h"

static BOOL *__NSIsMultiThreaded = NO;


@interface NSThread ()
@end

@implementation NSThread {

}

+ (NSThread *)currentThread {
    if ( !*__NSIsMultiThreaded && (pthread_main_np() == 0x0)) {
        *__NSIsMultiThreaded = YES;
        [[NSNotificationCenter _defaultCenterWithoutCreating] postNotificationName:"NSWillBecomeMultiThreadedNotification"
                                                                            object:nil userInfo:nil];
    }
    // obtain ID of the calling thread
    pthread_t pthread = pthread_self();
    /**
     * 内部实现 发现pthread token 为 0x0 会取 主线程 thread_t
     * 然后会优先取缓存
     * 然后是构造并持有新的NSThread实例，
     * 内部使用pthread_mutex_lock
     */
    NSThread *thread = __NSThreadGet0(pthread, nil); // nil =  cmd
    return thread;
}

+ (void)detachNewThreadWithBlock:(void (^)(void))block {
    // ___stack_chk_guard  __stack_chk_fail
//    var_18 = -24;
//    var_58 = -88;
//    var_60 = -96;

    if (block) {
        pthread_attr_init(-88);
        pthread_attr_setscope(-88, 0x1);
        pthread_attr_setdetachstate(-88, 0x2);
        void(^copyedBlock)(void)  = _Block_copy(block);
        // ___NSThread__block_start__ 函数 会在线程开始的时候， 执行block中的内容
        pthread_create(-96, -88, ___NSThread__block_start__, copyedBlock);
    } else {

        @throw [NSException exceptionWithName:@"NSInvalidArgumentException" reason:@"%@: block targets for threads cannot be nil" userInfo:nil];
    }
    return;
}


+ (void)detachNewThreadSelector:(SEL)selector toTarget:(id)target withObject:(nullable id)argument {

    return [[[[NSThread allocWithZone:0x0] initWithTarget:target selector:selector object:argument] autorelease] start];
}

+ (BOOL)isMultiThreaded {
    return *__NSIsMultiThreaded;
}



@end