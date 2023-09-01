//
//  IpostockTotalModel.swift
//  idghst
//
//  Created by idghst on 8/20/23.
//

import Foundation

struct IpoTotData: Codable {
    let 공모주: [IpoTotDetail]
}

struct IpoTotDetail: Codable {
    let 구분: String
    let 종목명: String
    let 종목코드: String
    let 진행상황: String
    let 시장구분: String
    let 업종: String
    let 공모청약시작일: String
    let 공모청약종료일: String
    let 환불일: String
    let 상장일: String
    let 확정공모가: String
    let 최저희망공모가액: String
    let 최대희망공모가액: String
    let 청약경쟁률: String
    let 의무보유확약: String
    let 주간사: String
}
