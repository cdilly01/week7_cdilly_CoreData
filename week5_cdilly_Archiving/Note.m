//
//  Note.m
//  week7_cdilly_CoreData
//
//  Created by A Student on 6/11/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "Note.h"

static NSString *const NOTETEXT = @"noteText";

@implementation Note

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.noteText forKey:NOTETEXT];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _noteText = [coder decodeObjectForKey:NOTETEXT];
    }
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat: @"%@", _noteText];
}

@end
