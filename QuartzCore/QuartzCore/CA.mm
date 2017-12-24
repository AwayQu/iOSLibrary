#include "CA.h"
#import "CALayer.h"
#include <pthread.h>
#include <string.h>

static Transaction *CA::Transaction::ensure() {
    void *t = pthread_getspecific(0x48);
    if (t == 0x0) {
        t = CA::Transaction::create();
    }
    return static_cast<Transaction *>(t);
}

int CA::Transaction::unlock() {
    ptr = rdi;
    rax = *(int32_t *) (ptr + 0x20);
    if (rax != 0x0) {
        rax = rax - 0x1;
        *(int32_t *) (ptr + 0x20) = rax;
        if (rax == 0x0) {
            rax = os_unfair_lock_unlock(*(ptr + 0x18));
            rdi = *(ptr + 0x48);
            if (rdi != 0x0) {
                *(ptr + 0x48) = 0x0;
                rax = CA::release_objects(rdi);
            }
        }
    }
    return rax;
}


static Transaction *CA::Transaction::ensure_compat() {
    Transaction *ptr = CA::Transaction::ensure();
    if (((*(int8_t *) (ptr + 0x84) & 0x8) != 0x0)
//            && (*(int32_t *)(*ptr + 0x10) == 0x0)) {
            ) {
        CA::Transaction::ensure_implicit();
    }
    return ptr;
}

/**

void *
     malloc(size_t size);

 void *
     memset(void *b, int c, size_t len);
 DESCRIPTION
     The memset() function writes len bytes of value c (converted to an unsigned char) 
     to the string b.

void dispatch_once_f( dispatch_once_t *predicate, void *context, dispatch_function_t function);
*/

Transaction *CA::Transaction::create() {

    if (*CA::Render::memory_once != 0xffffffffffffffff) {
        // render first initialize
        dispatch_once_f(CA::Render::memory_once, 0x0, CA::Render::init_memory_warnings_(void * ));
    }
    CA::Transaction *ptr = malloc(0x2000);
    if (ptr != 0x0) {
        memset(ptr, 0x0, 0x138);
        if (*CA::Transaction::create()::once != 0xffffffffffffffff) {
            // transaction first initialize
            (CA::Transaction::create()
            ::once, 0x0, CA::Transaction::init());
        }
        pthread_setspecific(0x48, ptr);
        *(int8_t *) (ptr + 0x84) = *(int8_t *) (ptr + 0x84) & 0xfe | (pthread_main_np() != 0x0 ? 0x1 : 0x0);
        *ptr = ptr + 0x88;
        *(ptr + 0x18) = CA::Transaction::transaction_lock;
        *(int8_t *) (ptr + 0x84) = *(int8_t *) (ptr + 0x84) & 0xf7 |
                (_CFExecutableLinkedOnOrAfter(0x3eb) == 0x0 ? 0x1 : 0x0) << 0x3;
        *(int8_t *) (ptr + 0x84) = *(int8_t *) (ptr + 0x84) & 0xef |
                (_CFExecutableLinkedOnOrAfter(0x3f2) == 0x0 ? 0x1 : 0x0) << 0x4;
        rax = *ptr;
        *(int32_t *) rax = 0xffffffff;
        *(int32_t *) (ptr + 0x8) = 0xffffffff;
        *(int32_t *) (rax + 0x58) = 0xffffffff;
    }
    rax = ptr;
    return rax;

}

int CA::Transaction::push(CA::Transaction *) {
    return 0;
}


int CA::Transaction::ensure_implicit() {
    r14 = rdi;
    if (*_initialized != 0xffffffffffffffff) {
        dispatch_once_f(_initialized, 0x0, _init_debug);
    }
    if (*(int8_t *) 0x1dd237 != 0x0) {
        NSLog(@"Started implicit transaction for thread %p\n", pthread_self());
    }
    rdi = *(r14 + 0x60);
    if (rdi == 0x0) {
        rdi = CFRunLoopGetCurrent();
        *(r14 + 0x60) = rdi;
    }
    if (*(r14 + 0x68) == 0x0) goto loc_b8ae0;

    loc_b8a64:
    ptr = CFRunLoopCopyCurrentMode(rdi);
    if (ptr != 0x0) {
        if (ptr != *_kCFRunLoopDefaultMode) {
            if ((*CA::Transaction::ensure_implicit()::tracking_mode == 0x0) && (CFEqual(ptr, @"UITrackingRunLoopMode") != 0x0)) {
                *CA::Transaction::ensure_implicit()
                ::tracking_mode = CFRetain(ptr);
                CFRunLoopAddObserver(*(r14 + 0x60), *(r14 + 0x68), ptr);
            }
            if (ptr != *CA::Transaction::ensure_implicit()::tracking_mode) {
                CFRunLoopAddObserver(*(r14 + 0x60), *(r14 + 0x68), ptr);
            }
        }
        CFRelease(ptr);
    }
    goto loc_b8b2f;

    loc_b8b2f:
    CA::Transaction::push(r14);
    rax = *r14;
    *(int8_t *) (rax + 0x7c) = *(int8_t *) (rax + 0x7c) | 0x1;
    return rax;

    loc_b8ae0:
    rax = CFRunLoopObserverCreate(0x0, 0xa0, 0x1, 0x1e8480, CA::Transaction::observer_callback(__CFRunLoopObserver * , unsigned long, void * ), 0x0);
    *(r14 + 0x68) = rax;
    if (rax == 0x0) goto loc_b8b2f;

    loc_b8b09:
    CFRunLoopAddObserver(*(r14 + 0x60), rax, *_kCFRunLoopCommonModes);
    if (*(r14 + 0x68) == 0x0) goto loc_b8b2f;

    loc_b8b26:
    rdi = *(r14 + 0x60);
    goto loc_b8a64;
}

