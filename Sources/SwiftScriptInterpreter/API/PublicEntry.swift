// SwiftBox patch: narrow public entry for host-side member evaluation.
//
// This file is additive only — it exposes the interpreter's existing
// internal property-lookup path to embedding hosts. No upstream logic,
// dependencies, or access levels are modified.
//
// Note: `Interpreter.call(_:arguments:)` for invoking `.function` values
// already exists upstream (API/Macros.swift, issue #14); only the member
// entry needed a wrapper.

extension Interpreter {
    /// SwiftBox patch: narrow public entry for member evaluation on an existing Value.
    ///
    /// Forwards to the interpreter's internal property-lookup path (the same
    /// one `evaluate(memberAccess:)` dispatches to). `offset` is the source
    /// position used for error anchoring; a host-side call has no script
    /// source, so `0` is passed.
    public func member(_ name: String, on receiver: Value) async throws -> Value {
        try await lookupProperty(name, on: receiver, at: 0)
    }
}
