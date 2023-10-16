//
//  GlobalValuesDataProvider.swift
//  IsisMarketCoins
//
//  Created by Guilherme Silveira de Souza on 16/10/23.
//

import Foundation

protocol GlobalValuesDataProviderDelegate: GenericDataProviderDelegate {}

class GlobalValuesDataProvider: DataProviderManager<GlobalValuesDataProviderDelegate, GlobalModel> {
    private let globalStore: GlobalStoreProtocol?

    init(globalStore: GlobalStoreProtocol = GlobalStore()) {
        self.globalStore = globalStore
    }

    func fetchGlobalValues() {
        globalStore?.fetchGlobal(completion: { result, error in
            if let error = error {
                self.delegate?.errorData(self.delegate, error: error)
            }
            
            if let result = result {
                self.delegate?.success(model: result)
            }
        })
    }
}
