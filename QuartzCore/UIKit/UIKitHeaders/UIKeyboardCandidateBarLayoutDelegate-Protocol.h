//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "UICollectionViewDelegate.h"

@class NSIndexPath, UICollectionView, UICollectionViewLayout;

@protocol UIKeyboardCandidateBarLayoutDelegate <UICollectionViewDelegate>
- (struct CGSize)sizeOfDummyItemForCollectionView:(UICollectionView *)arg1 layout:(UICollectionViewLayout *)arg2;
- (struct CGSize)collectionView:(UICollectionView *)arg1 layout:(UICollectionViewLayout *)arg2 sizeForItemAtIndexPath:(NSIndexPath *)arg3;

@optional
- (void)candidateBarLayoutDidFinishPreparingLayout;
- (double)leftMarginForCollectionView:(UICollectionView *)arg1 layout:(UICollectionViewLayout *)arg2;
@end

