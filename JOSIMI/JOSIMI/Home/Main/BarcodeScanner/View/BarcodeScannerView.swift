//
//  BarcodeScannerView.swift
//  Josimi
//
//  Created by 양원식 on 9/20/24.
//

import SwiftUI
import AVFoundation

struct BarcodeScannerView: UIViewControllerRepresentable {
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: BarcodeScannerView

        init(parent: BarcodeScannerView) {
            self.parent = parent
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
                if let barcode = metadataObject.stringValue {
                    parent.didFindCode(barcode)
                }
            }
        }
    }

    var didFindCode: (String) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return viewController }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return viewController
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return viewController
        }

        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean13, .ean8, .qr]
        } else {
            return viewController
        }

        // 카메라 미리보기 레이어 설정
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        let previewFrame = CGRect(x: 0, y: 0, width: viewController.view.bounds.width, height: 600) // 높이를 600으로 설정
        previewLayer.frame = previewFrame
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)

        // 오버레이 레이어 추가 (스캔 영역만 제외)
        let overlayLayer = CAShapeLayer()
        
        // 전체 화면을 그리고, 스캔 영역만 제외
        let path = UIBezierPath(rect: previewFrame)  // previewLayer의 크기만큼 영역 설정
        
        // 스캔 영역을 둥글게 설정
        let scanRect = CGRect(x: previewFrame.minX + 160, y: previewFrame.midY / 2, width: 505, height: 300) // 스캔할 영역 (중앙)
        let cornerRadius: CGFloat = 20  // 둥근 모서리 크기 설정
        let roundedScanRectPath = UIBezierPath(roundedRect: scanRect, cornerRadius: cornerRadius)  // 둥글게 만든 스캔 영역
        
        // 스캔 영역을 제외하고 어둡게 처리
        path.append(roundedScanRectPath.reversing())  // 스캔 영역을 제외한 부분을 어둡게
        overlayLayer.path = path.cgPath
        overlayLayer.fillColor = UIColor.black.withAlphaComponent(0.6).cgColor  // 반투명하게 처리
        viewController.view.layer.addSublayer(overlayLayer)

        // 백그라운드 스레드에서 startRunning() 호출
        DispatchQueue.global(qos: .userInitiated).async {
            captureSession.startRunning()
        }

        return viewController
    }





    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}


#Preview {
    BarcodeScannerView { code in
        print("Scanned code: \(code)")
    }
}
