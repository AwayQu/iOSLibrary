//
// Created by Away on 19/03/2018.
// Copyright (c) 2018 ___FULLUSERNAME___. All rights reserved.
//

#import <pthread.h>
#import "NSOperation.h"
#import "NSThreadPrivate.h"

int ___NSOQSchedule_f(NSOperation *op) {
    var_38 = objc_autoreleasePoolPush();

    ___NSOperationQueueInternal *queueInternal = op->_private;
    os_unfair_lock_lock(queueInternal->__queueLock);
    [queueInternal->__activeThreads addPointer:pthread_self()];
    os_unfair_lock_unlock(queueInternal->__queueLock);
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    [processInfo _reactivateActivity:[op _activity]];

    _CFSetTSD(0x18, *(op + 0x8), 0x0);
    _CFSetTSD(0x17, *op, 0x0);
    op->_private->__state = intrinsic_xchg(rax->__state, 0xd8);
    if (op->_private->__propertyQos != 0x0) {
        *var_60 = __NSConcreteStackBlock;
        *(int32_t *)(var_60 + 0x8) = 0xc0000000;
        *(int32_t *)(var_60 + 0xc) = 0x0;
        *(var_60 + 0x10) = _____NSOQSchedule_f_block_invoke;
        *(var_60 + 0x18) = ___block_descriptor_tmp.584;
        *(var_60 + 0x20) = r13;
        rbx = dispatch_block_create_with_qos_class(0x20, rax & 0xff, 0x0, var_60);
        dispatch_block_perform(0x20, rbx);
        _Block_release(rbx);
    } else {
        [op start];
    }
    _CFSetTSD(0x17, 0x0, 0x0);
    _CFSetTSD(0x18, 0x0, 0x0);
    if (([op isFinished] != 0x0) && (op->_private->__state <= 0xef)) {
        [__NSOperationInternal _observeValueForKeyPath:@"isFinished" ofObject:op changeKind:0x0 oldValue:0x0 newValue:0x0 indexes:0x0 context:0x0];
    }

    [[NSProcessInfo processInfo] endActivity:[op _activity]];

    r15 = pthread_self();
    os_unfair_lock_lock(op->_private->__queueLock);
    if ([op->_private->__activeThreads count] == 0x0)  {
        os_unfair_lock_unlock(op->_private->__queueLock);
        [op release];
        [op->_private release];
        rdi = *(rbx + 0x10);
        if (*(op->_private1) != 0x0) {
            //??
            dispatch_release(*(op->_private1));
        }
        free(*(op->_private1));
        rax = objc_autoreleasePoolPop(var_38);
        return rax;
    }

    loc_35dfa:
    r13 = @selector(pointerAtIndex:);
    rbx = 0x0;
    goto loc_35e03;

    loc_35e03:
    if (_objc_msgSend(r12->__activeThreads, r13) == r15) goto loc_35e29;

    loc_35e1f:
    rbx = rbx + 0x1;
    if (rbx < r14) goto loc_35e03;

    loc_35e53:
    os_unfair_lock_unlock(r12 + *_OBJC_IVAR_$___NSOperationQueueInternal.__queueLock);
    rbx = var_30;
    [*rbx release];
    [*(rbx + 0x8) release];
    rdi = *(rbx + 0x10);
    if (rdi != 0x0) {
        dispatch_release(rdi);
    }
    free(rbx);
    rax = objc_autoreleasePoolPop(var_38);
    return rax;

    loc_35e29:
    if (rbx != 0x7fffffffffffffff) {
        [r12->__activeThreads removePointerAtIndex:rbx];
    }
    goto loc_35e53;
}

