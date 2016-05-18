//
//  Photos.m
//  InstaKilo
//
//  Created by Zach Smoroden on 2016-05-18.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import "Photos.h"
#import <UIKit/UIKit.h>
#import "Photo.h"

@implementation Photos

- (instancetype)init
{
    self = [super init];
    if (self) {
        _photos = [@[] mutableCopy];
        //_locations = [@[] mutableCopy];
        
    }
    return self;
}

+ (instancetype)premadePhotoSet {
    Photos *newData = [[Photos alloc] init];
    
//    [newData.subjects addObject:@"Subject 1"];
//    [newData.subjects addObject:@"Subject 2"];
//    [newData.subjects addObject:@"Subject 3"];
//    
//    
//    [newData.photoSets addObject:[@[[UIImage imageNamed:@"img0"],
//                                    [UIImage imageNamed:@"img1"],
//                                    [UIImage imageNamed:@"img2"]] mutableCopy]];
//    
//    [newData.photoSets addObject:[@[[UIImage imageNamed:@"img3"],
//                                    [UIImage imageNamed:@"img4"],
//                                    [UIImage imageNamed:@"img5"]] mutableCopy]];
//    
//    [newData.photoSets addObject:[@[[UIImage imageNamed:@"img6"],
//                                    [UIImage imageNamed:@"img7"],
//                                    [UIImage imageNamed:@"img8"],
//                                    [UIImage imageNamed:@"img9"]] mutableCopy]];
//
    
    [newData.photos addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:@"img0"] andSubject:@"Subject 1" andLocation:@"Vancouver"]];
    [newData.photos addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:@"img1"] andSubject:@"Subject 2" andLocation:@"Nature"]];
    [newData.photos addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:@"img2"] andSubject:@"Subject 3" andLocation:@"Vancouver"]];
    [newData.photos addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:@"img3"] andSubject:@"Subject 1" andLocation:@"Italy"]];
    [newData.photos addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:@"img4"] andSubject:@"Subject 2" andLocation:@"Vancouver"]];
    [newData.photos addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:@"img5"] andSubject:@"Subject 3" andLocation:@"Nature"]];
    [newData.photos addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:@"img6"] andSubject:@"Subject 1" andLocation:@"Vancouver"]];
    [newData.photos addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:@"img7"] andSubject:@"Subject 2" andLocation:@"Italy"]];
    [newData.photos addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:@"img8"] andSubject:@"Subject 3" andLocation:@"Vancouver"]];
    [newData.photos addObject:[[Photo alloc] initWithImage:[UIImage imageNamed:@"img9"] andSubject:@"Subject 1" andLocation:@"Italy"]];
    
    return newData;
    
}

-(NSDictionary*)byLocation {
    
    NSMutableDictionary *sortedPhotos = [@{} mutableCopy];
    
    for (Photo* photo in self.photos) {
        if (!sortedPhotos[photo.location]) {
            sortedPhotos[photo.location] = [@[photo] mutableCopy];
        } else {
            [sortedPhotos[photo.location] addObject:photo];
        }
    }
    
    
    return sortedPhotos;
}
-(NSDictionary*)bySubject {
    NSMutableDictionary *sortedPhotos = [@{} mutableCopy];
    
    for (Photo* photo in self.photos) {
        if (!sortedPhotos[photo.subject]) {
            sortedPhotos[photo.subject] = [@[photo] mutableCopy];
        } else {
            [sortedPhotos[photo.subject] addObject:photo];
        }
    }
    
    
    return sortedPhotos;
}

@end
