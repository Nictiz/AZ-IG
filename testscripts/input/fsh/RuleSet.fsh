// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// Reusable RuleSets for the Conformancelab TestScripts, modelled on the IKNL PZP
// test materials (Metadata, ClientTesting/ServerTesting with the Conformancelab
// SUT marker) plus a reusable content-assert set for the AMB-naar-HAP message.

// Common metadata. testId = the resource id (also used for url and name).
// Set title and description directly on the TestScript (they may contain commas
// and parentheses, which RuleSet parameters cannot).
RuleSet: Metadata(testId)
* status = #active
* version = "0.1.0-alpha.1"
* experimental = true
* publisher = "Nictiz"
* contact.name = "Nictiz"
* contact.telecom.system = #email
* contact.telecom.value = "kwalificatie@nictiz.nl"
* id = "{testId}"
* url = "http://nictiz.nl/fhir/TestScript/{testId}"
* name = "{testId}"

// The system under test is a client (e.g. a Sender that pushes the message).
RuleSet: ClientTesting
* origin.extension[+].url = $CL-SUT
* origin.extension[=].valueBoolean = true
* origin.index = 1
* origin.profile = $origin-types#FHIR-Client
* destination.extension[+].url = $CL-SUT
* destination.extension[=].valueBoolean = false
* destination.index = 1
* destination.profile = $destination-types#FHIR-Server

// The system under test is a server (e.g. a Receiver that accepts the message).
RuleSet: ServerTesting
* origin.extension[+].url = $CL-SUT
* origin.extension[=].valueBoolean = false
* origin.index = 1
* origin.profile = $origin-types#FHIR-Client
* destination.extension[+].url = $CL-SUT
* destination.extension[=].valueBoolean = true
* destination.index = 1
* destination.profile = $destination-types#FHIR-Server

// Content asserts for a pushed AMB-naar-HAP message. Insert under a `test` (the
// paths resolve to that test's action list). Assumes a profile entry with id
// "referral-bundle" is declared on the TestScript (see the Sender TestScript).
RuleSet: ReferralMessageContentAsserts
* action[+].assert
  * description = "The pushed resource is a Bundle."
  * direction = #request
  * resource = #Bundle
  * warningOnly = false
  * stopTestOnFail = true
* action[+].assert
  * description = "The Bundle conforms to the AMB-naar-HAP message Bundle profile."
  * direction = #request
  * validateProfileId = "referral-bundle"
  * warningOnly = false
  * stopTestOnFail = true
* action[+].assert
  * description = "The Bundle is a message Bundle (Bundle.type = message)."
  * direction = #request
  * expression = "Bundle.type = 'message'"
  * warningOnly = false
  * stopTestOnFail = true
* action[+].assert
  * description = "The MessageHeader carries the AMB-naar-HAP transaction event (145)."
  * direction = #request
  * expression = "Bundle.entry.resource.ofType(MessageHeader).event.ofType(Coding).code = '145'"
  * warningOnly = false
  * stopTestOnFail = true
* action[+].assert
  * description = "The MessageHeader focuses a resource (the referral ServiceRequest)."
  * direction = #request
  * expression = "Bundle.entry.resource.ofType(MessageHeader).focus.exists()"
  * warningOnly = false
  * stopTestOnFail = false
* action[+].assert
  * description = "The Composition carries the mandatory 'reason for referral' section (SNOMED 440378000)."
  * direction = #request
  * expression = "Bundle.entry.resource.ofType(Composition).section.code.coding.where(system = 'http://snomed.info/sct' and code = '440378000').exists()"
  * warningOnly = false
  * stopTestOnFail = false
* action[+].assert
  * description = "Every entry resource (except OperationOutcome/Binary) declares a meta.profile."
  * direction = #request
  * expression = "Bundle.entry.resource.where(is(OperationOutcome).not() and is(Binary).not()).where(meta.profile.empty()).empty()"
  * warningOnly = false
  * stopTestOnFail = false
* action[+].assert
  * description = "Every Coding has both a system and a code."
  * direction = #request
  * expression = "Bundle.descendants().where(is(Coding)).all(system.exists() and code.exists())"
  * warningOnly = false
  * stopTestOnFail = false
* action[+].assert
  * description = "Every Identifier has a system (or type) and a value."
  * direction = #request
  * expression = "Bundle.descendants().where(is(Identifier)).all((system.exists() or type.exists()) and value.exists())"
  * warningOnly = false
  * stopTestOnFail = false