int ___NSOQSchedule(int arg0) {
    rcx = arg0;
    var_30 = *___stack_chk_guard;
    if (rcx == 0x0) goto loc_7437;

    loc_6c17:
    intrinsic_movaps(var_40, 0x0);
    intrinsic_movaps(var_50, 0x0);
    intrinsic_movaps(var_60, 0x0);
    intrinsic_movaps(var_70, 0x0);
    intrinsic_movaps(var_80, 0x0);
    intrinsic_movaps(var_90, 0x0);
    intrinsic_movaps(var_A0, 0x0);
    intrinsic_movaps(var_B0, 0x0);
    intrinsic_movaps(var_C0, 0x0);
    intrinsic_movaps(var_D0, 0x0);
    intrinsic_movaps(var_E0, 0x0);
    intrinsic_movaps(var_F0, 0x0);
    intrinsic_movaps(var_100, 0x0);
    intrinsic_movaps(var_110, 0x0);
    intrinsic_movaps(var_120, 0x0);
    var_130 = intrinsic_movaps(var_130, 0x0);
    var_148 = rcx;
    os_unfair_lock_lock(rcx->_private + *_OBJC_IVAR_$___NSOperationQueueInternal.__queueLock);
    rsi = var_148;
    rdi = rsi->_private;
    rcx = sign_extend_64(rdi->__actualMaxNumOps);
    rcx = rcx - sign_extend_64(rdi->__numExecOps);
    var_158 = rcx;
    if (rcx <= 0x0) goto loc_738a;

    loc_6cd3:
    if ((rdi->__suspended & 0x1) != 0x0) goto loc_739d;

    loc_6ce5:
    var_160 = 0x20;
    rdi = 0x0;
    r13 = 0x0;
    var_138 = var_130;
    goto loc_6d04;

    loc_6d04:
    rax = *(int8_t *)(rdi + ___NSOperationPrios);
    rcx = rsi->_private;
    rcx = rcx + *_OBJC_IVAR_$___NSOperationQueueInternal.__firstPriOperation;
    rdx = SAR((SAR(rax, 0x7) >> 0x6) + rax, 0x2);
    r15 = *(rcx + sign_extend_64(rdx) * 0x8 + 0x10);
    if (r15 == 0x0) goto loc_7358;

    loc_6d3f:
    var_140 = rdi;
    var_190 = @selector(length);
    var_188 = @selector(getBytes:maxLength:usedLength:encoding:options:range:remainingRange:);
    var_198 = @selector(retain);
    var_150 = @selector(retain);
    r14 = 0x0;
    goto loc_6d8a;

    loc_6d8a:
    rbx = r13;
    r12 = r14;
    goto loc_6d90;

    loc_6d90:
    r13 = rbx;
    r14 = r12;
    r12 = r15;
    goto loc_6d99;

    loc_6d99:
    rax = rsi->_private;
    rcx = *_OBJC_IVAR_$___NSOperationQueueInternal.__suspended;
    if ((*(int8_t *)(rax + rcx) & 0x1) != 0x0) goto loc_7351;

    loc_6db6:
    rax = r12->_private;
    r15 = rax->__nextPriOp;
    rcx = *_OBJC_IVAR_$___NSOperationInternal.__state;
    if (*(int8_t *)(rax + rcx) != 0x50) goto loc_6e2d;

    loc_6dda:
    rbx = r12->_private;
    if ((rbx->__cached_isReady & 0x1) != 0x0) goto loc_6eec;

    loc_6df7:
    os_unfair_lock_lock(*_OBJC_IVAR_$___NSOperationInternal.__lock + rbx);
    r14 = rbx->__unfinished_deps;
    os_unfair_lock_unlock(rbx + *_OBJC_IVAR_$___NSOperationInternal.__lock);
    rsi = var_148;
    if (r14 == 0x0) goto loc_6e41;

    loc_6e2d:
    r14 = r12;
    r12 = r15;
    if (r15 != 0x0) goto loc_6d99;

    loc_7351:
    rdi = var_140;
    goto loc_7358;

    loc_7358:
    if (var_158 <= 0x0) goto loc_73ae;

    loc_7362:
    rdi = rdi + 0x1;
    rax = rsi->_private;
    rcx = *_OBJC_IVAR_$___NSOperationQueueInternal.__suspended;
    rax = *(int8_t *)(rax + rcx);
    if (rdi > 0x4) goto loc_73ae;

    loc_7380:
    rax = rax & 0x1;
    if (rax == 0x0) goto loc_6d04;

    loc_73ae:
    rdi = rsi->_private;
    goto loc_73b9;

    loc_73b9:
    os_unfair_lock_unlock(rdi + *_OBJC_IVAR_$___NSOperationQueueInternal.__queueLock);
    if (r13 != 0x0) {
        r14 = @selector(isReady);
        r12 = @selector(release);
        rbx = var_138;
        do {
            if (_objc_msgSend(*rbx, r14) != 0x0) {
                rax = *rbx;
                rax = rax->_private;
                rcx = *_OBJC_IVAR_$___NSOperationInternal.__cached_isReady;
                rdx = 0x1;
                *(int8_t *)(rax + rcx) = intrinsic_xchg(*(int8_t *)(rax + rcx), rdx);
            }
            _objc_msgSend(*rbx, r12, rdx, rcx);
            rbx = rbx + 0x8;
            r13 = r13 - 0x1;
        } while (r13 != 0x0);
    }
    rdi = var_138;
    if (rdi != var_130) {
        free(rdi);
    }
    goto loc_7437;

    loc_7437:
    rax = *___stack_chk_guard;
    if (rax != var_30) {
        rax = __stack_chk_fail();
    }
    return rax;

    loc_6e41:
    rbx = r13 + 0x1;
    rax = var_160;
    if (rbx > rax) {
        rax = malloc_good_size(rax * 0x8 + 0x8);
        rax = rax >> 0x3;
        rcx = var_138;
        r14 = var_130;
        var_160 = rax;
        if (rcx != r14) {
            var_138 = realloc(rcx, rax * 0x8);
        }
        else {
            rax = malloc(rax * 0x8);
            rdx = r13 * 0x8;
            var_138 = rax;
            memmove(rax, r14, rdx);
        }
    }
    rcx = var_138;
    *(rcx + r13 * 0x8) = _objc_msgSend(r12, var_150);
    rsi = var_148;
    if (r15 != 0x0) goto loc_6d90;

    loc_734e:
    r13 = rbx;
    goto loc_7351;

    loc_6eec:
    if (r14 != 0x0) {
        r14->_private->__nextPriOp = r15;
    }
    else {
        rax = *(int8_t *)(var_140 + ___NSOperationPrios);
        *(sign_extend_64(SAR((SAR(rax, 0x7) >> 0x6) + rax, 0x2)) * 0x8 + 0x10 + rsi->_private + *_OBJC_IVAR_$___NSOperationQueueInternal.__firstPriOperation) = r15;
    }
    if (r15 == 0x0) {
        rax = *(int8_t *)(var_140 + ___NSOperationPrios);
        *(sign_extend_64(SAR((SAR(rax, 0x7) >> 0x6) + rax, 0x2)) * 0x8 + 0x10 + rsi->_private + *_OBJC_IVAR_$___NSOperationQueueInternal.__lastPriOperation) = r14;
    }
    r12->_private->__nextPriOp = 0x0;
    rax = r12->_private;
    rax->__state = intrinsic_xchg(rax->__state, 0x88);
    rax = rsi->_private;
    rax->__numExecOps = rax->__numExecOps + 0x1;
    var_150 = malloc(0x18);
    _objc_msgSend(r12, var_198);
    rbx = var_150;
    _objc_msgSend(var_148, var_198);
    rcx = var_148;
    *rbx = r12;
    *(rbx + 0x8) = rcx;
    *(rbx + 0x10) = 0x0;
    r12 = rcx->_private;
    if (r12->__mainQ != 0x0) {
        rdi = __dispatch_main_q;
        rsi = rbx;
    }
    else {
        rbx = r12->__dispatch_queue;
        if (rbx == 0x0) {
            rbx = r12->__backingQueue;
            if (rbx == 0x0) {
                rcx = r12->__propertyQoS;
                rax = __dispatch_queue_attr_concurrent;
                if (rcx != 0x0) {
                    rax = dispatch_queue_attr_make_with_qos_class();
                }
                rcx = r12->__overcommit;
                if ((rcx & 0x1) != 0x0) {
                    rax = dispatch_queue_attr_make_with_overcommit(rax, 0x1);
                }
                rbx = dispatch_queue_create(0x0, rax);
                rsi = *_OBJC_IVAR_$___NSOperationQueueInternal.__nameBuffer;
                if (*(int8_t *)(r12 + rsi) == 0x0) {
                    var_180 = _objc_msgSend;
                    rdi = r12->__name;
                    _objc_msgSend(rdi, var_190);
                    _objc_msgSend(rdi, var_188, rsi + r12, 0x13f);
                    *(int8_t *)(0x0 + *_OBJC_IVAR_$___NSOperationQueueInternal.__nameBuffer + r12) = 0x0;
                    __strlcat_chk(*_OBJC_IVAR_$___NSOperationQueueInternal.__nameBuffer + r12, " (QOS: ", 0x140, 0xffffffffffffffff);
                    rax = r12->__propertyQoS;
                    if (rax > 0x10) {
                        if (rax <= 0x18) {
                            if ((rax == 0x11) || (rax == 0x15)) {
                                __strlcat_chk();
                            }
                        }
                        else {
                            if ((rax == 0x19) || (rax == 0x21)) {
                                __strlcat_chk();
                            }
                        }
                    }
                    else {
                        if (((rax == 0x0) || (rax == 0x5)) || (rax == 0x9)) {
                            __strlcat_chk();
                        }
                    }
                    rcx = 0xffffffffffffffff;
                    __strlcat_chk(*_OBJC_IVAR_$___NSOperationQueueInternal.__nameBuffer + r12, ")", 0x140, rcx);
                    rsi = *_OBJC_IVAR_$___NSOperationQueueInternal.__nameBuffer;
                    rbx = var_180;
                }
                dispatch_queue_set_label_nocopy(rbx, rsi + r12);
                r12->__backingQueue = rbx;
            }
        }
        dispatch_retain(rbx);
        rsi = var_150;
        *(rsi + 0x10) = rbx;
        rdi = rbx;
    }
    rdx = ___NSOQSchedule_f;
    dispatch_async_f(rdi, rsi, rdx);
    COND = var_158 < 0x2;
    var_158 = var_158 + 0xffffffffffffffff;
    rsi = var_148;
    if ((COND) || (r15 == 0x0)) goto loc_7351;

    loc_6d7c:
    var_150 = @selector(retain);
    goto loc_6d8a;

    loc_739d:
    var_138 = var_130;
    r13 = 0x0;
    goto loc_73ae;

    loc_738a:
    var_138 = var_130;
    r13 = 0x0;
    goto loc_73b9;
}