int CA::Transaction::commit_transaction(CA::Transaction *transaction) {
    var_30 = *___stack_chk_guard;
//    *(var_1188 + 0xfffffffffffffff0) = transaction;
    *var_1200 = 0x10;
    var_11B0 = 0x10;
    r15 = CA::Context::retain_all_contexts(0x1, var_10B0, var_1200);
    r14 = arg0;
    rcx = var_1188;
    rax = CA::Transaction::get_value(*(arg0 + 0x28), 0x5d, 0x12);
    if (LOBYTE(rax) == 0x0) {
        var_1188 = 0x0;
    }
    var_1180 = 0x7ff0000000000000;
    *var_1210 = 0x0;
    rbx = r14;
    rax = CA::Transaction::get_value(*(rbx + 0x28), 0x9f, 0x12);
    LODWORD(rsi) = 0x0;
    rax = CA::Transaction::run_commit_handlers(rbx);
    var_1208 = var_1200;
    var_1138 = rbx;
    if (var_1200 == 0x0) goto loc_8c61a;

    loc_8c070:
    var_11A0 = objc_autoreleasePoolPush();
    var_1148 = rbx + 0x20;
    LODWORD(rcx) = 0x0;
    r13 = _objc_msgSend;
    var_11A8 = r15;
    do {
        var_1150 = rcx;
        r15 = *(r15 + rcx * 0x8);
        var_1190 = r15;
        *(r14 + 0x50) = r15;
        r15 = r15 + 0x10;
        rax = pthread_mutex_lock(r15);
        rax = *(var_1190 + 0x70);
        if (rax != 0x0) {
            r12 = *(rax + *_OBJC_IVAR_$_CALayer._attr + 0x8);
            *(int32_t *)r12 = *(int32_t *)r12 + 0x1;
            rax = pthread_mutex_unlock(r15);
            if (r12 != 0x0) {
                rbx = r14;
                do {
                    rsi = rbx;
                    rax = CA::Layer::layout_if_needed(r12);
                    rcx = sign_extend_64(*(int32_t *)(rbx + 0x8));
                    if (rcx >= 0x0) {
                        LODWORD(rdx) = *(int32_t *)(r12 + rcx * 0x4 + 0x100);
                        if (LODWORD(rdx) != 0x0) {
                            rax = r12 + rcx * 0x4 + 0x100;
                        }
                        else {
                            rsi = rbx;
                            rax = CA::Layer::thread_flags_(r12);
                            LODWORD(rdx) = *(int32_t *)rax;
                        }
                    }
                    else {
                        rsi = rbx;
                        rax = CA::Layer::thread_flags_(r12);
                        LODWORD(rdx) = *(int32_t *)rax;
                    }
                    COND = (HIBYTE(rdx) & 0x3) == 0x0;
                    rdx = var_1148;
                    if (COND) {
                        break;
                    }
                    var_1140 = 0x0;
                    var_1158 = rax;
                    do {
                        var_1030 = 0x0;
                        var_1028 = var_1000;
                        var_1010 = 0x0;
                        xmm0 = intrinsic_movapd(xmm0, *(int128_t *)0x17afa0);
                        var_1020 = intrinsic_movapd(var_1020, xmm0);
                        LODWORD(rax) = *(int32_t *)rdx;
                        *(int32_t *)rdx = LODWORD(rax + 0x1);
                        if (LODWORD(rax) == 0x0) {
                            rax = os_unfair_lock_lock(*(rbx + 0x18));
                        }
                        xmm0 = intrinsic_xorpd(xmm0, xmm0);
                        var_11F0 = intrinsic_movapd(var_11F0, xmm0);
                        var_11D8 = rbx;
                        var_11D0 = 0x0;
                        var_11C8 = 0x20000000100;
                        var_11C0 = 0x0;
                        r14 = rbx;
                        r15 = r12;
                        rsi = var_11F0;
                        rax = CA::Layer::collect_layers_(r12);
                        r12 = var_11F0;
                        rdi = r14;
                        rax = CA::Transaction::unlock();
                        if (0x0 != 0x0) {
                            if (r12 != 0x0) {
                                r14 = @selector(display);
                                do {
                                    r13 = _objc_msgSend;
                                    rax = _objc_msgSend(*(*r12 + 0x10), r14);
                                    *r12 = 0x0;
                                    r12 = *(r12 + 0x8);
                                } while (r12 != 0x0);
                                var_1140 = LODWORD(0x1);
                                r14 = var_1138;
                            }
                            else {
                                var_1140 = LODWORD(0x1);
                            }
                        }
                        var_1030 = 0x0;
                        rax = _x_heap_free(var_1030);
                        rdx = var_1148;
                        r12 = r15;
                        rbx = r14;
                    } while ((*(int8_t *)(var_1158 + 0x1) & 0x3) != 0x0);
                } while ((var_1140 & 0x1) != 0x0);
                r14 = rbx;
                rsi = rbx;
                rax = CA::Layer::prepare_commit(r12);
                *(int32_t *)r12 = lock intrinsic_xadd(*(int32_t *)r12, LODWORD(0xffffffff));
                if (LODWORD(0xffffffff) == 0x1) {
                    rdi = r12;
                    rax = CA::Layer::~Layer();
                    rax = free(r12);
                }
            }
        }
        else {
            rax = pthread_mutex_unlock(r15);
        }
        rcx = var_1150 + 0x1;
        rbx = var_1200;
        r15 = var_11A8;
    } while (rcx < rbx);
    rax = objc_autoreleasePoolPop(var_11A0);
    var_1158 = CA::Context::retain_all_contexts(0x1, var_1130, 0x10);
    if (rbx != 0x0) {
        r14 = r15;
        do {
            LODWORD(rsi) = 0x1;
            rax = CA::Context::unref(*r14);
            r14 = r14 + 0x8;
            rbx = rbx - 0x1;
        } while (rbx != 0x0);
    }
    if (r15 != var_10B0) {
        rax = free(r15);
    }
    rbx = var_1138;
    *(int8_t *)(rbx + 0x84) = *(int8_t *)(rbx + 0x84) | 0x2;
    LODWORD(rsi) = 0x3;
    rax = CA::Transaction::run_commit_handlers(rbx);
    r14 = objc_autoreleasePoolPush();
    rax = *rbx;
    r15 = *(rax + 0x28);
    if (r15 != 0x0) {
        var_1150 = r14;
        *(int32_t *)(rax + 0x58) = 0x5;
        r12 = r15;
        do {
            r14 = *(r12 + 0x10);
            if (r14 != 0x0) {
                *(r12 + 0x10) = 0x0;
                r13 = r14;
                do {
                    rbx = *r13;
                    rax = (*(rbx + 0x10))(rbx);
                    rax = _Block_release(rbx);
                    r13 = *(r13 + 0x8);
                } while (r13 != 0x0);
                do {
                    rbx = *(r14 + 0x8);
                    rax = free(r14);
                    r14 = rbx;
                } while (rbx != 0x0);
            }
            r12 = *r12;
        } while (r12 != 0x0);
        *(int32_t *)(*var_1138 + 0x58) = 0xffffffff;
        *(int32_t *)var_11F0 = 0x0;
        r14 = 0x10;
        var_1140 = 0x0;
        rbx = var_1158;
        do {
            if (r14 != 0x0) {
                LODWORD(r12) = 0x0;
                do {
                    if (LODWORD(*(int32_t *)(*(rbx + r12 * 0x8) + 0x64)) == *(int32_t *)(r15 + 0x8)) {
                        if (var_11F0 == 0x0) {
                            rax = mach_port_allocate(*(int32_t *)_mach_task_self_, 0x1, var_11F0);
                            rax = mach_port_insert_right(*(int32_t *)_mach_task_self_, var_11F0, LODWORD(var_11F0), 0x14);
                            rdi = *(rbx + r12 * 0x8);
                        }
                        rbx = CA::Context::retain_render_ctx();
                        if (rbx != 0x0) {
                            LODWORD(rcx) = *(int32_t *)(r15 + 0xc);
                            if (LODWORD(rcx) != 0x0) {
                                rax = CA::Render::Fence::set(rbx, var_11F0, 0x0, rcx);
                                if (LOBYTE(rax) != 0x0) {
                                    rdi = r15;
                                    var_1140 = var_1140 + (LOBYTE(CA::Transaction::Fence::release_port()) & 0xff);
                                }
                            }
                            rdi = rbx;
                            rax = CA::Render::Object::unref();
                            rbx = var_1158;
                        }
                        else {
                            rbx = var_1158;
                            rcx = *(rbx + r12 * 0x8);
                            LODWORD(rax) = *(int32_t *)(rcx + 0xa4);
                            if (LODWORD(rax) != 0x0) {
                                LODWORD(rdx) = *(int32_t *)(r15 + 0xc);
                                if (LODWORD(rdx) != 0x0) {
                                    rdx = *_NDR_record;
                                    LODWORD(rcx) = *(int32_t *)(rcx + 0x60);
                                    var_1014 = LODWORD(var_11F0);
                                    var_100C = LODWORD(0x130000);
                                    var_1008 = LODWORD(rdx);
                                    var_1000 = LODWORD(0x130000);
                                    var_FFC = *_NDR_record;
                                    var_FF4 = LODWORD(rcx);
                                    var_1030 = 0x80000013;
                                    var_1028 = LODWORD(rax);
                                    xmm0 = intrinsic_movapd(xmm0, *(int128_t *)0x17afb0);
                                    var_1024 = intrinsic_movupd(var_1024, xmm0);
                                    if (_voucher_mach_msg_set != 0x0) {
                                        rax = voucher_mach_msg_set(0x80000013);
                                    }
                                    var_1030 = 0x80000013;
                                    LODWORD(r8) = 0x0;
                                    rax = mach_msg(var_1030, 0x1, 0x40, 0x0, r8, 0x0, 0x0);
                                    rsp = (rsp - 0x10) + 0x10;
                                    if (LODWORD(rax) == 0x0) {
                                        rdi = r15;
                                        var_1140 = var_1140 + (LOBYTE(CA::Transaction::Fence::release_port()) & 0xff);
                                    }
                                }
                            }
                        }
                    }
                    r12 = r12 + 0x1;
                } while (r12 < r14);
            }
            r15 = *r15;
        } while (r15 != 0x0);
        LODWORD(rdi) = var_11F0;
        rbx = var_1138;
        r14 = var_1150;
        r15 = _mach_task_self_;
        if (LODWORD(rdi) != 0x0) {
            var_1188 = 0x0;
            rax = CA::Render::Fence::wait(rdi, var_1140);
            xmm1 = intrinsic_xorpd(xmm1, xmm1);
            xmm1 = intrinsic_ucomisd(xmm1, var_1188);
            if (xmm1 == 0x0) {
                var_1188 = intrinsic_movsd(var_1188, xmm0);
            }
            rax = mach_port_mod_refs(*(int32_t *)_mach_task_self_, var_11F0, 0x1, 0xffffffff);
            rax = mach_port_deallocate(*(int32_t *)_mach_task_self_, var_11F0);
        }
        var_11A0 = LODWORD(0x1);
    }
    else {
        var_11A0 = 0x0;
    }
    LODWORD(rsi) = 0x1;
    rax = CA::Transaction::run_commit_handlers(rbx);
    rax = objc_autoreleasePoolPop(r14);
    xmm0 = intrinsic_xorpd(xmm0, xmm0);
    xmm0 = intrinsic_ucomisd(xmm0, var_1188);
    r14 = var_1158;
    if (xmm0 == 0x0) {
        rax = mach_absolute_time();
        rax = _CATimeWithHostTime(rax, 0x1);
        xmm1 = intrinsic_movapd(xmm1, xmm0);
        xmm0 = intrinsic_movsd(xmm0, var_1210);
        xmm1 = intrinsic_ucomisd(xmm1, xmm0);
        if (xmm1 > 0x0) {
            rax = mach_absolute_time();
            rax = _CATimeWithHostTime(rax, 0x1);
        }
        var_1188 = intrinsic_movsd(var_1188, xmm0);
    }
    if (0x10 == 0x0) goto loc_8cef5;

    loc_8c69c:
    rbx = var_1198;
    var_11F8 = 0x0;
    LODWORD(rax) = 0x0;
    goto loc_8c6ca;

    loc_8c6ca:
    var_1150 = rax;
    rdi = *(r14 + rax * 0x8);
    var_1190 = rdi;
    var_1160 = 0x0;
    *(var_1178 + 0x8) = 0x0;
    *var_1178 = 0x0;
    var_1140 = rdi + 0x10;
    rax = pthread_mutex_lock(rdi + 0x10);
    rcx = var_1190;
    *(var_1138 + 0x50) = rcx;
    *(rcx + 0xc0) = rbx;
    LODWORD(rax) = *(int32_t *)(var_1138 + 0x20);
    *(int32_t *)(var_1138 + 0x20) = LODWORD(rax + 0x1);
    if (LODWORD(rax) == 0x0) {
        rax = os_unfair_lock_lock(*(var_1138 + 0x18));
        rcx = var_1190;
    }
    rdi = *(rcx + 0x78);
    if (rdi != 0x0) {
        var_1170 = rdi;
        LODWORD(rsi) = 0x0;
        rax = CA::Render::Context::will_commit(rdi);
        rcx = var_1190;
    }
    if ((*(int32_t *)(rcx + 0xa4) != 0x0) && ((*(int8_t *)(rcx + 0xd8) & 0x1) == 0x0)) {
        rdi = var_11F8;
        if (rdi == 0x0) {
            rdi = rsp + 0xffffffffffff8000;
            rsp = rdi;
        }
        *rdi = 0x0;
        *(rdi + 0x8) = rdi + 0x30;
        *(int8_t *)(rdi + 0x20) = 0x0;
        xmm0 = intrinsic_movaps(xmm0, *(int128_t *)0x17afc0);
        *(int128_t *)(rdi + 0x10) = intrinsic_movups(*(int128_t *)(rdi + 0x10), xmm0);
        r13 = rdi;
        rbx = _x_heap_malloc_small_(rdi, 0x80);
        LODWORD(rcx) = *(int32_t *)(var_1190 + 0x60);
        xmm0 = intrinsic_movsd(xmm0, var_1188);
        rsi = r13;
        rax = CA::Render::Encoder::Encoder(rbx, rsi, var_1190, rcx, xmm0);
        var_1178 = rbx;
        r15 = *(var_1190 + 0xa8);
        if (r15 == 0x0) {
            r15 = malloc_zone_malloc(_get_malloc_zone(0x20, rsi), 0x20);
            LODWORD(r8) = 0x0;
            *r15 = _x_hash_table_new_(0x0, 0x0, 0x0, 0x0, r8);
            *(r15 + 0x18) = 0x0;
            *(r15 + 0x10) = 0x0;
            *(r15 + 0x8) = 0x0;
            rax = os_unfair_lock_lock(CA::Render::Encoder::ObjectCache::_lock);
            rbx = *CA::Render::Encoder::ObjectCache::_cache_list;
            rax = _get_malloc_zone(0x10, 0x0);
            rax = malloc_zone_malloc(rax, 0x10);
            *(rax + 0x8) = rbx;
            *rax = r15;
            *CA::Render::Encoder::ObjectCache::_cache_list = rax;
            rax = os_unfair_lock_unlock(CA::Render::Encoder::ObjectCache::_lock);
            *(var_1190 + 0xa8) = r15;
            rbx = var_1178;
        }
        rsi = r15;
        rax = CA::Render::Encoder::set_object_cache(rbx);
        rcx = var_1190;
        var_11F8 = r13;
        var_11A8 = r13;
    }
    else {
        var_11A8 = 0x0;
    }
    rsi = var_1148;
    if ((*(int8_t *)(rcx + 0xd8) & 0x10) == 0x0) goto loc_8c948;

    loc_8c8cb:
    rdi = *(rcx + 0x78);
    if (rdi != 0x0) {
        rsi = *(rcx + 0x80);
        rax = CA::Render::Context::set_colorspace(rdi);
    }
    rbx = var_1178;
    if (rbx == 0x0) goto loc_8c933;

    loc_8c8ec:
    r15 = *(var_1190 + 0x80);
    rax = *(rbx + 0x18);
    if (rax + 0x1 <= *(rbx + 0x20)) goto loc_8c91d;

    loc_8c908:
    LODWORD(rsi) = 0x1;
    rax = CA::Render::Encoder::grow(rbx);
    if (LOBYTE(rax) == 0x0) goto loc_8c928;

    loc_8c919:
    rax = *(rbx + 0x18);
    goto loc_8c91d;

    loc_8c91d:
    *(rbx + 0x18) = rax + 0x1;
    *(int8_t *)rax = 0x8;
    goto loc_8c928;

    loc_8c928:
    rsi = r15;
    rax = CA::Render::Encoder::encode_colorspace(rbx);
    goto loc_8c933;

    loc_8c933:
    rcx = var_1190;
    *(int8_t *)(rcx + 0xd8) = *(int8_t *)(rcx + 0xd8) & 0xef;
    rsi = var_1148;
    goto loc_8c948;

    loc_8c948:
    rax = var_1178;
    if (rax != 0x0) {
        *(rax + 0x58) = *(rcx + 0x80);
    }
    rbx = *(var_1138 + 0x40);
    if (rbx != 0x0) {
        LODWORD(r13) = *(int32_t *)(rcx + 0x64);
        do {
            LODWORD(rax) = *(int32_t *)(rbx + 0x14);
            if ((LODWORD(rax) == 0x0) || (LODWORD(rax) == LODWORD(r13))) {
                r12 = *(rbx + 0x8);
                LODWORD(r15) = *(int32_t *)(rbx + 0x10);
                rdi = var_1170;
                if (rdi != 0x0) {
                    LODWORD(rdx) = LODWORD(r15);
                    rax = CA::Render::Context::delete_object(rdi, r12);
                }
                rdi = var_1178;
                if (rdi != 0x0) {
                    rax = CA::Render::encode_delete_object(rdi, r12, LODWORD(r15));
                }
            }
            rbx = *rbx;
        } while (rbx != 0x0);
        rcx = var_1190;
        rsi = var_1148;
    }
    rbx = *(var_1138 + 0x38);
    r13 = var_1198;
    if (rbx != 0x0) {
        LODWORD(r15) = *(int32_t *)(rcx + 0x64);
        do {
            LODWORD(rax) = *(int32_t *)(rbx + 0x20);
            if ((LODWORD(rax) == 0x0) || (LODWORD(rax) == LODWORD(r15))) {
                rax = CA::Context::commit_command(*(int32_t *)(rbx + 0x8), *(rbx + 0x10), *(rbx + 0x18), r13);
                rsi = rsi;
            }
            rbx = *rbx;
        } while (rbx != 0x0);
        rcx = var_1190;
    }
    rax = *(rcx + 0x70);
    if (rax != 0x0) {
        r15 = *(rax + *_OBJC_IVAR_$_CALayer._attr + 0x8);
        if (r15 != 0x0) {
            LOBYTE(rbx) = 0x1;
            rax = CA::Layer::commit_if_needed(r15, var_1138, r13);
        }
        else {
            LODWORD(rbx) = 0x0;
            LODWORD(r15) = 0x0;
        }
    }
    else {
        LODWORD(rbx) = 0x0;
        LODWORD(r15) = 0x0;
    }
    rdi = *(var_1138 + 0x58);
    if (rdi != 0x0) {
        var_1030 = CA::Context::commit_root(CA::Layer*, void*);
        var_1028 = r13;
        rax = _x_hash_table_foreach(rdi, CA::foreach_callback(CA::Layer*, CA::Layer*, void*), var_1030);
    }
    if (LOBYTE(rbx) != 0x0) {
        xmm0 = intrinsic_movsd(xmm0, var_1188);
        var_1218 = 0x3f800000;
        rdx = var_1138;
        rax = CA::Layer::collect_animations_(xmm0, r15, 0x7ff0000000000000);
    }
    rax = *var_1138;
    if ((*(int8_t *)(rax + 0x7c) & 0x4) == 0x0) goto loc_8cb32;

    loc_8cad2:
    LODWORD(r15) = *(int32_t *)(rax + 0x78);
    rax = var_1170;
    if (rax != 0x0) {
        *(int32_t *)(rax + 0x100) = LODWORD(r15);
    }
    rbx = var_1178;
    if (rbx == 0x0) goto loc_8cc54;

    loc_8caf9:
    rax = *(rbx + 0x18);
    if (rax + 0x1 <= *(rbx + 0x20)) goto loc_8cb1c;

    loc_8cb07:
    LODWORD(rsi) = 0x1;
    rax = CA::Render::Encoder::grow(rbx);
    if (LOBYTE(rax) == 0x0) goto loc_8cb27;

    loc_8cb18:
    rax = *(rbx + 0x18);
    goto loc_8cb1c;

    loc_8cb1c:
    *(rbx + 0x18) = rax + 0x1;
    *(int8_t *)rax = 0x19;
    goto loc_8cb27;

    loc_8cb27:
    LODWORD(rsi) = LODWORD(r15);
    rax = CA::Render::Encoder::encode_int32(rbx);
    goto loc_8cb32;

    loc_8cb32:
    rax = var_1178;
    if ((rax == 0x0) || (*(rax + 0x18) - *(rax + 0x10) == *(rax + 0x60))) goto loc_8cc54;

    loc_8cb54:
    var_11F0 = LOBYTE(0x0);
    rcx = var_11F0;
    rax = CA::Transaction::get_value(*(var_1138 + 0x28), 0x133, 0x7);
    if (var_11F0 == LOBYTE(0x0)) goto loc_8cc54;

    loc_8cb89:
    rax = pthread_main_np();
    LOBYTE(rax) = LOBYTE(LODWORD(rax) == 0x0 ? 0x1 : 0x0) | var_11A0;
    if (LOBYTE(rax) != 0x0) goto loc_8cc4d;

    loc_8cb9f:
    LOBYTE(rax) = *(int8_t *)_x_cpu_has_64bit.initialized;
    if (LOBYTE(rax) == 0x0) {
        var_1030 = 0x4;
        LODWORD(r8) = 0x0;
        rax = sysctlbyname("hw.cpu64bit_capable", _x_cpu_has_64bit.has_64_bit, var_1030, 0x0, r8);
        *(int8_t *)_x_cpu_has_64bit.initialized = 0x1;
    }
    if (*(int32_t *)_x_cpu_has_64bit.has_64_bit == 0x0) goto loc_8cc4d;

    loc_8cbe3:
    if (var_11F0 == 0x0) goto loc_8cc54;

    loc_8cbec:
    rbx = var_1178;
    rax = *(rbx + 0x18);
    if (rax + 0x1 <= *(rbx + 0x20)) goto loc_8cc16;

    loc_8cc01:
    LODWORD(rsi) = 0x1;
    rax = CA::Render::Encoder::grow(rbx);
    if (LOBYTE(rax) == 0x0) goto loc_8cc21;

    loc_8cc12:
    rax = *(rbx + 0x18);
    goto loc_8cc16;

    loc_8cc16:
    *(rbx + 0x18) = rax + 0x1;
    *(int8_t *)rax = 0x18;
    goto loc_8cc21;

    loc_8cc21:
    if (*_initialized != 0xffffffffffffffff) {
        rax = dispatch_once_f(_initialized, 0x0, _init_debug);
    }
    if (*(int8_t *)0x1dd26a != 0x0) {
        LODWORD(r8) = 0x0;
        rax = kdebug_trace(0x31ca0100, 0x0, 0x0, 0x0, r8);
    }
    goto loc_8cc54;

    loc_8cc54:
    rcx = var_1030;
    rax = CA::Transaction::get_value(*(var_1138 + 0x28), 0x10a, 0x12);
    if (LOBYTE(rax) == 0x0) goto loc_8cced;

    loc_8cc79:
    if (var_1170 != 0x0) {
        xmm0 = intrinsic_movsd(xmm0, var_1030);
        rax = CA::Render::Context::add_input_time(xmm0);
    }
    rbx = var_1178;
    if (rbx == 0x0) goto loc_8cced;

    loc_8cc9e:
    rax = *(rbx + 0x18);
    if (rax - *(rbx + 0x10) == *(rbx + 0x60)) goto loc_8cced;

    loc_8ccaf:
    r15 = var_1030;
    if (rax + 0x1 <= *(rbx + 0x20)) goto loc_8ccd7;

    loc_8ccc2:
    LODWORD(rsi) = 0x1;
    rax = CA::Render::Encoder::grow(rbx);
    if (LOBYTE(rax) == 0x0) goto loc_8cce2;

    loc_8ccd3:
    rax = *(rbx + 0x18);
    goto loc_8ccd7;

    loc_8ccd7:
    *(rbx + 0x18) = rax + 0x1;
    *(int8_t *)rax = 0x17;
    goto loc_8cce2;

    loc_8cce2:
    rsi = r15;
    rax = CA::Render::Encoder::encode_int64(rbx);
    goto loc_8cced;

    loc_8cced:
    rdi = var_1138;
    rax = CA::Transaction::unlock();
    r14 = var_1158;
    rax = var_1170;
    if (rax != 0x0) {
        *(int32_t *)(rax + 0x8) = *(int32_t *)(rax + 0x8) & 0xfffeffff;
    }
    rdi = var_1178;
    if (rdi != 0x0) {
        LODWORD(r15) = 0x0;
        if (LOBYTE(LOBYTE(*(rdi + 0x18) - *(rdi + 0x10) != *(rdi + 0x60) ? 0x1 : 0x0) | var_11A0) == 0x1) {
            if (*(int8_t *)(rdi + 0x68) != 0x0) {
                LODWORD(r15) = LODWORD(mig_get_reply_port());
                rdi = var_1178;
            }
            else {
                LODWORD(r15) = 0x0;
            }
            LODWORD(rdx) = LODWORD(r15);
            LODWORD(r13) = LODWORD(CA::Render::Encoder::send_message(rdi, *(int32_t *)(var_1190 + 0xa4)));
            rax = var_1190;
            if (LODWORD(r13) == 0x10000003) {
                *(int8_t *)(rax + 0xd8) = *(int8_t *)(rax + 0xd8) | 0x1;
            }
            *(int32_t *)(rax + 0x98) = *(int32_t *)(rax + 0x98) + 0x1;
            rdi = var_1178;
        }
        else {
            LODWORD(r13) = 0x0;
        }
        *(rdi + 0x58) = 0x0;
    }
    else {
        LODWORD(r15) = 0x0;
        LODWORD(r13) = 0x0;
    }
    *(var_1138 + 0x50) = 0x0;
    rdi = var_1190;
    *(rdi + 0xc0) = 0x0;
    rax = var_1170;
    if (rax != 0x0) {
        LODWORD(rcx) = *(int32_t *)(rax + 0x1c);
        *(int32_t *)(rax + 0x1c) = LODWORD(LODWORD(rcx) + 0x1);
        *(int32_t *)(rdi + 0x98) = LODWORD(LODWORD(rcx) + 0x1);
        LODWORD(rcx) = 0x0;
        rax = CA::Render::Context::did_commit(rax, 0x0 & 0xff, 0x0);
        rdi = var_1190;
    }
    LOBYTE(rax) = *(int8_t *)(rdi + 0xd8);
    *(int8_t *)(rdi + 0xd8) = LOBYTE(LOBYTE(LODWORD(rax)) & 0xfb);
    if ((LOBYTE(rax) & 0x8) != 0x0) {
        rax = CA::Context::destroy();
    }
    rax = pthread_mutex_unlock(var_1140);
    if (var_1178 != 0x0) {
        if (LODWORD(r15) != 0x0) {
            if (LODWORD(r13) == 0x0) {
                LODWORD(r8) = LODWORD(r15);
                rsp = (rsp - 0x10) + 0x10;
                LODWORD(r13) = LODWORD(mach_msg(var_1030, 0x2, 0x0, 0x5c, r8, 0x0, 0x0));
                if (LODWORD(r13) == 0x10000003) {
                    *(int8_t *)(var_1190 + 0xd8) = *(int8_t *)(var_1190 + 0xd8) | 0x1;
                    rax = mig_put_reply_port(LODWORD(r15));
                }
                else {
                    LODWORD(r13) = LODWORD(r13) + 0xeffffffe;
                    if ((LODWORD(r13) <= 0xe) && (!(BIT_TEST(LODWORD(0x4003), LODWORD(r13))))) {
                        rax = mig_put_reply_port(LODWORD(r15));
                    }
                    else {
                        rax = mig_dealloc_reply_port(LODWORD(r15));
                    }
                }
            }
            else {
                LODWORD(r13) = LODWORD(r13) + 0xeffffffe;
                if ((LODWORD(r13) <= 0xe) && (!(BIT_TEST(LODWORD(0x4003), LODWORD(r13))))) {
                    rax = mig_put_reply_port(LODWORD(r15));
                }
                else {
                    rax = mig_dealloc_reply_port(LODWORD(r15));
                }
            }
            rdi = var_1178;
        }
        rax = CA::Render::Encoder::~Encoder();
    }
    rdi = var_11A8;
    if (rdi != 0x0) {
        rax = _x_heap_free(rdi);
    }
    LODWORD(rsi) = 0x1;
    rax = CA::Context::unref(var_1190);
    rax = var_1150 + 0x1;
    rbx = var_1198;
    if (rax < 0x10) goto loc_8c6ca;

    loc_8cef5:
    if (r14 != var_1130) {
        rax = free(r14);
    }
    r14 = var_1138;
    rdx = var_1148;
    goto loc_8cf17;

    loc_8cf17:
    LODWORD(rax) = *(int32_t *)rdx;
    LODWORD(rcx) = rax + 0x1;
    *(int32_t *)rdx = LODWORD(rcx);
    if (LODWORD(rax) == 0x0) {
        rax = os_unfair_lock_lock(*(r14 + 0x18));
    }
    rbx = *(r14 + 0x78);
    if (rbx != 0x0) {
        r15 = @selector(layerDidBecomeVisible:);
        LODWORD(r12) = 0x10000;
        r13 = _objc_msgSend;
        do {
            r14 = *rbx;
            if (r14 != 0x0) {
                r13 = _objc_msgSend;
                rdi = *(r14 + 0x10);
                LODWORD(rdx) = *(int32_t *)(r14 + 0x30);
                LODWORD(rdx) = LODWORD(LODWORD(rdx) & LODWORD(0x10000)) >> 0x10;
                rax = _objc_msgSend(rdi, r15, rdx);
                *(int32_t *)r14 = lock intrinsic_xadd(*(int32_t *)r14, LODWORD(0xffffffff));
                if (LODWORD(0xffffffff) == 0x1) {
                    rdi = r14;
                    rax = CA::Layer::~Layer();
                    rax = free(r14);
                }
            }
            rbx = *(rbx + 0x8);
        } while (rbx != 0x0);
        r14 = var_1138;
        rdi = *(r14 + 0x78);
        if (rdi != 0x0) {
            do {
                rbx = *(rdi + 0x8);
                rax = free(rdi);
                rdi = rbx;
            } while (rbx != 0x0);
        }
        *(r14 + 0x78) = 0x0;
    }
    rdi = r14;
    rax = CA::Transaction::unlock();
    if (var_1208 == 0x0) {
        LODWORD(rsi) = 0x3;
        rax = CA::Transaction::run_commit_handlers(r14);
        LODWORD(rsi) = 0x1;
        rax = CA::Transaction::run_commit_handlers(r14);
    }
    LODWORD(rsi) = 0x2;
    rax = CA::Transaction::run_commit_handlers(r14);
    xmm0 = intrinsic_movsd(xmm0, var_1188);
    xmm1 = intrinsic_xorpd(xmm1, xmm1);
    xmm1 = intrinsic_ucomisd(xmm1, xmm0);
    if (xmm1 == 0x0) {
        rax = mach_absolute_time();
        rax = _CATimeWithHostTime(rax, 0x2);
        var_1188 = intrinsic_movsd(var_1188, xmm0);
    }
    rax = CA::Layer::set_next_animation_time(r14, xmm0, intrinsic_movsd(xmm1, 0x7ff0000000000000));
    xmm0 = intrinsic_movsd(xmm0, var_1188);
    *(int32_t *)0x1dd400 = *(int32_t *)0x1dd400 + 0x1;
    rax = _CAMarkStatistic(r14, 0x2, rdx, rcx, r8, 0x0);
    if (*buffer_list != 0x0) {
        LODWORD(rax) = 0x0;
        *(int32_t *)pending_async_collect = lock intrinsic_cmpxchg(*(int32_t *)pending_async_collect, LODWORD(0x1));
        if (*(int32_t *)pending_async_collect == 0x0) {
            rax = CA::DispatchGroup::enqueue(async_collect_callback(void*), 0x0);
        }
    }
    rax = *___stack_chk_guard;
    if (rax == var_30) {
        rbx = stack[2622];
        r12 = stack[2623];
        r13 = stack[2624];
        r14 = stack[2625];
        r15 = stack[2626];
        rsp = var_28 + 0x30;
        rbp = stack[2627];
    }
    else {
        rax = __stack_chk_fail();
    }
    return rax;

    loc_8cc4d:
    var_11F0 = 0x0;
    goto loc_8cc54;

    loc_8c61a:
    rdx = rbx + 0x20;
    r14 = rbx;
    goto loc_8cf17;
}

