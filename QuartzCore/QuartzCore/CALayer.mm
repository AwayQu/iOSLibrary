#import "CA.h"
#import "CAMediaTiming-Protocol.h"
#import "CAPropertyInfo-Protocol.h"
#import "CALayer.h"
#import "CAAction-Protocol.h"
#import "CAMLParser.h"
#import "CAFilter.h"

static BOOL _CAObject_automaticallyNotifiesObserversForKey(int arg0, int arg1) {
    rax = classDescription(arg0);
    *var_10 = rax;
    rax = propertyInfoForKey(rax, arg1, var_10);
    if (rax != 0x0) {
        if ((*(int8_t *) (rax + 0x1b) & 0x40) == 0x0) {
            rax = *(int8_t *) (var_10 + 0x78) != 0x0 ? 0x1 : 0x0;
        } else {
            rax = 0x0;
        }
    } else {
        rax = 0x1;
    }
    return rax;
}

@interface CALayer ()
+ (BOOL)CA_automaticallyNotifiesObservers:(Class)clazz;

+ (BOOL)automaticallyNotifiesObserversForKey:(id)arg1;

+ (BOOL)_hasRenderLayerSubclass;

+ (void)CAMLParserStartElement:(CAMLParser *)arg1;

+ (void)CAMLParserEndElement:(CAMLParser *)arg1;

+ (id)properties;
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

- (struct CGSize)preferredFrameSize {
    rbx = self;
    [self sizeRequisition];
    xmm2 = 0x0;
    xmm0 = intrinsic_ucomisd(xmm0, xmm2);
    xmm1 = intrinsic_ucomisd(xmm1, xmm2);
    if (((xmm1 == 0x0 ? 0x1 : 0x0) & (xmm0 == 0x0 ? 0x1 : 0x0)) == 0x1) {
        [rbx _preferredSize];
        var_18 = intrinsic_movsd(var_18, xmm0);
        var_20 = intrinsic_movsd(var_20, xmm1);
        [rbx setSizeRequisition:rdx];
    } else {
        var_20 = intrinsic_movsd(var_20, xmm1);
        var_18 = intrinsic_movsd(var_18, xmm0);
    }
    CA::Layer::get_frame_transform(*(rbx + *_OBJC_IVAR_$_CALayer._attr + 0x8), var_50);
    xmm1 = intrinsic_movsd(xmm1, *var_50);
    xmm2 = intrinsic_movsd(xmm2, var_18);
    xmm1 = intrinsic_mulsd(xmm1, xmm2);
    xmm0 = intrinsic_movsd(xmm0, *(var_50 + 0x10));
    xmm3 = intrinsic_movsd(xmm3, var_20);
    xmm0 = intrinsic_mulsd(xmm0, xmm3);
    xmm0 = intrinsic_addsd(xmm0, xmm1);
    var_20 = intrinsic_movsd(var_20, intrinsic_addsd(intrinsic_mulsd(xmm3, *(var_50 + 0x18)), intrinsic_mulsd(xmm2, *(var_50 + 0x8))));
    ceil(xmm0);
    var_18 = intrinsic_movsd(var_18, xmm0);
    xmm0 = intrinsic_movsd(xmm0, var_20);
    rax = ceil(xmm0);
    intrinsic_movaps(xmm1, xmm0);
    intrinsic_movsd(xmm0, var_18);
    return rax;
    return CGSize();
}

- (struct CGSize)_preferredSize {
    return [self size];
}


- (_Bool)needsLayout {
    CA::Layer *layer = static_cast<CA::Layer *>(self->_attr.layer);
    CA::Transaction *transaction = CA::Transaction::ensure_compat();
    rcx = sign_extend_64(*(int32_t *) (rax + 0x8));
    if (rcx >= 0x0) {
        rcx = *(int32_t *) (rbx + rcx * 0x4 + 0x100);
        if (rcx == 0x0) {
            rcx = *(int32_t *) CA::Layer::thread_flags_(rbx);
        }
    } else {
        rcx = *(int32_t *) CA::Layer::thread_flags_(rbx);
    }
    rax = (rcx & 0x20) >> 0x5;
    return rax;
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

- (void)drawInContext:(struct CGContext *)arg2 {
    r14 = arg2;
    r15 = self;
    if ((*(int8_t *) (*(r15 + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0x35) & 0x4) != 0x0) goto loc_ff07d;

    loc_feff7:
    r12 = [r15 actionForKey:@"onDraw"];
    if (r12 == 0x0) goto .l1;

    loc_ff01a:
    rbx = [[NSDictionary alloc] initWithObjectsAndKeys:r14];
    rdx = @"onDraw";
    rcx = r15;
    r8 = rbx;
    [r12 runActionForKey:rdx object:rcx arguments:r8];
    rsi = @selector(release);
    rdi = rbx;
    rax = _objc_msgSend;
    goto loc_ff0e5;

    loc_ff0e5:
    (rax)(rdi, rsi, rdx, rcx, r8);
    return;

    .l1:
    return;

    loc_ff07d:
    rbx = CA::Transaction::ensure();
    rax = *(int32_t *) (rbx + 0x20);
    *(int32_t *) (rbx + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(rbx + 0x18));
    }
    rax = *(r15 + *_OBJC_IVAR_$_CALayer._attr + 0x8);
    if ((*(int8_t *) (rax + 0x35) & 0x4) == 0x0) {
        r12 = 0x0;
    } else {
        r12 = [*(rax + 0x70) retain];
    }
    CA::Transaction::unlock();
    rdx = r15;
    rcx = r14;
    [r12 drawLayer:rdx inContext:rcx];
    rsi = @selector(release);
    rdi = r12;
    rax = _objc_msgSend;
    goto loc_ff0e5;
}

- (void)_contentsFormatDidChange:(id)arg2 {
    r14 = self->_attr.layer;
    r15 = [arg2 integerValue];
    rbx = CA::Transaction::ensure_compat();
    r12 = *(r14 + 0x10);
    rax = *(int32_t *) (rbx + 0x20);
    *(int32_t *) (rbx + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(rbx + 0x18));
    }
    if ((([r12 contents] != 0x0) && ((*(int32_t *) (r14 + 0x4) & 0x8000000) != 0x0)) && ((*(int8_t *) (r14 + 0x36) & 0x4) == 0x0)) {
        *(int32_t *) (r14 + 0x2c) = *(int32_t *) (r14 + 0x2c) & 0xfffffff8 | r15;
        [r12 setNeedsDisplay];
        CA::Layer::set_commit_needed(r14, rbx);
    }
    CA::Transaction::unlock();
    return;
}

- (struct CGColorSpace *)_retainColorSpace {
    rbx = CA::Layer::retain_context();
    if (rbx != 0x0) {
        r14 = CGColorSpaceRetain(*(rbx + 0x80));
        CA::Context::unref(rbx);
        rax = r14;
    } else {
        rdi = *0x1dd648;
        if (rdi == 0x0) {
            rdi = CGColorSpaceCreateWithName(*_kCGColorSpaceSRGB);
            *0x1dd648 = rdi;
        }
        rax = CGColorSpaceRetain(rdi);
    }
    return rax;
}

- (void)_colorSpaceDidChange {
    rbx = self->_attr.layer;
    r15 = CA::Transaction::ensure_compat();
    var_30 = rbx;
    r12 = *(rbx + 0x10);
    rax = *(int32_t *) (r15 + 0x20);
    *(int32_t *) (r15 + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(r15 + 0x18));
    }
    rbx = [r12 contents];
    r14 = 0x0;
    if (rbx != 0x0) {
        r13 = CFGetTypeID(rbx);
        rax = *CABackingStoreGetTypeID::type;
        if (rax == 0x0) {
            rax = _CFRuntimeRegisterClass(CABackingStoreGetTypeID::klass);
            *CABackingStoreGetTypeID::type = rax;
        }
        r14 = 0x1;
        if (r13 == rax) {
            r13 = [*(var_30 + 0x10) _retainColorSpace];
            if (_CABackingStoreSetColorSpace(rbx, r13) != 0x0) {
                [r12 setNeedsDisplay];
            }
            CGColorSpaceRelease(r13);
            r14 = 0x0;
        }
    }
    if ((([r12 backgroundColor] != 0x0) || ([r12 borderColor] != 0x0)) || ([r12 contentsMultiplyColor] != 0x0)) {
        r14 = r14 | 0x8000;
    }
    rdx = r14 | 0x2000;
    if ([r12 shadowColor] == 0x0) {
        rdx = r14;
    }
    if (rdx != 0x0) {
        CA::Layer::set_commit_needed(var_30, r15);
    }
    CA::Transaction::unlock();
    return;
}

- (void)_display {
    rbx = self->_attr.layer;
    if ((*(int32_t *) (rbx + 0x4) & 0x60000) != 0x0) goto .l11;

    loc_fe4bc:
    r14 = *(rbx + 0x10);
    xmm0 = intrinsic_xorpd(xmm0, xmm0);
    xmm0 = intrinsic_ucomisd(xmm0, *(rbx + 0x60));
    if (xmm0 == 0x0) goto loc_fe5bd;

    loc_fe4cf:
    xmm0 = intrinsic_ucomisd(xmm0, *(rbx + 0x68));
    if (xmm0 == 0x0) goto loc_fe5bd;

    loc_fe4da:
    if ((*(int8_t *) (rbx + 0x35) & 0x8) != 0x0) {
        r15 = CA::Transaction::ensure();
        rax = *(int32_t *) (r15 + 0x20);
        *(int32_t *) (r15 + 0x20) = rax + 0x1;
        if (rax == 0x0) {
            os_unfair_lock_lock(*(r15 + 0x18));
        }
        if ((*(int8_t *) (rbx + 0x35) & 0x8) == 0x0) {
            r12 = 0x0;
        } else {
            r12 = [*(rbx + 0x70) retain];
        }
        CA::Transaction::unlock();
        r15 = _objc_msgSend;
        rdx = r14;
        [r12 layerWillDraw:rdx];
        [r12 release];
    }
    if ((*(int8_t *) (rbx + 0x33) & 0x8) == 0x0) {
        xmm2 = intrinsic_movsd(xmm2, *0x17b440);
    } else {
        [r14 contentsScale];
        xmm2 = intrinsic_movapd(xmm2, xmm0);
    }
    xmm0 = intrinsic_movsd(xmm0, *(rbx + 0x60));
    xmm1 = intrinsic_movsd(xmm1, *(rbx + 0x68));
    xmm3 = intrinsic_xorpd(xmm3, xmm3);
    xmm3 = intrinsic_ucomisd(xmm3, xmm0);
    if (xmm3 > 0x0) goto loc_fe59b;

    loc_fe57b:
    xmm1 = intrinsic_ucomisd(xmm1, xmm3);
    if (xmm1 < 0x0) goto loc_fe59b;

    loc_fe581:
    xmm3 = intrinsic_movapd(xmm3, xmm2);
    xmm3 = intrinsic_mulsd(xmm3, xmm3);
    xmm3 = intrinsic_mulsd(xmm3, xmm0);
    xmm3 = intrinsic_mulsd(xmm3, xmm1);
    xmm3 = intrinsic_ucomisd(xmm3, *0x17b890);
    if (xmm3 <= 0x0) goto loc_fe5e1;

    loc_fe59b:
    rsi = *(rbx + 0x10);
    xmm3 = intrinsic_movapd(xmm3, xmm0);
    intrinsic_mulsd(xmm3, xmm2);
    xmm4 = intrinsic_movapd(xmm4, xmm1);
    intrinsic_mulsd(xmm4, xmm2);
    NSLog(@"-[%@ display]: Ignoring bogus layer size (%f, %f), contentsScale %f, backing store size (%f, %f)", rsi, rdx, rcx, r8, r9, stack[2023]);
    goto loc_fe5bd;

    loc_fe5bd:
    [r14 setContents:0x0];
    return;

    .l11:
    return;

    loc_fe5e1:
    xmm0 = intrinsic_mulsd(xmm0, xmm2);
    xmm0 = intrinsic_addsd(xmm0, *0x17b420);
    var_48 = intrinsic_movsd(var_48, xmm2);
    var_40 = intrinsic_movsd(var_40, xmm1);
    floor(xmm0);
    r15 = intrinsic_cvttsd2si(r15, xmm0);
    xmm0 = intrinsic_movsd(xmm0, var_40);
    xmm0 = intrinsic_mulsd(xmm0, var_48);
    xmm0 = intrinsic_addsd(xmm0, *0x17b420);
    rax = floor(xmm0);
    var_40 = r15;
    if (r15 <= 0x0) goto loc_fe5bd;

    loc_fe621:
    rax = intrinsic_cvttsd2si(rax, xmm0);
    var_2C = rax;
    if (rax <= 0x0) goto loc_fe5bd;

    loc_fe62c:
    r15 = *(int32_t *) (rbx + 0x2c);
    r12 = *(int32_t *) (rbx + 0x34);
    r13 = r15 & 0x7;
    [r14 isOpaque];
    rdi = 0x1;
    if ((r15 & 0x7) == 0x7) goto loc_fe6a0;

    loc_fe65b:
    (sign_extend_64(*(int32_t *) (0xfed04 + r13 * 0x4)) + 0xfed04)();
    return;

    loc_fe6a0:
    if (var_2C * var_40 > 0x3ff) goto loc_fe85a;

    loc_fe6b2:
    if ((r12 & 0x40000) == 0x0) {
        rdi = default_contents_image_format(rbx);
    }
    rax = rdi + 0xfffffffffffffffc;
    if ((rax <= 0x1d) && (!(BIT_TEST(0x7fffff2, rax)))) {
        rdi = (0x3066d6b03 >> rdi) + (0x3066d6b03 >> rdi) & 0x2 ^ 0xf;
    }
    var_38 = rdi;
    r12 = CA::Render::format_rowbytes(rdi, var_40);
    if (var_2C != 0x0) {
        rdi = var_2C * r12;
        if (rdi / var_2C != r12) {
            rdi = 0x0;
        }
    } else {
        rdi = 0x0;
    }
    r15 = CA::Render::aligned_malloc(rdi, var_C0);
    if (r15 == 0x0) goto .l11;

    loc_fe736:
    var_48 = r12;
    r12 = [*(rbx + 0x10) _retainColorSpace];
    if (CGColorSpaceGetNumberOfComponents(r12) != 0x3) {
        CGColorSpaceRelease(r12);
        r12 = CGColorSpaceRetain(CA::Render::format_default_colorspace(r13));
    }
    rax = CAGetCachedCGBitmapContext_(r15, var_40, var_2C, var_38, var_48, r12);
    if (rax == 0x0) goto loc_feb52;

    loc_fe799:
    r13 = *(rax + 0x10);
    CGColorSpaceRelease(r12);
    if (r13 == 0x0) goto loc_feb5a;

    loc_fe7ae:
    CA::Layer::prepare_context_for_drawing(rbx, r13, 0x1);
    rax = CA::Transaction::ensure_compat();
    rax = CA::Layer::layer_being_drawn(rbx, rax);
    [rax drawInContext:r13];
    _CAReleaseCachedCGContext(r13);
    vm_protect(*(int32_t *) _mach_task_self_, r15, var_C0, 0x1, 0x1);
    r15 = CGDataProviderCreateWithData(var_C0, r15, var_C0, CA::Render::aligned_release(void * , void const*, unsigned long));
    rax = var_38;
    if (rax <= 0x21) {
        rdx = *(int32_t *) (0x17c1f0 + sign_extend_64(rax) * 0x4);
        rcx = *(int32_t *) (0x17c0d0 + sign_extend_64(rax) * 0x4);
    } else {
        rdx = 0x0;
        rcx = 0x0;
    }
    rdi = sign_extend_64(var_40);
    rsi = sign_extend_64(var_2C);
    if (rax == 0x9) {
        rax = CGImageMaskCreate(rdi, rsi, rdx, rcx, var_48, r15, CA::Layer::display_()
        ::decode, 0x1);
        rsp = (rsp - 0x10) + 0x10;
    } else {
        r10 = 0x0;
        if (rax <= 0x21) {
            r10 = *(int32_t *) (0x17c040 + sign_extend_64(rax) * 0x4);
        }
        rax = CGImageCreate(rdi, rsi, rdx, rcx, var_48, r12, r10, r15, 0x0, 0x1, 0x0);
        rsp = (rsp - 0x30) + 0x30;
    }
    r12 = rax;
    CGDataProviderRelease(r15);
    [r14 setContents:r12];
    CGImageRelease(r12);
    goto loc_fecd5;

    loc_fecd5:
    *(int32_t *) (rbx + 0x4) = *(int32_t *) (rbx + 0x4) | 0x8000000;
    *(int8_t *) (rbx + 0x32) = *(int8_t *) (rbx + 0x32) & 0xfb;
    return;

    loc_feb5a:
    munmap(r15, var_C0);
    rax = *_CAGetStatsStruct.ogl_renderer_stats;
    rax = rax - var_C0;
    *_CAGetStatsStruct.ogl_renderer_stats = rax;
    if (rax > *0x1dd3f8) {
        *0x1dd3f8 = rax;
    }
    return;

    loc_feb52:
    CGColorSpaceRelease(r12);
    goto loc_feb5a;

    loc_fe85a:
    var_38 = 0x1;
    r15 = CA::Transaction::ensure_compat();
    rax = *(int32_t *) (r15 + 0x20);
    *(int32_t *) (r15 + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(r15 + 0x18));
    }
    rsi = @selector(contents);
    rdi = r14;
    r13 = _objc_msgSend(rdi, rsi);
    var_50 = r15;
    var_68 = r13;
    if (r13 != 0x0) {
        rdi = r13;
        r15 = CFGetTypeID(rdi);
        rax = *CABackingStoreGetTypeID::type;
        if (rax == 0x0) {
            rdi = CABackingStoreGetTypeID::klass;
            rax = _CFRuntimeRegisterClass(rdi);
            *CABackingStoreGetTypeID::type = rax;
        }
        COND = r15 != rax;
        r15 = var_50;
        if (!COND) {
            r12 = CFRetain(r13);
        } else {
            if ((r12 & 0x40000) == 0x0) {
                rdi = rbx;
                var_38 = default_contents_image_format(rdi);
            }
            r12 = _CABackingStoreCreate(rdi, rsi);
            if (r12 != 0x0) {
                r15 = [*(rbx + 0x10) _retainColorSpace];
                _CABackingStoreSetColorSpace(r12, r15);
                CGColorSpaceRelease(r15);
                pthread_mutex_lock(r12 + 0x10);
                *(int16_t *) (r12 + 0x18c) = *(int16_t *) (r12 + 0x18c) & 0xffff & 0xf9ff | 0x400;
                r15 = var_50;
                pthread_mutex_unlock(r12 + 0x10);
            } else {
                r12 = 0x0;
            }
        }
    } else {
        if ((r12 & 0x40000) == 0x0) {
            rdi = rbx;
            var_38 = default_contents_image_format(rdi);
        }
        r12 = _CABackingStoreCreate(rdi, rsi);
        if (r12 != 0x0) {
            r15 = [*(rbx + 0x10) _retainColorSpace];
            _CABackingStoreSetColorSpace(r12, r15);
            CGColorSpaceRelease(r15);
            pthread_mutex_lock(r12 + 0x10);
            *(int16_t *) (r12 + 0x18c) = *(int16_t *) (r12 + 0x18c) & 0xffff & 0xf9ff | 0x400;
            r15 = var_50;
            pthread_mutex_unlock(r12 + 0x10);
        } else {
            r12 = 0x0;
        }
    }
    if ([r14 drawsAsynchronously] == 0x0) {
        r13 = 0x0;
        if ([r14 acceleratesDrawing] != 0x0) {
            r13 = 0x100;
        }
    } else {
        r13 = 0x100;
    }
    if (*accel_once != 0xffffffffffffffff) {
        rdx = accel_init();
        dispatch_once_f(accel_once, 0x0, rdx);
    }
    var_58 = r12;
    if (r13 != 0x0) {
        r12 = *(int32_t *) (rbx + 0x30);
        r12 = SAR(r12 << 0xf, 0x1f);
        rdx = 0x2;
        CA::Layer::mark(rbx, r15, rdx);
    } else {
        r12 = 0x0;
    }
    CA::Transaction::unlock();
    if (var_58 == 0x0) goto .l11;

    loc_fe9e7:
    if ([r14 isOpaque] != 0x0) {
        r13 = r13 | 0x1;
    } else {
        rcx = r13 | 0x2;
        if ([r14 clearsContext] != 0x0) {
            r13 = rcx;
        }
    }
    var_60 = rbx + 0x28;
    r15 = r13 | 0x2;
    if (_CFExecutableLinkedOnOrAfter(0x3e9) != 0x0) {
        r15 = r13;
    }
    if (_CAInternAtom([r14 minificationFilter], 0x0, rdx) == 0x11b) {
        r15 = ([r14 drawsMipmapLevels] == 0x0 ? 0x1 : 0x0) << 0x3 | r15 | 0x4;
    }
    r8 = var_38;
    xmm0 = intrinsic_movsd(xmm0, var_48);
    r13 = r15 | 0x400;
    xmm0 = intrinsic_ucomisd(xmm0, *0x17b898);
    if (xmm0 <= 0x0) {
        r13 = r15;
    }
    rax = *(int32_t *) (rbx + 0x4);
    rax = !(rax >> 0xf) & 0x80 | r13;
    r15 = var_50;
    rcx = *(r15 + 0x50);
    rsi = rcx + 0xc8;
    if (rcx == 0x0) {
        rsi = rcx;
    }
    *var_C0 = __NSConcreteStackBlock;
    *(int32_t *) (var_C0 + 0x8) = 0xc0000000;
    *(int32_t *) (var_C0 + 0xc) = 0x0;
    *(var_C0 + 0x10) = ____ZN2CA5Layer8display_Ev_block_invoke;
    *(var_C0 + 0x18) = ___block_descriptor_tmp
    .467;
    *(var_C0 + 0x20) = rbx;
    *(var_C0 + 0x28) = var_58;
    *(int32_t *) (var_C0 + 0x38) = var_40;
    *(int32_t *) (var_C0 + 0x3c) = var_2C;
    *(int32_t *) (var_C0 + 0x40) = r8;
    *(int32_t *) (var_C0 + 0x44) = rax;
    *(int32_t *) (var_C0 + 0x48) = r12;
    r12 = var_58;
    *(var_C0 + 0x30) = rsi;
    _x_blame_allocations(backing_blame_callback(char * , unsigned long, void * ), var_60, var_C0);
    if (r12 != var_68) {
        [r14 setContents:r12];
    } else {
        rax = *(int32_t *) (r15 + 0x20);
        *(int32_t *) (r15 + 0x20) = rax + 0x1;
        if (rax == 0x0) {
            os_unfair_lock_lock(*(r15 + 0x18));
        }
        CA::Layer::begin_change(rbx, r15, @"contents", var_70);
        rax = sign_extend_64(*(int32_t *) (r15 + 0x8));
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
        *(int32_t *) rax = rcx & 0xfffffeff;
        CA::Layer::end_change(rbx, r15, 0x64, @"contents");
        CA::Transaction::unlock();
    }
    CFRelease(r12);
    rax = *(int32_t *) (rbx + 0x30);
    rcx = rax & 0xfffdffff;
    rax = rax | 0x20000;
    if ((r13 & 0x4) == 0x0) {
        rax = rcx;
    }
    *(int32_t *) (rbx + 0x30) = rax;
    goto loc_fecd5;
}

