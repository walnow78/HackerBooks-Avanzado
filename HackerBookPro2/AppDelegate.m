//
//  AppDelegate.m
//  HackerBookPro2
//
//  Created by Pawel Walicki on 4/5/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import "AppDelegate.h"
#import "POLCoreDataStack.h"
#import "POLBook.h"
#import "POLTag.h"
#import "POLBooksTableViewController.h"
#import "POLBookViewController.h"
@import CoreLocation;

@interface AppDelegate ()

// Propiedad de stack de core data

@property (nonatomic,strong) POLCoreDataStack *stack;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
       
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Inicializo el stack
    
    self.stack = [POLCoreDataStack coreDataStackWithModelName:@"Model"];
    
    // Compruebo si es la primera vez que arranca la aplicación
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *json = [userDefault objectForKey:@"json"];
    
    if (json == nil) {
        
        // Es la primera vez, descargo el json y inserto los datos.
  
        [self saveJsonInSandboxFromUrl:[[NSURL alloc] initWithString:@"https://keepcodigtest.blob.core.windows.net/containerblobstest/books_readable.json"]];
        [self insertJsonToCoreData];
        
    }
    
    // Recupero los tag de los libros
    
    NSFetchRequest *requestTag = [NSFetchRequest fetchRequestWithEntityName:[POLTag entityName]];
    
    requestTag.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:POLTagAttributes.name
                                                          ascending:YES
                                                           selector:@selector(compare:)]];
    
    
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:requestTag
                                                                         managedObjectContext:self.stack.context
                                                                           sectionNameKeyPath:nil
                                                                                    cacheName:nil];
    // Creo los VC
    
    //POLBooksTableViewController *booksVC = [[POLBooksTableViewController alloc] initWithFetchedResultsController:fc
    //                                                                                            style:UITableViewStylePlain];
    
    POLBooksTableViewController *booksVC = [[POLBooksTableViewController alloc] initWithContext:self.stack.context style:UITableViewStylePlain];

    // Recupero la información del primero libro del primer tag de la tabla.
    
    NSArray *t = [self.stack executeFetchRequest:requestTag errorBlock:^(NSError *error) {
        
        if (error) {
            NSLog(@"Error");
        }else{
            
        }
    }];
    
    // Compruebo que exista algún tag.
    
    POLBook *book;
    
    if ([t count] >0) {
        POLTag *tags = [t objectAtIndex:0];
        
        book = [[tags.book allObjects] objectAtIndex:0];
    }
   
    UINavigationController *booksNC = [[UINavigationController alloc] initWithRootViewController:booksVC];

    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        // For tablet

        POLBookViewController *bookVC = [[POLBookViewController alloc] initWithModel:book];
        
        UINavigationController *bookNC = [[UINavigationController alloc] initWithRootViewController:bookVC];
        
        UISplitViewController *splitVC = [[UISplitViewController alloc] init];
        
        // Asignación de los delegados
        
        booksVC.delegate = bookVC;
        
        splitVC.viewControllers = @[booksNC, bookNC];
        
        self.window.rootViewController = splitVC;
        
    }else{
        
        // For phone

        booksVC.delegate = booksVC;
        
        self.window.rootViewController = booksNC;
        
    }
    
    // Arranco el autosave
    
    [self autoSave];    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self.stack saveWithErrorBlock:^(NSError *error) {
        
        if (error) {
            NSLog(@"Error autosave: %@", error.localizedDescription);
        }else{
            NSLog(@"Autoguardado ...");
        }
    }];

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Utils

-(void) saveJsonInSandboxFromUrl: (NSURL*) url{
    
    NSError *error;
    
    // Descargo el json
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url
                                                 options:NSDataReadingUncached
                                                   error:&error];
    
    if (data != nil) {
        
        // Guardo el archivo en los documentos de la sandbox
        
        NSFileManager *filemanager = [NSFileManager defaultManager];
        
        NSURL* patch = [[filemanager URLsForDirectory:NSDocumentDirectory
                                            inDomains:NSUserDomainMask] lastObject];
        patch = [patch URLByAppendingPathComponent:[url lastPathComponent]];
        
        BOOL retorno;
        
        retorno = [data writeToURL:patch options:NSDataWritingAtomic error:&error];
        
        if (retorno==YES) {
            
            // No tengo ningún error, marco que no es la primera vez
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            
            [userDefault setObject:[url lastPathComponent] forKey:@"json"];
            
            [userDefault synchronize];
            
        }else{
            NSLog(@"Error guardando el json en Sandbox: %@", error.localizedDescription);
        }
        
    }else{
        NSLog(@"Error descargando json: %@", error.localizedDescription);
    }
    
}

-(void) insertJsonToCoreData{
    
    // Leo el json de la sandBox
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Recupero la ruta de Directory
    
    NSURL *patch = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    // Concateno el nombre del fichero a la ruta
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    patch = [patch URLByAppendingPathComponent:[userDefault objectForKey:@"json"]];
    
    NSError *error;
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:patch options:NSDataReadingUncached error:&error];
    
    if (data != nil) {
        
        // Serializo el json
        
        id json = [NSJSONSerialization JSONObjectWithData:data
                                                  options:kNilOptions
                                                    error:&error];
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            
            // Es un diccionario
            
            [POLBook bookWithDictionary:json context:self.stack.context];
            
        }else{
            
            // Es un array de diccionarios
            
            for (NSDictionary *each in json) {
                
                [POLBook bookWithDictionary:each context:self.stack.context];
            }
            
        }
        
    }else{
        NSLog(@"Error al convertir json en array: %@", error.localizedDescription);
    }
    
}
#pragma mark - Autosave

-(void)autoSave{
    
    [self save];
    
    // Llamada recursiva cada 5 seg.
    
    [self performSelector:@selector(autoSave)
               withObject:nil
               afterDelay:5];
    
}

-(void) save{
    
    // Guardo los datos en core data
    [self.stack saveWithErrorBlock:^(NSError *error) {
        
        if (error) {
            NSLog(@"Error autosave: %@", error.localizedDescription);
        }
    }];
}

@end
