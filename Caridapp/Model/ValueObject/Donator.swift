//
//  Donator.swift
//  Caridapp
//
//  Created by user190824 on 10/15/21.
//

import Foundation


public class Donator: Codable {
    public let name: String;
    public let addressF: String;
    public let addressR: String;
    public let rfc: String;
    public let phone: String;
    public let email: String;
    
    
    public init (name: String, addressF: String, addressR: String, rfc: String, phone: String, email: String) {
        self.name = name
        self.addressF = addressF;
        self.addressR = addressR;
        self.rfc = rfc;
        self.phone = phone;
        self.email = email;    }
}
