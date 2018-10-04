These values are returned as the error code property of an NSError object with the domain “NSURLErrorDomain”.

Declaration
SWIFT
var NSURLErrorUnknown: Int { get }
var NSURLErrorCancelled: Int { get }
var NSURLErrorBadURL: Int { get }
var NSURLErrorTimedOut: Int { get }
var NSURLErrorUnsupportedURL: Int { get }
var NSURLErrorCannotFindHost: Int { get }
var NSURLErrorCannotConnectToHost: Int { get }
var NSURLErrorDataLengthExceedsMaximum: Int { get }
var NSURLErrorNetworkConnectionLost: Int { get }
var NSURLErrorDNSLookupFailed: Int { get }
var NSURLErrorHTTPTooManyRedirects: Int { get }
var NSURLErrorResourceUnavailable: Int { get }
var NSURLErrorNotConnectedToInternet: Int { get }
var NSURLErrorRedirectToNonExistentLocation: Int { get }
var NSURLErrorBadServerResponse: Int { get }
var NSURLErrorUserCancelledAuthentication: Int { get }
var NSURLErrorUserAuthenticationRequired: Int { get }
var NSURLErrorZeroByteResource: Int { get }
var NSURLErrorCannotDecodeRawData: Int { get }
var NSURLErrorCannotDecodeContentData: Int { get }
var NSURLErrorCannotParseResponse: Int { get }
var NSURLErrorInternationalRoamingOff: Int { get }
var NSURLErrorCallIsActive: Int { get }
var NSURLErrorDataNotAllowed: Int { get }
var NSURLErrorRequestBodyStreamExhausted: Int { get }
var NSURLErrorFileDoesNotExist: Int { get }
var NSURLErrorFileIsDirectory: Int { get }
var NSURLErrorNoPermissionsToReadFile: Int { get }
var NSURLErrorSecureConnectionFailed: Int { get }
var NSURLErrorServerCertificateHasBadDate: Int { get }
var NSURLErrorServerCertificateUntrusted: Int { get }
var NSURLErrorServerCertificateHasUnknownRoot: Int { get }
var NSURLErrorServerCertificateNotYetValid: Int { get }
var NSURLErrorClientCertificateRejected: Int { get }
var NSURLErrorClientCertificateRequired: Int { get }
var NSURLErrorCannotLoadFromNetwork: Int { get }
var NSURLErrorCannotCreateFile: Int { get }
var NSURLErrorCannotOpenFile: Int { get }
var NSURLErrorCannotCloseFile: Int { get }
var NSURLErrorCannotWriteToFile: Int { get }
var NSURLErrorCannotRemoveFile: Int { get }
var NSURLErrorCannotMoveFile: Int { get }
var NSURLErrorDownloadDecodingFailedMidStream: Int { get }
var NSURLErrorDownloadDecodingFailedToComplete: Int { get }
OBJECTIVE-C
enum
{
   NSURLErrorUnknown = -1,
   NSURLErrorCancelled = -999,
   NSURLErrorBadURL = -1000,
   NSURLErrorTimedOut = -1001,
   NSURLErrorUnsupportedURL = -1002,
   NSURLErrorCannotFindHost = -1003,
   NSURLErrorCannotConnectToHost = -1004,
   NSURLErrorDataLengthExceedsMaximum = -1103,
   NSURLErrorNetworkConnectionLost = -1005,
   NSURLErrorDNSLookupFailed = -1006,
   NSURLErrorHTTPTooManyRedirects = -1007,
   NSURLErrorResourceUnavailable = -1008,
   NSURLErrorNotConnectedToInternet = -1009,
   NSURLErrorRedirectToNonExistentLocation = -1010,
   NSURLErrorBadServerResponse = -1011,
   NSURLErrorUserCancelledAuthentication = -1012,
   NSURLErrorUserAuthenticationRequired = -1013,
   NSURLErrorZeroByteResource = -1014,
   NSURLErrorCannotDecodeRawData = -1015,
   NSURLErrorCannotDecodeContentData = -1016,
   NSURLErrorCannotParseResponse = -1017,
   NSURLErrorInternationalRoamingOff = -1018,
   NSURLErrorCallIsActive = -1019,
   NSURLErrorDataNotAllowed = -1020,
   NSURLErrorRequestBodyStreamExhausted = -1021,
   NSURLErrorFileDoesNotExist = -1100,
   NSURLErrorFileIsDirectory = -1101,
   NSURLErrorNoPermissionsToReadFile = -1102,
   NSURLErrorSecureConnectionFailed = -1200,
   NSURLErrorServerCertificateHasBadDate = -1201,
   NSURLErrorServerCertificateUntrusted = -1202,
   NSURLErrorServerCertificateHasUnknownRoot = -1203,
   NSURLErrorServerCertificateNotYetValid = -1204,
   NSURLErrorClientCertificateRejected = -1205,
   NSURLErrorClientCertificateRequired = -1206,
   NSURLErrorCannotLoadFromNetwork = -2000,
   NSURLErrorCannotCreateFile = -3000,
   NSURLErrorCannotOpenFile = -3001,
   NSURLErrorCannotCloseFile = -3002,
   NSURLErrorCannotWriteToFile = -3003,
   NSURLErrorCannotRemoveFile = -3004,
   NSURLErrorCannotMoveFile = -3005,
   NSURLErrorDownloadDecodingFailedMidStream = -3006,
   NSURLErrorDownloadDecodingFailedToComplete = -3007
}
Constants
NSURLErrorUnknown
Returned when the URL Loading system encounters an error that it cannot interpret.