- (void)display {
    rbx = self->_attr.layer;
    if ((*(int32_t *) (rbx + 0x4) & 0x60000) == 0x0) {
        if ((*(int8_t *) (rbx + 0x35) & 0x2) == 0x0) {
            rdi = *(rbx + 0x10);
            [rdi _display];
        } else {
            r15 = CA::Transaction::ensure();
            rax = *(int32_t *) (r15 + 0x20);
            *(int32_t *) (r15 + 0x20) = rax + 0x1;
            if (rax == 0x0) {
                os_unfair_lock_lock(*(r15 + 0x18));
            }
            if ((*(int8_t *) (rbx + 0x35) & 0x2) == 0x0) {
                r14 = 0x0;
            } else {
                r14 = [*(rbx + 0x70) retain];
            }
            CA::Transaction::unlock();
            [r14 displayLayer:*(rbx + 0x10)];
            rdi = r14;
            [rdi release];
        }
    }
    return;
}

- (void)_renderBorderInContext:(struct CGContext *)arg1 {
    rdx = arg2;
    r14 = rdx;
    r12 = self;
    r15 = CA::Transaction::ensure();
    rax = *(int32_t *) (r15 + 0x20);
    *(int32_t *) (r15 + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(r15 + 0x18));
    }
    [r12 borderWidth];
    var_28 = intrinsic_movsd(var_28, xmm0);
    rbx = [r12 borderColor];
    xmm0 = intrinsic_xorpd(xmm0, xmm0);
    xmm1 = intrinsic_movsd(xmm1, var_28);
    xmm1 = intrinsic_ucomisd(xmm1, xmm0);
    if ((xmm1 > 0x0) && (rbx != 0x0)) {
        CGColorGetAlpha(rbx);
        xmm1 = intrinsic_xorpd(xmm1, xmm1);
        xmm0 = intrinsic_ucomisd(xmm0, xmm1);
        if (xmm0 > 0x0) {
            CGContextSaveGState(r14);
            if ([r12 edgeAntialiasingMask] == 0x0) {
                CGContextSetShouldAntialias(r14, 0x0);
            }
            rsi = rbx;
            CGContextSetStrokeColorWithColor(r14, rsi);
            xmm0 = intrinsic_movsd(xmm0, var_28);
            CGContextSetLineWidth(r14, rsi);
            if (r12 != 0x0) {
                rdx = @selector(bounds);
                rsi = r12;
                objc_msgSend_stret(var_70, rsi, rdx);
            } else {
                xmm0 = intrinsic_xorpd(xmm0, xmm0);
                var_60 = intrinsic_movapd(var_60, xmm0);
                var_70 = intrinsic_movapd(var_70, xmm0);
            }
            xmm0 = intrinsic_movsd(xmm0, var_28);
            xmm0 = intrinsic_mulsd(xmm0, *0x17b420);
            var_28 = intrinsic_movsd(var_28, xmm0);
            intrinsic_movapd(xmm1, xmm0);
            CGRectInset(var_90, rsi, rdx);
            [r12 cornerRadius];
            intrinsic_subsd(xmm0, var_28);
            _CA_CGContextAddRoundRect(r14);
            CA::Transaction::unlock();
            CGContextStrokePath(r14);
            rax = *(int32_t *) (r15 + 0x20);
            *(int32_t *) (r15 + 0x20) = rax + 0x1;
            if (rax == 0x0) {
                os_unfair_lock_lock(*(r15 + 0x18));
            }
            CGContextRestoreGState(r14);
        }
    }
    CA::Transaction::unlock();
    return;
}

- (void)_renderSublayersInContext:(struct CGContext *)arg1 {
    rbx = arg2;
    r15 = self;
    r14 = CA::Transaction::ensure();
    rax = *(int32_t *) (r14 + 0x20);
    *(int32_t *) (r14 + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(r14 + 0x18));
    }
    r15 = [[r15 sublayers] copy];
    CA::Transaction::unlock();
    var_30 = r15;
    r15 = [r15 count];
    if (r15 != 0x0) {
        var_A8 = @selector(objectAtIndex:);
        var_98 = @selector(renderInContext:);
        r13 = 0x0;
        r14 = var_90;
        do {
            r12 = _objc_msgSend(var_30, var_A8);
            CA::Layer::get_frame_transform(*(r12 + *_OBJC_IVAR_$_CALayer._attr + 0x8), r14);
            if (_CA_CGAffineTransformIsValid(r14) != 0x0) {
                CGContextSaveGState(rbx);
                CGContextGetBaseCTM(var_60, rbx);
                CGContextConcatCTM(rbx, rbx);
                CGAffineTransformConcat(var_D8, rbx);
                CGContextSetBaseCTM(rbx);
                _objc_msgSend(r12, var_98);
                CGContextSetBaseCTM(rbx);
                CGContextRestoreGState(rbx);
            }
            r13 = r13 + 0x1;
        } while (r15 != r13);
    }
    [var_30 release];
    return;
}

