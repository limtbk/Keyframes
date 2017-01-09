//
//  MainWindow.m
//  keyframes-sample-macos
//
//  Created by Ivan Klymchuk on 1/9/17.

#import "MainWindow.h"

@implementation MainWindow

- (void)awakeFromNib {
    [self registerForDraggedTypes:@[NSFilenamesPboardType]];
}

- (NSDragOperation)draggingEntered:(id < NSDraggingInfo >)sender {
    return NSDragOperationCopy;
}

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
    return NSDragOperationCopy;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    NSPasteboard *pboard = [sender draggingPasteboard];
    NSArray *filenames = [pboard propertyListForType:NSFilenamesPboardType];
    
    if (1 == filenames.count) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DragNDrop" object:[filenames firstObject]];
        return YES;
    }
    return NO;
}

@end
