#include "CA.h"
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

int CA::Transaction::commit_transaction() {
    return 0;
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
