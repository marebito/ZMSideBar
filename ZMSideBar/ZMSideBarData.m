//
//  ZMSideBarData.m
//  ZMSideBar
//
//  Created by Yuri Boyka on 2019/1/12.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMSideBarData.h"

@implementation BaseItem

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.name = @"";
        self.nameView = @"";
        self.icon = [NSImage imageNamed:@"account"];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.nameView = [aDecoder decodeObjectForKey:@"nameView"];
        self.icon = [aDecoder decodeObjectForKey:@"icon"];
        self.badge = [aDecoder decodeObjectForKey:@"badge"];
        self.badgeColor = [aDecoder decodeObjectForKey:@"badgeColor"];
        self.isHidden = [aDecoder decodeBoolForKey:@"isHidden"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.nameView forKey:@"nameView"];
    [aCoder encodeObject:self.icon forKey:@"icon"];
    [aCoder encodeObject:self.badge forKey:@"badge"];
    [aCoder encodeObject:self.badgeColor forKey:@"badgeColor"];
    [aCoder encodeBool:self.isHidden forKey:@"isHidden"];
}

- (instancetype)initWithName:(NSString *)name
                        icon:(NSImage *)icon
                    nameView:(NSString *)nameView
                       badge:(NSString *)badge
                  badgeColor:(NSColor *)badgeColor
{
    if (self = [super init])
    {
        self.name = name;
        self.nameView = nameView;
        self.icon = icon;
        self.badge = badge;
        self.badgeColor = badgeColor;
    }
    return self;
}

- (void)dump { NSLog(@"%@", self.name); }
@end

@implementation Account

- (void)dump
{
    NSLog(@"     Item: ");
    [super dump];
}

@end

@implementation Section

- (void)dump
{
    NSLog(@"Section: ");
    [super dump];

    for (Account *account in _accounts)
    {
        NSLog(@"  ");
        [account dump];
    }
}

@end

@implementation AllSection

- (void)moveItemAtIndex:(NSInteger)fromIndex
               inParent:(Section *)oldParent
                toIndex:(NSInteger)toIndex
               inParent:(Section *)newParent
{
    id removedItem = nil;
    if (!oldParent)
    {
        removedItem = self.sections[fromIndex];
        [self.sections removeObjectAtIndex:fromIndex];
    }
    else
    {
        removedItem = oldParent.accounts[fromIndex];
        [oldParent.accounts removeObjectAtIndex:fromIndex];
    }

    if (!newParent)
    {
        [self.sections insertObject:removedItem atIndex:toIndex];
    }
    else
    {
        [newParent.accounts insertObject:removedItem atIndex:toIndex];
    }
}

- (void)dump
{
    NSLog(@"AllSection: ");
    [super dump];

    for (Section *section in self.sections)
    {
        NSLog(@"  ");
        [section dump];
    }
}

@end

@implementation BaseItemMini

- (instancetype)initWithName:(NSString *)name
                        icon:(NSImage *)icon
                    nameView:(NSString *)nameView
                       badge:(NSString *)badge
                  badgeColor:(NSColor *)badgeColor
{
    if (self = [super init])
    {
        self.name = name;
        self.nameView = nameView;
        self.icon = icon;
        self.badge = badge;
        self.badgeColor = badgeColor;
    }
    return self;
}

@end

@implementation ZMSideBarData

@end
