#include "CA.h"
#include <pthread.h>
#include <string.h>
int CA::Transaction::ensure() {
    int t = pthread_getspecific(0x48);
    if (t == 0x0) {
        t = CA::Transaction::create();
    }
    return t;
}

int CA::Transaction::unlock() {
    ptr = rdi;
    rax = *(int32_t *)(ptr + 0x20);
    if (rax != 0x0) {
            rax = rax - 0x1;
            *(int32_t *)(ptr + 0x20) = rax;
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


int CA::Transaction::ensure_compat() {
    ptr = CA::Transaction::ensure();
    if (((*(int8_t *)(ptr + 0x84) & 0x8) != 0x0) && (*(int32_t *)(*ptr + 0x10) == 0x0)) {
            CA::Transaction::ensure_implicit();
    }
    rax = ptr;
    return rax;
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

int CA::Transaction::create() {

  if (*CA::Render::memory_once != 0xffffffffffffffff) {
            // render first initialize
            dispatch_once_f(CA::Render::memory_once, 0x0, CA::Render::init_memory_warnings_(void*));
    }
    (void *)ptr = malloc(0x2000);
    if (ptr != 0x0) {
            memset(ptr, 0x0, 0x138);
            if (*CA::Transaction::create()::once != 0xffffffffffffffff) {
                    // transaction first initialize
                    (CA::Transaction::create()::once, 0x0, CA::Transaction::init());
            }
            pthread_setspecific(0x48, ptr);
            *(int8_t *)(ptr + 0x84) = *(int8_t *)(ptr + 0x84) & 0xfe | (pthread_main_np() != 0x0 ? 0x1 : 0x0);
            *ptr = ptr + 0x88;
            *(ptr + 0x18) = CA::Transaction::transaction_lock;
            *(int8_t *)(ptr + 0x84) = *(int8_t *)(ptr + 0x84) & 0xf7 | (_CFExecutableLinkedOnOrAfter(0x3eb) == 0x0 ? 0x1 : 0x0) << 0x3;
            *(int8_t *)(ptr + 0x84) = *(int8_t *)(ptr + 0x84) & 0xef | (_CFExecutableLinkedOnOrAfter(0x3f2) == 0x0 ? 0x1 : 0x0) << 0x4;
            rax = *ptr;
            *(int32_t *)rax = 0xffffffff;
            *(int32_t *)(ptr + 0x8) = 0xffffffff;
            *(int32_t *)(rax + 0x58) = 0xffffffff;
    }
    rax = ptr;
    return rax;

}


int CA::Transaction::ensure_implicit() {
    r14 = rdi;
    if (*_initialized != 0xffffffffffffffff) {
            dispatch_once_f(_initialized, 0x0, _init_debug);
    }
    if (*(int8_t *)0x1dd237 != 0x0) {
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
                            *CA::Transaction::ensure_implicit()::tracking_mode = CFRetain(ptr);
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
    *(int8_t *)(rax + 0x7c) = *(int8_t *)(rax + 0x7c) | 0x1;
    return rax;

loc_b8ae0:
    rax = CFRunLoopObserverCreate(0x0, 0xa0, 0x1, 0x1e8480, CA::Transaction::observer_callback(__CFRunLoopObserver*, unsigned long, void*), 0x0);
    *(r14 + 0x68) = rax;
    if (rax == 0x0) goto loc_b8b2f;

loc_b8b09:
    CFRunLoopAddObserver(*(r14 + 0x60), rax, *_kCFRunLoopCommonModes);
    if (*(r14 + 0x68) == 0x0) goto loc_b8b2f;

loc_b8b26:
    rdi = *(r14 + 0x60);
    goto loc_b8a64;
}