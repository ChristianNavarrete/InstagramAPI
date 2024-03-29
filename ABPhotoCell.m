//
//  ABPhotoCell.m
//  Jeremy Footage
//
//  Created by HoodsDream on 10/8/14.
//  Copyright (c) 2014 Asteroid Blues. All rights reserved.
//

#import "ABPhotoCell.h"
#import "ABPhotoController.h"

@implementation ABPhotoCell

-(void)setPhoto:(NSDictionary *)photo {
    _photo = photo;
    [ABPhotoController imageForPhoto:_photo size:@"thumbnail" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView = [[UIImageView alloc]init];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(like)];
        
        tap.numberOfTapsRequired = 2;
        
        [self addGestureRecognizer:tap];
        
        [self.contentView addSubview:self.imageView];
        
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
    
}

-(void)like {
    NSLog(@"Link:%@", self.photo[@"link"]);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
   NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/%@/likes?access_token=%@",self.photo[@"id"],accessToken];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self likeCompletion];
        });
    }];
    
    [task resume];
    
}

-(void)likeCompletion {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Liked!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    
    [alert show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
}

@end
