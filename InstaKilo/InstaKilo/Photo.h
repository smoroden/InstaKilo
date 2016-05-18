//
//  Photo.h
//  InstaKilo
//
//  Created by Zach Smoroden on 2016-05-18.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *subject;
@property (nonatomic) NSString *location;


- (instancetype)initWithImage:(UIImage*)image andSubject:(NSString*)subject andLocation:(NSString*)location;
@end
