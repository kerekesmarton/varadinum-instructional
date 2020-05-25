import Foundation
//based on https://github.com/ZamzamInc/Shank

/// A dependency collection that provides resolutions for object instances.
open class CoreServiceLocator {
    /// Stored object instance factories.
    private var services = [String: Register]()
    
    /// Construct dependency resolutions.
    public init(@Builder _ modules: () -> [Register]) {
        modules().forEach { add(module: $0) }
    }
    
    /// Construct dependency resolution.
    public init(@Builder _ module: () -> Register) {
        add(module: module())
    }
    
    /// Assigns the current container to the composition root.
    open func build() {
        Self.shared = self
    }
    
    fileprivate init() {}
    deinit { services.removeAll() }
}

private extension CoreServiceLocator {
    /// Composition root container of dependencies.
    static var shared = CoreServiceLocator()
    
    /// Registers a specific type and its instantiating factory.
    func add(module: Register) {
        services[module.name] = module
    }

    /// Resolves through inference and returns an instance of the given type from the current default container.
    ///
    /// If the dependency is not found, an exception will occur.
    func resolve<T>(for name: String? = nil) -> T {
        let name = name ?? String(describing: T.self)
        
        guard let component: T = services[name]?.resolve() as? T else {
            fatalError("Dependency '\(T.self)' not resolved!")
        }
        
        return component
    }
}

// MARK: Public API
public extension CoreServiceLocator {
    @_functionBuilder struct Builder {
        public static func buildBlock(_ modules: Register...) -> [Register] { modules }
        public static func buildBlock(_ module: Register) -> Register { module }
    }
}

/// A type that contributes to the object graph.
public struct Register {
    fileprivate let name: String
    fileprivate let resolve: () -> Any
    
    public init<T>(_ name: String? = nil, _ resolve: @escaping () -> T) {
        self.name = name ?? String(describing: T.self)
        self.resolve = resolve
    }
}

/// Resolves an instance from the dependency injection container.
@propertyWrapper
public class Inject<Value> {
    private let name: String?
    private var storage: Value?
    
    public var wrappedValue: Value {
        storage ?? {
            let value: Value = CoreServiceLocator.shared.resolve(for: name)
            storage = value // Reuse instance for later
            return value
        }()
    }
    
    public init() {
        self.name = nil
    }
    
    public init(_ name: String) {
        self.name = name
    }
}
