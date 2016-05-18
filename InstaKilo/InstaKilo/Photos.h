//
//  Photos.h
//  InstaKilo
//
//  Created by Zach Smoroden on 2016-05-18.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photos : NSObject

@property (nonatomic) NSMutableArray *photos;
//@property (nonatomic) NSMutableArray *photoSets;

@property (nonatomic, readonly) NSMutableArray *locations;

+(instancetype)premadePhotoSet;


-(NSDictionary*)byLocation;
-(NSDictionary*)bySubject;

@end
