//
//  ZMSideBarViewController+TextFieldDelegate.m
//  ZMSideBar
//
//  Created by Yuri Boyka on 2019/1/12.
//  Copyright © 2019 Yuri Boyka. All rights reserved.
//

#import "ZMSideBarViewController+TextFieldDelegate.h"

@implementation ZMSideBarViewController (TextFieldDelegate)

- (void)controlTextDidEndEditing:(NSNotification *)obj
{
    NSTextField *textField = obj.object;
    NSInteger row = [self.sidebarOutlineView rowForView:textField];
    id item = [self.sidebarOutlineView itemAtRow:row];

    if ([item isKindOfClass:[Account class]])
    {
        ((Account *)item).name = textField.stringValue;
    }
}

@end
