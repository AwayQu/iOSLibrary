//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "NSCoding.h"

@class NSMutableArray, NSString;

__attribute__((visibility("hidden")))
@interface _UITraitStorage : NSObject <NSCoding>
{
    NSMutableArray *_records;
    NSString *_keyPath;
    id _object;
}

@property(readonly, nonatomic) __weak id object; // @synthesize object=_object;
@property(readonly, nonatomic) NSString *keyPath; // @synthesize keyPath=_keyPath;
- (void).cxx_destruct;
- (void)applyRecordsMatchingTraitCollection:(id)arg1;
- (void)addRecord:(id)arg1;
- (id)records;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (id)initWithObject:(id)arg1 keyPath:(id)arg2;

@end