int CA::Transaction::flush_transaction() {
    return 0;
}


int32_t *CA::Layer::class_state(void *) {
    var_38 = arg0;
    rax = classDescription(arg0);
    if (rax == 0x0) goto loc_108948;

    loc_10893b:
    rdx = *(rax + 0x70);
    if (rdx != 0x0) goto loc_108c96;

    loc_108948:
    var_60 = @selector(class);
    var_58 = @selector(_hasRenderLayerSubclass);
    goto loc_108971;

    loc_108971:
    rbx = malloc_zone_malloc(_get_malloc_zone(0x60, rsi), 0x60);
    *(rbx + 0x8) = 0x0;
    *rbx = 0x0;
    *(int32_t *) (rbx + 0x10) = 0x0;
    *(rbx + 0x58) = 0x0;
    *(rbx + 0x50) = 0x0;
    *(rbx + 0x48) = 0x0;
    *(rbx + 0x40) = 0x0;
    *(rbx + 0x38) = 0x0;
    *(rbx + 0x30) = 0x0;
    *(rbx + 0x28) = 0x0;
    *(rbx + 0x20) = 0x0;
    *(rbx + 0x18) = 0x0;
    *(int32_t *) (rbx + 0xc) = 0x4;
    *(int32_t *) (rbx + 0x4) = 0x7fc8;
    rax = bool_bits;
    rdx = 0x0;
    do {
        if (!(BIT_TEST(0x811220a8, rdx))) {
            rcx = *(int32_t *) rax;
            *(int32_t *) (rbx + (SAR(rcx, 0x5)) * 0x4 + 0x4) = *(int32_t *) (rbx + (SAR(rcx, 0x5)) * 0x4 + 0x4) |
                    0x1 << rcx;
        }
        rdx = rdx + 0x1;
        rax = rax + 0x20;
    } while (rdx != 0x20);
    var_30 = rbx;
    rax = classDescription(var_38);
    if ((rax != 0x0) && (*(int8_t *) (rax + 0x7a) != 0x0)) {
        *(int8_t *) (var_30 + 0xc) = *(int8_t *) (var_30 + 0xc) | 0x40;
    }
    rax = classDescription(var_38);
    if ((rax != 0x0) && (*(int8_t *) (rax + 0x79) != 0x0)) {
        *(int8_t *) (var_30 + 0xc) = *(int8_t *) (var_30 + 0xc) | 0x80;
    }
    *(int32_t *) var_30 = *(int32_t *) var_30 | CA::Layer::State::fetch_defaults(var_30, CA::Transaction::ensure(), fetchDefault(void * , unsigned int, _CAValueType, void * ));
    rax = _objc_msgSend(@class(CALayer), var_60);
    var_70 = rax;
    if (rax == var_38) goto loc_108b2a;

    loc_108a78:
    var_48 = 0x0;
    rax = 0x0;
    goto loc_108a80;

    loc_108a80:
    rcx = rax << 0x4;
    r14 = *(rcx + 0x1b99f8);
    if (*(int8_t *) r14 == 0x0) goto loc_108b1b;

    loc_108a96:
    var_68 = rcx;
    var_50 = rax;
    r15 = @selector(instanceMethodForSelector:);
    goto loc_108aa5;

    loc_108aa5:
    r12 = sel_registerName(r14);
    if ((r12 == 0x0) || (_objc_msgSend(var_38, r15) == _objc_msgSend(var_70, r15))) goto loc_108ade;

    loc_108afd:
    var_48 = var_48 | *(int32_t *) (var_68 + CA::Layer::changed_flags_for_class(objc_class * )
    ::changed_flags);
    goto loc_108b17;

    loc_108b17:
    rax = var_50;
    goto loc_108b1b;

    loc_108b1b:
    rax = rax + 0x1;
    if (rax != 0xf) goto loc_108a80;

    loc_108b30:
    rsi = var_58;
    rdx = var_48;
    rcx = rdx | 0x10000;
    if (_objc_msgSend(var_38, rsi) == 0x0) {
        rcx = rdx;
    }
    rcx = rcx | *(int32_t *) var_30;
    *(int32_t *) var_30 = rcx;
    if (rcx >= 0x0) {
        rsi = 0x2a;
        _CAObject_defaultValueForAtom(var_38, rsi, 0x1, var_40);
        rax = var_30;
        if (var_40 == 0x0) {
            rsi = 0x36;
            _CAObject_defaultValueForAtom(var_38, rsi, 0x1, var_40);
            rax = var_30;
            if (var_40 != 0x0) {
                *(int8_t *) (rax + 0x1) = *(int8_t *) (rax + 0x1) | 0x80;
            }
        } else {
            *(int8_t *) (rax + 0x1) = *(int8_t *) (rax + 0x1) | 0x80;
        }
        rcx = *(int32_t *) rax;
    }
    if ((rcx & 0x20) == 0x0) {
        rsi = 0x19d;
        _CAObject_defaultValueForAtom(var_38, rsi, 0x1, var_40);
        rax = var_30;
        if (var_40 != 0x0) {
            *(int8_t *) (rax + 0x1) = *(int8_t *) (rax + 0x1) | 0x20;
        }
    }
    rcx = classDescription(var_38);
    if (rcx == 0x0) goto loc_108c0f;

    loc_108bee:
    rcx = rcx + 0x70;
    rdx = var_30;
    goto loc_108bf6;

    loc_108bf6:
    if (*rcx != 0x0) goto loc_108c0a;

    loc_108bfc:
    *rcx = lock
    intrinsic_cmpxchg(*rcx, rdx);
    if (*rcx != 0x0) goto loc_108bf6;

    loc_108c96:
    rax = rdx;
    return rax;

    loc_108c0a:
    if (rdx != 0x0) {
        r13 = CA::Transaction::ensure();
        rax = var_30;
        rsi = *(rax + 0x50);
        if (rsi != 0x0) {
            CA::Transaction::release_object(r13);
            rax = var_30;
        }
        if (*(rax + 0x58) != 0x0) {
            rax = *(int32_t *) (r13 + 0x20);
            *(int32_t *) (r13 + 0x20) = rax + 0x1;
            if (rax == 0x0) {
                os_unfair_lock_lock(*(r13 + 0x18));
                if (*(var_30 + 0x58) != 0x0) {
                    CA::AttrList::free();
                }
            } else {
                CA::AttrList::free();
            }
            CA::Transaction::unlock();
            rax = var_30;
        }
        free(rax);
    }
    goto loc_108c77;

    loc_108c77:
    rax = classDescription(var_38);
    if (rax == 0x0) goto loc_108971;

    loc_108c89:
    rdx = *(rax + 0x70);
    if (rdx == 0x0) goto loc_108971;
    goto loc_108c96;

    loc_108c0f:
    r13 = CA::Transaction::ensure();
    rax = var_30;
    rsi = *(rax + 0x50);
    if (rsi != 0x0) {
        CA::Transaction::release_object(r13);
        rax = var_30;
    }
    if (*(rax + 0x58) != 0x0) {
        rax = *(int32_t *) (r13 + 0x20);
        *(int32_t *) (r13 + 0x20) = rax + 0x1;
        if (rax == 0x0) {
            os_unfair_lock_lock(*(r13 + 0x18));
            if (*(var_30 + 0x58) != 0x0) {
                CA::AttrList::free();
            }
        } else {
            CA::AttrList::free();
        }
        CA::Transaction::unlock();
        rax = var_30;
    }
    free(rax);
    goto loc_108c77;

    loc_108ade:
    r14 = r14 + strlen(r14) + 0x1;
    if (*(int8_t *) r14 != 0x0) goto loc_108aa5;
    goto loc_108b17;

    loc_108b2a:
    var_48 = 0x0;
    goto loc_108b30;
    return 0;
}

int32_t CA::Layer::layout_if_needed(CA::Transaction *transaction) {
    return 0;
}

int32_t CA::Layer::thread_flags_(CA::Transaction *transaction) {
    return 0;
}

int32_t CA::Layer::invalidate_layout() {
    rax = *(rdi + 0x80);
    if (rax == 0x0) goto .l1;

    loc_104c6c:
    rax = *rax;
    if (rax == 0x0) goto .l1;

    loc_104c79:
    rdx = *(int32_t *)(rax + 0x8);
    if ((rdx & 0xffffff) == 0x1a9) goto loc_104c90;

    loc_104c86:
    rax = *rax;
    if (rax != 0x0) goto loc_104c79;

    .l1:
    return rax;

    loc_104c90:
    rdi = *(rdi + 0x10);
    intrinsic_movsd(xmm0, *_CGSizeZero);
    intrinsic_movsd(xmm1, *_CTFontCopyGraphicsFont);
    rax = [rdi setSizeRequisition:rdx];
    return rax;
}

int CA::Layer::set_bit(CA::Layer *arg0, unsigned int arg1, unsigned int arg2, bool arg3, void (*arg4)(CA::Transaction *)) {
    return 0;
}