This can occur when an error originates from a lower level framework or library. Whenever this error code is received, it is a bug, and should be reported to Apple.

Available in OS X v10.2 and later.
NSURLErrorCancelled
Returned when an asynchronous load is canceled.

A Web Kit framework delegate will receive this error when it performs a cancel operation on a loading resource. Note that an NSURLConnection or NSURLDownload delegate will not receive this error if the download is canceled.

Available in OS X v10.2 and later.
NSURLErrorBadURL
Returned when a URL is sufficiently malformed that a URL request cannot be initiated

Available in OS X v10.2 and later.
NSURLErrorTimedOut
Returned when an asynchronous operation times out.

NSURLConnection will send this error to its delegate when the timeoutInterval in NSURLRequest expires before a load can complete.

Available in OS X v10.2 and later.
NSURLErrorUnsupportedURL
Returned when a properly formed URL cannot be handled by the framework.

The most likely cause is that there is no available protocol handler for the URL.

Available in OS X v10.2 and later.
NSURLErrorCannotFindHost
Returned when the host name for a URL cannot be resolved.

Available in OS X v10.2 and later.
NSURLErrorCannotConnectToHost
Returned when an attempt to connect to a host has failed.

This can occur when a host name resolves, but the host is down or may not be accepting connections on a certain port.

Available in OS X v10.2 and later.
NSURLErrorDataLengthExceedsMaximum
Returned when the length of the resource data exceeds the maximum allowed.

Available in OS X v10.5 and later.
NSURLErrorNetworkConnectionLost
Returned when a client or server connection is severed in the middle of an in-progress load.

Available in OS X v10.2 and later.
NSURLErrorDNSLookupFailed
See NSURLErrorCannotFindHost

Available in OS X v10.2 and later.
NSURLErrorHTTPTooManyRedirects
Returned when a redirect loop is detected or when the threshold for number of allowable redirects has been exceeded (currently 16).

Available in OS X v10.2 and later.
NSURLErrorResourceUnavailable
Returned when a requested resource cannot be retrieved.

Examples are “file not found”, and data decoding problems that prevent data from being processed correctly.

Available in OS X v10.2 and later.
NSURLErrorNotConnectedToInternet
Returned when a network resource was requested, but an internet connection is not established and cannot be established automatically, either through a lack of connectivity, or by the user's choice not to make a network connection automatically.

Available in OS X v10.2 and later.
NSURLErrorRedirectToNonExistentLocation
Returned when a redirect is specified by way of server response code, but the server does not accompany this code with a redirect URL.

Available in OS X v10.2 and later.
NSURLErrorBadServerResponse
Returned when the URL Loading system receives bad data from the server.

This is equivalent to the “500 Server Error” message sent by HTTP servers.

Available in OS X v10.2 and later.
NSURLErrorUserCancelledAuthentication
Returned when an asynchronous request for authentication is cancelled by the user.

This is typically incurred by clicking a “Cancel” button in a username/password dialog, rather than the user making an attempt to authenticate.

Available in OS X v10.2 and later.
NSURLErrorUserAuthenticationRequired
Returned when authentication is required to access a resource.

