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
    
    public func size(at path: URL?) -> String? {
        guard let path,
              let attributes = try? fileManager.attributesOfItem(atPath: path.path())
        else { return format(bytes: .zero) }
        let fileSize = attributes[.size] as? Int64 ?? 0
        return format(bytes: fileSize)
    }
    
    func format(bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB, .useGB]
        formatter.countStyle = .file
        
        return formatter.string(fromByteCount: bytes)
    }
}
