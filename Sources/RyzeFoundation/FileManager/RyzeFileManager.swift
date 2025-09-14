//
//  RyzeFileManager.swift
//  Ryze
//
//  Created by Rafael Escaleira on 13/09/25.
//

public actor RyzeFileManager {
    private var fileManager = FileManager.default
    
    public init() {}
    
    public func path(
        with name: String,
        privacy: RyzeFilePrivacy = .public
    ) -> URL? {
        guard let documentsURL = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return nil }
        
        switch privacy {
        case .public:
            return documentsURL.appendingPathComponent(name)
            
        case .private:
            let privateURL = documentsURL.appendingPathComponent(privacy.rawValue)
            do {
                try fileManager.createDirectory(
                    at: privateURL,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
            } catch { return nil }
            return privateURL.appendingPathComponent(name)
        }
    }
}
