//
// Created by Away on 25/12/2017.
// Copyright (c) 2017 Away. All rights reserved.
//

#import <new>
#import <pthread.h>
#import "CADisplayLink.h"
#import "CADisplay.h"

@interface CADisplayLink ()
@end

@implementation CADisplayLink {

}

- (CADisplay *)display {
    return (__bridge CADisplayLink *) (self->_impl + 0x8);
}


+ (id)displayLinkWithTarget:(id)target selector:(SEL)sel {
    CADisplay *mainDisplay = [CADisplay mainDisplay];
    if (mainDisplay) {
        return [self displayLinkWithDisplay:mainDisplay target:target selector:sel];
    } else {
        return nil;
    }
}

+ (id)displayLinkWithDisplay:(id)display target:(id)target selector:(SEL)sel {
    void *newValue = operator new(0xe8, _cmd, display, target, sel);
    void *impl = self->_impl;
    int8_t rcx;
    CFTypeRef rax;
    if (target) {
        rax = CFRetain(target);
        int8_t rcx = *(int8_t *) (newValue + 0xe4) & 0xfc;
    } else {
        rcx = 0x0;
        rax = 0x0;
    }

    *(newValue + 0x8) = rax;
    *(newValue + 0x10) = sel;
    *(newValue + 0x18) = 0x0;
    *(int32_t *) (newValue + 0x24) = 0x0;
    *(newValue + 0xd8) = 0x0;
    *(newValue + 0xd0) = 0x0;
    *(newValue + 0xc8) = 0x0;
    *(newValue + 0xc0) = 0x0;
    *(newValue + 0xb8) = 0x0;
    *(newValue + 0xb0) = 0x0;
    *(newValue + 0xa8) = 0x0;
    *(newValue + 0xa0) = 0x0;
    *(newValue + 0x98) = 0x0;
    *(int8_t *) (newValue + 0xe4) = rcx;
    *(int32_t *) (newValue + 0xe0) = 0x0;
    pthread_mutex_init(newValue + 0x28, 0x0);
    pthread_cond_init(newValue + 0x68, 0x0);
    *(newValue + 0x20) = 0x1;
    CADisplayLink *displayLink = [[CADisplayLink alloc] _initWithDisplayLinkItem:newValue];

    return [displayLink autorelease];
}


- (double)timestamp {
    return _CATimeWithHostTime(*(self->_impl + 0xc8), _cmd);
}

- (void)removeFromRunLoop:(NSRunLoop *)runLoop forMode:(NSRunLoopMode)mode {
    r12 = mode;
    r15 = self->_impl;
    CFRunLoopRef cfRunLoop = [runLoop getCFRunLoop];
    if (*(*(r15 + 0xa8) + 0x10) == cfRunLoop) goto loc_b901;

    .l1:
    return;

    loc_b901:
    rax = *(r15 + 0xb0);
    if (rax == 0x0) goto .l1;

    loc_b90d:
    rbx = r15 + 0xb0;
    goto loc_b914;

    loc_b914:
    rax = CFEqual(*rax, r12);
    rcx = *rbx;
    if (rax != 0x0) goto loc_b938;

    loc_b926:
    rax = *(rcx + 0x8);
    rbx = rcx + 0x8;
    if (rax != 0x0) goto loc_b914;
    goto .l1;

    loc_b938:
    CFRelease(*rcx);
    rdi = *rbx;
    if (rdi != 0x0) {
        r12 = *(rdi + 0x8);
        free(rdi);
    }
    else {
        r12 = 0x0;
    }
    *rbx = r12;
    rdi = r15;
    CA::Display::DisplayLinkItem::update_link(rdi);
    return;
}


- (id)_initWithDisplayLinkItem:(struct DisplayLinkItem *)item {

//    ; Variables:
//    ;    var_20: -32

//    r14 = rdx;
//    *var_20 = arg0;
//    *(var_20 + 0x8) = _OBJC_CLASS_$_CADisplayLink;
//    rbx = [[var_20 super] init];
//    if (rbx != 0x0) {
//        rbx->_impl = r14;
//        *(r14 + 0xa0) = rbx;
//    }
//    else {
//        if (r14 != 0x0) {
//            CA::Display::DisplayLinkItem::~DisplayLinkItem();
//            operator delete(r14);
//        }
//    }
//    rax = rbx;
//    return rax;
    r14 = rdx;

    *(item + 0x8) = [CADisplayLink class];
    rbx = [[var_20 super] init];
    if (rbx != 0x0) {
        rbx->_impl = r14;
        *(r14 + 0xa0) = rbx;
    }
    else {
        if (r14 != 0x0) {
            CA::Display::DisplayLinkItem::~DisplayLinkItem();
            operator delete(r14);
        }
    }
    rax = rbx;
    return rax;
}


