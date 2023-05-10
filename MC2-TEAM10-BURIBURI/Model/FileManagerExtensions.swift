//
//  FileManagerExtensions.swift
//  FileManagerTest
//
//  Created by xnoag on 2023/05/08.
//

//* -> 현재 단계
// -> 코드 설명

/*
 FileManager에서 다루는 URL이란?
 파일 또는 Directory에 대한 경로를 의미한다.
 일반적으로 파일 URL은 "file://" 스키마를 사용하여 표시한다.
 예를들어, "file:///home/user/documents/myFile.text"는
 "/home/user/documents" Directory에 있는 "myFile.text"파일을 나타낸다.
 */

import Foundation

extension FileManager {
    
    //* 현재 앱의 Document Directory의 URL을 반환하는 변수를 생성한다.
    var documentDirectory: URL? {
        // 요청한 Document Directory에 대한 URL 배열 중에서 첫번쨰 URL을 반환한다.
        return self.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    
    //* 앱의 Document Directory에 파일을 복사하고, 복사된 파일의 URL을 반환하거나, 이미 존재하는 파일의 URL을 반환하는 함수를 만든다. -> 앱에서 사용하는 파일을 Document Directory에 저장할 수 있다.
    func copyItemToDocumentDirectory(from sourceURL: URL) -> URL? {
        // 현재 앱의 Document Directory의 URL을 가져와서 documentDirectory 상수에 할당한다.
        guard let documentDirectory = documentDirectory else { return nil }
        // sourceURL의 URL 띄어쓰기 마지막에 있는 String을 fileName 상수에 할당한다. 이는 복사할 파일의 이름이 된다.
        let fileName = sourceURL.lastPathComponent
        // documentDirectory의 URL 마지막에 fileName을 추가해서 복사할 파일의 대상 URL을 만들고 destinationURL 상수에 할당한다.
        let destinationURL = documentDirectory.appendingPathComponent(fileName)
        // destinationURL 경로에 파일이 있다면, destinationURL을 반환한다.
        if self.fileExists(atPath: destinationURL.path) {
            return destinationURL
        } else {
            do {
                // 없으면 sourceURL을 새로운 위치의 destinationURL에 복사하고 destinationURL을 반환한다.
                try self.copyItem(at: sourceURL, to: destinationURL)
                return destinationURL
            } catch let error {
                print("Unable to copy file: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    
    //* url로 전달된 파일의 URL을 현재 앱의 Document Directory에서 삭제하는 함수를 생성한다.
    func removeItemFromDocumentDirectory(url: URL) {
        // 현재 앱의 Document Directory의 URL을 가져와서 documentDirectory 상수에 할당한다.
        guard let documentDirectory = documentDirectory else { return }
        // url의 URL 띄어쓰기 마지막에 있는 String을 fileName에 할당한다. 이는 삭제할 파일의 이름이 된다.
        let fileName = url.lastPathComponent
        // documentDirectory의 URL 마지막에 fileName을 추가해서 삭제할 파일의 URL을 만들고 fileUrl 상수에 할당한다.
        let fileUrl = documentDirectory.appendingPathComponent(fileName)
        // fileUrl 경로에 파일이 있다면, url에 있는 파일을 지워라.
        if self.fileExists(atPath: fileUrl.path) {
            do {
                try self.removeItem(at: url)
            } catch let error {
                print("Unable to remove file: \(error.localizedDescription)")
            }
        }
    }
    
    
    //* url로 전달된 Directory의 내용들을 URL 배열로 반환한다.
    func getContentsOfDirectory(_ url: URL) -> [URL] {
        // url이 Directory인지 확인할 수 있게 isDirectory 변수를 생성한다.
        var isDirectory: ObjCBool = false
        // url 경로가 존재하는지 확인하고, Directory인지 아닌지에 대한 여부를 isDirectory 파라미터로 반환한다.
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory), isDirectory.boolValue else { return [] }
        do {
            // url 경로가 존재하고, Directory가 맞다면, url Directory 내부의 파일들의 URL 배열을 반환한다.
            return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        } catch let error {
            print("Unable to get directory contents: \(error.localizedDescription)")
        }
        return []
    }
}
