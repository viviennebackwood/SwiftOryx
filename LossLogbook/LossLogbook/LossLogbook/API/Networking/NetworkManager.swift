//
//  NetworkManager.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 25.08.2023.
//

import Foundation

// MARK: - Network Layer Protocol

protocol NetworkAdapter {
    func request<T: Decodable>(type: T.Type, endpoint: Endpoint, completion: @escaping (Result<[T], NetworkError>) -> Void)
}


// MARK: - Network Layer Implementation

class URLSessionNetworkAdapter: NetworkAdapter {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    
    func request<T: Decodable>(type: T.Type, endpoint: Endpoint, completion: @escaping (Result<[T], NetworkError>) -> Void) where T : Decodable {
        guard let url = endpoint.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(reason: error.localizedDescription)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(reason: "No HTTP response")))
                return
            }

            let statusInfo = NetworkError.serverError(statusCode: httpResponse.statusCode).statusCodeIsSuccessful()

            if !statusInfo.success {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode([T].self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                completion(.failure(.decodingFailed(reason: decodingError.localizedDescription)))
            }
        }

        task.resume()
    }
}



// MARK: - Network Manager

protocol BasicNetworkManagerFetchers {
    func fetchEquiment(completion: @escaping (Result<[EquipmentJSON], NetworkError>) -> Void)
    
    func fetchEquimentOryx(completion: @escaping (Result<[EquipmentOryxJSON], NetworkError>) -> Void)
    
    func fetchPersonnel(completion: @escaping (Result<[PersonnelJSON], NetworkError>) -> Void)
}

class NetworkManager {
    // MARK: - PROPERTIES
    private let networkAdapter: NetworkAdapter
    
    
    init(networkAdapter: NetworkAdapter = URLSessionNetworkAdapter()) {
        self.networkAdapter = networkAdapter
    }
    
    // MARK: - FETCHERS
    func fetchData<T: Decodable>(customEndpoint: Endpoint, completion: @escaping (Result<[T], NetworkError>) -> Void) {
        self.networkAdapter.request(type: T.self, endpoint: customEndpoint, completion: completion)
    }
   
    // Fetch data using a default endpoint
    private func fetchData<T: Decodable>(defaultEndpoint: Endpoint.DefaultEndpoint, completion: @escaping (Result<[T], NetworkError>) -> Void) {
        self.networkAdapter.request(type: T.self, endpoint: defaultEndpoint.endpoint, completion: completion)
    }

    private func updateEquipmentData(mainData: [EquipmentJSON], correctionData: [EquipmentJSON]) -> [EquipmentJSON]  {
        var updatedEquipmentData = mainData
        
        for correction in correctionData {
            if let index = updatedEquipmentData.firstIndex(where: { $0.date == correction.date }) {
                updatedEquipmentData[index].update(with: correction)
            }
        }
        
        return updatedEquipmentData
    }
    
}

// MARK: - BasicNetworkManagerFetchers
extension NetworkManager: BasicNetworkManagerFetchers {

    func fetchEquiment(completion: @escaping (Result<[EquipmentJSON], NetworkError>) -> Void) {
        // Fetch main equipment data
        self.fetchData(defaultEndpoint: .equipment) { (result: Result<[EquipmentJSON], NetworkError>) in
            switch result {
            case .success(let mainEquipmentData):

                DispatchQueue.global(qos: .background).async {
                    self.fetchData(defaultEndpoint: .equipment_correction) { (correctionResult: Result<[EquipmentJSON], NetworkError>) in
                        switch correctionResult {
                            
                        case .success(let correctionData):
                            let updatedEquipmentData = self.updateEquipmentData(mainData: mainEquipmentData, correctionData: correctionData)
                            DispatchQueue.main.async {
                                completion(.success(updatedEquipmentData))
                            }
                            
                        case .failure(let error):
                            print("[CorrectionData] - Fetching: \(error.description)")
                            DispatchQueue.main.async {
                                completion(.failure(error))
                            }
                        }
                    }
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchEquimentOryx(completion: @escaping (Result<[EquipmentOryxJSON], NetworkError>) -> Void) {
        fetchData(defaultEndpoint: .equipment_oryx, completion: completion)
    }
    
    func fetchPersonnel(completion: @escaping (Result<[PersonnelJSON], NetworkError>) -> Void) {
        fetchData(defaultEndpoint: .personnel, completion: completion)
    }

}


