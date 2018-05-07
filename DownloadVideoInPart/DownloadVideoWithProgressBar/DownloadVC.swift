//
//  DownloadVC.swift
//  DownloadVideoWithProgressBar
//
//  Created by Sufalam 7 on 07/05/18.
//  Copyright © 2018 Abhirajsinh. All rights reserved.
//

import UIKit
import Alamofire
import AVKit
import AVFoundation
import MBCircularProgressBar

class DownloadVC: UIViewController {
    
    var resumeData: Data?
    let playerController = AVPlayerViewController()
    var videoURL:URL!
    var request:DownloadRequest?
    
    @IBOutlet weak var viewProgressCircle: MBCircularProgressBarView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Print the path of Document Directory
       print(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).last! as String)
        
        // fetch the resume data if available
        if let data = UserDefaults.standard.value(forKey: "videoResumeData"){
            resumeData = data as? Data
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDownloadClicked(_ sender: Any) {
        downloadVideo()
    }
    
    func downloadVideo() {
        
        // Set that path in document directory where you want to store your file
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let documentsURL = URL(fileURLWithPath: documentsPath, isDirectory: true)
            let fileURL = documentsURL.appendingPathComponent("video.mp4")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        if let resumeData = resumeData { //Past downloaded data is present, resume from  last sesison
            request = Alamofire.download(resumingWith: resumeData, to: destination)
        }else{// If no data present, then start from starting
            request = Alamofire.download("https://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_2mb.mp4", to: destination)
        }
        request?.downloadProgress{ (progress) in //Show progress in progress bar
                self.viewProgressCircle.value = CGFloat(progress.fractionCompleted * 100)
                print(CGFloat(progress.fractionCompleted * 100))
        }

        request?.responseData { response in
            switch response.result {
            case .success:
                print("Download Succesfully")
            case .failure: // Save the last resume data here
                UserDefaults.standard.set(response.resumeData, forKey: "videoResumeData")
                self.resumeData = response.resumeData
            }
        }
    }
    
    
    @IBAction func cancelDownload(_ sender: Any) {
        request?.cancel()
    }
}
