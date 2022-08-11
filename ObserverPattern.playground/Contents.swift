struct WeatherData {
    let temp: Double
    let humidity: Double
    let pressure: Double
}

class WeatherDataFeatcher {
    
    private var data: WeatherData?
    private var observers: [WeatherDataObserver] = []
    
    private func fetchTemperature() -> Double {
        return 10.0
    }
    
    private func fetchHumidity() -> Double {
        return 12.0
    }
    
    private func fetchPressure() -> Double {
        return 15.0
    }
    
    func fetachData() {
        data = WeatherData(temp: fetchTemperature(), humidity: fetchHumidity(), pressure: fetchPressure())
        notifiyObservers()
    }
    
    func registerObserver(observer: WeatherDataObserver) {
        self.observers.append(observer)
    }
    
    func registerObservers(observers: WeatherDataObserver...) {
        observers.forEach{(self.observers.append($0))}
    }
    
    func removeObserver(observer: WeatherDataObserver) {
        self.observers.removeAll(where: {
            $0 === observer
        })
    }
    
    private func notifiyObservers() {
        self.observers.forEach{($0.onWeatherDataChanged(data: data))}
    }
}

protocol WeatherDataObserver: AnyObject {
    func onWeatherDataChanged(data: WeatherData?)
}

class CurrentConditionDisplay: WeatherDataObserver {
    private var data: WeatherData?
    
    func onWeatherDataChanged(data: WeatherData?) {
        self.data = data
        displayData()
    }
    
    func displayData() {
        print("Current Condition Temp = \(data?.temp)")
    }
}

class StatisticsDisplay: WeatherDataObserver {
    private var data: WeatherData?
    
    func onWeatherDataChanged(data: WeatherData?) {
        self.data = data
        displayData()
    }
    
    func displayData() {
        print("Statistics Temp = \(data?.temp)")
    }
}

class ForecastDisplay: WeatherDataObserver {
    private var data: WeatherData?
    
    func onWeatherDataChanged(data: WeatherData?) {
        self.data = data
        displayData()
    }
    
    func displayData() {
        print("Forecast Temp = \(data?.temp)")
    }
}

let currentContidionDisplay = CurrentConditionDisplay()
let statisticsDisplay = StatisticsDisplay()
let forecastDisplay = ForecastDisplay()

let weatherFeatcher = WeatherDataFeatcher()
weatherFeatcher.registerObservers(observers: currentContidionDisplay, statisticsDisplay, forecastDisplay)
weatherFeatcher.fetachData()

weatherFeatcher.removeObserver(observer: statisticsDisplay)
weatherFeatcher.fetachData()
