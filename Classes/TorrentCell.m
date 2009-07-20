//
//  TorrentCell.m
//  rt-phone
//
//  Created by Gavin Gilmour on 19/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TorrentCell.h"

@implementation TorrentCell

@synthesize primaryLabel,secondaryLabel,myImageView;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {

        // Initialization code

        primaryLabel = [[UILabel alloc]init];
        primaryLabel.textAlignment = UITextAlignmentLeft;
        primaryLabel.font = [UIFont systemFontOfSize:13];

        secondaryLabel = [[UILabel alloc]init];
        secondaryLabel.textAlignment = UITextAlignmentLeft;
        secondaryLabel.font = [UIFont systemFontOfSize:8];

        myImageView = [[UIImageView alloc]init];

        [self.contentView addSubview:primaryLabel];
        [self.contentView addSubview:secondaryLabel];
        [self.contentView addSubview:myImageView];

    }

    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];

    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;

    frame= CGRectMake(boundsX+10 ,5, 35, 35);
    myImageView.frame = frame;
    frame= CGRectMake(boundsX+70 ,5, 200, 25);
    primaryLabel.frame = frame;
    frame= CGRectMake(boundsX+70 ,28, 100, 15);
    secondaryLabel.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    // NSLog(@"what the hell");
}


- (void)dealloc {
    [super dealloc];
}


@end
