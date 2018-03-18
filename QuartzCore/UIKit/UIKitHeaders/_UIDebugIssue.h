//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "_UIDebugIssueReporting.h"

@class NSArray, NSString, _UIDebugIssueReport;

__attribute__((visibility("hidden")))
@interface _UIDebugIssue : NSObject <_UIDebugIssueReporting>
{
    NSString *_description;
    NSString *_prefix;
    _UIDebugIssueReport *_subissueReport;
}

+ (id)issueWithFormat:(id)arg1;
+ (id)issueWithDescription:(id)arg1;
@property(readonly, nonatomic, getter=_subissueReport) _UIDebugIssueReport *subissueReport; // @synthesize subissueReport=_subissueReport;
@property(copy, nonatomic) NSString *prefix; // @synthesize prefix=_prefix;
@property(copy, nonatomic) NSString *description; // @synthesize description=_description;
- (void).cxx_destruct;
- (void)addIssue:(id)arg1;
@property(readonly, copy, nonatomic) NSArray *subissues;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

