//
//  ABPhotoController.h
//  Jeremy Footage
//
//  Created by HoodsDream on 10/13/14.
//  Copyright (c) 2014 Asteroid Blues. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABPhotoController : NSObject

+(void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion;

@end
