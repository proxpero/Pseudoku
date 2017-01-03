//
//  CameraViewController.swift
//  CandidCamera
//
//  Created by Todd Olsen on 12/27/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit
import AVFoundation

// http://stackoverflow.com/questions/28487146/how-to-add-live-camera-preview-to-uiview
// http://stackoverflow.com/questions/39841095/avlayervideogravityresize-does-not-match-on-new-devices-ios-10

final class CameraViewController: UIViewController {

    var captureSession: AVCaptureSession!
    var photoOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)

        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch {
            print(error.localizedDescription)
        }

        captureSession.addInput(input)

        photoOutput = AVCapturePhotoOutput()

        captureSession.addOutput(photoOutput)
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.masksToBounds = true

        view.layer.addSublayer(previewLayer)

        cameraBegin()

    }

    override func viewDidLayoutSubviews() {
        previewLayer.frame = view.bounds
    }

    func cameraBegin() {

        captureSession.startRunning()
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)

        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch {
            print(error.localizedDescription)
        }

        if ( captureSession.canAddInput(input) == false ) {
            print("capture session problem?")
            return
        }

        captureSession.addInput(input)

        photoOutput = AVCapturePhotoOutput()
//        photoOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]

        if ( captureSession.canAddOutput(photoOutput) == false )
        {
            print("capture session with stillImageOutput problem?")
            return
        }

        captureSession.addOutput(photoOutput)
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.masksToBounds = true

        view.layer.addSublayer(previewLayer)
        captureSession.startRunning()
        previewLayer.frame = view.bounds
        print(view.bounds)

    }

}
