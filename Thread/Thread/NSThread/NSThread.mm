//
// Created by Away on 18/03/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

#import <pthread.h>
#import "NSThread.h"




@interface NSThread ()
@end

@implementation NSThread {

}

- (instancetype)init {
    self = [super init];
    if (self) {
        _NSThreadData *threadData = [_NSThreadData new];
        threadData->dict = [NSMutableDictionary new];
        threadData->name = 0x0;
        threadData->target = 0x0;
        threadData->selector = 0x0;
        threadData->argument = 0x0;
        threadData->qstate = 0x0;
        *(int32_t *)_init.seqNum ++;
        threadData->seqNum = 0x2;
        threadData->cancel = 0x0;
        threadData->status = 0x0;
        threadData->performQ = 0x0;
        threadData->performD = 0x0;
        threadData->qos = 0x0;
        threadData->defpri = 0xbff0000000000000;
        threadData->pri = 0xbff0000000000000;
        pthread_attr_init(threadData->attr);
        pthread_attr_setscope(threadData->attr, 0x1);
        pthread_attr_setdetachstate(threadData->attr, 0x2);
        threadData->tid = 0x0;
        self->_private = threadData;
        if (pthread_attr_getschedparam(threadData->attr, -40) == 0x0) {
            threadData->defpri = intrinsic_movsd(rbx->defpri, intrinsic_divsd(intrinsic_cvtsi2sd(xmm0, var_-40), *0x2f1ea8));
        }
        threadData->pri = threadData->defpri;

    }
    return self;
}


+ (NSThread *)currentThread {
    if ( !*__NSIsMultiThreaded && (pthread_main_np() == 0x0)) {
        *__NSIsMultiThreaded = YES;
        [[NSNotificationCenter _defaultCenterWithoutCreating] postNotificationName:@"NSWillBecomeMultiThreadedNotification"
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

- (NSMutableDictionary *)threadDictionary {
//    return self->_private->dict;
    return nil;
}

+ (void)sleepUntilDate:(NSDate *)date {
    CFAbsoluteTime toTime = CFGetSystemUptime(self, _cmd, date);
    CFAbsoluteTime nowTime = CFAbsoluteTimeGetCurrent();
    NSTimeInterval unTilTimeInterval = [date timeIntervalSinceReferenceDate];
    if (nowTime > toTime) {
        do {
            nanosleep(-56, 0x0);
            nowTime = CFGetSystemUptime();
        } while (nowTime - toTime > 0x0);
    }
    return;
}

+ (void)exit {

    rax = pthread_exit(0x0);
    stack[2046] = rbp;
    stack[2045] = *_OBJC_IVAR_$_NSConnection.runLoops;
    stack[2044] = 0x0;
    stack[2043] = r13;
    stack[2042] = _objc_msgSend;
    stack[2041] = rbx;
    rsp = rsp - 0x38;
    rbx = rdx;
    [*__NSConnectionModesLock lock];
    [rbx retain];
    rdx = rbx;
    r12 = _objc_msgSend;
    if ([0x0->runLoops containsObjectIdenticalTo:rdx] != 0x0) {
        rdx = rbx;
        [0x0->runLoops removeObjectIdenticalTo:rdx];
        if ((0x0->rootObject != 0x0) || (0x0->localProxyCount > 0x0)) {
            rdx = rbx;
            [0x0 removePortsFromRunLoop:rdx];
        }
    }
    (r12)(rbx, @selector(release), rdx);
    rax = r12;
    (rax)(*__NSConnectionModesLock, @selector(unlock), rdx);
    return;

}

- (void)start {

    r15 = self;
    rax = self->_private;
    if (self->_private->status >= 0xd) {

        @throw [NSException exceptionWithName:@"NSInvalidArgumentException" reason:@"%@: attempt to start the thread again" userInfo:nil];
    }
    self->_private->status = 0xd;
    if (self->_private->cancel != 0x0) {
        self->_private->status = 0xf;
    }
    else {
        if (*__NSIsMultiThreaded == 0x0) {
            *__NSIsMultiThreaded = 0x1;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NSWillBecomeMultiThreadedNotification"
                                                                                object:nil userInfo:nil];
        }
        if (self->_private->qos != 0x0) {
            rbx = rbx + *_OBJC_IVAR_$__NSThreadData.attr;
            pthread_attr_set_qos_class_np(rbx);
            rbx = r15->_private;
        }
        r12 = *_OBJC_IVAR_$__NSThreadData.tid + rbx;
        rbx = rbx + *_OBJC_IVAR_$__NSThreadData.attr;
        /**
         * ___NSThread__start__
         * 中会获取当前Loop，并且添加一个Source
         */
        rbx = pthread_create(r12, rbx, ___NSThread__start__, [r15 retain]);
        if (rbx != 0x0) {
            NSLog(@"%@: Thread creation failed with error %d", __NSMethodExceptionProem(r15, var_-48), rbx);
        }
    }
    return;
}


@end