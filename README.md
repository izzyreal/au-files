# AUv3 file management utilities

A standalone application that embeds an AUv3 is free to read and write files from your iOS device's system-wide Documents.

Although an AUv3 is free to read files from your iOS device's system-wide Documents, there is no way for an AUv3 to write files to that directory. This means any content created by the AUv3 is not accessible outside the AUv3 without intervention of the application that embeds it.

This repo contains some utilities to support the following flow to work around this problem:
* The application and the AUv3 make use of a Shared directory that is only accessible to them. The user can't access this directory directly via the Files app.
* The application is used whenever the user needs to copy files from the Shared directory into a directory that is accessible via the Files app.

It's a bit clunky, but it's the best we have according to some experienced plugin developers.