@interface __NSOperationInternal : NSObject

@end

@implementation __NSOperationInternal

- (void)_start:(NSOperation *)operation {

    r13 = arg2;
    r15 = _cmd;
    r12 = self;
    r14 = r12->__state;
    if (r14 == 0xf4) goto .l1;

    loc_399fe:
    r12->__state = lock intrinsic_cmpxchg(r12->__state, 0xd8);
    if (r12->__state == 0x0) goto loc_39adb;

    loc_39a15:
    if ((r14 == 0xf0) || (r14 == 0xe0)) goto loc_39a3b;

    loc_39a21:
    if ((r14 != 0xd8) || (r12->__queue == 0x0)) goto loc_39a81;

    loc_39b41:
    r15 = _NSPushAutoreleasePool();
    if ((r12->__isCancelled & 0x1) != 0x0) goto loc_39d0b;

    loc_39b61:
    rax = @"isExecuting";
    if (rax == @"isReady") goto loc_39ba5;

    loc_39b74:
    if (rax == @"isFinished") goto loc_39bae;

    loc_39b80:
    if (rax == @"isExecuting") goto loc_39bb7;

    loc_39b8c:
    if (rax != @"isCancelled") goto loc_39c1c;

    loc_39b9c:
    rax = *_OBJC_IVAR_$___NSOperationInternal.__isCancelledObserverCount;
    goto loc_39bbe;

    loc_39bbe:
    if (*(int8_t *)(r12 + rax) != 0x0) {
        *var_B8 = __NSConcreteStackBlock;
        *(int32_t *)(var_B8 + 0x8) = 0xc2000000;
        *(int32_t *)(var_B8 + 0xc) = 0x0;
        *(var_B8 + 0x10) = ___32-[__NSOperationInternal _start:]_block_invoke;
        *(var_B8 + 0x18) = ___block_descriptor_tmp.79;
        *(var_B8 + 0x20) = r12;
        rsi = @selector(_changeValueForKeys:count:maybeOldValuesDict:usingBlock:);
        rdx = __NSOperationExecutingKeys;
        rdi = r13;
    }
    else {
        r12->__state = intrinsic_xchg(r12->__state, 0xe0);
        rdi = @class(__NSOperationInternal);
        rsi = @selector(_observeValueForKeyPath:ofObject:changeKind:oldValue:newValue:indexes:context:);
        rdx = @"isExecuting";
    }
    goto loc_39c57;

    loc_39c57:
    _objc_msgSend(rdi, rsi);
    xmm0 = intrinsic_movsd(xmm0, r12->__thread_prio);
    var_30 = intrinsic_movsd(var_30, xmm0);
    xmm0 = intrinsic_ucomisd(xmm0, *0x2f17a8);
    if ((xmm0 == 0x0) && (CPU_FLAGS & NP)) {
        xmm0 = intrinsic_xorpd(xmm0, xmm0);
        var_38 = intrinsic_movsd(var_38, xmm0);
    }
    else {
        [NSThread threadPriority];
        var_38 = intrinsic_movsd(var_38, xmm0);
        xmm0 = intrinsic_movsd(xmm0, r12->__thread_prio);
        [NSThread setThreadPriority:rdx];
    }
    rsi = @selector(main);
    if (_CFExecutableLinkedOnOrAfter(0x6) != 0x0) {
        _objc_msgSend(r13, rsi);
    }
    else {
        _objc_msgSend(r13, rsi);
    }
    xmm0 = intrinsic_movsd(xmm0, var_30);
    xmm0 = intrinsic_ucomisd(xmm0, *0x2f17a8);
    if ((xmm0 != 0x0) || (!CPU_FLAGS & NP)) {
        intrinsic_movsd(xmm0, var_38);
        [NSThread setThreadPriority:rdx];
    }
    goto loc_39d0b;

    loc_39d0b:
    if (r12->__state != 0xe0) goto loc_39e0d;

    loc_39d1e:
    rax = __NSOperationExecutingAndFinishedKeys;
    rcx = 0x0;
    rdx = @"isReady";
    rsi = @"isFinished";
    r9 = @"isExecuting";
    r8 = @"isCancelled";
    goto loc_39d43;

    loc_39d43:
    rdi = *rax;
    if (rdi == rdx) goto loc_39d63;

    loc_39d4b:
    if (rdi == rsi) goto loc_39d6c;

    loc_39d50:
    if (rdi == r9) goto loc_39d75;

    loc_39d55:
    if (rdi != r8) goto loc_39d88;

    loc_39d5a:
    rdi = *_OBJC_IVAR_$___NSOperationInternal.__isCancelledObserverCount;
    goto loc_39d7c;

    loc_39d7c:
    if (*(int8_t *)(r12 + rdi) != 0x0) goto loc_39e55;

    loc_39d88:
    rcx = rcx + 0x1;
    rax = rax + 0x8;
    if (rcx < 0x2) goto loc_39d43;

    loc_39d95:
    _objc_msgSend->__state = intrinsic_xchg(_objc_msgSend->__state, 0xf0);
    [__NSOperationInternal _observeValueForKeyPath:@"isExecuting" ofObject:r13 changeKind:0x0 oldValue:0x0 newValue:0x0 indexes:0x0 context:0x0];
    [__NSOperationInternal _observeValueForKeyPath:@"isFinished" ofObject:r13 changeKind:0x0 oldValue:0x0 newValue:0x0 indexes:0x0 context:0x0];
    goto loc_39f5a;

    loc_39f5a:
    _NSPopAutoreleasePool();
    return;

    .l1:
    return;

    loc_39e55:
    *var_90 = __NSConcreteStackBlock;
    *(int32_t *)(var_90 + 0x8) = 0xc2000000;
    *(int32_t *)(var_90 + 0xc) = 0x0;
    *(var_90 + 0x10) = ___32-[__NSOperationInternal _start:]_block_invoke.89;
    *(var_90 + 0x18) = ___block_descriptor_tmp.92;
    *(var_90 + 0x20) = r12;
    rsi = @selector(_changeValueForKeys:count:maybeOldValuesDict:usingBlock:);
    goto loc_39f11;

    loc_39f11:
    rdi = r13;
    goto loc_39f54;

    loc_39f54:
    _objc_msgSend(rdi, rsi);
    goto loc_39f5a;

    loc_39d75:
    rdi = *_OBJC_IVAR_$___NSOperationInternal.__isExecutingObserverCount;
    goto loc_39d7c;

    loc_39d6c:
    rdi = *_OBJC_IVAR_$___NSOperationInternal.__isFinishedObserverCount;
    goto loc_39d7c;

    loc_39d63:
    rdi = *_OBJC_IVAR_$___NSOperationInternal.__isReadyObserverCount;
    goto loc_39d7c;

    loc_39e0d:
    rax = @"isFinished";
    if (rax == @"isReady") goto loc_39ea5;

    loc_39e24:
    if (rax == @"isFinished") goto loc_39eae;

    loc_39e30:
    if (rax == @"isExecuting") goto loc_39eb7;

    loc_39e3c:
    if (rax != @"isCancelled") goto loc_39f19;

    loc_39e4c:
    rax = *_OBJC_IVAR_$___NSOperationInternal.__isCancelledObserverCount;
    goto loc_39ebe;

    loc_39ebe:
    if (*(int8_t *)(r12 + rax) == 0x0) goto loc_39f19;

    loc_39ec6:
    *var_68 = __NSConcreteStackBlock;
    *(int32_t *)(var_68 + 0x8) = 0xc2000000;
    *(int32_t *)(var_68 + 0xc) = 0x0;
    *(var_68 + 0x10) = ___32-[__NSOperationInternal _start:]_block_invoke.95;
    *(var_68 + 0x18) = ___block_descriptor_tmp.98;
    *(var_68 + 0x20) = r12;
    rsi = @selector(_changeValueForKeys:count:maybeOldValuesDict:usingBlock:);
    goto loc_39f11;

    loc_39f19:
    r12->__state = intrinsic_xchg(r12->__state, 0xf0);
    rdi = @class(__NSOperationInternal);
    rsi = @selector(_observeValueForKeyPath:ofObject:changeKind:oldValue:newValue:indexes:context:);
    goto loc_39f54;

    loc_39eb7:
    rax = *_OBJC_IVAR_$___NSOperationInternal.__isExecutingObserverCount;
    goto loc_39ebe;

    loc_39eae:
    rax = *_OBJC_IVAR_$___NSOperationInternal.__isFinishedObserverCount;
    goto loc_39ebe;

    loc_39ea5:
    rax = *_OBJC_IVAR_$___NSOperationInternal.__isReadyObserverCount;
    goto loc_39ebe;

    loc_39c1c:
    r12->__state = intrinsic_xchg(r12->__state, 0xe0);
    rdi = @class(__NSOperationInternal);
    rsi = @selector(_observeValueForKeyPath:ofObject:changeKind:oldValue:newValue:indexes:context:);
    rdx = @"isExecuting";
    goto loc_39c57;

    loc_39bb7:
    rax = *_OBJC_IVAR_$___NSOperationInternal.__isExecutingObserverCount;
    goto loc_39bbe;

    loc_39bae:
    rax = *_OBJC_IVAR_$___NSOperationInternal.__isFinishedObserverCount;
    goto loc_39bbe;

    loc_39ba5:
    rax = *_OBJC_IVAR_$___NSOperationInternal.__isReadyObserverCount;
    goto loc_39bbe;

    loc_39a81:
    var_40 = r13;
    r13 = r12->__queue;
    rbx = @class(NSException);
    __NSMethodExceptionProem(r12, r15);
    rsi = @selector(raise:format:);
    _objc_msgSend(rbx, rsi);
    r13 = var_40;
    goto loc_39adb;

    loc_39adb:
    if ((r14 <= 0x50) && ([r13 isReady] == 0x0)) {
        r12->__state = intrinsic_xchg(r12->__state, r14);
        rbx = r13;
        r13 = *_NSInvalidArgumentException;
        __NSMethodExceptionProem(r12, r15);
        rdx = r13;
        r13 = rbx;
        [NSException raise:rdx format:@"%@: receiver is not yet ready to execute"];
    }
    goto loc_39b41;

    loc_39a3b:
    var_30 = @class(NSException);
    rbx = r13;
    r13 = *_NSInvalidArgumentException;
    __NSMethodExceptionProem(r12, r15);
    rdx = r13;
    r13 = rbx;
    [var_30 raise:rdx format:@"%@: receiver is already executing"];
    goto loc_39a81;
}


