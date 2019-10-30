//
//  AudioStreamDownloader.swift
//  AudioEngineTest
//
//  Created by Anshul, Arnav on 10/30/19.
//  Copyright © 2019 Anshul, Arnav. All rights reserved.
//

import UIKit

struct StreamProgressInfo {
    let streamId: String
    let progress: Double
    let data: Data
    let contentLengthReceived: Int64?
    let totalBytesExpected: Int64?
}

protocol StreamingProgressDelegate: NSObjectProtocol {
    func streamProgressUpdate(streamInfo: StreamProgressInfo)
}

class AudioStreamDownloader: NSObject {

    let streamingURL: URL
    var networkSession: URLSession?
    var dataTask: URLSessionDataTask?

    let identifier: String

    var expectedTotalContentLength: Int64?
    var contentLengthReceived: Int64 = 0

    var progressDelegate: StreamingProgressDelegate?

    init(withURL url:URL) {
        streamingURL = url
        identifier = url.pathComponents.last ?? url.absoluteString

        super.init()

        let sessionConfiguration = URLSessionConfiguration.background(withIdentifier: identifier)
        sessionConfiguration.networkServiceType = NSURLRequest.NetworkServiceType(rawValue: 8) ?? .responsiveData
        sessionConfiguration.waitsForConnectivity = true
        networkSession = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
    }

    func startStreaming() {
        var request = URLRequest(url: streamingURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.addValue("bytes=\(0)-", forHTTPHeaderField: "Range")
        dataTask = networkSession?.dataTask(with: request)
        dataTask?.taskDescription = identifier
        dataTask?.resume()
    }

    func pauseStreaming() {
        dataTask?.suspend()
    }

    func resumeStreaming() {
        dataTask?.resume()
    }

    func stopStreaming() {
        dataTask?.cancel()
    }

}

extension AudioStreamDownloader: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("Data received")
        contentLengthReceived = contentLengthReceived + Int64(data.count)
        let progress: Double
        if let totalSize = expectedTotalContentLength {
            progress = Double(contentLengthReceived)/Double(totalSize)
        } else {
            progress = 0
        }
        let streamProgressInfo = StreamProgressInfo(streamId: identifier, progress: progress, data: data, contentLengthReceived: contentLengthReceived, totalBytesExpected: expectedTotalContentLength)
        print(streamProgressInfo)
        progressDelegate?.streamProgressUpdate(streamInfo: streamProgressInfo)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print("ExpectedContentLength:\(response.expectedContentLength) ")
        expectedTotalContentLength = response.expectedContentLength
        completionHandler(.allow)
    }
}