- (void)addToRunLoop:(NSRunLoop *)runLoop forMode:(NSRunLoopMode)mode {
    r12 = mode;
    r15 = self->_impl;
    CFRunLoopRef runLoopRef = [runLoop getCFRunLoop];
    rax = *(self->_impl + 0xa8);
    if ((rax != 0x0) && (*(rax + 0x10) != runLoopRef)) {
        [NSException raise:@"CADisplayLink" format:@"%@: already added to runloop %p, cannot also be added to %p"];
    }
    rbx = *(self->_impl + 0xb0);


    loc_b85d:
    if (*(self->_impl + 0xb0) != 0x0) goto loc_b84a;

    loc_b862:

    CFStringRef string = CFStringCreateCopy(0x0, (__bridge CFStringRef)mode);
    rbx = *(self->_impl + 0xb0);
    rax = _get_malloc_zone(0x10, mode);
    rax = malloc_zone_malloc(rax, 0x10);
    *(rax + 0x8) = rbx;
    *rax = string;
    *(self->_impl + 0xb0) = rax;
    rdi = self->_impl;
    CA::Display::DisplayLinkItem::update_link(rdi);
    return;

    .l1:
    return;

    loc_b84a:
    if (CFEqual(*rbx, mode) != 0x0) goto .l1;

    loc_b859:
    rbx = *(rbx + 0x8);
    goto loc_b85d;
}

- (void)dealloc {
//    r14 = self;
//    rbx = r14->_impl;
//    if (rbx != 0x0) {
//        CA::Display::DisplayLinkItem::~DisplayLinkItem();
//        operator delete(rbx);
//    }
//    *var_20 = r14;
//    *(var_20 + 0x8) = _OBJC_CLASS_$_CADisplayLink;
//    [[var_20 super] dealloc];
//    return;
    if (self->_impl) {
        CA::Display::DisplayLinkItem::~DisplayLinkItem();
        operator delete(self->_impl);
    }
    *var_20 = r14;
    *(var_20 + 0x8) = _OBJC_CLASS_$_CADisplayLink;
    [[var_20 super] dealloc];
}

- (double)duration {
    return _CATimeWithHostTime(*(self->_impl + 0xd8), _cmd);

}

- (void)setPaused:(bool)paused {
    BOOL rdx = paused;
    void *rax = self->_impl;
    int rcx = *(int8_t *)(rax + 0xe4) & 0xff;
    if ((rcx & 0x1) != (rdx & 0xff)) {
        *(int8_t *)(rax + 0xe4) = rcx & 0xfe | rdx;
        if (*(rax + 0xa8)) {
            os_unfair_lock_lock(CA::Display::DisplayLink::_lock);
            CA::Display::DisplayLink::update_paused_locked();
            os_unfair_lock_unlock(CA::Display::DisplayLink::_lock);
        }
    }
    return;
}

- (bool)isPaused {
    int8_t val= *(int8_t *)(self->_impl + 0xe4);
    return static_cast<bool>(val & 0x1);
}

- (void)setFrameInterval:(long long int)frameInterval {
    rdx = frameInterval;
    rsi = _cmd;
    CMP(rdx, 0x1);
    rax = 0x1;
    asm{ cmovg      eax, edx };
    intrinsic_cvttsd2si(rsi, intrinsic_divsd(intrinsic_movsd(xmm1, *0x17b450), intrinsic_cvtsi2sd(xmm0, rax, rdx)), rdx);
    CA::Display::DisplayLinkItem::set_preferred_fps(self->_impl);
    return;
}

- (void)invalidate {
    r12 = self->_impl;
    *(int32_t *)(r12 + 0xe0) = 0x1;
    r14 = r12 + 0x28;
    pthread_mutex_lock(r14);
    r15 = *(r12 + 0xb0);
    *(r12 + 0xb0) = 0x0;
    r13 = r12 + 0x68;
    do {
        rbx = *(r12 + 0x98);
        if (rbx == 0x0) {
            break;
        }
        if (rbx == pthread_self()) {
            break;
        }
        pthread_cond_wait(r13, r14);
    } while (true);
    rax = *(r12 + 0xa8);
    if (rax != 0x0) {
        rbx = *(rax + 0x10);
    }
    else {
        rbx = 0x0;
    }
    pthread_mutex_unlock(r14);
    CA::Display::(r15);
    if (rbx != 0x0) {
        rdi = r12;
        CA::Display::DisplayLinkItem::update_link(rdi);
    }
    return;
}


@end