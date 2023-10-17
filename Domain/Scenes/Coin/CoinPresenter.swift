//
//  CoinPresenter.swift
//  MarketCoins
//
//  Created by Robson Moreira on 07/11/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CoinPresentationLogic {
    func presentCoin(response: Coin.FetchCurrentData.Response)
    func presentMarketChart(response: [Coin.FetchMarketChart.Response])
    func presentError(error: KarketCoinsError)
}

class CoinPresenter: CoinPresentationLogic {
    
    weak var viewController: CoinDisplayLogic?
    
    // MARK: Do something
    
    func presentCoin(response: Coin.FetchCurrentData.Response) {
        let viewModel = Coin.FetchCurrentData.ViewModel(
            currentPrice: response.currentPrice.toCurrency(from: response.baseCoin),
            priceChangePercentage: getAttributedString(response.priceChangePercentage),
            coinName: response.coinName,
            coinPrice: 1.toCurrency(from: response.baseCoin),
            coinSymbol: response.coinSymbol.uppercased(),
            coinImage: response.coinImage,
            currentPriceComparationToCoin: response.currentPriceComparationToCoin.toCurrency(from: response.baseCoin),
            comparationToCoinSymbol: response.comparationToCoinSymbol.uppercased(),
            priceChangePercentageOneDay: getAttributedString(response.priceChangePercentageOneDay),
            priceChangePercentageOneWeek: getAttributedString(response.priceChangePercentageOneWeek),
            priceChangePercentageTwoWeeks: getAttributedString(response.priceChangePercentageTwoWeeks),
            priceChangePercentageOneMonth: getAttributedString(response.priceChangePercentageOneMonth),
            priceChangePercentageTwoMonths: getAttributedString(response.priceChangePercentageTwoMonths),
            priceChangePercentageOneYear: getAttributedString(response.priceChangePercentageOneYear),
            marketCapRank: "#\(response.marketCapRank)",
            marketCap: response.marketCap.toCurrency(from: response.baseCoin),
            fullyDilutedValuation: response.fullyDilutedValuation.toCurrency(from: response.baseCoin),
            totalVolume: response.totalVolume.toCurrency(from: response.baseCoin),
            high24h: response.high24h.toCurrency(from: response.baseCoin),
            low24h: response.low24h.toCurrency(from: response.baseCoin),
            supplyAvailable: response.supplyAvailable.formatNumber(),
            totalSupply: response.totalSupply.formatNumber(),
            maxSupply: response.maxSupply.formatNumber(),
            maximumValue: response.maximumValue.toCurrency(from: response.baseCoin),
            maximumValuePercentage: response.maximumValuePercentage.toPercentage(),
            maximumValueDate: "\(response.maximumValueDate.formatter(to: "dd, MMM, YYYY")) (\(response.maximumValueDate.differenceDays(to: Date())) dias)",
            minimumValue: response.minimumValue.toCurrency(from: response.baseCoin),
            minimumValuePercentage: response.minimumValuePercentage.toPercentage(),
    minimumValueDate: "\(response.minimumValueDate.formatter(to: "dd, MMM, YYYY")) (\(response.minimumValueDate.differenceDays(to: Date())) dias)"
        )
        viewController?.displayCoin(viewModel: viewModel)
    }
    
    func presentMarketChart(response: [Coin.FetchMarketChart.Response]) {
        let viewModel = Coin.FetchMarketChart.ViewModel(
            minimumPrice: (response.min { $0.price < $1.price }?.price ?? 0.0) - (1/100),
            maximumPrice: (response.max { $1.price > $0.price }?.price ?? 0.0) + (1/100),
            dataEntries: response.map { $0.dataEntry }
        )
        viewController?.displayMarketChart(viewModel: viewModel)
    }
    
    func presentError(error: KarketCoinsError) {
        viewController?.displayError(error: error.errorDescription)
    }
    
    private func getAttributedString(_ value: Double) -> NSAttributedString {
        let color = (value.sign == .minus) ? UIColor.systemRed : UIColor.systemGreen
        let attributes = [ NSAttributedString.Key.foregroundColor: color ]
        return NSAttributedString(string: value.toPercentage(), attributes: attributes)
    }
}