Available in OS X v10.2 and later.
NSURLErrorZeroByteResource
Returned when a server reports that a URL has a non-zero content length, but terminates the network connection “gracefully” without sending any data.

Available in OS X v10.2 and later.
NSURLErrorCannotDecodeRawData
Returned when content data received during an NSURLConnection request cannot be decoded for a known content encoding.

Available in OS X v10.5 and later.
NSURLErrorCannotDecodeContentData
Returned when content data received during an NSURLConnection request has an unknown content encoding.

Available in OS X v10.5 and later.
NSURLErrorCannotParseResponse
Returned when a response to an NSURLConnection request cannot be parsed.

Available in OS X v10.5 and later.
NSURLErrorInternationalRoamingOff
Returned when a connection would require activating a data context while roaming, but international roaming is disabled.

Available in OS X v10.7 and later.
NSURLErrorCallIsActive
Returned when a connection is attempted while a phone call is active on a network that does not support simultaneous phone and data communication (EDGE or GPRS).

Available in OS X v10.7 and later.
NSURLErrorDataNotAllowed
Returned when the cellular network disallows a connection.

Available in OS X v10.7 and later.
NSURLErrorRequestBodyStreamExhausted
Returned when a body stream is needed but the client does not provide one. This impacts clients on iOS that send a POST request using a body stream but do not implement the NSURLConnection delegate method connection:needNewBodyStream.

Available in OS X v10.7 and later.
NSURLErrorFileDoesNotExist
Returned when a file does not exist.

Available in OS X v10.2 and later.
NSURLErrorFileIsDirectory
Returned when a request for an FTP file results in the server responding that the file is not a plain file, but a directory.

Available in OS X v10.2 and later.
NSURLErrorNoPermissionsToReadFile
Returned when a resource cannot be read due to insufficient permissions.

Available in OS X v10.2 and later.
NSURLErrorSecureConnectionFailed
Returned when an attempt to establish a secure connection fails for reasons which cannot be expressed more specifically.

Available in OS X v10.2 and later.
NSURLErrorServerCertificateHasBadDate
Returned when a server certificate has a date which indicates it has expired, or is not yet valid.

Available in OS X v10.2 and later.
NSURLErrorServerCertificateUntrusted
Returned when a server certificate is signed by a root server which is not trusted.

Available in OS X v10.2 and later.
NSURLErrorServerCertificateHasUnknownRoot
Returned when a server certificate is not signed by any root server.

Available in OS X v10.2 and later.
NSURLErrorServerCertificateNotYetValid
Returned when a server certificate is not yet valid.

Available in OS X v10.4 and later.
NSURLErrorClientCertificateRejected
Returned when a server certificate is rejected.

Available in OS X v10.4 and later.
NSURLErrorClientCertificateRequired
Returned when a client certificate is required to authenticate an SSL connection during an NSURLConnection request.

Available in OS X v10.6 and later.
NSURLErrorCannotLoadFromNetwork
Returned when a specific request to load an item only from the cache cannot be satisfied.

This error is sent at the point when the library would go to the network accept for the fact that is has been blocked from doing so by the “load only from cache” directive.

Available in OS X v10.2 and later.
NSURLErrorCannotCreateFile
Returned when NSURLDownload object was unable to create the downloaded file on disk due to a I/O failure.

Available in OS X v10.2 and later.
NSURLErrorCannotOpenFile
Returned when NSURLDownload was unable to open the downloaded file on disk.

Available in OS X v10.2 and later.
NSURLErrorCannotCloseFile
Returned when NSURLDownload was unable to close the downloaded file on disk.

Available in OS X v10.2 and later.
NSURLErrorCannotWriteToFile
Returned when NSURLDownload was unable to write to the downloaded file on disk.

Available in OS X v10.2 and later.
NSURLErrorCannotRemoveFile
Returned when NSURLDownload was unable to remove a downloaded file from disk.

Available in OS X v10.2 and later.
NSURLErrorCannotMoveFile
Returned when NSURLDownload was unable to move a downloaded file on disk.

Available in OS X v10.2 and later.
NSURLErrorDownloadDecodingFailedMidStream
Returned when NSURLDownload failed to decode an encoded file during the download.

Available in OS X v10.2 and later.
NSURLErrorDownloadDecodingFailedToComplete
Returned when NSURLDownload failed to decode an encoded file after downloading.

Available in OS X v10.2 and later.
