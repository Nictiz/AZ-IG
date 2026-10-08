// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// =============================================================================
// Shared conformance-resource metadata.
//
// Section 10.2.1.1 of the Nictiz FHIR Profiling Guidelines R4 requires publisher,
// contact and copyright on every conformance resource, and recommends description
// and purpose. The three required elements are the same everywhere, so they live in
// one RuleSet rather than being repeated per artifact; the strings are taken
// verbatim from nl-core so the whole family reads alike.
//
// Insert on every Profile, Extension, CodeSystem, ValueSet, ActorDefinition and
// CapabilityStatement. purpose is per artifact and is set at the artifact itself.
// =============================================================================

RuleSet: NictizMetadata
* ^publisher = "Nictiz"
* ^contact.name = "Nictiz"
* ^contact.telecom.system = #url
* ^contact.telecom.value = "https://www.nictiz.nl"
* ^contact.telecom.use = #work
* ^copyright = "Copyright and related rights waived via CC0, https://creativecommons.org/publicdomain/zero/1.0/. This does not apply to information from third parties, for example a medical terminology system. The implementer alone is responsible for identifying and obtaining any necessary licenses or authorizations to utilize third party IP in connection with the specification or otherwise."

// The same, for Instance-based conformance resources (CapabilityStatement,
// ActorDefinition), where the elements are set directly instead of through carets.
RuleSet: NictizMetadataInstance
* publisher = "Nictiz"
* contact.name = "Nictiz"
* contact.telecom.system = #url
* contact.telecom.value = "https://www.nictiz.nl"
* contact.telecom.use = #work
* copyright = "Copyright and related rights waived via CC0, https://creativecommons.org/publicdomain/zero/1.0/. This does not apply to information from third parties, for example a medical terminology system. The implementer alone is responsible for identifying and obtaining any necessary licenses or authorizations to utilize third party IP in connection with the specification or otherwise."