- (void)_renderForegroundInContext:(struct CGContext *)arg1 {
    rbx = arg2;
    r14 = self;
    var_30 = *___stack_chk_guard;
    r13 = CA::Transaction::ensure();
    rax = *(int32_t *) (r13 + 0x20);
    *(int32_t *) (r13 + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(r13 + 0x18));
    }
    r15 = [r14 contents];
    if (r15 != 0x0) {
        var_C8 = r14;
        if (r14 != 0x0) {
            [var_220 bounds];
        } else {
            xmm0 = intrinsic_xorpd(xmm0, xmm0);
            var_210 = intrinsic_movapd(var_210, xmm0);
            var_220 = intrinsic_movapd(var_220, xmm0);
        }
        r14 = CFGetTypeID(r15);
        if (r14 == CGImageGetTypeID()) {
            r12 = 0x0;
        } else {
            rax = *CABackingStoreGetTypeID::type;
            if (rax == 0x0) {
                rax = _CFRuntimeRegisterClass(CABackingStoreGetTypeID::klass);
                *CABackingStoreGetTypeID::type = rax;
            }
            if (r14 == rax) {
                r15 = _CABackingStoreCopyCGImage(r15);
                r12 = 0x1;
            } else {
                r14 = [r15 CA_copyRenderValue];
                if (r14 != 0x0) {
                    if ((*(*r14 + 0x18))(r14) == 0x15) {
                        r15 = CA::Render::Image::copy_cgimage();
                        r12 = 0x1;
                    } else {
                        r12 = 0x0;
                        r15 = 0x0;
                    }
                    CA::Render::Object::unref();
                } else {
                    r12 = 0x0;
                    r15 = 0x0;
                }
            }
        }
        CGContextSaveGState(rbx);
        var_B8 = r13;
        if (r15 != 0x0) {
            var_160 = *(var_C8 + *_OBJC_IVAR_$_CALayer._attr + 0x8);
            r14 = CGImageGetWidth(r15);
            rax = CGImageGetHeight(r15);
            xmm0 = intrinsic_movdqa(xmm0, *(int128_t *) 0x17a970);
            xmm4 = intrinsic_punpckldq(zero_extend_64(r14), xmm0);
            xmm2 = intrinsic_movapd(xmm2, *(int128_t *) 0x17a980);
            xmm4 = intrinsic_subpd(xmm4, xmm2);
            xmm4 = intrinsic_haddpd(xmm4, xmm4);
            xmm1 = intrinsic_punpckldq(zero_extend_64(rax), xmm0);
            xmm1 = intrinsic_subpd(xmm1, xmm2);
            xmm1 = intrinsic_haddpd(xmm1, xmm1);
            xmm0 = intrinsic_pxor(xmm0, xmm0);
            var_130 = intrinsic_movdqa(var_130, xmm0);
            var_120 = intrinsic_movlpd(var_120, xmm4);
            var_E0 = intrinsic_movapd(var_E0, xmm1);
            var_118 = intrinsic_movlpd(var_118, xmm1);
            rcx = *(int32_t *) (var_160 + 0x30);
            if ((rcx & 0x8000000) != 0x0) {
                var_180 = intrinsic_movapd(var_180, xmm4);
                [var_C8 contentsScale];
                xmm1 = intrinsic_movsd(xmm1, *0x17b440);
                xmm1 = intrinsic_divsd(xmm1, xmm0);
                xmm4 = intrinsic_movapd(xmm4, var_180);
                xmm4 = intrinsic_mulsd(xmm4, xmm1);
                xmm2 = intrinsic_movapd(xmm2, var_E0);
                xmm2 = intrinsic_mulsd(xmm2, xmm1);
                var_E0 = intrinsic_movapd(var_E0, xmm2);
                xmm1 = intrinsic_movapd(xmm1, var_120);
                xmm0 = intrinsic_movddup(xmm0, xmm0);
                xmm1 = intrinsic_divpd(xmm1, xmm0);
                var_120 = intrinsic_movapd(var_120, xmm1);
                rcx = *(int32_t *) (var_160 + 0x30);
            }
            if ((rcx & 0x4000000) != 0x0) {
                var_180 = intrinsic_movapd(var_180, xmm4);
                [var_240 contentsRect];
                COND = (*(int32_t *) (*(var_C8 + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0x4) & 0x400000) != 0x0;
                xmm4 = intrinsic_movapd(xmm4, var_180);
                if (!COND) {
                    xmm1 = intrinsic_movsd(xmm1, var_228);
                    xmm0 = intrinsic_movsd(xmm0, *0x17b440);
                    xmm0 = intrinsic_subsd(xmm0, var_238);
                    xmm0 = intrinsic_subsd(xmm0, xmm1);
                    intrinsic_movsd(var_238, xmm0);
                } else {
                    xmm0 = intrinsic_movsd(xmm0, var_238);
                    xmm1 = intrinsic_movsd(xmm1, var_228);
                }
                xmm4 = intrinsic_mulsd(xmm4, var_230);
                var_E0 = intrinsic_movapd(var_E0, intrinsic_mulsd(intrinsic_movapd(xmm2, var_E0), xmm1));
                xmm1 = intrinsic_movsd(xmm1, var_240);
                xmm1 = intrinsic_unpcklpd(xmm1, xmm0);
                xmm1 = intrinsic_mulpd(xmm1, var_120);
                xmm1 = intrinsic_xorpd(xmm1, *(int128_t *) 0x17a9c0);
                var_130 = intrinsic_movapd(var_130, xmm1);
            }
            rdi = *(int32_t *) (var_160 + 0x2c);
            rdi = rdi >> 0x3;
            rcx = var_220;
            var_1D0 = rcx;
            rax = var_218;
            var_1C8 = rax;
            var_1C0 = var_210;
            var_1B8 = var_208;
            xmm1 = intrinsic_xorpd(xmm1, xmm1, var_210, rcx);
            xmm2 = intrinsic_ucomisd(zero_extend_64(var_210), xmm1);
            xmm0 = zero_extend_64(var_208);
            if (xmm2 < 0x0) {
                xmm3 = intrinsic_addsd(zero_extend_64(rcx), xmm2);
                var_1D0 = intrinsic_movsd(var_1D0, xmm3);
                xmm2 = intrinsic_xorpd(xmm2, *(int128_t *) 0x17a9c0);
                var_1C0 = intrinsic_movlpd(var_1C0, xmm2);
            }
            var_C0 = r15;
            rdi = rdi & 0xf;
            xmm0 = intrinsic_ucomisd(xmm0, xmm1);
            if (xmm0 < 0x0) {
                xmm1 = intrinsic_addsd(zero_extend_64(rax), xmm0);
                var_1C8 = intrinsic_movsd(var_1C8, xmm1);
                xmm0 = intrinsic_xorpd(xmm0, *(int128_t *) 0x17a9c0);
                var_1B8 = intrinsic_movlpd(var_1B8, xmm0);
            }
            var_180 = intrinsic_movapd(var_180, xmm4);
            *var_50 = intrinsic_movsd(*var_50, xmm4);
            xmm0 = intrinsic_movapd(xmm0, var_E0);
            *(var_50 + 0x8) = intrinsic_movsd(*(var_50 + 0x8), xmm0);
            CA::Render::compute_gravity_transform(rdi, var_1D0, var_50, var_240, var_410);
            rcx = *var_410;
            rax = *(var_410 + 0x8);
            xmm0 = intrinsic_movapd(xmm0, *(int128_t *) var_240);
            var_280 = rcx;
            var_338 = rax;
            var_330 = intrinsic_movupd(var_330, xmm0);
            rdx = @selector(contentsTransform);
            rsi = var_C8;
            objc_msgSend_stret(var_4A0, rsi, rdx);
            CGAffineTransformConcat(var_1D0, rsi);
            xmm0 = intrinsic_movapd(xmm0, var_1D0);
            xmm1 = intrinsic_movapd(xmm1, var_1C0);
            xmm2 = intrinsic_movapd(xmm2, var_1B0);
            var_400 = intrinsic_movapd(var_400, xmm0);
            var_3F0 = intrinsic_movapd(var_3F0, xmm1);
            intrinsic_movapd(var_3E0, xmm2);
            CGContextConcatCTM(rbx, rsi);
            r14 = var_C0;
            if ((*(int32_t *) (*(var_C8 + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0x4) & 0x400000) == 0x0) {
                xmm0 = intrinsic_movsd(xmm0, *0x17b418);
                var_308 = intrinsic_movups(var_308, xmm0);
                xmm0 = intrinsic_movapd(xmm0, var_E0);
                intrinsic_movsd(var_2F8, xmm0);
                CGContextConcatCTM(rbx, rsi);
            }
            rsi = @selector(edgeAntialiasingMask);
            if (_objc_msgSend(var_C8, rsi) == 0x0) {
                rsi = 0x0;
                CGContextSetShouldAntialias(rbx, rsi);
            }
            xmm0 = intrinsic_xorpd(xmm0, xmm0);
            var_370 = intrinsic_movapd(var_370, xmm0);
            xmm0 = intrinsic_movapd(xmm0, var_180);
            var_360 = intrinsic_movsd(var_360, xmm0);
            xmm0 = intrinsic_movapd(xmm0, var_E0);
            intrinsic_movsd(var_358, xmm0);
            CGContextClipToRect(rbx, rsi);
            if (r12 == 0x0) {
                CGImageRetain(r14);
            }
            var_14C = 0x100 & *(int32_t *) (var_160 + 0x30);
            r15 = var_C8;
            r12 = [r15 contentsMultiplyColor];
            var_148 = 0x0;
            if ((r12 != 0x0) && (r12 != *white)) {
                var_1F0 = r12;
                r13 = CGImageGetWidth(r14);
                var_100 = CGImageGetHeight(var_C0);
                r15 = CGImageGetBitmapInfo(var_C0) & 0x100;
                if (r15 == 0x0) {
                    rcx = COND_BYTE_SET(E);
                    rdx = 0x1;
                    if (CGImageGetBitsPerComponent(var_C0) == 0x10) {
                        rdx = 0x13;
                    }
                    var_110 = rdx;
                    r12 = rcx * 0x4 + 0x4;
                } else {
                    var_110 = 0xd;
                    r12 = 0x8;
                }
                r14 = CGImageGetColorSpace(var_C0);
                if (CGColorSpaceGetModel(r14) != 0x1) {
                    r14 = _CAGetColorSpace(0x9 - (r15 >> 0x8));
                }
                rax = calloc((r12 * r13 + 0x1f & 0xffffffffffffffe0) * var_100, 0x1);
                var_E8 = rax;
                rdx = var_100;
                var_1E0 = r12 * r13 + 0x1f & 0xffffffffffffffe0;
                r9 = r14;
                rax = CAGetCachedCGBitmapContext_(rax, r13, rdx, var_110, r12 * r13 + 0x1f & 0xffffffffffffffe0, r9);
                if (rax != 0x0) {
                    rax = *(rax + 0x10);
                } else {
                    rax = 0x0;
                }
                var_140 = rax;
                rax = CGImageIsMask(var_C0);
                xmm0 = intrinsic_movdqa(xmm0, *(int128_t *) 0x17a970);
                xmm2 = intrinsic_punpckldq(zero_extend_64(r13), xmm0);
                xmm1 = intrinsic_movapd(xmm1, *(int128_t *) 0x17a980);
                xmm2 = intrinsic_subpd(xmm2, xmm1);
                xmm2 = intrinsic_haddpd(xmm2, xmm2);
                xmm3 = intrinsic_punpckldq(zero_extend_64(var_100), xmm0);
                xmm3 = intrinsic_subpd(xmm3, xmm1);
                xmm3 = intrinsic_haddpd(xmm3, xmm3);
                var_170 = intrinsic_movapd(var_170, xmm2);
                var_1A0 = intrinsic_movapd(var_1A0, xmm3);
                if (rax != 0x0) {
                    xmm0 = intrinsic_pxor(xmm0, xmm0);
                    var_3D0 = intrinsic_movdqa(var_3D0, xmm0);
                    var_3C0 = intrinsic_movsd(var_3C0, xmm2);
                    intrinsic_movsd(var_3B8, xmm3);
                    CGContextClipToMask(var_140, var_C0, rdx);
                    CGContextSetFillColorWithColor(var_140, var_1F0);
                    xmm0 = intrinsic_pxor(xmm0, xmm0);
                    var_3B0 = intrinsic_movdqa(var_3B0, xmm0);
                    xmm0 = intrinsic_movapd(xmm0, var_170);
                    var_3A0 = intrinsic_movsd(var_3A0, xmm0);
                    xmm0 = intrinsic_movapd(xmm0, var_1A0);
                    intrinsic_movsd(var_398, xmm0);
                    CGContextFillRect(var_140, var_1F0);
                } else {
                    CGContextSetBlendMode(var_140, 0x11);
                    xmm0 = intrinsic_pxor(xmm0, xmm0);
                    var_390 = intrinsic_movdqa(var_390, xmm0);
                    xmm0 = intrinsic_movapd(xmm0, var_170);
                    var_380 = intrinsic_movsd(var_380, xmm0);
                    xmm0 = intrinsic_movapd(xmm0, var_1A0);
                    intrinsic_movsd(var_378, xmm0);
                    CGContextDrawImage(var_140, var_C0, rdx);
                    rcx = 0x0;
                    rdi = var_1F0;
                    rdx = var_1D0;
                    CA::Render::convert_cgcolor_to_float(rdi, r14, rdx, rcx);
                    xmm6 = intrinsic_movdqa(xmm6, *(int128_t *) var_1D0);
                    rax = var_110 & 0x1f;
                    if (rax != 0x1) {
                        if (rax != 0x13) {
                            var_110 = intrinsic_movdqa(var_110, xmm6);
                            if ((rax == 0xd) && (var_100 != 0x0)) {
                                xmm0 = intrinsic_movdqa(xmm0, var_110);
                                var_170 = intrinsic_movdqa(var_170, intrinsic_pshufd(xmm0, 0xf5));
                                var_1A0 = intrinsic_movdqa(var_1A0, intrinsic_pshufd(xmm0, 0xe7));
                                xmm0 = intrinsic_psrldq(xmm0, 0x8);
                                var_190 = intrinsic_movdqa(var_190, xmm0);
                                r14 = 0x0;
                                r15 = var_E8;
                                do {
                                    if (r13 != 0x0) {
                                        r12 = 0x0;
                                        do {
                                            __extendhfsf2(*(int16_t *) (r15 + r12 * 0x8) & 0xffff);
                                            xmm0 = intrinsic_mulss(xmm0, var_110);
                                            *(int16_t *) (r15 + r12 * 0x8) = __truncsfhf2();
                                            __extendhfsf2(*(int16_t *) (r15 + r12 * 0x8 + 0x2) & 0xffff);
                                            xmm0 = intrinsic_mulss(xmm0, var_170);
                                            *(int16_t *) (r15 + r12 * 0x8 + 0x2) = __truncsfhf2();
                                            __extendhfsf2(*(int16_t *) (r15 + r12 * 0x8 + 0x4) & 0xffff);
                                            xmm0 = intrinsic_mulss(xmm0, var_190);
                                            *(int16_t *) (r15 + r12 * 0x8 + 0x4) = __truncsfhf2();
                                            __extendhfsf2(*(int16_t *) (r15 + r12 * 0x8 + 0x6) & 0xffff);
                                            xmm0 = intrinsic_mulss(xmm0, var_1A0);
                                            *(int16_t *) (r15 + r12 * 0x8 + 0x6) = __truncsfhf2();
                                            r12 = r12 + 0x1;
                                        } while (r13 != r12);
                                    }
                                    r14 = r14 + 0x1;
                                    r15 = r15 + var_1E0;
                                } while (r14 != var_100);
                            }
                        } else {
                            xmm4 = intrinsic_movdqa(xmm4, xmm6);
                            xmm4 = intrinsic_psrldq(xmm4, 0x8);
                            xmm1 = intrinsic_movss(xmm1, *(int32_t *) 0x17bb94);
                            xmm4 = intrinsic_mulss(xmm4, xmm1);
                            xmm2 = intrinsic_movss(xmm2, *(int32_t *) 0x17ba34);
                            xmm4 = intrinsic_addss(xmm4, xmm2);
                            xmm4 = intrinsic_ucomiss(xmm4, xmm1);
                            rax = xmm4 <= 0x0 ? 0x1 : 0x0;
                            xmm3 = intrinsic_xorpd(xmm3, xmm3);
                            xmm4 = intrinsic_ucomiss(xmm4, xmm3);
                            rdx = (xmm4 < 0x0 ? 0x1 : 0x0) & rax;
                            COND = rdx != 0x0;
                            rax = 0xffff00000000;
                            if (COND) {
                                rax = 0x0;
                            }
                            xmm0 = intrinsic_movss(xmm0, *(int32_t *) 0x17bb98);
                            xmm5 = intrinsic_movaps(xmm5, xmm4);
                            xmm5 = intrinsic_subss(xmm5, xmm0);
                            rdi = intrinsic_cvttss2si(rdi, xmm5);
                            rcx = intrinsic_cvttss2si(rcx, xmm4);
                            xmm4 = intrinsic_ucomiss(xmm4, xmm0);
                            asm{
                            cmovae     rcx, rdi
                            };
                            rcx = rcx << 0x20;
                            if (rdx != 0x0) {
                                rcx = rax;
                            }
                            xmm4 = intrinsic_ucomiss(xmm4, xmm1);
                            xmm4 = intrinsic_pshufd(xmm6, 0xf5);
                            xmm4 = intrinsic_mulss(xmm4, xmm1);
                            xmm4 = intrinsic_addss(xmm4, xmm2);
                            asm{
                            cmova      rcx, rax
                            };
                            xmm4 = intrinsic_ucomiss(xmm4, xmm1);
                            rax = xmm4 <= 0x0 ? 0x1 : 0x0;
                            xmm4 = intrinsic_ucomiss(xmm4, xmm3);
                            rdx = (xmm4 < 0x0 ? 0x1 : 0x0) & rax;
                            COND = rdx != 0x0;
                            rax = intrinsic_cvttss2si(rax, xmm4);
                            xmm5 = intrinsic_movaps(xmm5, xmm4);
                            xmm5 = intrinsic_subss(xmm5, xmm0);
                            r9 = intrinsic_cvttss2si(r9, xmm5);
                            rdi = 0xffff0000;
                            if (COND) {
                                rdi = 0x0;
                            }
                            r9 = r9 ^ 0x8000000000000000;
                            xmm4 = intrinsic_ucomiss(xmm4, xmm0);
                            if (xmm4 < 0x0) {
                                r9 = rax;
                            }
                            r9 = r9 << 0x10;
                            if (rdx != 0x0) {
                                r9 = rdi;
                            }
                            xmm4 = intrinsic_ucomiss(xmm4, xmm1);
                            xmm4 = intrinsic_movdqa(xmm4, xmm6);
                            xmm4 = intrinsic_mulss(xmm4, xmm1);
                            xmm4 = intrinsic_addss(xmm4, xmm2);
                            asm{
                            cmova      r9, rdi
                            };
                            xmm4 = intrinsic_ucomiss(xmm4, xmm1);
                            rax = xmm4 <= 0x0 ? 0x1 : 0x0;
                            xmm4 = intrinsic_ucomiss(xmm4, xmm3);
                            rdx = (xmm4 < 0x0 ? 0x1 : 0x0) & rax;
                            COND = rdx != 0x0;
                            rdi = intrinsic_cvttss2si(rdi, xmm4);
                            xmm5 = intrinsic_movaps(xmm5, xmm4);
                            xmm5 = intrinsic_subss(xmm5, xmm0);
                            rax = intrinsic_cvttss2si(rax, xmm5);
                            rsi = 0xffff;
                            if (COND) {
                                rsi = 0x0;
                            }
                            rax = rax ^ 0x8000000000000000;
                            xmm4 = intrinsic_ucomiss(xmm4, xmm0);
                            if (xmm4 < 0x0) {
                                rax = rdi;
                            }
                            if (rdx != 0x0) {
                                rax = rsi;
                            }
                            xmm4 = intrinsic_ucomiss(xmm4, xmm1);
                            asm{
                            cmova      rax, rsi
                            };
                            xmm4 = intrinsic_pshufd(xmm6, 0xe7);
                            xmm4 = intrinsic_mulss(xmm4, xmm1);
                            xmm4 = intrinsic_addss(xmm4, xmm2);
                            xmm4 = intrinsic_ucomiss(xmm4, xmm1);
                            rdx = xmm4 <= 0x0 ? 0x1 : 0x0;
                            xmm4 = intrinsic_ucomiss(xmm4, xmm3);
                            if (var_100 != 0x0) {
                                rsi = 0xffff000000000000 & rdx;
                                r9 = r9 | rax;
                                rcx = rcx | r9;
                                rdi = intrinsic_cvttss2si(rdi, intrinsic_subss(intrinsic_movaps(xmm1, xmm4), xmm0));
                                r11 = intrinsic_cvttss2si(r11, xmm4);
                                xmm4 = intrinsic_ucomiss(xmm4, xmm0);
                                asm{
                                cmovae     r11, rdi
                                };
                                r11 = r11 << 0x30;
                                r8 = 0x0;
                                COND = rsi != 0x0;
                                rsi = 0xffff000000000000;
                                if (COND) {
                                    r8 = 0x0;
                                    rsi = r8;
                                }
                                if (CPU_FLAGS & NE) {
                                    r11 = rsi;
                                }
                                xmm4 = intrinsic_ucomiss(xmm4, *(int32_t *) 0x17bb94);
                                asm{
                                cmova      r11, rsi
                                };
                                r11 = ((r11 | rcx) >> 0x30) + 0x1;
                                r14 = (rcx >> 0x20 & 0xffff) + 0x1;
                                r9 = (r9 >> 0x10) + 0x1;
                                r15 = (rax & 0xffff) + 0x1;
                                r12 = var_E8;
                                do {
                                    if (r13 != 0x0) {
                                        rsi = 0x0;
                                        do {
                                            rdi = *(r12 + rsi * 0x8);
                                            rdx = (rdi >> 0x10) * r9 & 0x1ffff0000;
                                            *(r12 + rsi * 0x8) = (rdi & 0xffff) * r15 >> 0x10 |
                                                    ((rdi >> 0x30) * r11 & 0xffffffffffff0000) << 0x20 | rdx |
                                                    ((rdi >> 0x20 & 0xffff) * r14 & 0xffffffffffff0000) << 0x10;
                                            rsi = rsi + 0x1;
                                        } while (r13 != rsi);
                                    }
                                    r8 = r8 + 0x1;
                                    r12 = r12 + var_1E0;
                                } while (r8 != var_100);
                            }
                        }
                    } else {
                        xmm0 = intrinsic_movss(xmm0, *(int32_t *) 0x17ba30);
                        xmm2 = intrinsic_movdqa(xmm2, xmm6);
                        xmm2 = intrinsic_mulss(xmm2, xmm0);
                        xmm2 = intrinsic_addss(xmm2, *(int32_t *) 0x17ba34);
                        xmm2 = intrinsic_ucomiss(xmm2, xmm0);
                        rcx = xmm2 <= 0x0 ? 0x1 : 0x0;
                        xmm1 = intrinsic_xorpd(xmm1, xmm1);
                        xmm2 = intrinsic_ucomiss(xmm2, xmm1);
                        rax = (xmm2 < 0x0 ? 0x1 : 0x0) & rcx;
                        COND = rax != 0x0;
                        rcx = 0xff0000;
                        if (COND) {
                            rcx = 0x0;
                        }
                        xmm2 = intrinsic_ucomiss(xmm2, xmm0);
                        if ((xmm2 <= 0x0) && ((rax & 0x1) == 0x0)) {
                            rcx = (intrinsic_cvttss2si(rax, xmm2) & 0xff) << 0x10;
                        }
                        xmm2 = intrinsic_pshufd(xmm6, 0xf5);
                        xmm2 = intrinsic_mulss(xmm2, xmm0);
                        xmm2 = intrinsic_addss(xmm2, *(int32_t *) 0x17ba34);
                        xmm2 = intrinsic_ucomiss(xmm2, xmm0);
                        rdx = xmm2 <= 0x0 ? 0x1 : 0x0;
                        xmm2 = intrinsic_ucomiss(xmm2, xmm1);
                        rax = (xmm2 < 0x0 ? 0x1 : 0x0) & rdx;
                        rdi = 0xff00;
                        if (rax != 0x0) {
                            rdi = 0x0;
                        }
                        xmm2 = intrinsic_ucomiss(xmm2, xmm0);
                        if ((xmm2 <= 0x0) && ((rax & 0x1) == 0x0)) {
                            rdi = (intrinsic_cvttss2si(rax, xmm2) & 0xff) << 0x8;
                        }
                        xmm2 = intrinsic_movdqa(xmm2, xmm6);
                        xmm2 = intrinsic_psrldq(xmm2, 0x8);
                        xmm2 = intrinsic_mulss(xmm2, xmm0);
                        xmm2 = intrinsic_addss(xmm2, *(int32_t *) 0x17ba34);
                        xmm2 = intrinsic_ucomiss(xmm2, xmm0);
                        rdx = xmm2 <= 0x0 ? 0x1 : 0x0;
                        xmm1 = intrinsic_xorpd(xmm1, xmm1);
                        xmm2 = intrinsic_ucomiss(xmm2, xmm1);
                        rax = (xmm2 < 0x0 ? 0x1 : 0x0) & rdx;
                        COND = rax != 0x0;
                        r9 = 0x100;
                        if (COND) {
                            r9 = 0x1;
                        }
                        xmm2 = intrinsic_ucomiss(xmm2, xmm0);
                        if ((xmm2 <= 0x0) && ((rax & 0x1) == 0x0)) {
                            r9 = (intrinsic_cvttss2si(rax, xmm2) & 0xff) + 0x1;
                        }
                        xmm2 = intrinsic_pshufd(xmm6, 0xe7);
                        xmm2 = intrinsic_mulss(xmm2, xmm0);
                        xmm2 = intrinsic_addss(xmm2, *(int32_t *) 0x17ba34);
                        xmm2 = intrinsic_ucomiss(xmm2, xmm0);
                        rdx = xmm2 <= 0x0 ? 0x1 : 0x0;
                        xmm2 = intrinsic_ucomiss(xmm2, xmm1);
                        rax = (xmm2 < 0x0 ? 0x1 : 0x0) & rdx;
                        r10 = 0xff000000;
                        if (rax != 0x0) {
                            r10 = 0x0;
                        }
                        xmm2 = intrinsic_ucomiss(xmm2, xmm0);
                        if (xmm2 <= 0x0) {
                            COND = (rax & 0x1) != 0x0;
                            rax = rdi;
                            if (!COND) {
                                r10 = intrinsic_cvttss2si(r10, xmm2);
                                r10 = r10 << 0x18;
                            }
                        } else {
                            rax = rdi;
                        }
                        if (var_100 != 0x0) {
                            r10 = ((r10 | rcx | rax) >> 0x18) + 0x1;
                            r11 = ((rcx | rax) >> 0x10 & 0xff) + 0x1;
                            r15 = (rax & 0xff) + 0x1;
                            r8 = 0x0;
                            r14 = var_E8;
                            do {
                                r12 = r15;
                                if (r13 != 0x0) {
                                    rax = 0x0;
                                    do {
                                        rcx = *(int32_t *) (r14 + rax * 0x4);
                                        rdx = (rcx & 0xff) * r12 & 0x1ff00;
                                        *(int32_t *) (r14 + rax * 0x4) = (rcx & 0xff) * r9 >> 0x8 |
                                                (rcx >> 0x18) * r10 << 0x10 & 0xff000000 | rdx |
                                                (rcx >> 0x10 & 0xff) * r11 << 0x8 & 0xffff0000;
                                        rax = rax + 0x1;
                                    } while (r13 != rax);
                                }
                                r8 = r8 + 0x1;
                                r14 = r14 + var_1E0;
                            } while (r8 != var_100);
                        }
                    }
                }
                var_148 = CGBitmapContextCreateImage(var_140);
                _CAReleaseCachedCGContext(var_140);
                free(var_E8);
                r13 = var_B8;
                r14 = var_C0;
                r15 = var_C8;
                r12 = var_1F0;
            }
            rax = 0x2000000 & *(int32_t *) (var_160 + 0x30);
            rax = rax | var_14C;
            if (rax != 0x0) {
                xmm1 = intrinsic_ucomisd(zero_extend_64(var_280), *0x17b440);
                xmm0 = intrinsic_movsd(xmm0, var_408);
                if (xmm1 == 0x0) {
                    xmm0 = intrinsic_ucomisd(xmm0, *0x17b440);
                    if (xmm0 == 0x0) {
                        CA::Transaction::unlock();
                        if (CGImageIsMask(r14) != 0x0) {
                            CGContextClipToMask(rbx, r14, rdx);
                            CGContextSetFillColorWithColor(rbx, r12);
                            CGContextFillRect(rbx, r12);
                        } else {
                            rax = var_148;
                            if (rax != 0x0) {
                                r14 = rax;
                            }
                            CGContextDrawImage(rbx, r14, rdx);
                        }
                        rax = *(int32_t *) (r13 + 0x20);
                        *(int32_t *) (r13 + 0x20) = rax + 0x1;
                        if (rax == 0x0) {
                            os_unfair_lock_lock();
                        }
                    } else {
                        var_110 = intrinsic_movsd(var_110, xmm1);
                        var_140 = intrinsic_movapd(var_140, xmm0);
                        rax = var_148;
                        if (rax != 0x0) {
                            r14 = rax;
                        }
                        if (r15 != 0x0) {
                            rdx = @selector(contentsCenter);
                            objc_msgSend_stret(var_1D0, r15, rdx);
                        } else {
                            xmm0 = intrinsic_xorpd(xmm0, xmm0);
                            var_1C0 = intrinsic_movapd(var_1C0, xmm0);
                            var_1D0 = intrinsic_movapd(var_1D0, xmm0);
                        }
                        CGContextBeginTransparencyLayer(rbx, 0x0);
                        CGContextSetBlendMode(rbx, 0x11);
                        rdi = var_C8;
                        if ((*(int32_t *) (*(rdi + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0x4) & 0x400000) == 0x0) {
                            xmm0 = intrinsic_movsd(xmm0, *0x17b440);
                            xmm0 = intrinsic_subsd(xmm0, var_1C8);
                            xmm0 = intrinsic_subsd(xmm0, var_1B8);
                            var_1C8 = intrinsic_movsd(var_1C8, xmm0);
                        }
                        rax = [rdi literalContentsCenter];
                        xmm0 = intrinsic_movsd(xmm0, var_1C0);
                        xmm2 = intrinsic_xorpd(xmm2, xmm2);
                        xmm2 = intrinsic_ucomisd(xmm2, xmm0);
                        xmm5 = intrinsic_movapd(xmm5, var_180);
                        if (xmm2 == 0x0) {
                            if (rax != 0x0) {
                                xmm0 = intrinsic_movsd(xmm0, *0x17b730);
                            } else {
                                xmm0 = intrinsic_movddup(xmm0, xmm5);
                                xmm1 = intrinsic_xorpd(xmm1, xmm1);
                                xmm1 = intrinsic_cvtsd2ss(xmm1, xmm0);
                                asm{
                                rcpss      xmm1, xmm1
                                };
                                xmm0 = intrinsic_cvtss2sd(0x0, xmm1);
                                xmm1 = intrinsic_movapd(xmm1, xmm0);
                                xmm1 = intrinsic_mulsd(xmm1, xmm5);
                                xmm3 = intrinsic_movsd(xmm3, *0x17b418);
                                xmm1 = intrinsic_addsd(xmm1, xmm3);
                                xmm1 = intrinsic_mulsd(xmm1, xmm0);
                                xmm0 = intrinsic_subsd(xmm0, xmm1);
                                xmm1 = intrinsic_movapd(xmm1, xmm0);
                                xmm1 = intrinsic_mulsd(xmm1, xmm5);
                                xmm1 = intrinsic_addsd(xmm1, xmm3);
                                xmm1 = intrinsic_mulsd(xmm1, xmm0);
                                xmm0 = intrinsic_subsd(xmm0, xmm1);
                            }
                            xmm1 = intrinsic_movsd(xmm1, *0x17b498);
                            xmm1 = intrinsic_mulsd(xmm1, xmm0);
                            xmm1 = intrinsic_addsd(xmm1, var_1D0);
                            var_1D0 = intrinsic_movsd(var_1D0, xmm1);
                            intrinsic_movsd(var_1C0, xmm0);
                        }
                        xmm1 = intrinsic_movsd(xmm1, var_1B8);
                        xmm2 = intrinsic_ucomisd(xmm2, xmm1);
                        if (xmm2 == 0x0) {
                            if (rax != 0x0) {
                                xmm1 = intrinsic_movsd(xmm1, *0x17b730);
                            } else {
                                xmm4 = intrinsic_movapd(xmm4, var_E0);
                                xmm1 = intrinsic_movddup(xmm1, xmm4);
                                xmm2 = intrinsic_xorpd(xmm2, xmm2);
                                xmm2 = intrinsic_cvtsd2ss(xmm2, xmm1);
                                asm{
                                rcpss      xmm2, xmm2
                                };
                                xmm1 = intrinsic_cvtss2sd(0x0, xmm2);
                                xmm2 = intrinsic_movapd(xmm2, xmm1);
                                xmm2 = intrinsic_mulsd(xmm2, xmm4);
                                xmm3 = intrinsic_movsd(xmm3, *0x17b418);
                                xmm2 = intrinsic_addsd(xmm2, xmm3);
                                xmm2 = intrinsic_mulsd(xmm2, xmm1);
                                xmm1 = intrinsic_subsd(xmm1, xmm2);
                                xmm2 = intrinsic_movapd(xmm2, xmm1);
                                xmm2 = intrinsic_mulsd(xmm2, xmm4);
                                xmm2 = intrinsic_addsd(xmm2, xmm3);
                                xmm2 = intrinsic_mulsd(xmm2, xmm1);
                                xmm1 = intrinsic_subsd(xmm1, xmm2);
                            }
                            xmm2 = intrinsic_movsd(xmm2, *0x17b498);
                            xmm2 = intrinsic_mulsd(xmm2, xmm1);
                            xmm2 = intrinsic_addsd(xmm2, var_1C8);
                            var_1C8 = intrinsic_movsd(var_1C8, xmm2);
                            intrinsic_movsd(var_1B8, xmm1);
                        }
                        intrinsic_movsd(var_38, xmm5);
                        xmm4 = intrinsic_movsd(xmm4, var_1D0);
                        xmm0 = intrinsic_addsd(xmm0, xmm4);
                        xmm4 = intrinsic_mulsd(xmm4, xmm5);
                        intrinsic_movsd(var_48, xmm4);
                        xmm0 = intrinsic_mulsd(xmm0, xmm5);
                        intrinsic_movsd(var_40, xmm0);
                        intrinsic_movsd(var_78, xmm5);
                        xmm2 = intrinsic_movsd(xmm2, *0x17b440);
                        xmm3 = intrinsic_movapd(xmm3, xmm2);
                        xmm3 = intrinsic_divsd(xmm3, var_110);
                        xmm4 = intrinsic_mulsd(xmm4, xmm3);
                        xmm0 = intrinsic_subsd(xmm0, xmm5);
                        xmm0 = intrinsic_mulsd(xmm0, xmm3);
                        xmm0 = intrinsic_addsd(xmm0, xmm5);
                        xmm4 = intrinsic_minsd(xmm4, xmm5);
                        xmm3 = intrinsic_xorpd(xmm3, xmm3);
                        xmm4 = intrinsic_maxsd(xmm4, xmm3);
                        var_88 = intrinsic_movsd(var_88, xmm4);
                        xmm0 = intrinsic_minsd(xmm0, xmm5);
                        xmm0 = intrinsic_maxsd(xmm0, xmm3);
                        var_80 = intrinsic_movsd(var_80, xmm0);
                        xmm4 = intrinsic_ucomisd(xmm4, xmm0);
                        if (xmm4 > 0x0) {
                            xmm0 = intrinsic_addsd(xmm0, xmm4);
                            xmm0 = intrinsic_mulsd(xmm0, *0x17b420);
                            intrinsic_movsd(var_80, xmm0);
                            intrinsic_movsd(var_88, xmm0);
                        }
                        xmm4 = intrinsic_movapd(xmm4, var_E0);
                        intrinsic_movsd(var_58, xmm4);
                        xmm0 = intrinsic_movsd(xmm0, var_1C8);
                        xmm1 = intrinsic_addsd(xmm1, xmm0);
                        xmm0 = intrinsic_mulsd(xmm0, xmm4);
                        intrinsic_movsd(var_68, xmm0);
                        xmm1 = intrinsic_mulsd(xmm1, xmm4);
                        intrinsic_movsd(var_60, xmm1);
                        intrinsic_movsd(var_98, xmm4);
                        xmm2 = intrinsic_divsd(xmm2, var_140);
                        xmm0 = intrinsic_mulsd(xmm0, xmm2);
                        xmm1 = intrinsic_subsd(xmm1, xmm4);
                        xmm1 = intrinsic_mulsd(xmm1, xmm2);
                        xmm1 = intrinsic_addsd(xmm1, xmm4);
                        xmm0 = intrinsic_minsd(xmm0, xmm4);
                        xmm0 = intrinsic_maxsd(xmm0, xmm3);
                        var_A8 = intrinsic_movsd(var_A8, xmm0);
                        xmm1 = intrinsic_minsd(xmm1, xmm4);
                        xmm1 = intrinsic_maxsd(xmm1, xmm3);
                        var_A0 = intrinsic_movsd(var_A0, xmm1);
                        xmm0 = intrinsic_ucomisd(xmm0, xmm1);
                        if (xmm0 > 0x0) {
                            xmm1 = intrinsic_addsd(xmm1, xmm0);
                            xmm1 = intrinsic_mulsd(xmm1, *0x17b420);
                            intrinsic_movsd(var_A0, xmm1);
                            intrinsic_movsd(var_A8, xmm1);
                        }
                        rsi = 0x0;
                        CGContextSetShouldAntialias(rbx, rsi);
                        rdi = var_B8;
                        CA::Transaction::unlock();
                        xmm0 = intrinsic_movapd(xmm0, var_410);
                        var_1E0 = intrinsic_movapd(var_1E0, xmm0);
                        xmm0 = intrinsic_movddup(xmm0, xmm0);
                        xmm1 = intrinsic_movddup(xmm1, var_140);
                        rax = 0x0;
                        xmm2 = intrinsic_xorpd(xmm2, xmm2);
                        xmm3 = intrinsic_xorpd(xmm3, xmm3);
                        xmm3 = intrinsic_cvtsd2ss(xmm3, xmm0);
                        var_1F0 = intrinsic_movapd(var_1F0, xmm3);
                        xmm2 = intrinsic_cvtsd2ss(xmm2, xmm1);
                        var_280 = intrinsic_movapd(var_280, xmm2);
                        xmm0 = intrinsic_xorpd(xmm0, xmm0);
                        xmm1 = intrinsic_xorpd(xmm1, xmm1);
                        do {
                            xmm2 = intrinsic_movsd(xmm2, *(rbp + rax * 0x8 + 0xffffffffffffff98));
                            var_1F8 = intrinsic_movsd(var_1F8, xmm2);
                            var_290 = rax;
                            xmm2 = intrinsic_movsd(xmm2, *(rbp + rax * 0x8 + 0xffffffffffffff58));
                            var_288 = intrinsic_movsd(var_288, xmm2);
                            var_260 = intrinsic_movapd(var_260, xmm0);
                            xmm2 = intrinsic_subsd(xmm2, xmm0);
                            var_250 = intrinsic_movapd(var_250, xmm2);
                            xmm2 = intrinsic_ucomisd(xmm2, *0x17b680);
                            if (xmm2 > 0x0) {
                                xmm2 = intrinsic_movsd(xmm2, var_1F8);
                                xmm2 = intrinsic_subsd(xmm2, xmm1);
                                xmm3 = intrinsic_movapd(xmm3, xmm2);
                                xmm0 = intrinsic_movapd(xmm0, *(int128_t *) 0x17a9c0);
                                xmm3 = intrinsic_xorpd(xmm3, xmm0);
                                var_4B0 = intrinsic_movapd(var_4B0, xmm3);
                                xmm1 = intrinsic_xorpd(xmm1, xmm0);
                                var_180 = intrinsic_movapd(var_180, xmm1);
                                xmm0 = intrinsic_movapd(xmm0, var_250);
                                var_160 = intrinsic_movapd(var_160, xmm2);
                                xmm0 = intrinsic_divsd(xmm0, xmm2);
                                var_4C0 = intrinsic_movapd(var_4C0, xmm0);
                                xmm0 = intrinsic_xorpd(xmm0, xmm0);
                                xmm1 = intrinsic_xorpd(xmm1, xmm1);
                                var_270 = intrinsic_movapd(var_270, xmm1);
                                r13 = 0x0;
                                do {
                                    xmm1 = intrinsic_movaps(xmm1, var_270);
                                    var_100 = intrinsic_movaps(var_100, xmm1);
                                    xmm1 = intrinsic_movapd(xmm1, xmm0);
                                    xmm0 = intrinsic_movsd(xmm0, *(rbp + r13 * 0x8 + 0xffffffffffffffb8));
                                    var_270 = intrinsic_movaps(var_270, xmm0);
                                    xmm0 = intrinsic_movsd(xmm0, *(rbp + r13 * 0x8 + 0xffffffffffffff78));
                                    var_4D0 = intrinsic_movapd(var_4D0, xmm0);
                                    var_E0 = intrinsic_movapd(var_E0, xmm1);
                                    xmm0 = intrinsic_subsd(xmm0, xmm1);
                                    var_190 = intrinsic_movapd(var_190, xmm0);
                                    xmm0 = intrinsic_ucomisd(xmm0, *0x17b680);
                                    if (xmm0 > 0x0) {
                                        xmm0 = intrinsic_movapd(xmm0, var_270);
                                        xmm0 = intrinsic_subsd(xmm0, var_100);
                                        var_1A0 = intrinsic_movsd(var_1A0, xmm0);
                                        if (var_14C == 0x0) {
                                            CGContextSaveGState(rbx);
                                            xmm0 = intrinsic_movapd(xmm0, var_E0);
                                            var_2F0 = intrinsic_movsd(var_2F0, xmm0);
                                            xmm0 = intrinsic_movapd(xmm0, var_260);
                                            var_2E8 = intrinsic_movsd(var_2E8, xmm0);
                                            xmm0 = intrinsic_movapd(xmm0, var_190);
                                            var_2E0 = intrinsic_movsd(var_2E0, xmm0);
                                            xmm0 = intrinsic_movapd(xmm0, var_250);
                                            var_2D8 = intrinsic_movsd(var_2D8, xmm0);
                                            CGContextClipToRect(rbx, rsi);
                                            xmm0 = intrinsic_movapd(xmm0, var_E0);
                                            xmm1 = intrinsic_movapd(xmm1, var_260);
                                            CGContextTranslateCTM(rbx, rsi, rdx);
                                            xmm0 = intrinsic_movapd(xmm0, var_190);
                                            xmm0 = intrinsic_divsd(xmm0, var_1A0);
                                            xmm1 = intrinsic_movapd(xmm1, var_4C0);
                                            CGContextScaleCTM(rbx, rsi, rdx);
                                            xmm0 = intrinsic_movapd(xmm0, var_100);
                                            xmm0 = intrinsic_xorpd(xmm0, *(int128_t *) 0x17a9c0);
                                            xmm1 = intrinsic_movapd(xmm1, var_180);
                                            CGContextTranslateCTM(rbx, rsi, rdx);
                                            rsi = r14;
                                            CGContextDrawImage(rbx, rsi, rdx);
                                            rdi = rbx;
                                            CGContextRestoreGState(rdi);
                                        } else {
                                            xmm2 = intrinsic_movapd(xmm2, var_E0);
                                            xmm2 = intrinsic_unpcklpd(xmm2, var_260);
                                            xmm0 = intrinsic_movapd(xmm0, var_1E0);
                                            xmm2 = intrinsic_mulpd(xmm2, xmm0);
                                            xmm1 = intrinsic_movapd(xmm1, var_190);
                                            xmm1 = intrinsic_unpcklpd(xmm1, var_250);
                                            xmm1 = intrinsic_mulpd(xmm1, xmm0);
                                            var_190 = intrinsic_movapd(var_190, xmm1);
                                            COND = (*(int32_t *) (*(var_C8 + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0x4) & 0x400000) != 0x0;
                                            xmm1 = intrinsic_movapd(xmm1, xmm2);
                                            xmm1 = intrinsic_movhlps(xmm1, xmm1);
                                            var_4E0 = intrinsic_movaps(var_4E0, xmm1);
                                            xmm0 = intrinsic_movapd(xmm0, var_160);
                                            var_E8 = intrinsic_movsd(var_E8, xmm0);
                                            var_E0 = intrinsic_movapd(var_E0, xmm2);
                                            if (!COND) {
                                                var_470 = intrinsic_movapd(var_470, xmm2);
                                                xmm0 = intrinsic_movapd(xmm0, var_190);
                                                var_460 = intrinsic_movapd(var_460, xmm0);
                                                CGRectGetMaxY(rdi);
                                                xmm1 = intrinsic_movapd(xmm1, xmm0);
                                                xmm1 = intrinsic_subsd(xmm1, var_160);
                                                xmm0 = intrinsic_movapd(xmm0, var_4B0);
                                                var_E8 = intrinsic_movsd(var_E8, xmm0);
                                                xmm2 = intrinsic_movapd(xmm2, var_E0);
                                            }
                                            var_170 = intrinsic_movsd(var_170, xmm1);
                                            r15 = zero_extend_64(xmm2);
                                            xmm0 = intrinsic_movapd(xmm0, var_100);
                                            xmm0 = intrinsic_xorpd(xmm0, *(int128_t *) 0x17a9c0);
                                            var_100 = intrinsic_movapd(var_100, xmm0);
                                            r12 = r15;
                                            do {
                                                var_450 = intrinsic_movapd(var_450, xmm2);
                                                xmm0 = intrinsic_movapd(xmm0, var_190);
                                                var_440 = intrinsic_movapd(var_440, xmm0);
                                                CGRectGetMaxY(rdi);
                                                xmm1 = intrinsic_movsd(xmm1, var_170);
                                                xmm1 = intrinsic_ucomisd(xmm1, xmm0);
                                                if (xmm1 >= 0x0) {
                                                    break;
                                                }
                                                var_2C8 = intrinsic_movsd(var_2C8, xmm1);
                                                xmm0 = intrinsic_movsd(xmm0, var_1A0);
                                                var_2C0 = intrinsic_movsd(var_2C0, xmm0);
                                                xmm0 = intrinsic_movapd(xmm0, var_160);
                                                var_2B8 = intrinsic_movsd(var_2B8, xmm0);
                                                CGRectGetMaxY(rdi);
                                                xmm0 = intrinsic_ucomisd(xmm0, var_4E0);
                                                if (xmm0 <= 0x0) {
                                                    break;
                                                }
                                                xmm0 = intrinsic_movapd(xmm0, var_E0);
                                                var_110 = intrinsic_movsd(var_110, xmm0);
                                                r12 = r15;
                                                do {
                                                    var_430 = intrinsic_movapd(var_430, xmm0);
                                                    xmm0 = intrinsic_movapd(xmm0, var_190);
                                                    var_420 = intrinsic_movapd(var_420, xmm0);
                                                    CGRectGetMaxX(rdi);
                                                    xmm1 = intrinsic_movsd(xmm1, var_110);
                                                    xmm1 = intrinsic_ucomisd(xmm1, xmm0);
                                                    if (xmm1 >= 0x0) {
                                                        break;
                                                    }
                                                    CGContextSaveGState(rbx);
                                                    xmm0 = intrinsic_movaps(xmm0, var_1F0);
                                                    asm{
                                                    rcpss      xmm0, xmm0
                                                    };
                                                    xmm0 = intrinsic_cvtss2sd(xmm0, xmm0);
                                                    xmm1 = intrinsic_movapd(xmm1, xmm0);
                                                    xmm2 = intrinsic_movapd(xmm2, var_1E0);
                                                    xmm1 = intrinsic_mulsd(xmm1, xmm2);
                                                    xmm3 = intrinsic_movsd(xmm3, *0x17b418);
                                                    xmm4 = intrinsic_movapd(xmm4, xmm3);
                                                    xmm1 = intrinsic_addsd(xmm1, xmm4);
                                                    xmm1 = intrinsic_mulsd(xmm1, xmm0);
                                                    xmm0 = intrinsic_subsd(xmm0, xmm1);
                                                    xmm1 = intrinsic_movapd(xmm1, xmm0);
                                                    xmm1 = intrinsic_mulsd(xmm1, xmm2);
                                                    xmm1 = intrinsic_addsd(xmm1, xmm4);
                                                    xmm1 = intrinsic_mulsd(xmm1, xmm0);
                                                    xmm0 = intrinsic_subsd(xmm0, xmm1);
                                                    xmm1 = intrinsic_movaps(xmm1, var_280);
                                                    asm{
                                                    rcpss      xmm1, xmm1
                                                    };
                                                    xmm1 = intrinsic_cvtss2sd(xmm1, xmm1);
                                                    xmm2 = intrinsic_movapd(xmm2, xmm1);
                                                    xmm3 = intrinsic_movapd(xmm3, var_140);
                                                    xmm2 = intrinsic_mulsd(xmm2, xmm3);
                                                    xmm2 = intrinsic_addsd(xmm2, xmm4);
                                                    xmm2 = intrinsic_mulsd(xmm2, xmm1);
                                                    xmm1 = intrinsic_subsd(xmm1, xmm2);
                                                    xmm2 = intrinsic_movapd(xmm2, xmm1);
                                                    xmm2 = intrinsic_mulsd(xmm2, xmm3);
                                                    xmm2 = intrinsic_addsd(xmm2, xmm4);
                                                    xmm2 = intrinsic_mulsd(xmm2, xmm1);
                                                    xmm1 = intrinsic_subsd(xmm1, xmm2);
                                                    CGContextScaleCTM(rbx, rsi, rdx);
                                                    xmm0 = intrinsic_movsd(xmm0, var_110);
                                                    var_2B0 = intrinsic_movsd(var_2B0, xmm0);
                                                    xmm0 = intrinsic_movsd(xmm0, var_170);
                                                    var_2A8 = intrinsic_movsd(var_2A8, xmm0);
                                                    xmm0 = intrinsic_movsd(xmm0, var_1A0);
                                                    var_2A0 = intrinsic_movsd(var_2A0, xmm0);
                                                    xmm0 = intrinsic_movapd(xmm0, var_160);
                                                    var_298 = intrinsic_movsd(var_298, xmm0);
                                                    CGContextClipToRect(rbx, rsi);
                                                    xmm0 = intrinsic_movsd(xmm0, var_110);
                                                    xmm1 = intrinsic_movsd(xmm1, var_170);
                                                    CGContextTranslateCTM(rbx, rsi, rdx);
                                                    xmm0 = intrinsic_movapd(xmm0, var_100);
                                                    xmm1 = intrinsic_movapd(xmm1, var_180);
                                                    CGContextTranslateCTM(rbx, rsi, rdx);
                                                    rsi = r14;
                                                    CGContextDrawImage(rbx, rsi, rdx);
                                                    rdi = rbx;
                                                    CGContextRestoreGState(rdi);
                                                    xmm0 = intrinsic_movsd(xmm0, var_110);
                                                    xmm0 = intrinsic_addsd(xmm0, var_1A0);
                                                    var_110 = intrinsic_movsd(var_110, xmm0);
                                                    r12 = zero_extend_64(xmm0);
                                                    xmm0 = intrinsic_movapd(xmm0, var_E0);
                                                } while (true);
                                                xmm0 = intrinsic_movsd(xmm0, var_170);
                                                xmm0 = intrinsic_addsd(xmm0, var_E8);
                                                var_170 = intrinsic_movsd(var_170, xmm0);
                                                xmm2 = intrinsic_movapd(xmm2, var_E0);
                                            } while (true);
                                        }
                                    }
                                    r13 = r13 + 0x1;
                                    xmm0 = intrinsic_movapd(xmm0, var_4D0);
                                } while (r13 < 0x3);
                            }
                            rax = var_290 + 0x1;
                            xmm0 = intrinsic_movsd(xmm0, var_288);
                            xmm1 = intrinsic_movsd(xmm1, var_1F8);
                        } while (rax < 0x3);
                        CGContextEndTransparencyLayer(rbx);
                        rdx = var_B8;
                        rax = *(int32_t *) (rdx + 0x20);
                        *(int32_t *) (rdx + 0x20) = rax + 0x1;
                        if (rax == 0x0) {
                            os_unfair_lock_lock();
                        }
                    }
                } else {
                    var_110 = intrinsic_movsd(var_110, xmm1);
                    var_140 = intrinsic_movapd(var_140, xmm0);
                    rax = var_148;
                    if (rax != 0x0) {
                        r14 = rax;
                    }
                    if (r15 != 0x0) {
                        rdx = @selector(contentsCenter);
                        objc_msgSend_stret(var_1D0, r15, rdx);
                    } else {
                        xmm0 = intrinsic_xorpd(xmm0, xmm0);
                        var_1C0 = intrinsic_movapd(var_1C0, xmm0);
                        var_1D0 = intrinsic_movapd(var_1D0, xmm0);
                    }
                    CGContextBeginTransparencyLayer(rbx, 0x0);
                    CGContextSetBlendMode(rbx, 0x11);
                    rdi = var_C8;
                    if ((*(int32_t *) (*(rdi + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0x4) & 0x400000) == 0x0) {
                        xmm0 = intrinsic_movsd(xmm0, *0x17b440);
                        xmm0 = intrinsic_subsd(xmm0, var_1C8);
                        xmm0 = intrinsic_subsd(xmm0, var_1B8);
                        var_1C8 = intrinsic_movsd(var_1C8, xmm0);
                    }
                    rax = [rdi literalContentsCenter];
                    xmm0 = intrinsic_movsd(xmm0, var_1C0);
                    xmm2 = intrinsic_xorpd(xmm2, xmm2);
                    xmm2 = intrinsic_ucomisd(xmm2, xmm0);
                    xmm5 = intrinsic_movapd(xmm5, var_180);
                    if (xmm2 == 0x0) {
                        if (rax != 0x0) {
                            xmm0 = intrinsic_movsd(xmm0, *0x17b730);
                        } else {
                            xmm0 = intrinsic_movddup(xmm0, xmm5);
                            xmm1 = intrinsic_xorpd(xmm1, xmm1);
                            xmm1 = intrinsic_cvtsd2ss(xmm1, xmm0);
                            asm{
                            rcpss      xmm1, xmm1
                            };
                            xmm0 = intrinsic_cvtss2sd(0x0, xmm1);
                            xmm1 = intrinsic_movapd(xmm1, xmm0);
                            xmm1 = intrinsic_mulsd(xmm1, xmm5);
                            xmm3 = intrinsic_movsd(xmm3, *0x17b418);
                            xmm1 = intrinsic_addsd(xmm1, xmm3);
                            xmm1 = intrinsic_mulsd(xmm1, xmm0);
                            xmm0 = intrinsic_subsd(xmm0, xmm1);
                            xmm1 = intrinsic_movapd(xmm1, xmm0);
                            xmm1 = intrinsic_mulsd(xmm1, xmm5);
                            xmm1 = intrinsic_addsd(xmm1, xmm3);
                            xmm1 = intrinsic_mulsd(xmm1, xmm0);
                            xmm0 = intrinsic_subsd(xmm0, xmm1);
                        }
                        xmm1 = intrinsic_movsd(xmm1, *0x17b498);
                        xmm1 = intrinsic_mulsd(xmm1, xmm0);
                        xmm1 = intrinsic_addsd(xmm1, var_1D0);
                        var_1D0 = intrinsic_movsd(var_1D0, xmm1);
                        intrinsic_movsd(var_1C0, xmm0);
                    }
                    xmm1 = intrinsic_movsd(xmm1, var_1B8);
                    xmm2 = intrinsic_ucomisd(xmm2, xmm1);
                    if (xmm2 == 0x0) {
                        if (rax != 0x0) {
                            xmm1 = intrinsic_movsd(xmm1, *0x17b730);
                        } else {
                            xmm4 = intrinsic_movapd(xmm4, var_E0);
                            xmm1 = intrinsic_movddup(xmm1, xmm4);
                            xmm2 = intrinsic_xorpd(xmm2, xmm2);
                            xmm2 = intrinsic_cvtsd2ss(xmm2, xmm1);
                            asm{
                            rcpss      xmm2, xmm2
                            };
                            xmm1 = intrinsic_cvtss2sd(0x0, xmm2);
                            xmm2 = intrinsic_movapd(xmm2, xmm1);
                            xmm2 = intrinsic_mulsd(xmm2, xmm4);
                            xmm3 = intrinsic_movsd(xmm3, *0x17b418);
                            xmm2 = intrinsic_addsd(xmm2, xmm3);
                            xmm2 = intrinsic_mulsd(xmm2, xmm1);
                            xmm1 = intrinsic_subsd(xmm1, xmm2);
                            xmm2 = intrinsic_movapd(xmm2, xmm1);
                            xmm2 = intrinsic_mulsd(xmm2, xmm4);
                            xmm2 = intrinsic_addsd(xmm2, xmm3);
                            xmm2 = intrinsic_mulsd(xmm2, xmm1);
                            xmm1 = intrinsic_subsd(xmm1, xmm2);
                        }
                        xmm2 = intrinsic_movsd(xmm2, *0x17b498);
                        xmm2 = intrinsic_mulsd(xmm2, xmm1);
                        xmm2 = intrinsic_addsd(xmm2, var_1C8);
                        var_1C8 = intrinsic_movsd(var_1C8, xmm2);
                        intrinsic_movsd(var_1B8, xmm1);
                    }
                    intrinsic_movsd(var_38, xmm5);
                    xmm4 = intrinsic_movsd(xmm4, var_1D0);
                    xmm0 = intrinsic_addsd(xmm0, xmm4);
                    xmm4 = intrinsic_mulsd(xmm4, xmm5);
                    intrinsic_movsd(var_48, xmm4);
                    xmm0 = intrinsic_mulsd(xmm0, xmm5);
                    intrinsic_movsd(var_40, xmm0);
                    intrinsic_movsd(var_78, xmm5);
                    xmm2 = intrinsic_movsd(xmm2, *0x17b440);
                    xmm3 = intrinsic_movapd(xmm3, xmm2);
                    xmm3 = intrinsic_divsd(xmm3, var_110);
                    xmm4 = intrinsic_mulsd(xmm4, xmm3);
                    xmm0 = intrinsic_subsd(xmm0, xmm5);
                    xmm0 = intrinsic_mulsd(xmm0, xmm3);
                    xmm0 = intrinsic_addsd(xmm0, xmm5);
                    xmm4 = intrinsic_minsd(xmm4, xmm5);
                    xmm3 = intrinsic_xorpd(xmm3, xmm3);
                    xmm4 = intrinsic_maxsd(xmm4, xmm3);
                    var_88 = intrinsic_movsd(var_88, xmm4);
                    xmm0 = intrinsic_minsd(xmm0, xmm5);
                    xmm0 = intrinsic_maxsd(xmm0, xmm3);
                    var_80 = intrinsic_movsd(var_80, xmm0);
                    xmm4 = intrinsic_ucomisd(xmm4, xmm0);
                    if (xmm4 > 0x0) {
                        xmm0 = intrinsic_addsd(xmm0, xmm4);
                        xmm0 = intrinsic_mulsd(xmm0, *0x17b420);
                        intrinsic_movsd(var_80, xmm0);
                        intrinsic_movsd(var_88, xmm0);
                    }
                    xmm4 = intrinsic_movapd(xmm4, var_E0);
                    intrinsic_movsd(var_58, xmm4);
                    xmm0 = intrinsic_movsd(xmm0, var_1C8);
                    xmm1 = intrinsic_addsd(xmm1, xmm0);
                    xmm0 = intrinsic_mulsd(xmm0, xmm4);
                    intrinsic_movsd(var_68, xmm0);
                    xmm1 = intrinsic_mulsd(xmm1, xmm4);
                    intrinsic_movsd(var_60, xmm1);
                    intrinsic_movsd(var_98, xmm4);
                    xmm2 = intrinsic_divsd(xmm2, var_140);
                    xmm0 = intrinsic_mulsd(xmm0, xmm2);
                    xmm1 = intrinsic_subsd(xmm1, xmm4);
                    xmm1 = intrinsic_mulsd(xmm1, xmm2);
                    xmm1 = intrinsic_addsd(xmm1, xmm4);
                    xmm0 = intrinsic_minsd(xmm0, xmm4);
                    xmm0 = intrinsic_maxsd(xmm0, xmm3);
                    var_A8 = intrinsic_movsd(var_A8, xmm0);
                    xmm1 = intrinsic_minsd(xmm1, xmm4);
                    xmm1 = intrinsic_maxsd(xmm1, xmm3);
                    var_A0 = intrinsic_movsd(var_A0, xmm1);
                    xmm0 = intrinsic_ucomisd(xmm0, xmm1);
                    if (xmm0 > 0x0) {
                        xmm1 = intrinsic_addsd(xmm1, xmm0);
                        xmm1 = intrinsic_mulsd(xmm1, *0x17b420);
                        intrinsic_movsd(var_A0, xmm1);
                        intrinsic_movsd(var_A8, xmm1);
                    }
                    rsi = 0x0;
                    CGContextSetShouldAntialias(rbx, rsi);
                    rdi = var_B8;
                    CA::Transaction::unlock();
                    xmm0 = intrinsic_movapd(xmm0, var_410);
                    var_1E0 = intrinsic_movapd(var_1E0, xmm0);
                    xmm0 = intrinsic_movddup(xmm0, xmm0);
                    xmm1 = intrinsic_movddup(xmm1, var_140);
                    rax = 0x0;
                    xmm2 = intrinsic_xorpd(xmm2, xmm2);
                    xmm3 = intrinsic_xorpd(xmm3, xmm3);
                    xmm3 = intrinsic_cvtsd2ss(xmm3, xmm0);
                    var_1F0 = intrinsic_movapd(var_1F0, xmm3);
                    xmm2 = intrinsic_cvtsd2ss(xmm2, xmm1);
                    var_280 = intrinsic_movapd(var_280, xmm2);
                    xmm0 = intrinsic_xorpd(xmm0, xmm0);
                    xmm1 = intrinsic_xorpd(xmm1, xmm1);
                    do {
                        xmm2 = intrinsic_movsd(xmm2, *(rbp + rax * 0x8 + 0xffffffffffffff98));
                        var_1F8 = intrinsic_movsd(var_1F8, xmm2);
                        var_290 = rax;
                        xmm2 = intrinsic_movsd(xmm2, *(rbp + rax * 0x8 + 0xffffffffffffff58));
                        var_288 = intrinsic_movsd(var_288, xmm2);
                        var_260 = intrinsic_movapd(var_260, xmm0);
                        xmm2 = intrinsic_subsd(xmm2, xmm0);
                        var_250 = intrinsic_movapd(var_250, xmm2);
                        xmm2 = intrinsic_ucomisd(xmm2, *0x17b680);
                        if (xmm2 > 0x0) {
                            xmm2 = intrinsic_movsd(xmm2, var_1F8);
                            xmm2 = intrinsic_subsd(xmm2, xmm1);
                            xmm3 = intrinsic_movapd(xmm3, xmm2);
                            xmm0 = intrinsic_movapd(xmm0, *(int128_t *) 0x17a9c0);
                            xmm3 = intrinsic_xorpd(xmm3, xmm0);
                            var_4B0 = intrinsic_movapd(var_4B0, xmm3);
                            xmm1 = intrinsic_xorpd(xmm1, xmm0);
                            var_180 = intrinsic_movapd(var_180, xmm1);
                            xmm0 = intrinsic_movapd(xmm0, var_250);
                            var_160 = intrinsic_movapd(var_160, xmm2);
                            xmm0 = intrinsic_divsd(xmm0, xmm2);
                            var_4C0 = intrinsic_movapd(var_4C0, xmm0);
                            xmm0 = intrinsic_xorpd(xmm0, xmm0);
                            xmm1 = intrinsic_xorpd(xmm1, xmm1);
                            var_270 = intrinsic_movapd(var_270, xmm1);
                            r13 = 0x0;
                            do {
                                xmm1 = intrinsic_movaps(xmm1, var_270);
                                var_100 = intrinsic_movaps(var_100, xmm1);
                                xmm1 = intrinsic_movapd(xmm1, xmm0);
                                xmm0 = intrinsic_movsd(xmm0, *(rbp + r13 * 0x8 + 0xffffffffffffffb8));
                                var_270 = intrinsic_movaps(var_270, xmm0);
                                xmm0 = intrinsic_movsd(xmm0, *(rbp + r13 * 0x8 + 0xffffffffffffff78));
                                var_4D0 = intrinsic_movapd(var_4D0, xmm0);
                                var_E0 = intrinsic_movapd(var_E0, xmm1);
                                xmm0 = intrinsic_subsd(xmm0, xmm1);
                                var_190 = intrinsic_movapd(var_190, xmm0);
                                xmm0 = intrinsic_ucomisd(xmm0, *0x17b680);
                                if (xmm0 > 0x0) {
                                    xmm0 = intrinsic_movapd(xmm0, var_270);
                                    xmm0 = intrinsic_subsd(xmm0, var_100);
                                    var_1A0 = intrinsic_movsd(var_1A0, xmm0);
                                    if (var_14C == 0x0) {
                                        CGContextSaveGState(rbx);
                                        xmm0 = intrinsic_movapd(xmm0, var_E0);
                                        var_2F0 = intrinsic_movsd(var_2F0, xmm0);
                                        xmm0 = intrinsic_movapd(xmm0, var_260);
                                        var_2E8 = intrinsic_movsd(var_2E8, xmm0);
                                        xmm0 = intrinsic_movapd(xmm0, var_190);
                                        var_2E0 = intrinsic_movsd(var_2E0, xmm0);
                                        xmm0 = intrinsic_movapd(xmm0, var_250);
                                        var_2D8 = intrinsic_movsd(var_2D8, xmm0);
                                        CGContextClipToRect(rbx, rsi);
                                        xmm0 = intrinsic_movapd(xmm0, var_E0);
                                        xmm1 = intrinsic_movapd(xmm1, var_260);
                                        CGContextTranslateCTM(rbx, rsi, rdx);
                                        xmm0 = intrinsic_movapd(xmm0, var_190);
                                        xmm0 = intrinsic_divsd(xmm0, var_1A0);
                                        xmm1 = intrinsic_movapd(xmm1, var_4C0);
                                        CGContextScaleCTM(rbx, rsi, rdx);
                                        xmm0 = intrinsic_movapd(xmm0, var_100);
                                        xmm0 = intrinsic_xorpd(xmm0, *(int128_t *) 0x17a9c0);
                                        xmm1 = intrinsic_movapd(xmm1, var_180);
                                        CGContextTranslateCTM(rbx, rsi, rdx);
                                        rsi = r14;
                                        CGContextDrawImage(rbx, rsi, rdx);
                                        rdi = rbx;
                                        CGContextRestoreGState(rdi);
                                    } else {
                                        xmm2 = intrinsic_movapd(xmm2, var_E0);
                                        xmm2 = intrinsic_unpcklpd(xmm2, var_260);
                                        xmm0 = intrinsic_movapd(xmm0, var_1E0);
                                        xmm2 = intrinsic_mulpd(xmm2, xmm0);
                                        xmm1 = intrinsic_movapd(xmm1, var_190);
                                        xmm1 = intrinsic_unpcklpd(xmm1, var_250);
                                        xmm1 = intrinsic_mulpd(xmm1, xmm0);
                                        var_190 = intrinsic_movapd(var_190, xmm1);
                                        COND = (*(int32_t *) (*(var_C8 + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0x4) & 0x400000) != 0x0;
                                        xmm1 = intrinsic_movapd(xmm1, xmm2);
                                        xmm1 = intrinsic_movhlps(xmm1, xmm1);
                                        var_4E0 = intrinsic_movaps(var_4E0, xmm1);
                                        xmm0 = intrinsic_movapd(xmm0, var_160);
                                        var_E8 = intrinsic_movsd(var_E8, xmm0);
                                        var_E0 = intrinsic_movapd(var_E0, xmm2);
                                        if (!COND) {
                                            var_470 = intrinsic_movapd(var_470, xmm2);
                                            xmm0 = intrinsic_movapd(xmm0, var_190);
                                            var_460 = intrinsic_movapd(var_460, xmm0);
                                            CGRectGetMaxY(rdi);
                                            xmm1 = intrinsic_movapd(xmm1, xmm0);
                                            xmm1 = intrinsic_subsd(xmm1, var_160);
                                            xmm0 = intrinsic_movapd(xmm0, var_4B0);
                                            var_E8 = intrinsic_movsd(var_E8, xmm0);
                                            xmm2 = intrinsic_movapd(xmm2, var_E0);
                                        }
                                        var_170 = intrinsic_movsd(var_170, xmm1);
                                        r15 = zero_extend_64(xmm2);
                                        xmm0 = intrinsic_movapd(xmm0, var_100);
                                        xmm0 = intrinsic_xorpd(xmm0, *(int128_t *) 0x17a9c0);
                                        var_100 = intrinsic_movapd(var_100, xmm0);
                                        r12 = r15;
                                        do {
                                            var_450 = intrinsic_movapd(var_450, xmm2);
                                            xmm0 = intrinsic_movapd(xmm0, var_190);
                                            var_440 = intrinsic_movapd(var_440, xmm0);
                                            CGRectGetMaxY(rdi);
                                            xmm1 = intrinsic_movsd(xmm1, var_170);
                                            xmm1 = intrinsic_ucomisd(xmm1, xmm0);
                                            if (xmm1 >= 0x0) {
                                                break;
                                            }
                                            var_2C8 = intrinsic_movsd(var_2C8, xmm1);
                                            xmm0 = intrinsic_movsd(xmm0, var_1A0);
                                            var_2C0 = intrinsic_movsd(var_2C0, xmm0);
                                            xmm0 = intrinsic_movapd(xmm0, var_160);
                                            var_2B8 = intrinsic_movsd(var_2B8, xmm0);
                                            CGRectGetMaxY(rdi);
                                            xmm0 = intrinsic_ucomisd(xmm0, var_4E0);
                                            if (xmm0 <= 0x0) {
                                                break;
                                            }
                                            xmm0 = intrinsic_movapd(xmm0, var_E0);
                                            var_110 = intrinsic_movsd(var_110, xmm0);
                                            r12 = r15;
                                            do {
                                                var_430 = intrinsic_movapd(var_430, xmm0);
                                                xmm0 = intrinsic_movapd(xmm0, var_190);
                                                var_420 = intrinsic_movapd(var_420, xmm0);
                                                CGRectGetMaxX(rdi);
                                                xmm1 = intrinsic_movsd(xmm1, var_110);
                                                xmm1 = intrinsic_ucomisd(xmm1, xmm0);
                                                if (xmm1 >= 0x0) {
                                                    break;
                                                }
                                                CGContextSaveGState(rbx);
                                                xmm0 = intrinsic_movaps(xmm0, var_1F0);
                                                asm{
                                                rcpss      xmm0, xmm0
                                                };
                                                xmm0 = intrinsic_cvtss2sd(xmm0, xmm0);
                                                xmm1 = intrinsic_movapd(xmm1, xmm0);
                                                xmm2 = intrinsic_movapd(xmm2, var_1E0);
                                                xmm1 = intrinsic_mulsd(xmm1, xmm2);
                                                xmm3 = intrinsic_movsd(xmm3, *0x17b418);
                                                xmm4 = intrinsic_movapd(xmm4, xmm3);
                                                xmm1 = intrinsic_addsd(xmm1, xmm4);
                                                xmm1 = intrinsic_mulsd(xmm1, xmm0);
                                                xmm0 = intrinsic_subsd(xmm0, xmm1);
                                                xmm1 = intrinsic_movapd(xmm1, xmm0);
                                                xmm1 = intrinsic_mulsd(xmm1, xmm2);
                                                xmm1 = intrinsic_addsd(xmm1, xmm4);
                                                xmm1 = intrinsic_mulsd(xmm1, xmm0);
                                                xmm0 = intrinsic_subsd(xmm0, xmm1);
                                                xmm1 = intrinsic_movaps(xmm1, var_280);
                                                asm{
                                                rcpss      xmm1, xmm1
                                                };
                                                xmm1 = intrinsic_cvtss2sd(xmm1, xmm1);
                                                xmm2 = intrinsic_movapd(xmm2, xmm1);
                                                xmm3 = intrinsic_movapd(xmm3, var_140);
                                                xmm2 = intrinsic_mulsd(xmm2, xmm3);
                                                xmm2 = intrinsic_addsd(xmm2, xmm4);
                                                xmm2 = intrinsic_mulsd(xmm2, xmm1);
                                                xmm1 = intrinsic_subsd(xmm1, xmm2);
                                                xmm2 = intrinsic_movapd(xmm2, xmm1);
                                                xmm2 = intrinsic_mulsd(xmm2, xmm3);
                                                xmm2 = intrinsic_addsd(xmm2, xmm4);
                                                xmm2 = intrinsic_mulsd(xmm2, xmm1);
                                                xmm1 = intrinsic_subsd(xmm1, xmm2);
                                                CGContextScaleCTM(rbx, rsi, rdx);
                                                xmm0 = intrinsic_movsd(xmm0, var_110);
                                                var_2B0 = intrinsic_movsd(var_2B0, xmm0);
                                                xmm0 = intrinsic_movsd(xmm0, var_170);
                                                var_2A8 = intrinsic_movsd(var_2A8, xmm0);
                                                xmm0 = intrinsic_movsd(xmm0, var_1A0);
                                                var_2A0 = intrinsic_movsd(var_2A0, xmm0);
                                                xmm0 = intrinsic_movapd(xmm0, var_160);
                                                var_298 = intrinsic_movsd(var_298, xmm0);
                                                CGContextClipToRect(rbx, rsi);
                                                xmm0 = intrinsic_movsd(xmm0, var_110);
                                                xmm1 = intrinsic_movsd(xmm1, var_170);
                                                CGContextTranslateCTM(rbx, rsi, rdx);
                                                xmm0 = intrinsic_movapd(xmm0, var_100);
                                                xmm1 = intrinsic_movapd(xmm1, var_180);
                                                CGContextTranslateCTM(rbx, rsi, rdx);
                                                rsi = r14;
                                                CGContextDrawImage(rbx, rsi, rdx);
                                                rdi = rbx;
                                                CGContextRestoreGState(rdi);
                                                xmm0 = intrinsic_movsd(xmm0, var_110);
                                                xmm0 = intrinsic_addsd(xmm0, var_1A0);
                                                var_110 = intrinsic_movsd(var_110, xmm0);
                                                r12 = zero_extend_64(xmm0);
                                                xmm0 = intrinsic_movapd(xmm0, var_E0);
                                            } while (true);
                                            xmm0 = intrinsic_movsd(xmm0, var_170);
                                            xmm0 = intrinsic_addsd(xmm0, var_E8);
                                            var_170 = intrinsic_movsd(var_170, xmm0);
                                            xmm2 = intrinsic_movapd(xmm2, var_E0);
                                        } while (true);
                                    }
                                }
                                r13 = r13 + 0x1;
                                xmm0 = intrinsic_movapd(xmm0, var_4D0);
                            } while (r13 < 0x3);
                        }
                        rax = var_290 + 0x1;
                        xmm0 = intrinsic_movsd(xmm0, var_288);
                        xmm1 = intrinsic_movsd(xmm1, var_1F8);
                    } while (rax < 0x3);
                    CGContextEndTransparencyLayer(rbx);
                    rdx = var_B8;
                    rax = *(int32_t *) (rdx + 0x20);
                    *(int32_t *) (rdx + 0x20) = rax + 0x1;
                    if (rax == 0x0) {
                        os_unfair_lock_lock();
                    }
                }
            } else {
                CA::Transaction::unlock();
                if (CGImageIsMask(r14) != 0x0) {
                    CGContextClipToMask(rbx, r14, rdx);
                    CGContextSetFillColorWithColor(rbx, r12);
                    CGContextFillRect(rbx, r12);
                } else {
                    rax = var_148;
                    if (rax != 0x0) {
                        r14 = rax;
                    }
                    CGContextDrawImage(rbx, r14, rdx);
                }
                rax = *(int32_t *) (r13 + 0x20);
                *(int32_t *) (r13 + 0x20) = rax + 0x1;
                if (rax == 0x0) {
                    os_unfair_lock_lock();
                }
            }
            if (var_148 != 0x0) {
                CGImageRelease(var_148);
            }
            CGImageRelease(var_C0);
            r13 = var_B8;
        } else {
            CA::Transaction::unlock();
            [var_C8 _prepareContext:rbx];
            CGContextClipToRect(rbx, @selector(_prepareContext:));
            CGContextBeginTransparencyLayer(rbx, 0x0);
            rax = CA::Layer::layer_being_drawn(*(var_C8 + *_OBJC_IVAR_$_CALayer._attr + 0x8), r13);
            [rax drawInContext:rbx];
            CGContextEndTransparencyLayer(rbx);
            rax = *(int32_t *) (r13 + 0x20);
            *(int32_t *) (r13 + 0x20) = rax + 0x1;
            if (rax == 0x0) {
                os_unfair_lock_lock(*(r13 + 0x18));
            }
        }
        CGContextRestoreGState(rbx);
    }
    CA::Transaction::unlock();
    if (*___stack_chk_guard != var_30) {
        __stack_chk_fail();
    }
    return;
}

- (void)_renderBackgroundInContext:(struct CGContext *)arg1 {
    r14 = arg2;
    r15 = self;
    rbx = CA::Transaction::ensure();
    rax = *(int32_t *) (rbx + 0x20);
    *(int32_t *) (rbx + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(rbx + 0x18));
    }
    r12 = [r15 backgroundColor];
    if (r12 != 0x0) {
        CGColorGetAlpha(r12);
        xmm1 = intrinsic_xorpd(xmm1, xmm1);
        xmm0 = intrinsic_ucomisd(xmm0, xmm1);
        if (xmm0 > 0x0) {
            if (r15 != 0x0) {
                [var_B0 bounds];
            } else {
                xmm0 = intrinsic_xorpd(xmm0, xmm0);
                var_A0 = intrinsic_movapd(var_A0, xmm0);
                var_B0 = intrinsic_movapd(var_B0, xmm0);
            }
            [r15 cornerRadius];
            var_B8 = intrinsic_movsd(var_B8, xmm0);
            r13 = CGColorGetPattern(r12);
            if (r13 != 0x0) {
                CGContextGetBaseCTM(var_88, r14);
                var_C0 = *(var_88 + 0x28);
                var_C8 = *(var_88 + 0x20);
                var_D0 = *(var_88 + 0x18);
                var_D8 = *(var_88 + 0x10);
                rax = *var_88;
                var_E0 = *(var_88 + 0x8);
                var_E8 = rax;
                rsi = r14;
                CGContextGetCTM(var_88);
                var_30 = var_60;
                var_38 = var_68;
                var_40 = var_70;
                var_48 = var_78;
                var_50 = var_80;
                var_58 = var_88;
                if ((*(int32_t *) (*(r15 + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0x4) & 0x400000) == 0x0) {
                    xmm0 = intrinsic_movsd(xmm0, *0x17b418);
                    intrinsic_movupd(var_100, xmm0);
                    CGAffineTransformConcat(var_88, rsi);
                    var_30 = var_60;
                    var_38 = var_68;
                    var_40 = var_70;
                    var_48 = var_78;
                    var_50 = var_80;
                    var_58 = var_88;
                    CGPatternGetStep(r13);
                    xmm0 = intrinsic_movsd(xmm0, var_98);
                    fmod(xmm0, xmm1);
                    xmm1 = intrinsic_movapd(xmm1, xmm0);
                    xmm0 = intrinsic_xorpd(xmm0, xmm0);
                    CGContextSetPatternPhase(r14, rsi);
                }
                if (CGPatternGetShading(r13) != 0x0) {
                    xmm0 = intrinsic_movsd(xmm0, var_A0);
                    intrinsic_movsd(xmm1, var_98);
                    CGAffineTransformMakeScale(var_148, rsi);
                    CGAffineTransformConcat(var_88, rsi);
                    var_30 = var_60;
                    var_38 = var_68;
                    var_40 = var_70;
                    var_48 = var_78;
                    var_50 = var_80;
                    var_58 = var_88;
                }
                r13 = 0x1;
                CGContextSetBaseCTM(r14);
            } else {
                r13 = 0x0;
            }
            CGContextSaveGState(r14);
            if ([r15 edgeAntialiasingMask] == 0x0) {
                CGContextSetShouldAntialias(r14, 0x0);
            }
            CGContextSetFillColorWithColor(r14, r12);
            intrinsic_movsd(xmm0, var_B8);
            _CA_CGContextAddRoundRect(r14);
            CA::Transaction::unlock();
            CGContextFillPath(r14);
            rax = *(int32_t *) (rbx + 0x20);
            *(int32_t *) (rbx + 0x20) = rax + 0x1;
            if (rax == 0x0) {
                os_unfair_lock_lock(*(rbx + 0x18));
            }
            CGContextRestoreGState(r14);
            if (r13 != 0x0) {
                CGContextSetBaseCTM(r14);
            }
        }
    }
    CA::Transaction::unlock();
    return;
}

- (void)renderInContext:(struct CGContext *)arg1 {
    r12 = arg2;
    r15 = self;
    var_30 = *___stack_chk_guard;
    if ([self isHidden] != 0x0) goto loc_fbd4e;

    loc_fb4fa:
    [r15 opacity];
    xmm1 = intrinsic_xorpd(xmm1, xmm1);
    xmm0 = intrinsic_ucomiss(xmm0, xmm1);
    if (xmm0 <= 0x0) goto loc_fbd4e;

    loc_fb517:
    var_48 = intrinsic_movss(var_48, xmm0);
    if ((*(int32_t *) (*(r15 + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0x4) & 0x60000) == 0x0) {
        [r15 layoutIfNeeded];
        [r15 displayIfNeeded];
    }
    rbx = CA::Transaction::ensure();
    [r15 shadowOpacity];
    var_4C = intrinsic_movss(var_4C, xmm0);
    r13 = [r15 masksToBounds];
    rax = *(int32_t *) (rbx + 0x20);
    *(int32_t *) (rbx + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(rbx + 0x18));
    }
    rsi = @selector(retain);
    r14 = _objc_msgSend([r15 mask], rsi);
    CA::Transaction::unlock();
    if (r13 != 0x0) {
        [var_88 bounds];
        rsi = @selector(cornerRadius);
        _objc_msgSend(r15, rsi);
        var_40 = intrinsic_movsd(var_40, xmm0);
        CGContextSaveGState(r12);
        xmm0 = intrinsic_xorpd(xmm0, xmm0);
        xmm1 = intrinsic_movsd(xmm1, var_40);
        xmm1 = intrinsic_ucomisd(xmm1, xmm0);
        COND = xmm1 <= 0x0;
        xmm0 = intrinsic_movapd(xmm0, xmm1);
        if (!COND) {
            _CA_CGContextAddRoundRect(r12);
            rsp = (rsp - 0x20) + 0x20;
            CGContextClip(r12);
        } else {
            CGContextClipToRect(r12, rsi);
            rsp = (rsp - 0x20) + 0x20;
        }
    }
    if (r14 != 0x0) {
        rsi = 0x0;
        CGContextBeginTransparencyLayer(r12, rsi);
    }
    CGContextSaveGState(r12);
    xmm0 = intrinsic_movss(xmm0, var_48);
    xmm0 = intrinsic_ucomiss(xmm0, *(int32_t *) 0x17b9f8);
    var_58 = rbx;
    if (xmm0 < 0x0) {
        xmm0 = intrinsic_cvtss2sd(xmm0, xmm0);
        CGContextSetAlpha(r12, rsi);
        var_40 = 0x1;
    } else {
        var_40 = 0x0;
    }
    rbx = [r15 compositingFilter];
    var_48 = r14;
    if (rbx == 0x0) goto loc_fb91f;

    loc_fb6ea:
    var_31 = r13;
    r13 = @selector(isKindOfClass:);
    rdx = [NSString class];
    if (_objc_msgSend(rbx, r13) == 0x0) goto loc_fb724;

    loc_fb71d:
    rdi = rbx;
    goto loc_fb75e;

    loc_fb75e:
    rax = _CAInternAtom(rdi, 0x0, rdx);
    if (rax <= 0xd5) goto loc_fb7ba;

    loc_fb771:
    r13 = var_31;
    r14 = var_48;
    if (rax > 0x198) goto loc_fb804;

    loc_fb784:
    if (rax > 0x164) goto loc_fb846;

    loc_fb78f:
    if (rax == 0xd6) goto loc_fb8c7;

    loc_fb79a:
    if (rax == 0x125) goto loc_fb8ce;

    loc_fb7a5:
    rsi = 0x1;
    if (rax == 0x150) {
        CGContextSetBlendMode(r12, rsi);
        var_40 = 0x1;
    }
    goto loc_fb91f;

    loc_fb91f:
    xmm0 = intrinsic_xorpd(xmm0, xmm0);
    xmm1 = intrinsic_movss(xmm1, var_4C);
    xmm1 = intrinsic_ucomiss(xmm1, xmm0);
    if (xmm1 > 0x0) {
        rdx = var_58;
        rax = *(int32_t *) (rdx + 0x20);
        rcx = rax + 0x1;
        *(int32_t *) (rdx + 0x20) = rcx;
        if (rax == 0x0) {
            os_unfair_lock_lock(*(rdx + 0x18));
        }
        [r15 shadowOffset];
        var_A0 = intrinsic_movsd(var_A0, xmm0);
        var_98 = intrinsic_movsd(var_98, xmm1);
        [r15 shadowRadius];
        var_90 = intrinsic_movsd(var_90, xmm0);
        r14 = [r15 shadowColor];
        if (r14 != 0x0) {
            CGColorGetAlpha(r14);
            xmm1 = intrinsic_xorpd(xmm1, xmm1);
            xmm0 = intrinsic_ucomisd(xmm0, xmm1);
            if (xmm0 > 0x0) {
                xmm0 = intrinsic_movss(xmm0, var_4C);
                xmm0 = intrinsic_ucomiss(xmm0, *(int32_t *) 0x17b9f8);
                if (xmm0 != 0x0) {
                    var_31 = r13;
                    r13 = CGColorGetNumberOfComponents(r14);
                    var_40 = rsp;
                    rcx = 0xffffffff0 & r13 * 0x8 + 0xf;
                    rbx = rsp - rcx;
                    rax = CGColorGetComponents(r14);
                    rdx = SAR(r13 << 0x20, 0x1d);
                    memcpy(rbx, rax, rdx);
                    xmm0 = intrinsic_cvtss2sd(0x0, var_4C);
                    xmm0 = intrinsic_mulsd(xmm0, *(rbx + (SAR(0xffffffff00000000 + (r13 << 0x20), 0x1d))));
                    *(rbx + (SAR(0xffffffff00000000 + (r13
                            << 0x20), 0x1d))) = intrinsic_movsd(*(rbx + (SAR(0xffffffff00000000 + (r13
                            << 0x20), 0x1d))), xmm0);
                    rbx = CGColorCreate(CGColorGetColorSpace(r14), rbx);
                    rsp = var_40;
                    r13 = var_31;
                } else {
                    rbx = r14;
                }
                xmm0 = intrinsic_movsd(xmm0, var_90);
                xmm0 = intrinsic_addsd(xmm0, xmm0);
                xmm0 = intrinsic_cvtsd2ss(xmm0, xmm0);
                intrinsic_cvtss2sd(xmm2, xmm0);
                intrinsic_movsd(xmm0, var_A0);
                intrinsic_movsd(xmm1, var_98);
                CGContextSetShadowWithColor(r12, rbx, rdx, rcx);
                var_40 = 0x1;
                if (rbx != r14) {
                    CGColorRelease(rbx);
                }
            }
        }
        CA::Transaction::unlock();
        r14 = var_48;
    }
    if (var_40 == 0x0) {
        [r15 _renderBackgroundInContext:r12];
        [r15 _renderForegroundInContext:r12];
        [r15 _renderSublayersInContext:r12];
        [r15 _renderBorderInContext:r12];
    } else {
        CGContextBeginTransparencyLayer(r12, 0x0);
        [r15 _renderBackgroundInContext:r12];
        [r15 _renderForegroundInContext:r12];
        [r15 _renderSublayersInContext:r12];
        [r15 _renderBorderInContext:r12];
        CGContextEndTransparencyLayer(r12);
    }
    CGContextRestoreGState(r12);
    if (r14 != 0x0) {
        CA::Layer::get_frame_transform(*(r14 + *_OBJC_IVAR_$_CALayer._attr + 0x8), var_88);
        if (_CA_CGAffineTransformIsValid(var_88) != 0x0) {
            CGContextSaveGState(r12);
            CGContextGetBaseCTM(var_100, r12);
            CGContextConcatCTM(r12, r12);
            rax = *var_100;
            CGAffineTransformConcat(var_D0, r12);
            rax = *var_D0;
            CGContextSetBaseCTM(r12);
            CGContextSetBlendMode(r12, 0x16);
            CGContextBeginTransparencyLayer(r12, 0x0);
            [var_48 renderInContext:r12];
            CGContextEndTransparencyLayer(r12);
            rax = *var_100;
            r14 = var_48;
            CGContextSetBaseCTM(r12);
            CGContextRestoreGState(r12);
        }
        CGContextEndTransparencyLayer(r12);
    }
    if (r13 != 0x0) {
        CGContextRestoreGState(r12);
    }
    [r14 release];
    goto loc_fbd4e;

    loc_fbd4e:
    if (*___stack_chk_guard != var_30) {
        __stack_chk_fail();
    }
    return;

    loc_fb8ce:
    rsi = 0x5;
    goto loc_fb912;

    loc_fb912:
    CGContextSetBlendMode(r12, rsi);
    var_40 = 0x1;
    goto loc_fb91f;

    loc_fb8c7:
    rsi = 0x9;
    goto loc_fb912;

    loc_fb846:
    if (rax == 0x165) goto loc_fb8d5;

    loc_fb851:
    if (rax == 0x171) goto loc_fb8dc;

    loc_fb85c:
    if (rax != 0x172) goto loc_fb91f;

    loc_fb867:
    rsi = 0x1b;
    goto loc_fb912;

    loc_fb8dc:
    rsi = 0x1a;
    goto loc_fb912;

    loc_fb8d5:
    rsi = 0x3;
    goto loc_fb912;

    loc_fb804:
    rcx = rax + 0xfffffffffffffe56;
    if (rcx > 0x7) goto loc_fb871;

    loc_fb80f:
    goto
    *0xfbdbc[sign_extend_64(*(int32_t *) (0xfbdbc + rcx * 0x4)) + 0xfbdbc];

    loc_fb81f:
    rsi = 0x8;
    goto loc_fb912;

    loc_fb8b2:
    rsi = 0x14;
    goto loc_fb912;

    loc_fb8b9:
    rsi = 0x12;
    goto loc_fb912;

    loc_fb8c0:
    rsi = 0x13;
    goto loc_fb912;

    loc_fb871:
    if (rax == 0x20a) goto loc_fb8e3;

    loc_fb878:
    if (rax != 0x199) goto loc_fb91f;

    loc_fb883:
    rsi = 0x2;
    goto loc_fb912;

    loc_fb8e3:
    rsi = 0x19;
    goto loc_fb912;

    loc_fb7ba:
    r13 = var_31;
    r14 = var_48;
    if (rax <= 0x76) goto loc_fb829;

    loc_fb7c7:
    rcx = rax + 0xffffffffffffff7b;
    if (rcx > 0x8) goto loc_fb88d;

    loc_fb7d6:
    goto
    *0xfbd98[sign_extend_64(*(int32_t *) (0xfbd98 + rcx * 0x4)) + 0xfbd98];

    loc_fb7e6:
    rsi = 0x4;
    goto loc_fb912;

    loc_fb8ea:
    rsi = 0x18;
    goto loc_fb912;

    loc_fb8f1:
    rsi = 0x16;
    goto loc_fb912;

    loc_fb8f8:
    rsi = 0x17;
    goto loc_fb912;

    loc_fb8ff:
    rsi = 0x15;
    goto loc_fb912;

    loc_fb906:
    rsi = 0xa;
    goto loc_fb912;

    loc_fb88d:
    if (rax == 0x77) goto loc_fb90d;

    loc_fb892:
    if (rax != 0xb4) goto loc_fb91f;

    loc_fb89d:
    rsi = 0xb;
    goto loc_fb912;

    loc_fb90d:
    rsi = 0x11;
    goto loc_fb912;

    loc_fb829:
    if (rax == 0x49) goto loc_fb8a4;

    loc_fb82e:
    if (rax == 0x50) goto loc_fb8ab;

    loc_fb833:
    if (rax != 0x52) goto loc_fb91f;

    loc_fb83c:
    rsi = 0x6;
    goto loc_fb912;

    loc_fb8ab:
    rsi = 0x7;
    goto loc_fb912;

    loc_fb8a4:
    rsi = 0x10;
    goto loc_fb912;

    loc_fb724:
    rdx = [CAFilter class];
    if (_objc_msgSend(rbx, r13, rdx) == 0x0) goto loc_fb7f0;

    loc_fb749:
    rdi = [rbx type];
    goto loc_fb75e;

    loc_fb7f0:
    r13 = var_31;
    r14 = var_48;
    goto loc_fb91f;
}

- (void)displayIfNeeded {
    if ([self needsDisplay]) {
        [self display];
    }
}

- (_Bool)needsDisplay {
    rbx = self->_attr.layer;
    rax = CA::Transaction::ensure_compat();
    rcx = sign_extend_64(*(int32_t *) (rax + 0x8));
    if (rcx >= 0x0) {
        rcx = *(int32_t *) (rbx + rcx * 0x4 + 0x100);
        if (rcx == 0x0) {
            rcx = *(int32_t *) CA::Layer::thread_flags_(rbx);
        }
    } else {
        rcx = *(int32_t *) CA::Layer::thread_flags_(rbx);
    }
    rax = (rcx & 0x100) >> 0x8;
    return rax;
}

- (void)setNeedsDisplayInRect:(struct CGRect)arg1 {
    rbx = self->_attr.layer;
    if ((*(int32_t *) (rbx + 0x4) & 0x60000) == 0x0) {
        r15 = arg_0;
        r14 = CA::Transaction::ensure_compat();
        rax = *(int32_t *) (r14 + 0x20);
        *(int32_t *) (r14 + 0x20) = rax + 0x1;
        if (rax == 0x0) {
            os_unfair_lock_lock(*(r14 + 0x18));
        }
        xmm1 = intrinsic_movsd(xmm1, *(r15 + 0x10));
        xmm0 = intrinsic_xorpd(xmm0, xmm0);
        var_70 = intrinsic_movapd(var_70, xmm1);
        xmm0 = intrinsic_ucomisd(xmm0, xmm1);
        if (xmm0 != 0x0) {
            xmm1 = intrinsic_movsd(xmm1, *(r15 + 0x18));
            var_60 = intrinsic_movapd(var_60, xmm1);
            xmm0 = intrinsic_ucomisd(xmm0, xmm1);
            if (xmm0 != 0x0) {
                r12 = *(rbx + 0x10);
                if ([r12 contents] != 0x0) {
                    rax = *CABackingStoreGetTypeID::type;
                    var_30 = rax;
                    rdi = var_30;
                    r13 = CFGetTypeID(rax);
                    rax = *CABackingStoreGetTypeID::type;
                    if (rax == 0x0) {
                        rax = _CFRuntimeRegisterClass(CABackingStoreGetTypeID::klass);
                        rdi = var_30;
                        *CABackingStoreGetTypeID::type = rax;
                    }
                    if (r13 == rax) {
                        xmm0 = intrinsic_movupd(xmm0, *(int128_t *) r15);
                        xmm1 = intrinsic_movupd(xmm1, *(int128_t * )(rbx + 0x50));
                        xmm0 = intrinsic_subpd(xmm0, xmm1);
                        var_50 = intrinsic_movapd(var_50, xmm0);
                        xmm0 = intrinsic_movapd(xmm0, var_70);
                        var_40 = intrinsic_movsd(var_40, xmm0);
                        xmm2 = intrinsic_movapd(xmm2, var_60);
                        intrinsic_movsd(var_38, xmm2);
                        if ((*(int8_t *) (rbx + 0x33) & 0x8) != 0x0) {
                            [r12 contentsScale];
                            xmm1 = intrinsic_movddup(xmm1, xmm0);
                            xmm0 = intrinsic_movapd(xmm0, var_50);
                            xmm0 = intrinsic_mulpd(xmm0, xmm1);
                            var_50 = intrinsic_movapd(var_50, xmm0);
                            xmm0 = intrinsic_movapd(xmm0, xmm1);
                            xmm0 = intrinsic_mulpd(xmm0, var_40);
                            intrinsic_movapd(var_40, xmm0);
                            xmm2 = intrinsic_movapd(xmm2, xmm0);
                            xmm2 = intrinsic_movhlps(xmm2, xmm2);
                            rdi = var_30;
                        }
                        rax = 0x0;
                        xmm1 = intrinsic_movapd(xmm1, xmm0);
                        xmm0 = intrinsic_movsd(xmm0, *0x17b5e8);
                        xmm2 = intrinsic_ucomisd(xmm2, xmm0);
                        rsi = var_50;
                        asm{
                        cmova      rsi, rax
                        };
                        xmm1 = intrinsic_ucomisd(xmm1, xmm0);
                        asm{
                        cmova      rsi, rax
                        };
                        _CABackingStoreInvalidate(rdi, rsi);
                    }
                }
            }
        }
        CA::Layer::mark(rbx, r14, 0x100);
        CA::Transaction::unlock();
    }
    return;
}

- (void)setNeedsDisplay {
    rcx = *_CGRectInfinite;
    [self setNeedsDisplayInRect:rdx, rcx];
    return;
}

- (id)modelLayer {
    rbx = self->_attr.layer;
    CA::Transaction::ensure_compat();
    rax = CA::Layer::model_layer(rbx);
    if (rax != 0x0) {
        rax = *(rax + 0x10);
    } else {
        rax = 0x0;
    }
    return rax;
}

- (id)presentationLayer {
    CA::Layer *layer = static_cast<CA::Layer *>(self->_attr.layer);
    CA::Transaction::ensure_compat();
    return CA::Layer::presentation_layer(layer);

}

- (void)_cancelAnimationTimer {
    return;
}

- (_Bool)_scheduleAnimationTimer {
    return YES;
}

- (id)animationKeys {
    var_30 = *___stack_chk_guard;
    r14 = CA::Transaction::ensure_compat();
    rbx = [self modelLayer];
    if (rbx != 0x0) {
        rax = *(int32_t *) (r14 + 0x20);
        *(int32_t *) (r14 + 0x20) = rax + 0x1;
        if (rax == 0x0) {
            os_unfair_lock_lock(*(r14 + 0x18));
        }
        rbx = *(*(rbx + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0xe8);
        if (rbx != 0x0) {
            r13 = 0x0;
            rcx = rbx;
            do {
                if (*(rcx + 0x10) != 0x0) {
                    CMP(*(int8_t *) (rcx + 0x30) & 0xc, 0x1);
                    r13 = r13 + 0x0 + CARRY(RFLAGS(cf));
                }
                rcx = *rcx;
            } while (rcx != 0x0);
            if (r13 != 0x0) {
                r15 = r13 * 0x8;
                if (r15 <= 0x1000) {
                    r12 = rsp - (r15 + 0xf & 0xfffffffffffffff0);
                    rax = 0x0;
                    do {
                        rcx = *(rbx + 0x10);
                        if ((rcx != 0x0) && ((*(int8_t *) (rbx + 0x30) & 0xc) == 0x0)) {
                            *(r12 + rax * 0x8) = rcx;
                            rax = rax + 0x1;
                        }
                        rbx = *rbx;
                    } while (rbx != 0x0);
                    rbx = [NSArray arrayWithObjects:r12 count:r13];
                    if (r15 >= 0x1001) {
                        free(r12);
                    }
                } else {
                    r12 = malloc(r15);
                    if (r12 != 0x0) {
                        rax = 0x0;
                        do {
                            rcx = *(rbx + 0x10);
                            if ((rcx != 0x0) && ((*(int8_t *) (rbx + 0x30) & 0xc) == 0x0)) {
                                *(r12 + rax * 0x8) = rcx;
                                rax = rax + 0x1;
                            }
                            rbx = *rbx;
                        } while (rbx != 0x0);
                        rbx = [NSArray arrayWithObjects:r12 count:r13];
                        if (r15 >= 0x1001) {
                            free(r12);
                        }
                    } else {
                        rbx = 0x0;
                    }
                }
            } else {
                rbx = 0x0;
            }
        } else {
            rbx = 0x0;
        }
        CA::Transaction::unlock();
    } else {
        rbx = 0x0;
    }
    if (*___stack_chk_guard == var_30) {
        rax = rbx;
    } else {
        rax = __stack_chk_fail();
    }
    return rax;
}

- (id)animationForKey:(id)arg1 {
    r12 = arg2;
    r14 = CA::Transaction::ensure_compat();
    rbx = [self modelLayer];
    if (((rbx == 0x0) || (*(*(rbx + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0xe8) == 0x0)) || ([r12 length] == 0x0)) goto loc_fb014;

    loc_fafb1:
    rax = *(int32_t *) (r14 + 0x20);
    *(int32_t *) (r14 + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(r14 + 0x18));
    }
    rbx = *(*(rbx + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0xe8);
    if (rbx == 0x0) goto loc_fb019;

    loc_fafda:
    var_30 = _objc_msgSend;
    r13 = @selector(isEqualToString:);
    r15 = 0x0;
    goto loc_fafef;

    loc_fafef:
    if (((*(int8_t *) (rbx + 0x30) & 0xc) != 0x0) || (_objc_msgSend(*(rbx + 0x10), r13, r12) == 0x0)) goto loc_fb006;

    loc_fb01e:
    r14 = var_30;
    r15 = [[*(rbx + 0x8) retain] autorelease];
    goto loc_fb046;

    loc_fb046:
    CA::Transaction::unlock();
    goto loc_fb04e;

    loc_fb04e:
    rax = r15;
    return rax;

    loc_fb006:
    rbx = *rbx;
    if (rbx != 0x0) goto loc_fafef;

    loc_fb00e:
    r14 = var_30;
    goto loc_fb046;

    loc_fb019:
    r15 = 0x0;
    goto loc_fb046;

    loc_fb014:
    r15 = 0x0;
    goto loc_fb04e;
}

- (void)removeAnimationForKey:(id)arg1 {
    r12 = arg2;
    r14 = CA::Transaction::ensure_compat();
    rbx = [self modelLayer];
    if (((rbx == 0x0) || (*(*(rbx + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0xe8) == 0x0)) || ([r12 length] == 0x0)) goto .l1;

    loc_fae64:
    rax = *(int32_t *) (r14 + 0x20);
    *(int32_t *) (r14 + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(r14 + 0x18));
    }
    var_30 = _objc_msgSend;
    r15 = var_40;
    var_38 = rbx;
    *r15 = *(*(rbx + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0xe8);
    goto loc_fae9e;

    loc_fae9e:
    r13 = @selector(isEqualToString:);
    goto loc_faea5;

    loc_faea5:
    rbx = *r15;
    if (rbx == 0x0) goto loc_faef5;

    loc_faead:
    if (((*(int8_t *) (rbx + 0x30) & 0x4) != 0x0) || (_objc_msgSend(*(rbx + 0x10), r13, r12) == 0x0)) goto loc_faef0;

    loc_faec4:
    rax = *(int16_t *) (rbx + 0x30) & 0xffff;
    if ((rax & 0x12) != 0x0) goto loc_faee9;

    loc_faecc:
    *r15 = *rbx;
    schedule_stop_callback(rbx);
    CA::Layer::free_animation(rbx, 0x1);
    goto loc_faea5;

    loc_faee9:
    *(int16_t *) (rbx + 0x30) = rax | 0x4;
    goto loc_faef0;

    loc_faef0:
    r15 = rbx;
    goto loc_fae9e;

    loc_faef5:
    CA::Layer::set_animations(*(var_38 + *_OBJC_IVAR_$_CALayer._attr + 0x8));
    CA::Layer::mark_animations(*(var_38 + *_OBJC_IVAR_$_CALayer._attr + 0x8), var_30);
    CA::Transaction::unlock();
    return;

    .l1:
    return;
}

- (void)removeAllAnimations {
    r14 = CA::Transaction::ensure_compat();
    r15 = [self modelLayer];
    if (r15 != 0x0) {
        rax = *(r15 + *_OBJC_IVAR_$_CALayer._attr + 0x8);
        if (*(rax + 0xe8) != 0x0) {
            rcx = *(int32_t *) (r14 + 0x20);
            *(int32_t *) (r14 + 0x20) = rcx + 0x1;
            if (rcx == 0x0) {
                os_unfair_lock_lock(*(r14 + 0x18));
                rax = *(r15 + *_OBJC_IVAR_$_CALayer._attr + 0x8);
            }
            r13 = var_30;
            *r13 = *(rax + 0xe8);
            do {
                rbx = *r13;
                if (rbx == 0x0) {
                    break;
                }
                rax = *(int16_t *) (rbx + 0x30) & 0xffff;
                if ((rax & 0x12) == 0x0) {
                    *r13 = *rbx;
                    schedule_stop_callback(rbx);
                    CA::Layer::free_animation(rbx, 0x1);
                } else {
                    *(int16_t *) (rbx + 0x30) = rax | 0x4;
                    r13 = rbx;
                }
            } while (true);
            CA::Layer::set_animations(*(r15 + *_OBJC_IVAR_$_CALayer._attr + 0x8));
            CA::Layer::mark_animations(*(r15 + *_OBJC_IVAR_$_CALayer._attr + 0x8), r14);
            CA::Transaction::unlock();
        }
    }
    return;
}

- (void)addAnimation:(id)arg1 forKey:(id)arg2 {
    r14 = arg3;
    r12 = arg2;
    r15 = self;
    rdx = [CATransition class];
    if ([r12 isKindOfClass:rdx] != 0x0) {
        r14 = @"transition";
    }
    else {
        rax = [r14 length];
        if (rax == 0x0) {
            r14 = rax;
        }
    }
    r13 = [r12 copy];
    if (r13 == 0x0) goto .l3;

    loc_faaf6:
    r12 = CA::Transaction::ensure_compat();
    r15 = [r15 modelLayer];
    if (r15 == 0x0) goto loc_fac6a;

    loc_fab1a:
    rax = [r13 delegate];
    var_30 = rax;
    if ((rax == 0x0) && (CA::Transaction::get_value(*(r12 + 0x28), 0x17, 0x2) != 0x0)) {
        if (var_30 != 0x0) {
            [r13 setDelegate:rdx];
        }
    }
    if (CA::Transaction::get_value(*(r12 + 0x28), 0x18, 0x12) != 0x0) {
        xmm0 = intrinsic_movsd(xmm0, var_38);
    }
    else {
        xmm0 = intrinsic_movsd(xmm0, *0x17b5d8);
    }
    [r13 setDefaultDuration:rdx];
    [r13 duration];
    xmm0 = intrinsic_ucomisd(xmm0, *0x17b410);
    if (xmm0 <= 0x0) goto loc_fac7c;

    loc_fabce:
    rcx = var_40;
    rdx = 0x2;
    if (CA::Transaction::get_value(*(r12 + 0x28), 0x19, rdx) != 0x0) {
        rdx = var_40;
        if (rdx != 0x0) {
            [r13 setTimingFunction:rdx];
        }
    }
    if ([r13 isKindOfClass:[CAPropertyAnimation class], rcx] != 0x0) {
        rax = [r13 keyPath];
        if ((r14 != 0x0) && (rax == 0x0)) {
            [r13 setKeyPath:r14];
        }
    }
    CA::Layer::add_animation(*(r15 + *_OBJC_IVAR_$_CALayer._attr + 0x8), r13);
    goto loc_fac6a;

    loc_fac6a:
    [r13 release];
    return;

    .l3:
    return;

    loc_fac7c:
    rbx = lookup_delegate_methods(r12, var_30);
    if ((rbx & 0x40) != 0x0) {
        [var_30 animationDidStart:r13];
    }
    if (rbx < 0x0) {
        [var_30 animationDidStop:r13 finished:0x1];
    }
    [r13 release];
    if (r14 != 0x0) {
        [r15 removeAnimationForKey:r14];
    }
    return;
}

- (id)actionForKey:(id)arg1 {
    var_38 = arg2;
    r12 = self;
    r15 = CA::Transaction::ensure_compat();
    rax = *(int32_t *)(r15 + 0x20);
    *(int32_t *)(r15 + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(r15 + 0x18));
    }
    r14 = *(r12 + *_OBJC_IVAR_$_CALayer._attr + 0x8);
    if ((*(int8_t *)(r14 + 0x35) & 0x1) == 0x0) goto loc_fa8b0;

    loc_fa887:
    rdi = *(r14 + 0x70);
    if (rdi == 0x0) goto loc_fa8b0;

    loc_fa890:
    rbx = [rdi actionForLayer:r12 forKey:var_38];
    if (rbx != 0x0) goto loc_faa13;

    loc_fa8b0:
    rax = *(r14 + 0x80);
    var_30 = r15;
    if ((rax == 0x0) || (CA::AttrList::get(*rax, 0x1, 0x1) == 0x0)) goto loc_fa8ff;

    loc_fa8da:
    rbx = [var_50 objectForKey:var_38];
    r15 = var_30;
    if (rbx != 0x0) goto loc_faa13;

    loc_fa8ff:
    var_48 = r12;
    if ((*(int8_t *)(r14 + 0x34) & 0x8) == 0x0) goto loc_fa9be;

    loc_fa90e:
    rax = *(r14 + 0x80);
    rbx = var_48;
    if ((rax == 0x0) || (CA::AttrList::get(*rax, 0x1cb, 0x1) == 0x0)) {
        rax = [rbx class];
        _CAObject_defaultValueForAtom(rax, 0x1cb, 0x1, var_40);
    }
    rax = var_40;
    if (rax == 0x0) goto loc_fa9be;

    loc_fa967:
    r13 = @selector(objectForKey:);
    r15 = @"actions";
    r14 = @"style";
    goto loc_fa983;

    loc_fa983:
    rax = _objc_msgSend(rax, r13, r15);
    rbx = _objc_msgSend(rax, r13, var_38);
    if (rbx != 0x0) goto loc_faa0f;

    loc_fa9a8:
    rax = _objc_msgSend(var_40, r13, r14);
    var_40 = rax;
    if (rax != 0x0) goto loc_fa983;

    loc_fa9be:
    r14 = var_48;
    rbx = [[r14 class] defaultActionForKey:var_38];
    CA::Transaction::unlock();
    if (rbx == 0x0) {
        if ((*(int32_t *)(*(r14 + *_OBJC_IVAR_$_CALayer._attr + 0x8) + 0x4) & 0x40) == 0x0) {
            rbx = 0x0;
        }
        else {
            rbx = [CATransaction _implicitAnimationForLayer:r14 keyPath:var_38];
        }
    }
    goto loc_faa1b;

    loc_faa1b:
    rax = 0x0;
    if (rbx != *_kCFNull) {
        rax = rbx;
    }
    return rax;

    loc_faa0f:
    r15 = var_30;
    goto loc_faa13;

    loc_faa13:
    CA::Transaction::unlock();
    goto loc_faa1b;
}

- (void)replaceSublayer:(id)arg1 with:(id)arg2 {
    r14 = arg3;
    r13 = arg2;
    rbx = self;
    if (r13 == r14) goto .l1;

    loc_fa56b:
    rax = *(rbx + *_OBJC_IVAR_$_CALayer._attr + 0x8);
    if ((*(int32_t *)(rax + 0x4) & 0x60000) != 0x0) {
        [NSException raise:@"CALayerInvalidTree" format:@"expecting model layer not copy: %@"];
    }
    rax = *(r13 + *_OBJC_IVAR_$_CALayer._attr + 0x8);
    if ((*(int32_t *)(rax + 0x4) & 0x60000) != 0x0) {
        [NSException raise:@"CALayerInvalidTree" format:@"expecting model layer not copy: %@"];
        rax = *(r13 + *_OBJC_IVAR_$_CALayer._attr + 0x8);
    }
    r12 = *_OBJC_IVAR_$_CALayer._attr;
    if (*(rax + 0x8) != *(rbx + r12 + 0x8)) {
        [NSException raise:@"CALayerInvalid" format:@"replaced layer %@ is not a sublayer of %@"];
    }
    r15 = CA::Transaction::ensure_compat();
    r12 = *(rbx + r12 + 0x8);
    rax = *(int32_t *)(r15 + 0x20);
    *(int32_t *)(r15 + 0x20) = rax + 0x1;
    if (rax == 0x0) {
        os_unfair_lock_lock(*(r15 + 0x18));
    }
    if (r14 == 0x0) goto loc_fa6b0;

    loc_fa642:
    rax = *(r14 + *_OBJC_IVAR_$_CALayer._attr + 0x8);
    if ((*(int32_t *)(rax + 0x4) & 0x60000) != 0x0) {
        [NSException raise:@"CALayerInvalidTree" format:@"expecting model layer not copy: %@"];
        rax = *(r14 + *_OBJC_IVAR_$_CALayer._attr + 0x8);
    }
    rdi = *(rax + 0x8);
    if (rdi != 0x0) {
        CA::Layer::remove_sublayer(rdi, r15);
    }
    else {
        CFRetain(r14);
        CA::Layer::remove_from_context();
    }
    if (*(r12 + 0x20) == r13) goto loc_fa772;

    loc_fa6f2:
    CA::Layer::begin_change(r12, r15, @"sublayers", var_38);
    rcx = r12;
    do {
        rax = rcx;
        rcx = *(rax + 0x8);
    } while (rcx != 0x0);
    var_2C = *(int32_t *)(rax + 0xfc);
    CA::Layer::update_removed_sublayer(*(r13 + *_OBJC_IVAR_$_CALayer._attr + 0x8), r15);
    CA::Transaction::release_object(r15);
    rcx = *(r12 + 0x18);
    rax = rcx->_ivars;
    rdi = *(rcx + *_OBJC_IVAR_$_CALayerArray._ivars + 0x8);
    rbx = 0xffffffffffffffff;
    if (rdi == 0x0) goto loc_fa78d;

    loc_fa760:
    rsi = 0x0;
    goto loc_fa762;

    loc_fa762:
    if (*(rax + rsi * 0x8) == r13) goto loc_fa78a;

    loc_fa768:
    rsi = rsi + 0x1;
    if (rsi < rdi) goto loc_fa762;

    loc_fa78d:
    if (*(int8_t *)(rcx + *_OBJC_IVAR_$_CALayerArray._ivars + 0x20) != 0x0) goto loc_fa81c;

    loc_fa798:
    *(rax + rbx * 0x8) = r14;
    CA::Layer::update_added_sublayer(*(r14 + *_OBJC_IVAR_$_CALayer._attr + 0x8), r15, r12);
    rdi = *(r14 + *_OBJC_IVAR_$_CALayer._attr + 0x8);
    rax = sign_extend_64(*(int32_t *)(r15 + 0x8));
    if ((rax < 0x0) || (*(int32_t *)(rdi + rax * 0x4 + 0x100) == 0x0)) {
        *(int32_t *)CA::Layer::thread_flags_(rdi);
    }
    CA::Layer::update_for_changed_sublayers(r12, r15);
    CA::Layer::end_change(r12, r15, 0x1cd, @"sublayers");
    goto loc_fa806;

    loc_fa806:
    CA::Transaction::unlock();
    return;

    .l1:
    return;

    loc_fa81c:
    abort();
    return;

    loc_fa78a:
    rbx = rsi;
    goto loc_fa78d;

    loc_fa772:
    CA::Layer::set_mask(r12);
    CA::Transaction::release_object(r15);
    goto loc_fa806;

    loc_fa6b0:
    CA::Layer::remove_sublayer(r12, r15);
    CA::Transaction::release_object(r15);
    goto loc_fa806;
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

#pragma mark - Properties

- (BOOL)needsDisplayOnBoundsChange {
    CA::Layer *layer = static_cast<CA::Layer *>(self->_attr.layer);

    return static_cast<BOOL>((*(layer->value0x2e) & 0x2) >> 0x1);;
}

- (void)setNeedsDisplayOnBoundsChange:(BOOL)needsDisplayOnBoundsChange {
    CA::Layer::set_bit(static_cast<CA::Layer *>(self->_attr.layer), 0x154, 0x11, 0x57, reinterpret_cast<void (CA::Layer::*)(CA::Transaction *)>(needsDisplayOnBoundsChange & 0xff));
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

+ (void)CAMLParserStartElement:(CAMLParser *)arg2 {
    CALayer *layer = [[self alloc] init]; // CAMLParser
    [arg2 setElementValue:layer]; // CAMLParser
    [layer release];
}

+ (id)properties {
    // TODO:
    return _CAObject_propertyKeys(self, _cmd, rdx);
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
    r14 = *+[CALayer defaultValueForKey:]
    ::corners;
    if (r14 == 0x0) {
        r14 = [[NSNumber alloc] initWithUnsignedInt:0xf];
        *+[CALayer defaultValueForKey:]
        ::corners = r14;
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
    if (*(int32_t *) rax == rbx) goto loc_f7571;

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
    r14 = *+[CALayer defaultValueForKey:]
    ::one;
    if (r14 == 0x0) {
        r14 = [[NSNumber alloc] initWithInt:0x1];
        *+[CALayer defaultValueForKey:]
        ::one = r14;
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
    r14 = *+[CALayer defaultValueForKey:]
    ::defEdges;
    if (r14 == 0x0) {
        r14 = [[NSNumber alloc] initWithUnsignedInt:0xf];
        *+[CALayer defaultValueForKey:]
        ::defEdges = r14;
    }
    goto loc_f758c;

    loc_f721f:
    r14 = *+[CALayer defaultValueForKey:]
    ::inf;
    if (r14 == 0x0) {
        rax = [NSNumber alloc];
        intrinsic_movsd(xmm0, *0x17b428);
        r14 = [rax initWithDouble:rdx];
        *+[CALayer defaultValueForKey:]
        ::inf = r14;
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
    r14 = *+[CALayer defaultValueForKey:]
    ::defOffset;
    if (r14 == 0x0) {
        intrinsic_movsd(xmm1, *0x17b878);
        r14 = [[NSValue valueWithSize:rdx] retain];
        *+[CALayer defaultValueForKey:]
        ::defOffset = r14;
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
    r14 = *+[CALayer defaultValueForKey:]
    ::three;
    if (r14 == 0x0) {
        r14 = [[NSNumber alloc] initWithInt:0x3];
        *+[CALayer defaultValueForKey:]
        ::three = r14;
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
    goto
    *0xf75a0[sign_extend_64(*(int32_t *) (0xf75a0 + rax * 0x4)) + 0xf75a0];

    loc_f6fc4:
    r14 = *+[CALayer defaultValueForKey:]
    ::unitRect;
    if (r14 == 0x0) {
        var_70 = intrinsic_movaps(var_70, 0x0);
        intrinsic_movaps(var_60, intrinsic_movaps(0x0, *(int128_t *) 0x17a960));
        r14 = [[NSValue valueWithRect:rdx, rcx] retain];
        *+[CALayer defaultValueForKey:]
        ::unitRect = r14;
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
        r14 = CGColorCreate(rdi, +[CALayer defaultValueForKey:]
        ::values);
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
    r14 = *+[CALayer defaultValueForKey:]
    ::fullRect;
    if (r14 == 0x0) {
        var_50 = intrinsic_movaps(var_50, intrinsic_movaps(xmm0, *(int128_t *) 0x17ac40));
        intrinsic_movaps(var_40, 0x0);
        r14 = [[NSValue valueWithRect:rdx, rcx] retain];
        *+[CALayer defaultValueForKey:]
        ::fullRect = r14;
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
    r14 = *+[CALayer defaultValueForKey:]
    ::defPhase;
    if (r14 == 0x0) {
        r14 = [[NSValue valueWithSize:rdx] retain];
        *+[CALayer defaultValueForKey:]
        ::defPhase = r14;
    }
    goto loc_f758c;

    loc_f7383:
    r14 = *+[CALayer defaultValueForKey:]
    ::defAnchor;
    if (r14 == 0x0) {
        intrinsic_movaps(xmm1, intrinsic_movsd(xmm0, *0x17b420));
        r14 = [[NSValue valueWithPoint:rdx] retain];
        *+[CALayer defaultValueForKey:]
        ::defAnchor = r14;
    }
    goto loc_f758c;
}

+ (BOOL)needsLayoutForKey:(id)arg1 {
    return NO;
}


+ (void)CAMLParserEndElement:(id)arg2 {
    rbx = [arg2 elementValue]; // arg2 CAMLParser
    if ([rbx needsDisplayOnBoundsChange] != 0x0) {
        rax = [rbx contents];
        if (rax != 0x0) {
            rdi = rbx;
            [rdi setContents:rax];
        } else {
            rdi = rbx;
            [rdi setNeedsDisplay];
        }
    }
    return;
}

#pragma mark - Overridden

+ (BOOL)resolveInstanceMethod:(SEL)arg1 {
    return _CAObject_resolveInstanceMethod(self, arg1);
}
@end