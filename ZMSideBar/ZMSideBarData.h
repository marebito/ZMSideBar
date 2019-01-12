//
//  ZMSideBarData.h
//  ZMSideBar
//
//  Created by Yuri Boyka on 2019/1/12.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseItem : NSObject<NSCoding>
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *nameView;
@property(nonatomic, strong) NSImage *icon;
@property(nonatomic, copy) NSString *badge;
@property(nonatomic, strong) NSColor *badgeColor;
@property(nonatomic, assign) BOOL isHidden;
@property(nonatomic, strong) NSColor *colorText;
@property(nonatomic, strong) id identity;
@end

@interface Account : BaseItem

@end

@interface Section : BaseItem
@property(nonatomic, strong) NSMutableArray<Account *> *accounts;
@end

@interface AllSection : BaseItem
@property(nonatomic, strong) NSMutableArray<Section *> *sections;
- (void)dump;
- (void)moveItemAtIndex:(NSInteger)fromIndex
               inParent:(Section *)oldParent
                toIndex:(NSInteger)toIndex
               inParent:(Section *)newParent;
@end

@interface BaseItemMini : NSObject
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *nameView;
@property(nonatomic, strong) NSImage *icon;
@property(nonatomic, copy) NSString *badge;
@property(nonatomic, strong) NSColor *badgeColor;
@property(nonatomic, assign) BOOL isHidden;
@end

@interface AccountMini:BaseItem

@end

@interface SectionMini:BaseItem
@property(nonatomic, strong) NSMutableArray<AccountMini *> *accounts;
@end

@interface AllSectionMini : BaseItem
@property(nonatomic, strong) NSMutableArray<SectionMini *> *sections;
@end

@interface ZMSideBarData : NSObject

@end

NS_ASSUME_NONNULL_END
