#import "CA.h"
#import "CAMediaTiming-Protocol.h"
#import "CAPropertyInfo-Protocol.h"
#import "CALayer.h"
#import "CAAction-Protocol.h"

static BOOL _CAObject_automaticallyNotifiesObserversForKey(int arg0, int arg1) {
    rax = classDescription(arg0);
    *var_10 = rax;
    rax = propertyInfoForKey(rax, arg1, var_10);
    if (rax != 0x0) {
        if ((*(int8_t *)(rax + 0x1b) & 0x40) == 0x0) {
            rax = *(int8_t *)(var_10 + 0x78) != 0x0 ? 0x1 : 0x0;
        }
        else {
            rax = 0x0;
        }
    }
    else {
        rax = 0x1;
    }
    return rax;
}

@interface CALayer ()
+ (BOOL)CA_automaticallyNotifiesObservers:(Class)clazz;
+ (BOOL)automaticallyNotifiesObserversForKey:(id)arg1;
+ (BOOL)_hasRenderLayerSubclass;
+ (void)CAMLParserEndElement:(id)arg1;
@end


@implementation CALayer


+ (nullable id <CAAction>)defaultActionForKey:(NSString *)event {
    return nil;
}


+ (id)layer {
    return [[[self alloc] init] autorelease];
}

