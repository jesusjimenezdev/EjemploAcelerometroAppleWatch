import WatchKit
import Foundation
import CoreMotion

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var labelX: WKInterfaceLabel!
    @IBOutlet var labelY: WKInterfaceLabel!
    @IBOutlet var labelZ: WKInterfaceLabel!
    
    let motionManager = CMMotionManager()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        motionManager.accelerometerUpdateInterval = 0.1
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if motionManager.isAccelerometerAvailable {
            let handler: CMAccelerometerHandler = {(datos: CMAccelerometerData?, error: Error?) -> Void in
                self.labelX.setText(String(datos!.acceleration.x))
                self.labelY.setText(String(datos!.acceleration.y))
                self.labelZ.setText(String(datos!.acceleration.z))
            }
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: handler)
        } else {
            self.labelX.setText("No disponible")
            self.labelY.setText("No disponible")
            self.labelZ.setText("No disponible")
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        motionManager.stopAccelerometerUpdates()
    }

}
