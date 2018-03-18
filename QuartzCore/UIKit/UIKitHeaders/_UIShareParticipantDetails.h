//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "NSSecureCoding.h"

@class NSString, UIColor;

@interface _UIShareParticipantDetails : NSObject <NSSecureCoding>
{
    NSString *_participantID;
    NSString *_detailText;
    UIColor *_participantColor;
}

+ (_Bool)supportsSecureCoding;
@property(copy) UIColor *participantColor; // @synthesize participantColor=_participantColor;
@property(copy) NSString *detailText; // @synthesize detailText=_detailText;
@property(copy) NSString *participantID; // @synthesize participantID=_participantID;
- (void).cxx_destruct;
- (id)initWithCoder:(id)arg1;
- (void)encodeWithCoder:(id)arg1;

@end
