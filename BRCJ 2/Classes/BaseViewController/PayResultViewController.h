//
//  PayResultViewController.h
//  BRCJ
//
//  Created by wuchunyi on 2019/11/27.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BRBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
判断外边还是里面
*/


@interface PayResultViewController : BRBaseViewController

/**
 yes 是外边，no是里面
 */
@property (nonatomic,assign)BOOL isOut;

@end

NS_ASSUME_NONNULL_END
