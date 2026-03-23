Profile: ERefPractitionerRole
Parent: PractitionerRole
Id: ereferral-practitioner-role
Title: "PH eReferral PractitionerRole"
Description: "Profile on PractitionerRole for the Philippines eReferral specification. This profile is used to capture the role of the referring practitioner (sending side) and care navigator (receiving side) within the eReferral workflow."
* ^status = #draft
* ^jurisdiction = urn:iso:std:iso:3166#PH "Philippines"
* ^purpose = "This profile defines the constraints for representing practitioner roles in the Philippines eReferral context, including both the referring practitioner (requester) and the receiving practitioner/care navigator."

// Element ID: REF-1 - Name of Referring Practitioner (sending side)
// Element ID: REF-9 - Care Navigator (receiving side)
// Maps to: PractitionerRole.practitioner
// FHIR Path: ServiceRequest.requester (sending side) or ServiceRequest.performer (receiving side)
// Description: References the Practitioner resource containing the name and demographics of the referring practitioner (REF-1) or care navigator (REF-9)
* practitioner 1..1 MS
* practitioner only Reference(Practitioner)
* practitioner ^short = "The referring or receiving practitioner"
* practitioner ^definition = "Reference to the Practitioner resource representing the individual practitioner (referring practitioner on the sending side per REF-1, or care navigator on the receiving side per REF-9)."

// Element IDs: REF-5, REF-6, REF-7, REF-8 - Initiating Facility Name, NHFR Code, Address, Contact (sending side)
// Element IDs: REF-10, REF-11 - Receiving Facility Name, NHFR Code (receiving side)
// Maps to: PractitionerRole.organization
// FHIR Path: ServiceRequest.requester (sending side) or ServiceRequest.performer (receiving side)
// Description: References the Organization resource containing facility details including:
//   - REF-5: Initiating Facility Name (Organization.name)
//   - REF-6: Initiating Facility NHFR Code (Organization.identifier[NHFR])
//   - REF-7: Initiating Facility Address (Organization.address)
//   - REF-8: Initiating Facility Contact Number (Organization.telecom)
//   - REF-10: Receiving Facility Name (Organization.name)
//   - REF-11: Receiving Facility NHFR Code (Organization.identifier[NHFR])
* organization 1..1 MS
* organization only Reference(Organization)
* organization ^short = "The healthcare facility where the practitioner works"
* organization ^definition = "Reference to the Organization resource representing the healthcare facility (initiating facility on the sending side per REF-5/REF-6/REF-7/REF-8, or receiving facility on the receiving side per REF-10/REF-11)."

// Element ID: REF-2 - Practitioner Role
// Maps to: PractitionerRole.code
// FHIR Path: PractitionerRole.code
// Description: Designation or role of the referring professional (e.g., Midwife, District Nurse, District Medical Officer)
* code 1..* MS
* code ^short = "Role or designation of the practitioner"
* code ^definition = "The designation or role of the practitioner (e.g., Midwife, District Nurse, District Medical Officer). Required per REF-2 from Synchronous TDG FHIR Mapping."
* code ^comment = "This element captures the professional role of the practitioner within the eReferral context per REF-2. Common values include midwife, district nurse, and district medical officer."

// Remove non-essential elements not referenced in TDG sheet
// * specialty 0..0
// * active 0..0
// * period 0..0
// * telecom 0..0
// * location 0..0
// * healthcareService 0..0
// * availableTime 0..0
// * notAvailable 0..0
// * availabilityExceptions 0..0
// * endpoint 0..0
// * identifier 0..0
