
/*
 * Describes a recipe.
 */
@interface Recipe : NSObject
{
}

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* instructions;
@property (nonatomic, retain) UIImage* image;

@end
