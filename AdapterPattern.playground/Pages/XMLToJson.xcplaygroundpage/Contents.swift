import Foundation

class XmlDataApi {
    static let shared = XmlDataApi()
    private init() {}
    
    func provideXmlData() -> String {
        return "This is XML Data"
    }
}

protocol ConverterClient {
    func performConvert() -> String
}

class XmlToJsonAdapter: ConverterClient {
    func performConvert() -> String {
        return "\(XmlDataApi.shared.provideXmlData()) converted to JSON"
    }
}

class XmlToCustomAdapter: ConverterClient {
    func performConvert() -> String {
        return "\(XmlDataApi.shared.provideXmlData()) converted to Custom"
    }
}

class DataReader {
    let adapter: ConverterClient
    
    init(adapter: ConverterClient) {
        self.adapter = adapter
    }
    
    func provideDataFromApi() -> String {
        return adapter.performConvert()
    }
}

let reader = DataReader(adapter: XmlToCustomAdapter())
print(reader.provideDataFromApi())




