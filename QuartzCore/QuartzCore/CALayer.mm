#import "CA.h"
#import "CAMediaTiming-Protocol.h"
#import "CAPropertyInfo-Protocol.h"
#import "CALayer.h"

@interface CALayer ()

@end


@implementation CALayer


+ (id)layer {
    return [[[self alloc] init] autorelease];
}

- (void)layoutSublayers {
    r14 = self;
    if ((*(int8_t *) (self->_attr.layer + 0x35) & 0x30) == 0x0) goto loc_ff4b9;

    loc_ff425:
    rbx = CA::Transaction::ensure();
    rax = *(int32_t *) (rbx + 0x20);
    *(int32_t *) (rbx + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(rbx + 0x18));
    }
    rax = *(r14 + *_OBJC_IVAR_$_CALayer._attr + 0x8);
    rcx = *(int32_t *) (rax + 0x34);
    if ((rcx & 0x10) != 0x0) goto loc_ff45e;

    loc_ff450:
    if ((rcx & 0x20) == 0x0) goto loc_ff4b1;

    loc_ff455:
    rcx = @selector(_layoutSublayersOfLayer:);
    goto loc_ff465;

    loc_ff465:
    r15 = *rcx;
    if (r15 == 0x0) goto loc_ff4b1;

    loc_ff46d:
    r12 = [*(rax + 0x70) retain];
    CA::Transaction::unlock();
    [r12 performSelector:r15 withObject:r14];
    rdi = r12;
    [rdi release];
    return;

    loc_ff4b1:
    CA::Transaction::unlock();
    goto loc_ff4b9;

    loc_ff4b9:
    rax = [r14 actionForKey:@"onLayout"];
    if (rax != 0x0) {
        rcx = r14;
        [rax runActionForKey:@"onLayout" object:rcx arguments:0x0];
    }
    return;

    loc_ff45e:
    rcx = @selector(layoutSublayersOfLayer:);
    goto loc_ff465;
}

- (void)layoutIfNeeded {
    // class_state
    if ((*(int32_t *) (self->_attr.layer + 0x4) & 0x60000) == 0x0) {
        CA::Transaction *transaction = CA::Transaction::ensure_compat();
        int32_t rax = *(int32_t *) (transaction + 0x20);
        *(int32_t *) (transaction + 0x20) = rax + 0x1; // r14.prop  ++
        if (rax == 0x0) {
            os_unfair_lock_lock(*(transaction + 0x18));
        }
        int32_t rbx = (int32_t) (self->_attr.layer);
        int32_t r15;
        do {
            r15 = rbx;
            int32_t rbx = *(int32_t *) (rbx + 0x8);
            if (rbx == 0x0) {
                break;
            }
            rax = sign_extend_64(*(int32_t *) (transaction + 0x8));
            if (rax >= 0x0) {
                rax = *(int32_t *) (rbx + rax * 0x4 + 0x100);
                if (rax == 0x0) {
                    rax = CA::Layer::thread_flags_(rbx);
                    rax = *(int32_t *) rax;
                }
            } else {
                rax = CA::Layer::thread_flags_(rbx);
                rax = *(int32_t *) rax;
            }
        } while ((rax & 0x40) != 0x0);
        rcx = *(int32_t *) (r15 + 0x10);
        if (rcx != 0x0) {
            do {
                self->_attr.refcount++;
                if (self->_attr.refcount < 0x2) {
                    break;
                }
                *(int32_t *) rcx = lock
                intrinsic_cmpxchg(*(int32_t *) rcx, rdx);
            } while (*(int32_t *) rcx != 0x0);
            CA::Transaction::unlock();
            CA::Layer::layout_if_needed(r15);
            rdi = *(r15 + 0x10);
            if (rdi != 0x0) {
                _CALayerRelease(rdi);
            }
        } else {
            CA::Transaction::unlock();
        }
    }
    return;
}

