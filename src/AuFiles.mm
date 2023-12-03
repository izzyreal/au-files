#import "AuFiles.hpp"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AuFiles : NSObject

- (void)writeToFileAU;
- (void)writeToFileStandalone;

@end

@implementation AuFiles

- (NSURL *)createDocumentsDirectoryInSharedContainer {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *groupURL = [fileManager containerURLForSecurityApplicationGroupIdentifier:@"group.nl.izmar.aufiles"];
    NSURL *documentsURL = [groupURL URLByAppendingPathComponent:@"Documents"];

    if (![fileManager fileExistsAtPath:[documentsURL path]]) {
        NSError *error = nil;
        [fileManager createDirectoryAtURL:documentsURL withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"Error creating Documents directory in shared container: %@", error.localizedDescription);
            return nil;
        }
    }

    return documentsURL;
}

- (void)writeToFileAU {
    NSString *content = @"foo";

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *groupURL = [fileManager containerURLForSecurityApplicationGroupIdentifier:@"group.nl.izmar.aufiles"];
    NSURL *documentsURL = [groupURL URLByAppendingPathComponent:@"Documents"];

    NSString *filePath = [[documentsURL URLByAppendingPathComponent:@"au-example.txt"] path];

    NSError *error;
    BOOL success = [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];

    if (!success) {
        NSLog(@"Error writing file: %@", error.localizedDescription);
    }
}

- (void)writeToFileStandalone {
    NSString *content = @"bar";

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *groupURL = [fileManager containerURLForSecurityApplicationGroupIdentifier:@"group.nl.izmar.aufiles"];
    NSURL *documentsURL = [groupURL URLByAppendingPathComponent:@"Documents"];

    NSString *filePath = [[documentsURL URLByAppendingPathComponent:@"standalone-example.txt"] path];

    NSError *error;
    BOOL success = [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];

    if (!success) {
        NSLog(@"Error writing file: %@", error.localizedDescription);
    }
}

- (void)syncToDocuments {
    NSFileManager *fileManager = [NSFileManager defaultManager];

    // Get the shared App Group container's Documents directory URL
    NSURL *sharedDocumentsURL = [[fileManager containerURLForSecurityApplicationGroupIdentifier:@"group.nl.izmar.aufiles"] URLByAppendingPathComponent:@"Documents"];

    // Get the local Documents directory URL
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *localDocumentsDirectory = [paths objectAtIndex:0];
    NSURL *localDocumentsURL = [NSURL fileURLWithPath:localDocumentsDirectory];

    NSError *error = nil;
    NSArray *sharedDirectoryContents = [fileManager contentsOfDirectoryAtURL:sharedDocumentsURL
                                                 includingPropertiesForKeys:nil
                                                                    options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                      error:&error];
    if (error) {
        NSLog(@"Error reading shared Documents directory: %@", error.localizedDescription);
        return;
    }

    for (NSURL *sourceURL in sharedDirectoryContents) {
        NSURL *destinationURL = [localDocumentsURL URLByAppendingPathComponent:[sourceURL lastPathComponent]];

        NSError *copyError = nil;
        // Remove existing file if it exists
        if ([fileManager fileExistsAtPath:[destinationURL path]]) {
            [fileManager removeItemAtURL:destinationURL error:nil];
        }

        // Copy file from shared Documents to local Documents directory
        [fileManager copyItemAtURL:sourceURL toURL:destinationURL error:&copyError];
        if (copyError) {
            NSLog(@"Error copying file %@: %@", [sourceURL lastPathComponent], copyError.localizedDescription);
        }
    }
}

- (void)presentDocumentBrowser {
    NSFileManager *fileManager = [NSFileManager defaultManager];
     NSURL *groupURL = [fileManager containerURLForSecurityApplicationGroupIdentifier:@"group.nl.izmar.aufiles"];
     NSURL *documentsURL = [groupURL URLByAppendingPathComponent:@"Documents"];

     // Initialize the Document Picker for the shared Documents directory
     UIDocumentPickerViewController *documentPickerVC = [[UIDocumentPickerViewController alloc] initWithURL:documentsURL inMode:UIDocumentPickerModeOpen];
     documentPickerVC.delegate = self;
     documentPickerVC.allowsMultipleSelection = YES;
     documentPickerVC.shouldShowFileExtensions = YES;

     // Present the Document Picker
     [self presentViewController:documentPickerVC animated:YES completion:nil];
 }

@end

void AuFilesCpp::writeFileAUCpp()
{
    @autoreleasepool {
        AuFiles *auFiles = [[AuFiles alloc] init];
        [auFiles writeToFileAU];
    }
}

void AuFilesCpp::writeFileStandaloneCpp()
{
    @autoreleasepool {
        AuFiles *auFiles = [[AuFiles alloc] init];
        [auFiles writeToFileStandalone];
    }
}

void AuFilesCpp::syncToDocumentsCpp()
{
    @autoreleasepool {
        AuFiles *auFiles = [[AuFiles alloc] init];
        [auFiles syncToDocuments];
    }
}

void AuFilesCpp::createSharedDocumentsCpp()
{
    @autoreleasepool {
        AuFiles *auFiles = [[AuFiles alloc] init];
        [auFiles createDocumentsDirectoryInSharedContainer];
    }
}

void AuFilesCpp::presentDocumentBrowserCpp()
{
    @autoreleasepool {
        AuFiles *auFiles = [[AuFiles alloc] init];
        [auFiles presentDocumentBrowser];
    }
}
