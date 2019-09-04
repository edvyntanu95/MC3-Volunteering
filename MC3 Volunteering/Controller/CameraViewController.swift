//
//  CameraViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 27/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import AVFoundation
import Lottie

class CameraViewController: UIViewController {

    @IBOutlet weak var animationQR: AnimationView!
        @IBOutlet weak var previewContainer: UIView!
        
        
        private var captureSession: AVCaptureSession = AVCaptureSession()
        private let sessionQueue = DispatchQueue(label: "Capture Session Queue")
        
        fileprivate var previewLayer: AVCaptureVideoPreviewLayer!
    
    var scanResultString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        playAnimation()
    }
    
    func playAnimation(){
        let scanner = Animation.named("qr")
        animationQR.animation = scanner
        animationQR.loopMode = .loop
        animationQR.play()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }

        
        private func setupCaptureSession() {
            sessionQueue.sync {
                self.captureSession.beginConfiguration()
                
                let output = AVCaptureMetadataOutput()
                
                if let device = AVCaptureDevice.default(for: .video),
                    let input = try? AVCaptureDeviceInput(device: device),
                    self.captureSession.canAddInput(input) && self.captureSession.canAddOutput(output) {
                    self.captureSession.addInput(input)
                    self.captureSession.addOutput(output)
                    
                    output.metadataObjectTypes = [
                        .aztec,
                        .code39,
                        .code39Mod43,
                        .code93,
                        .code39Mod43,
                        .code128,
                        .dataMatrix,
                        .ean8,
                        .ean13,
                        .interleaved2of5,
                        .itf14,
                        .interleaved2of5,
                        .pdf417,
                        .qr,
                        .upce
                    ]
                    
                    output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                }
                
                self.captureSession.commitConfiguration()
                
                DispatchQueue.main.async {
                    self.setupPreviewLayer(session: self.captureSession)
                    self.setupBoundingBox()
                }
                
                self.captureSession.startRunning()
            }
        }
        
        private func setupPreviewLayer(session: AVCaptureSession) {
            previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.frame = previewContainer.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            previewContainer.layer.addSublayer(previewLayer)
        }
    
    
        
        
        
        private var boundingBox = CAShapeLayer()
        private func setupBoundingBox() {
            boundingBox.frame = previewContainer.layer.bounds
            boundingBox.strokeColor = UIColor.red.cgColor
            boundingBox.lineWidth = 4.0
            boundingBox.fillColor = UIColor.clear.cgColor
            previewContainer.layer.addSublayer(boundingBox)
        }
        
        
        fileprivate func updateBoundingBox(_ points: [CGPoint]) {
            guard let firstPoint = points.first else {
                return
            }
            
            let path = UIBezierPath()
            path.move(to: firstPoint)
            
            var newPoints = points
            newPoints.removeFirst()
            newPoints.append(firstPoint)
            
            newPoints.forEach { path.addLine(to: $0) }
            
            boundingBox.path = path.cgPath
            boundingBox.isHidden = false
        }
        
        private var resetTimer: Timer?
        fileprivate func hideBoundingBox(after: Double) {
            resetTimer?.invalidate()
            resetTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval() + after,
                                              repeats: false) {
                                                [weak self] (timer) in
                                                self?.resetViews() }
        }
        
        private func resetViews() {
            boundingBox.isHidden = true
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScannerResultSegue" {
            let destVC = segue.destination as? ScanResultViewController
            destVC?.scanResult = scanResultString
        }
    }
    
    
    

}

extension CameraViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            nextPage(result: object.stringValue!)
            guard let transformedObject = previewLayer.transformedMetadataObject(for: object) as? AVMetadataMachineReadableCodeObject else {
                return
            }
            
            updateBoundingBox(transformedObject.corners)
            hideBoundingBox(after: 0.25)
        }
    }
    
    func nextPage(result:String){
        self.captureSession.stopRunning()
        scanResultString = result
//        let from = storyboard?.instantiateViewController(withIdentifier: "CameraViewController") as? CameraViewController
//        let vc = storyboard?.instantiateViewController(withIdentifier: "ScanResultViewController") as? ScanResultViewController
        //        let myActivity = myActivitiesEventList[indexPath.row]
        //        let myActivityStatus = myActivitiesEventsListStatus[indexPath.row]
        //
        //        let eventRecordID = myActivity.recordID.recordName as! String
        //        vc?.eventId = eventRecordID
//        vc?.scanResult = result
//        self.navigationController?.pushViewController(vc!, animated: true)
        //        navigationController?.popToRootViewController(animated: true)
        
        performSegue(withIdentifier: "ScannerResultSegue", sender: nil)
        
        
    }
}