+ (BOOL)needsDisplayForKey:(id)arg1 {
    return NO;
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

#pragma mark - Private

+ (BOOL)CA_automaticallyNotifiesObservers:(Class)clazz {
    return [CALayer class] != clazz;
}

+ (BOOL)automaticallyNotifiesObserversForKey:(id)arg1 {
    return _CAObject_automaticallyNotifiesObserversForKey([self class], arg1);
}

+ (BOOL)_hasRenderLayerSubclass {
    return NO;
}


#pragma mark - NSSecureCoding
+ (BOOL)supportsSecureCoding {
    return YES;
}

#pragma mark - ToDo
+ (id)defaultValueForKey:(id)arg1 {
    rbx = _CAInternAtom(arg2, 0x0, arg2);
    if (rbx <= 0x9d) goto loc_f6f98;

    loc_f6f15:
    if (rbx > 0x14b) goto loc_f703b;

    loc_f6f21:
    if (rbx <= 0x136) goto loc_f70ed;

    loc_f6f2d:
    if (rbx > 0x13c) goto loc_f71a0;

    loc_f6f39:
    if (rbx == 0x137) goto loc_f71b4;

    loc_f6f45:
    if (rbx != 0x13b) goto loc_f74f3;

    loc_f6f51:
    r14 = *+[CALayer defaultValueForKey:]::corners;
    if (r14 == 0x0) {
        r14 = [[NSNumber alloc] initWithUnsignedInt:0xf];
        *+[CALayer defaultValueForKey:]::corners = r14;
    }
    goto loc_f758c;

    loc_f758c:
    rax = r14;
    return rax;

    loc_f74f3:
    rax = 0x1b95b0;
    r14 = 0x0;
    rcx = 0x0;
    goto loc_f7504;

    loc_f7504:
    if (*(int32_t *)rax == rbx) goto loc_f7571;

    loc_f7508:
    rcx = rcx + 0x1;
    rax = rax + 0x20;
    if (rcx < 0x20) goto loc_f7504;
    goto loc_f758c;

    loc_f7571:
    rax = _kCFBooleanFalse;
    if (BIT_TEST(0x811220a8, rcx)) {
        rax = _kCFBooleanTrue;
    }
    goto loc_f7589;

    loc_f7589:
    r14 = *rax;
    goto loc_f758c;

    loc_f71b4:
    r14 = @"linear";
    goto loc_f758c;

    loc_f71a0:
    if (rbx == 0x13d) goto loc_f71d8;

    loc_f71a8:
    if (rbx != 0x147) goto loc_f74f3;
    goto loc_f71b4;

    loc_f71d8:
    r14 = *+[CALayer defaultValueForKey:]::one;
    if (r14 == 0x0) {
        r14 = [[NSNumber alloc] initWithInt:0x1];
        *+[CALayer defaultValueForKey:]::one = r14;
    }
    goto loc_f758c;

    loc_f70ed:
    if (rbx == 0x9e) goto loc_f721f;

    loc_f70f9:
    if (rbx == 0xa0) goto loc_f73d0;

    loc_f7105:
    if (rbx != 0xb9) goto loc_f74f3;

    loc_f7111:
    r14 = @"removed";
    goto loc_f758c;

    loc_f73d0:
    r14 = *+[CALayer defaultValueForKey:]::defEdges;
    if (r14 == 0x0) {
        r14 = [[NSNumber alloc] initWithUnsignedInt:0xf];
        *+[CALayer defaultValueForKey:]::defEdges = r14;
    }
    goto loc_f758c;

    loc_f721f:
    r14 = *+[CALayer defaultValueForKey:]::inf;
    if (r14 == 0x0) {
        rax = [NSNumber alloc];
        intrinsic_movsd(xmm0, *0x17b428);
        r14 = [rax initWithDouble:rdx];
        *+[CALayer defaultValueForKey:]::inf = r14;
    }
    goto loc_f758c;

    loc_f703b:
    if (rbx <= 0x19c) goto loc_f711d;

    loc_f7047:
    if (rbx > 0x1a1) goto loc_f71c0;

    loc_f7053:
    if (rbx == 0x19d) goto loc_f72f2;

    loc_f705f:
    if (rbx != 0x19e) goto loc_f74f3;

    loc_f706b:
    r14 = *+[CALayer defaultValueForKey:]::defOffset;
    if (r14 == 0x0) {
        intrinsic_movsd(xmm1, *0x17b878);
        r14 = [[NSValue valueWithSize:rdx] retain];
        *+[CALayer defaultValueForKey:]::defOffset = r14;
    }
    goto loc_f758c;

    loc_f72f2:
    r14 = *black;
    if (r14 == 0x0) {
        rdi = *0x1dd648;
        if (rdi == 0x0) {
            rdi = CGColorSpaceCreateWithName(*_kCGColorSpaceSRGB);
            *0x1dd648 = rdi;
        }
        r14 = CGColorCreate(rdi, 0x18b670);
        *black = r14;
    }
    goto loc_f758c;

    loc_f71c0:
    if (rbx == 0x1a2) goto loc_f7417;

    loc_f71cc:
    if (rbx != 0x1b5) goto loc_f74f3;
    goto loc_f71d8;

    loc_f7417:
    r14 = *+[CALayer defaultValueForKey:]::three;
    if (r14 == 0x0) {
        r14 = [[NSNumber alloc] initWithInt:0x3];
        *+[CALayer defaultValueForKey:]::three = r14;
    }
    goto loc_f758c;

    loc_f711d:
    if (rbx == 0x14c) goto loc_f721f;

    loc_f7129:
    if ((rbx == 0x15d) || (rbx == 0x180)) goto loc_f71d8;
    goto loc_f74f3;

    loc_f6f98:
    if (rbx <= 0x35) goto loc_f70b8;

    loc_f6fa1:
    rax = rbx + 0xffffffffffffff9b;
    if (rax > 0xd) goto loc_f7269;

    loc_f6fad:
    r14 = @"RGBA8";
    goto *0xf75a0[sign_extend_64(*(int32_t *)(0xf75a0 + rax * 0x4)) + 0xf75a0];

    loc_f6fc4:
    r14 = *+[CALayer defaultValueForKey:]::unitRect;
    if (r14 == 0x0) {
        var_70 = intrinsic_movaps(var_70, 0x0);
        intrinsic_movaps(var_60, intrinsic_movaps(0x0, *(int128_t *)0x17a960));
        r14 = [[NSValue valueWithRect:rdx, rcx] retain];
        *+[CALayer defaultValueForKey:]::unitRect = r14;
    }
    goto loc_f758c;

    loc_f7516:
    r14 = @"resize";
    goto loc_f758c;

    loc_f751f:
    r14 = *white;
    if (r14 == 0x0) {
        rdi = *0x1dd648;
        if (rdi == 0x0) {
            rdi = CGColorSpaceCreateWithName(*_kCGColorSpaceSRGB);
            *0x1dd648 = rdi;
        }
        r14 = CGColorCreate(rdi, +[CALayer defaultValueForKey:]::values);
        *white = r14;
    }
    goto loc_f758c;

    loc_f7568:
    r14 = @"stretch";
    goto loc_f758c;

    loc_f7269:
    if (rbx == 0x36) goto loc_f72f2;

    loc_f7272:
    if (rbx != 0x79) goto loc_f74f3;

    loc_f727b:
    r14 = *+[CALayer defaultValueForKey:]::fullRect;
    if (r14 == 0x0) {
        var_50 = intrinsic_movaps(var_50, intrinsic_movaps(xmm0, *(int128_t *)0x17ac40));
        intrinsic_movaps(var_40, 0x0);
        r14 = [[NSValue valueWithRect:rdx, rcx] retain];
        *+[CALayer defaultValueForKey:]::fullRect = r14;
    }
    goto loc_f758c;

    loc_f70b8:
    if (rbx > 0x12) goto loc_f7146;

    loc_f70c1:
    if (rbx == 0x9) goto loc_f7342;

    loc_f70ca:
    if (rbx != 0xc) goto loc_f74f3;

    loc_f70d3:
    rdi = "CALAYER_ALLOWS_GROUP_OPACITY";
    r14 = @"CALayerAllowsGroupOpacity";
    r15 = @"UIViewGroupOpacity";
    goto loc_f7357;

    loc_f7357:
    if (getenv(rdi) == 0x0) goto loc_f745e;

    loc_f7365:
    rax = _kCFBooleanFalse;
    if (atoi(_kCFBooleanFalse) != 0x0) {
        rax = _kCFBooleanTrue;
    }
    goto loc_f7589;

    loc_f745e:
    r12 = [[NSBundle mainBundle] infoDictionary];
    rdx = r14;
    r14 = [r12 objectForKey:rdx];
    if (r14 != 0x0) goto loc_f74b9;

    loc_f749e:
    rdx = r15;
    r14 = [r12 objectForKey:rdx];
    if (r14 == 0x0) goto loc_f74e2;

    loc_f74b9:
    if ([r14 isKindOfClass:[NSNumber class]] != 0x0) goto loc_f758c;

    loc_f74e2:
    if (rbx != 0xc) goto loc_f74f3;

    loc_f74e7:
    rax = _kCFBooleanTrue;
    goto loc_f7589;

    loc_f7342:
    rdi = "CALAYER_ALLOWS_EDGE_ANTIALIASING";
    r14 = @"CALayerAllowsEdgeAntialiasing";
    r15 = @"UIViewEdgeAntialiasing";
    goto loc_f7357;

    loc_f7146:
    if (rbx == 0x13) goto loc_f7383;

    loc_f714f:
    if (rbx != 0x2b) goto loc_f74f3;

    loc_f7158:
    r14 = *+[CALayer defaultValueForKey:]::defPhase;
    if (r14 == 0x0) {
        r14 = [[NSValue valueWithSize:rdx] retain];
        *+[CALayer defaultValueForKey:]::defPhase = r14;
    }
    goto loc_f758c;

    loc_f7383:
    r14 = *+[CALayer defaultValueForKey:]::defAnchor;
    if (r14 == 0x0) {
        intrinsic_movaps(xmm1, intrinsic_movsd(xmm0, *0x17b420));
        r14 = [[NSValue valueWithPoint:rdx] retain];
        *+[CALayer defaultValueForKey:]::defAnchor = r14;
    }
    goto loc_f758c;
}

+ (void)CAMLParserEndElement:(id)arg2 {
    rbx = [arg2 elementValue]; // arg2 CAMLParser
    if ([rbx needsDisplayOnBoundsChange] != 0x0) {
        rax = [rbx contents];
        if (rax != 0x0) {
            rdi = rbx;
            [rdi setContents:rax];
        }
        else {
            rdi = rbx;
            [rdi setNeedsDisplay];
        }
    }
    return;
}


@end