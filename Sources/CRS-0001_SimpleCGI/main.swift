/***************************************************************************************************
 CRS-0001
   © 2017 YOCKOW.
     Licensed under CC0 1.0 Universal.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

// Very simple CGI program with `CGIResponder`.
// Don't forget `respond()`.

import Foundation
import CGIResponder

var responder = CGIResponder()
responder.status = .ok
responder.contentType = MIMEType(pathExtension:.txt, parameters:["charset":"UTF-8"])!
responder.content = .string("Hello, World!\n", encoding:.utf8)

responder.respond()