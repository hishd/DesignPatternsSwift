import UIKit

struct Job {
    let title: String
    let company: String
    let salary: Double
}

protocol JobProvider {
    func provide() -> [Job]
}

class RemoteJobProvider: JobProvider {
    func provide() -> [Job] {
        return [
            Job(title: "Software Engineer", company: "Virtusa", salary: 10000.0),
            Job(title: "Network Engineer", company: "WSO2", salary: 15000.0),
            Job(title: "DevOps Engineer", company: "99X", salary: 13000.0)
        ]
    }
}

class LocalJobProvider: JobProvider {
    func provide() -> [Job] {
        return [
            Job(title: "Android Developer", company: "Virtusa", salary: 12000.0),
            Job(title: "iOS Developer", company: "WSO2", salary: 13000.0),
            Job(title: "React Developer", company: "99X", salary: 14000.0)
        ]
    }
}

//class CachedJobProvider: JobProvider {
//    func provide() -> [Job] {
//        return [
//            Job(title: "Tech Lead", company: "Virtusa", salary: 18000.0),
//            Job(title: "Senior Software Engineer", company: "WSO2", salary: 16000.0),
//            Job(title: "Software Engineer", company: "99X", salary: 12000.0)
//        ]
//    }
//}

let networkAvailable: Bool = true

//Composing Objects and creating a Fallback Strategy
class JobProviderFallback: JobProvider {
    let primary: JobProvider
    let fallback: JobProvider
    
    init(primary: JobProvider, fallback: JobProvider) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func provide() -> [Job] {
        if networkAvailable {
            return primary.provide()
        } else {
            return fallback.provide()
        }
    }
}

class JobComponent {
    let provider: JobProvider
    
    init(provider: JobProvider) {
        self.provider = provider
    }
    
    func loadJobs() -> [Job] {
        return provider.provide()
    }
}

let jobComponent = JobComponent(provider: JobProviderFallback(primary: RemoteJobProvider(), fallback: LocalJobProvider()))
print(jobComponent.loadJobs())
