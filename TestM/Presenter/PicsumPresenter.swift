//
//  PicsumPresenter.swift
//  TestM
//
//  Created by GS on 03/08/20.
//  Copyright © 2020 Gaurishankar Vibhute. All rights reserved.
//

import Foundation


class PicsumPresenter {
    
    let apiclient = APIClient();
    
    
    func makeapicall(complition: @escaping ([PicsumModel]) -> Void) {
        apiclient.frtchpicsumdata(complition: {
            result in
//                print("I am done \(result)")
            complition(result)
        })
        
        
    }
}
