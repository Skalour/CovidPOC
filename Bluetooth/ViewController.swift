//
//  ViewController.swift
//  Bluetooth
//
//  Created by Marceau Hollertt on 22/05/2020.
//  Copyright © 2020 Marceau Hollertt. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralDelegate, CBCentralManagerDelegate {
   private var centralManager: CBCentralManager!
   private var peripheral: CBPeripheral!
    private var int = 0
   
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central state update")
                  if central.state != .poweredOn {
                      print("Central is not powered on")
                  } else {
                      print("Central scanning for devices");
                    centralManager.scanForPeripherals(withServices: nil,
                                                        options: [CBCentralManagerScanOptionAllowDuplicatesKey : false])
                  }
    }
    

    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if(int < 20){
            //print(peripheral)
            if let power = advertisementData[CBAdvertisementDataTxPowerLevelKey] as? Double{
                       print("RSSI : ", RSSI)
                       print("Distance to peripheral ",peripheral.name, " is ", pow(10, ((power - Double(truncating: RSSI))/20)))
                   }
            int = int + 1
        }
        else{
            self.centralManager.stopScan()

        }

        self.peripheral = peripheral
        self.peripheral.delegate = self

        self.centralManager.connect(self.peripheral, options: nil)

    }
    
    // The handler if we do connect succesfully
        func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
            if peripheral == self.peripheral {
                print(peripheral.name)
                print("Connected !")

            }
        }


    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.global())
        func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        }
    }


}