- (void)setNeedsLayout {
    if ((*(int32_t *) (self->_attr.layer + 0x4) & 0x60000) == 0x0) {
        r14 = CA::Transaction::ensure_compat();
        rax = *(int32_t *) (r14 + 0x20);
        *(int32_t *) (r14 + 0x20) = rax + 0x1;
        if (rax == 0x0) {
            os_unfair_lock_lock(*(r14 + 0x18));
        }
        rax = sign_extend_64(*(int32_t *) (r14 + 0x8));
        if (rax >= 0x0) {
            rcx = *(int32_t *) (rbx + rax * 0x4 + 0x100);
            if (rcx != 0x0) {
                rax = rbx + rax * 0x4 + 0x100;
            } else {
                rax = CA::Layer::thread_flags_(rbx);
                rcx = *(int32_t *) rax;
            }
        } else {
            rax = CA::Layer::thread_flags_(rbx);
            rcx = *(int32_t *) rax;
        }
        if ((rcx & 0x20) == 0x0) {
            *(int32_t *) rax = rcx | 0x20;
            CA::Layer::invalidate_layout();
            do {
                rbx = *(rbx + 0x8);
                if (rbx == 0x0) {
                    break;
                }
                rax = sign_extend_64(*(int32_t *) (r14 + 0x8));
                if (rax >= 0x0) {
                    rsi = *(int32_t *) (rbx + rax * 0x4 + 0x100);
                    if (rsi != 0x0) {
                        rcx = rbx + rax * 0x4 + 0x100;
                    } else {
                        rcx = CA::Layer::thread_flags_(rbx);
                        rsi = *(int32_t *) rcx;
                    }
                } else {
                    rcx = CA::Layer::thread_flags_(rbx);
                    rsi = *(int32_t *) rcx;
                }
                if ((rsi & 0x40) != 0x0) {
                    break;
                }
                *(int32_t *) rcx = rsi | 0x40;
                CA::Layer::invalidate_layout();
            } while (true);
        }
        CA::Transaction::unlock();
    }
    return;
}


- (id)init {


    self = [super init];
    if (self != nil) {
        _attr.magic = 0x4c415952;
        int32_t *state = CA::Layer::class_state([self class]);

        int32_t value = (*state & 0x1) + (*state & 0x1) + 0x2000000;
        CA::Transaction::ensure();
        // CA::Layer
        rbx = malloc_zone_malloc(_get_malloc_zone(0x118, @selector(class)), 0x118);
        *(rbx + 0x8) = 0x0;
        *(rbx + 0x10) = self;
        *(rbx + 0x20) = 0x0;
        *(rbx + 0x18) = 0x0;
        CA::Layer::State::State(rbx + 0x28, state);
        *(int32_t *) (rbx + 0x98) = 0x0;
        *(rbx + 0x90) = 0x0;
        *(rbx + 0x88) = 0x0;
        *(int32_t *) (rbx + 0x10c) = 0x0;
        *(rbx + 0x110) = 0x0;
        *(rbx + 0xf8) = 0x0;
        *(rbx + 0xf0) = 0x0;
        *(rbx + 0xe8) = 0x0;
        *(rbx + 0xe0) = 0x0;
        *(rbx + 0xd8) = 0x0;
        *(rbx + 0xd0) = 0x0;
        *(rbx + 0xc8) = 0x0;
        *(rbx + 0xc0) = 0x0;
        *(rbx + 0xb8) = 0x0;
        *(rbx + 0xb0) = 0x0;
        *(rbx + 0xa8) = 0x0;
        *(rbx + 0xa0) = 0x0;
        *(int32_t *) rbx = 0x1;
        *(int32_t *) (rbx + 0x4) = value;
        *(int32_t *) (rbx + 0x108) = 0x0;
        *(rbx + 0x100) = 0x0;
        self->_attr.layer = rbx;
    }
    return self;
}


@end