// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to POLBook.h instead.

@import CoreData;

extern const struct POLBookAttributes {
	__unsafe_unretained NSString *isFavorite;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *urlImage;
	__unsafe_unretained NSString *urlPdf;
} POLBookAttributes;

extern const struct POLBookRelationships {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *note;
	__unsafe_unretained NSString *pdf;
	__unsafe_unretained NSString *tag;
} POLBookRelationships;

@class POLAuthor;
@class POLImage;
@class POLNote;
@class POLPDF;
@class POLTag;

@interface POLBookID : NSManagedObjectID {}
@end

@interface _POLBook : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) POLBookID* objectID;

@property (nonatomic, strong) NSNumber* isFavorite;

@property (atomic) BOOL isFavoriteValue;
- (BOOL)isFavoriteValue;
- (void)setIsFavoriteValue:(BOOL)value_;

//- (BOOL)validateIsFavorite:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* urlImage;

//- (BOOL)validateUrlImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* urlPdf;

//- (BOOL)validateUrlPdf:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *author;

- (NSMutableSet*)authorSet;

@property (nonatomic, strong) POLImage *image;

//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *note;

- (NSMutableSet*)noteSet;

@property (nonatomic, strong) POLPDF *pdf;

//- (BOOL)validatePdf:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *tag;

- (NSMutableSet*)tagSet;

@end

@interface _POLBook (AuthorCoreDataGeneratedAccessors)
- (void)addAuthor:(NSSet*)value_;
- (void)removeAuthor:(NSSet*)value_;
- (void)addAuthorObject:(POLAuthor*)value_;
- (void)removeAuthorObject:(POLAuthor*)value_;

@end

@interface _POLBook (NoteCoreDataGeneratedAccessors)
- (void)addNote:(NSSet*)value_;
- (void)removeNote:(NSSet*)value_;
- (void)addNoteObject:(POLNote*)value_;
- (void)removeNoteObject:(POLNote*)value_;

@end

@interface _POLBook (TagCoreDataGeneratedAccessors)
- (void)addTag:(NSSet*)value_;
- (void)removeTag:(NSSet*)value_;
- (void)addTagObject:(POLTag*)value_;
- (void)removeTagObject:(POLTag*)value_;

@end

@interface _POLBook (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveIsFavorite;
- (void)setPrimitiveIsFavorite:(NSNumber*)value;

- (BOOL)primitiveIsFavoriteValue;
- (void)setPrimitiveIsFavoriteValue:(BOOL)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSString*)primitiveUrlImage;
- (void)setPrimitiveUrlImage:(NSString*)value;

- (NSString*)primitiveUrlPdf;
- (void)setPrimitiveUrlPdf:(NSString*)value;

- (NSMutableSet*)primitiveAuthor;
- (void)setPrimitiveAuthor:(NSMutableSet*)value;

- (POLImage*)primitiveImage;
- (void)setPrimitiveImage:(POLImage*)value;

- (NSMutableSet*)primitiveNote;
- (void)setPrimitiveNote:(NSMutableSet*)value;

- (POLPDF*)primitivePdf;
- (void)setPrimitivePdf:(POLPDF*)value;

- (NSMutableSet*)primitiveTag;
- (void)setPrimitiveTag:(NSMutableSet*)value;

@end