@end

@interface NSOperation ()
@end

@implementation NSOperation {

}

- (void)start {

    if (!self->_private) {

    } else {
        [self->_private _start:self];
    }
    return;

}

@end

@interface __NSOperationQueueInternal : NSObject {
@public
    NSString *__name;
}
@property (nonatomic, strong) NSString *_name;
@end

@implementation __NSOperationQueueInternal

@end

@implementation NSOperationQueue

- (instancetype)init {
    self = [super init];
    if (self) {
        rbx = self;
        rax = __NSIsMultiThreaded;
        if (!*__NSIsMultiThreaded) {
            *__NSIsMultiThreaded = YES;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"NSWillBecomeMultiThreadedNotification" object:nil userInfo:nil];
        }

        self->_private = [__NSOperationQueueInternal new];
        self->_private->__queueLock = 0x0;
        self->_private->__maxNumOps = 0xffffffffffffffff;
        self->_private->__actualMaxNumOps = 0x7fffffff;

        ((__NSOperationQueueInternal *)self->_private)->__name = [[NSString stringWithFormat:@"NSOperationQueue %p", self] copy];
        _oq_set_property_qos(self, 0x0);
    }

    return self;
}

- (void)addOperation:(NSOperation *)op {
    r13 = 0x0;
    rbx = op;
    r15 = _cmd;
    r14 = self;
    var_30 = *___stack_chk_guard;
    if ((rbx != 0x0) || (r13 != 0x0)) {
        if ((r13 == 0x0) || ([r13 count] != 0x0)) {
            *var_F8 = 0x0;
            *(var_F8 + 0x8) = var_F8;
            *(int32_t *)(var_F8 + 0x10) = 0x52000000;
            *(int32_t *)(var_F8 + 0x14) = 0x30;
            xmm0 = zero_extend_64(___Block_byref_object_dispose_);
            xmm1 = intrinsic_punpcklqdq(zero_extend_64(___Block_byref_object_copy_), xmm0, 0x52000000, 0x0);
            *(int128_t *)(var_F8 + 0x18) = intrinsic_movdqu(*(int128_t *)(var_F8 + 0x18), xmm1);
            *(var_F8 + 0x28) = 0x0;
            *var_1E0 = 0x0;
            *(var_1E0 + 0x8) = var_1E0;
            *(int32_t *)(var_1E0 + 0x10) = 0x52000000;
            *(int32_t *)(var_1E0 + 0x14) = 0x30;
            *(int128_t *)(var_1E0 + 0x18) = intrinsic_movdqu(*(int128_t *)(var_1E0 + 0x18), xmm1);
            *(var_1E0 + 0x28) = 0x0;
            *var_1B0 = 0x0;
            *(var_1B0 + 0x8) = var_1B0;
            *(int32_t *)(var_1B0 + 0x10) = 0x20000000;
            *(int32_t *)(var_1B0 + 0x14) = 0x20;
            *(var_1B0 + 0x18) = 0x0;
            *var_190 = 0x0;
            *(var_190 + 0x8) = var_190;
            *(int32_t *)(var_190 + 0x10) = 0x20000000;
            *(int32_t *)(var_190 + 0x14) = 0x20;
            *(var_190 + 0x18) = 0x0;
            var_B8 = r14;
            var_C0 = r15;
            var_C8 = rbx;
            if (op) {
                _____addOperations_block_invoke(__NSConcreteStackBlock, op);
            }
            else {
                xmm0 = intrinsic_pxor(xmm0, xmm0);
                *(int128_t *)(var_220 + 0x30) = intrinsic_movdqa(*(int128_t *)(var_220 + 0x30), xmm0);
                *(int128_t *)(var_220 + 0x20) = intrinsic_movdqa(*(int128_t *)(var_220 + 0x20), xmm0);
                *(int128_t *)(var_220 + 0x10) = intrinsic_movdqa(*(int128_t *)(var_220 + 0x10), xmm0);
                *(int128_t *)var_220 = intrinsic_movdqa(*(int128_t *)var_220, xmm0);
                r15 = [r13 countByEnumeratingWithState:rdx objects:var_B0 count:0x10];
                if (r15 != 0x0) {
                    r14 = **(var_220 + 0x10);
                    r12 = __NSConcreteStackBlock;
                    do {
                        rbx = 0x0;
                        do {
                            if (*var_210 != r14) {
                                objc_enumerationMutation(r13);
                            }
                            _____addOperations_block_invoke(r12, *(var_218 + rbx * 0x8));
                            rbx = rbx + 0x1;
                        } while (rbx < r15);
                        r15 = [r13 countByEnumeratingWithState:var_220 objects:var_B0 count:0x10];
                    } while (r15 != 0x0);
                }
            }
            if (*(var_1A8 + 0x18) != 0x0) {
                rdi = *(var_F0 + 0x28);
                if (rdi != 0x0) {
                    r14 = @selector(release);
                    do {
                        rbx = rdi->_private->__nextOp;
                        _op_set_queue_locked(rdi, 0x0);
                        *(var_F0 + 0x28)->_private->__prevOp = 0x0;
                        *(var_F0 + 0x28)->_private->__nextOp = 0x0;
                        rcx = *(var_F0 + 0x28)->_private;
                        rcx->__state = lock intrinsic_cmpxchg(rcx->__state, 0x0);
                        _objc_msgSend(*(var_F0 + 0x28), r14, *_OBJC_IVAR_$___NSOperationInternal.__state, rcx);
                        *(var_F0 + 0x28) = rbx;
                        rdi = rbx;
                    } while (rbx != 0x0);
                }
                if (r13 != 0x0) {
                    r14 = @class(NSException);
                    rbx = __NSMethodExceptionProem(var_B8, var_C0);
                    rdx = *_NSInvalidArgumentException;
                    r9 = *(var_1A8 + 0x18);
                    rax = *(var_188 + 0x18);
                    rax = rax + r9;
                    rcx = " is";
                    rdi = "s are";
                    if (r9 == 0x1) {
                        rdi = rcx;
                    }
                    [r14 raise:rdx format:@"%@: %lu (of %lu) operation%s finished, executing, or already in a queue, and cannot be enqueued"];
                }
                rax = var_C8->_private;
                rax = rax->__state;
                rax = ROL((rax & 0xff) + 0xffffff28, 0x1e);
                if (rax >= 0x8) {
                    rbx = var_B8;
                    r12 = var_C0;
                    if ((rax == 0x0) || (rax == 0x2)) {
                        __NSMethodExceptionProem(rbx, r12);
                        [NSException raise:*_NSInvalidArgumentException format:@"%@: operation is executing and cannot be enqueued"];
                    }
                }
                else {
                    rbx = var_B8;
                    r12 = var_C0;
                    __NSMethodExceptionProem(rbx, r12);
                    [NSException raise:*_NSInvalidArgumentException format:@"%@: operation is finished and cannot be enqueued"];
                    __NSMethodExceptionProem(rbx, r12);
                    [NSException raise:*_NSInvalidArgumentException format:@"%@: operation is executing and cannot be enqueued"];
                }
                r15 = *_NSInvalidArgumentException;
                __NSMethodExceptionProem(rbx, r12);
                [NSException raise:r15 format:@"%@: operation is already enqueued on a queue"];
            }
            else {
                rbx = var_B8;
            }
            os_unfair_lock_lock(rbx->_private + *_OBJC_IVAR_$___NSOperationQueueInternal.__queueLock);
            rax = rbx->_private;
            rax = rax->__pendingLastOperation;
            *(var_F0 + 0x28)->_private->__prevOp = rax;
            rcx = *(var_F0 + 0x28);
            if (rax != 0x0) {
                rax = rax->_private;
                rdx = *_OBJC_IVAR_$___NSOperationInternal.__nextOp;
            }
            else {
                rax = rbx->_private;
                rdx = *_OBJC_IVAR_$___NSOperationQueueInternal.__pendingFirstOperation;
            }
            *(rax + rdx) = rcx;
            rbx->_private->__pendingLastOperation = *(var_1D8 + 0x28);
            os_unfair_lock_unlock(rbx->_private + *_OBJC_IVAR_$___NSOperationQueueInternal.__queueLock);
            if (_oq_has_observer(rbx) != 0x0) {
                [rbx _changeValueForKeys:__NSOperationQueueOperationsAndOperationCountKeys count:0x2 maybeOldValuesDict:0x0 usingBlock:__NSConcreteStackBlock];
            }
            else {
                _____addOperations_block_invoke.621(__NSConcreteStackBlock);
            }
            ___NSOQSchedule(rbx);
            _Block_object_dispose(var_190, 0x8);
            _Block_object_dispose(var_1B0, 0x8);
            _Block_object_dispose(var_1E0, 0x8);
            _Block_object_dispose(var_F8, 0x8);
        }
    }
    rax = *___stack_chk_guard;
    if (rax != var_30) {
        rax = __stack_chk_fail();
    }
    return rax;
}




@end