Alias: $sct = http://snomed.info/sct
Alias: $loinc = http://loinc.org
Alias: $icd-10 = http://hl7.org/fhir/sid/icd-10
Alias: $rxnorm = http://www.nlm.nih.gov/research/umls/rxnorm
Alias: $contactRole2 = http://terminology.hl7.org/CodeSystem/contactRole2
Alias: $v2-0360 = http://terminology.hl7.org/CodeSystem/v2-0360
Alias: $v3-ActCode = http://terminology.hl7.org/CodeSystem/v3-ActCode
Alias: $v3-ActPriority = http://terminology.hl7.org/CodeSystem/v3-ActPriority
Alias: $v3-ParticipationType = http://terminology.hl7.org/CodeSystem/v3-ParticipationType
Alias: $v3-ParticipationMode = http://terminology.hl7.org/CodeSystem/v3-ParticipationMode
Alias: $v3-ObservationInterpretation = http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation
Alias: $v3-RoleCode = http://terminology.hl7.org/CodeSystem/v3-RoleCode
Alias: $org-type = http://terminology.hl7.org/CodeSystem/organization-type
Alias: $condition-clinical = http://terminology.hl7.org/CodeSystem/condition-clinical
Alias: $condition-ver-status = http://terminology.hl7.org/CodeSystem/condition-ver-status
Alias: $condition-category = http://terminology.hl7.org/CodeSystem/condition-category
Alias: $observation-category = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $communication-category = http://terminology.hl7.org/CodeSystem/communication-category
Alias: $ucum = http://unitsofmeasure.org
Alias: $transport-location-type = http://terminology.hl7.org/CodeSystem/transport-location-type
Alias: $us-core-documentreference-category = http://hl7.org/fhir/us/core/CodeSystem/us-core-documentreference-category
Alias: $ihe-format = http://ihe.net/fhir/ValueSet/IHE.FormatCode.codesystem
Alias: $ph-ereferral-facility-level = http://ph-ereferral.org/CodeSystem/facility-level
Alias: $ph-ereferral-facility-level-sd = http://ph-ereferral.org/StructureDefinition/facility-level

// =============================================================================
// PATIENTS
// =============================================================================

Instance: patient-maria-santos
InstanceOf: Patient
Usage: #inline
* identifier[+].use = #official
* identifier[=].system = "http://ph-ereferral.org/patient-id"
* identifier[=].value = "PH-PATIENT-2026-00001"
* name[+].use = #official
* name[=].family = "Santos"
* name[=].given[+] = "Maria"
* gender = #female
* birthDate = "1997-02-25"
* address[+].use = #home
* address[=].type = #physical
* address[=].line[+] = "Barangay Tibanga"
* address[=].city = "Iligan City"
* address[=].state = "Lanao del Norte"
* address[=].country = "Philippines"

Instance: patient-newborn
InstanceOf: Patient
Usage: #inline
* name[+].use = #temp
* name[=].family = "Santos"
* name[=].text = "Baby of Maria Santos"
* gender = #unknown
* birthDate = "2026-02-25"
// * birthPlace.address.text = "Adventist Medical Center" // Consider adding birthplace in PH Core
* multipleBirthBoolean = false
* contact[+].relationship[+].coding[+].system = $contactRole2
* contact[=].relationship[=].coding[=].code = #N
* contact[=].relationship[=].coding[=].display = "Next-of-Kin"
* contact[=].name.family = "Santos"
* contact[=].name.given[+] = "Maria"

// =============================================================================
// PRACTITIONERS
// =============================================================================

Instance: practitioner-elena-midwife
InstanceOf: Practitioner
Usage: #inline
* identifier[+].use = #official
* identifier[=].system = "http://ph-ereferral.org/practitioner-id"
* identifier[=].value = "PH-MIDWIFE-2026-00042"
* name[+].use = #official
* name[=].family = "Elena"
* name[=].given[+] = "Midwife"
* name[=].prefix[+] = "Midwife"
* qualification[+].code.coding[+].system = $v2-0360
* qualification[=].code.coding[=].code = #RM
* qualification[=].code.coding[=].display = "Registered Midwife"

Instance: practitioner-luz-navigator
InstanceOf: Practitioner
Usage: #inline
* identifier[+].use = #official
* identifier[=].system = "http://ph-ereferral.org/practitioner-id"
* identifier[=].value = "PH-NAVIGATOR-2026-00015"
* name[+].use = #official
* name[=].family = "Luz"
* name[=].given[+] = "Navigator"
* qualification[+].code.coding[+].system = $sct
* qualification[=].code.coding[=].code = #224571005
* qualification[=].code.coding[=].display = "Nurse Navigator"

Instance: practitioner-dr-rivera
InstanceOf: Practitioner
Usage: #inline
* identifier[+].use = #official
* identifier[=].system = "http://ph-ereferral.org/practitioner-id"
* identifier[=].value = "PH-PHYSICIAN-2026-00128"
* name[+].use = #official
* name[=].family = "Rivera"
* name[=].given[+] = "Dr."
* name[=].prefix[+] = "Dr."
* qualification[+].code.coding[+].system = $v2-0360
* qualification[=].code.coding[=].code = #MD
* qualification[=].code.coding[=].display = "Doctor of Medicine"
* qualification[+].code.coding[+].system = $sct
* qualification[=].code.coding[=].code = #309343006
* qualification[=].code.coding[=].display = "Physician, Obstetrics and Gynecology"

// =============================================================================
// ORGANIZATIONS
// =============================================================================

Instance: organization-lgu-iligan
InstanceOf: Organization
Usage: #inline
* identifier[+].use = #official
* identifier[=].system = "http://ph-ereferral.org/lgu-id"
* identifier[=].value = "PH-LGU-2026-00045"
* name = "Local Government Unit - Iligan City"
* type[+].coding[+].system = $org-type
* type[=].coding[=].code = #govt
* type[=].coding[=].display = "Government"

Instance: organization-barangay-tibanga-hc
InstanceOf: Organization
Usage: #inline
* identifier[+].use = #official
* identifier[=].system = "http://ph-ereferral.org/facility-id"
* identifier[=].value = "PH-RHU-2026-00089"
* name = "Barangay Tibanga Health Center"
* type[+].coding[+].system = $org-type
* type[=].coding[=].code = #prov
* type[=].coding[=].display = "Healthcare Provider"
* partOf.reference = "Organization/organization-lgu-iligan"
* partOf.display = "Local Government Unit - Iligan City"

Instance: organization-adventist-medical-center
InstanceOf: Organization
Usage: #inline
* identifier[+].use = #official
* identifier[=].system = "http://ph-ereferral.org/facility-id"
* identifier[=].value = "PH-HOSPITAL-2026-00012"
* name = "Adventist Medical Center"
* alias[+] = "AMC"
* type[+].coding[+].system = $org-type
* type[=].coding[=].code = #prov
* type[=].coding[=].display = "Healthcare Provider"
* type[+].coding[+].system = $sct
* type[=].coding[=].code = #22232009
* type[=].coding[=].display = "Hospital"
* extension[+].url = $ph-ereferral-facility-level-sd
* extension[=].valueCodeableConcept.coding[+].system = $ph-ereferral-facility-level
* extension[=].valueCodeableConcept.coding[=].code = #level-ii
* extension[=].valueCodeableConcept.coding[=].display = "Level II Hospital"

// =============================================================================
// LOCATIONS
// =============================================================================

Instance: location-barangay-tibanga-hc
InstanceOf: Location
Usage: #inline
* status = #active
* name = "Barangay Tibanga Health Center - Maternal Care Unit"
* description = "Maternal Care Provider unit for prenatal and postnatal care"
* type[+].coding[+].system = $v3-RoleCode
* type[=].coding[=].code = #HOSP
* type[=].coding[=].display = "Hospital"
* type[+].coding[+].system = $sct
* type[=].coding[=].code = #257573002
* type[=].coding[=].display = "Maternity unit"
* managingOrganization.reference = "Organization/organization-barangay-tibanga-hc"

Instance: location-adventist-labor-room
InstanceOf: Location
Usage: #inline
* status = #active
* name = "Adventist Medical Center - Labor and Delivery Unit"
* type[+].coding[+].system = $sct
* type[=].coding[=].code = #257573002
* type[=].coding[=].display = "Maternity unit"
* managingOrganization.reference = "Organization/organization-adventist-medical-center"

Instance: location-adventist-operating-room
InstanceOf: Location
Usage: #inline
* status = #active
* name = "Adventist Medical Center - Operating Room"
* type[+].coding[+].system = $sct
* type[=].coding[=].code = #14100006
* type[=].coding[=].display = "Operating room"
* managingOrganization.reference = "Organization/organization-adventist-medical-center"

// =============================================================================
// ENCOUNTERS
// =============================================================================

Instance: encounter-prenatal-initial
InstanceOf: Encounter
Usage: #inline
* status = #finished
* class.system = $v3-ActCode
* class.code = #AMB
* class.display = "ambulatory"
* type[+].coding[+].system = $sct
* type[=].coding[=].code = #424619007
* type[=].coding[=].display = "Prenatal visit"
* priority.coding[+].system = $v3-ActPriority
* priority.coding[=].code = #EM
* priority.coding[=].display = "emergency"
* subject.reference = "Patient/patient-maria-santos"
* participant[+].type[+].coding[+].system = $v3-ParticipationType
* participant[=].type[=].coding[=].code = #ATND
* participant[=].type[=].coding[=].display = "attender"
* participant[=].individual.reference = "Practitioner/practitioner-elena-midwife"
* period.start = "2026-02-25T00:00:00Z"
* period.end = "2026-02-25T00:30:00Z"
* reasonCode[+].coding[+].system = $sct
* reasonCode[=].coding[=].code = #423470008
* reasonCode[=].coding[=].display = "Severe headache"
* reasonCode[+].coding[+].system = $sct
* reasonCode[=].coding[=].code = #404640003
* reasonCode[=].coding[=].display = "Visual disturbance"
* serviceProvider.reference = "Organization/organization-barangay-tibanga-hc"
* location[+].location.reference = "Location/location-barangay-tibanga-hc"

Instance: encounter-amc-arrival
InstanceOf: Encounter
Usage: #inline
* status = #finished
* class.system = $v3-ActCode
* class.code = #EMER
* class.display = "emergency"
* type[+].coding[+].system = $sct
* type[=].coding[=].code = #50849002
* type[=].coding[=].display = "Emergency room admission"
* priority.coding[+].system = $v3-ActPriority
* priority.coding[=].code = #EM
* priority.coding[=].display = "emergency"
* subject.reference = "Patient/patient-maria-santos"
* participant[+].type[+].coding[+].system = $v3-ParticipationType
* participant[=].type[=].coding[=].code = #ATND
* participant[=].type[=].coding[=].display = "attender"
* participant[=].individual.reference = "Practitioner/practitioner-dr-rivera"
* period.start = "2026-02-25T00:35:00Z"
* period.end = "2026-02-25T02:00:00Z"
* reasonReference[+].reference = "condition-severe-preeclampsia"
* serviceProvider.reference = "organization-adventist-medical-center"
* location[+].location.reference = "location-adventist-labor-room"
// * incomingReferral[+].reference = "service-request-referral"

// =============================================================================
// CONDITIONS
// =============================================================================

Instance: condition-severe-preeclampsia
InstanceOf: Condition
Usage: #inline
* clinicalStatus.coding[+].system = $condition-clinical
* clinicalStatus.coding[=].code = #active
* clinicalStatus.coding[=].display = "Active"
* verificationStatus.coding[+].system = $condition-ver-status
* verificationStatus.coding[=].code = #confirmed
* verificationStatus.coding[=].display = "Confirmed"
* category[+].coding[+].system = $condition-category
* category[=].coding[=].code = #encounter-diagnosis
* category[=].coding[=].display = "Encounter Diagnosis"
* severity.coding[+].system = $sct
* severity.coding[=].code = #24484000
* severity.coding[=].display = "Severe"
* code.coding[+].system = $icd-10
* code.coding[=].code = #O14.1
* code.coding[=].display = "Severe pre-eclampsia"
* code.coding[+].system = $sct
* code.coding[=].code = #72546008
* code.coding[=].display = "Severe pre-eclampsia"
* subject.reference = "Patient/patient-maria-santos"
* encounter.reference = "Encounter/encounter-prenatal-initial"
* onsetDateTime = "2026-02-25T00:00:00Z"
* recordedDate = "2026-02-25T00:05:00Z"
* recorder.reference = "Practitioner/practitioner-elena-midwife"
* note[+].text = "Obstetric emergency requiring immediate specialist intervention at facility equipped for cesarean delivery. Beyond RHU capabilities."

// =============================================================================
// OBSERVATIONS
// =============================================================================

Instance: observation-bp-severe
InstanceOf: Observation
Usage: #inline
* status = #final
* category[+].coding[+].system = $observation-category
* category[=].coding[=].code = #vital-signs
* category[=].coding[=].display = "Vital Signs"
* code.coding[+].system = $loinc
* code.coding[=].code = #85354-9
* code.coding[=].display = "Blood pressure panel"
* subject.reference = "Patient/patient-maria-santos"
* encounter.reference = "Encounter/encounter-prenatal-initial"
* effectiveDateTime = "2026-02-25T00:05:00Z"
* performer[+].reference = "Practitioner/practitioner-elena-midwife"
* component[+].code.coding[+].system = $loinc
* component[=].code.coding[=].code = #8480-6
* component[=].code.coding[=].display = "Systolic blood pressure"
* component[=].valueQuantity.value = 160
* component[=].valueQuantity.unit = "mmHg"
* component[=].valueQuantity.system = $ucum
* component[=].valueQuantity.code = #mm[Hg]
* component[+].code.coding[+].system = $loinc
* component[=].code.coding[=].code = #8462-4
* component[=].code.coding[=].display = "Diastolic blood pressure"
* component[=].valueQuantity.value = 110
* component[=].valueQuantity.unit = "mmHg"
* component[=].valueQuantity.system = $ucum
* component[=].valueQuantity.code = #mm[Hg]
* interpretation[+].coding[+].system = $v3-ObservationInterpretation
* interpretation[=].coding[=].code = #HH
* interpretation[=].coding[=].display = "Critically high"
* note[+].text = "Blood pressure reading triggers immediate recognition of severe pre-eclampsia"

Instance: observation-pregnancy-status
InstanceOf: Observation
Usage: #inline
* status = #final
* category[+].coding[+].system = $observation-category
* category[=].coding[=].code = #survey
* category[=].coding[=].display = "Survey"
* code.coding[+].system = $loinc
* code.coding[=].code = #82810-3
* code.coding[=].display = "Pregnancy status"
* subject.reference = "Patient/patient-maria-santos"
* effectiveDateTime = "2026-02-25T00:00:00Z"
* valueCodeableConcept.coding[+].system = $sct
* valueCodeableConcept.coding[=].code = #77386006
* valueCodeableConcept.coding[=].display = "Pregnant"
* component[+].code.coding[+].system = $loinc
* component[=].code.coding[=].code = #41272-4
* component[=].code.coding[=].display = "Gestational age"
* component[=].valueQuantity.value = 36
* component[=].valueQuantity.unit = "weeks"
* component[=].valueQuantity.system = $ucum
* component[=].valueQuantity.code = #wk
* component[+].code.coding[+].system = $loinc
* component[=].code.coding[=].code = #11636-8
* component[=].code.coding[=].display = "Gravidity"
* component[=].valueQuantity.value = 3
* component[=].valueQuantity.unit = "pregnancies"
* component[+].code.coding[+].system = $loinc
* component[=].code.coding[=].code = #11637-6
* component[=].code.coding[=].display = "Parity"
* component[=].valueQuantity.value = 2
* component[=].valueQuantity.unit = "births"

Instance: observation-fetal-distress
InstanceOf: Observation
Usage: #inline
* status = #final
* category[+].coding[+].system = $observation-category
* category[=].coding[=].code = #exam
* category[=].coding[=].display = "Exam"
* code.coding[+].system = $sct
* code.coding[=].code = #276530008
* code.coding[=].display = "Fetal distress"
* subject.reference = "Patient/patient-maria-santos"
* encounter.reference = "Encounter/encounter-amc-arrival"
* effectiveDateTime = "2026-02-25T00:40:00Z"
* performer[+].reference = "Practitioner/practitioner-dr-rivera"
* valueCodeableConcept.coding[+].system = $sct
* valueCodeableConcept.coding[=].code = #276530008
* valueCodeableConcept.coding[=].display = "Fetal distress"
* note[+].text = "Fetal monitoring reveals signs of distress, necessitating immediate cesarean delivery"

// =============================================================================
// MEDICATIONS
// =============================================================================

Instance: medication-magnesium-sulfate
InstanceOf: Medication
Usage: #inline
* code.coding[+].system = $rxnorm
* code.coding[=].code = #6918
* code.coding[=].display = "Magnesium Sulfate"
* code.coding[+].system = $sct
* code.coding[=].code = #387362007
* code.coding[=].display = "Magnesium sulfate"
* form.coding[+].system = $sct
* form.coding[=].code = #385219001
* form.coding[=].display = "Injection solution"

Instance: medication-administration-magnesium
InstanceOf: MedicationAdministration
Usage: #inline
* status = #completed
* category = #medication
* medicationReference.reference = "Medication/medication-magnesium-sulfate"
* subject.reference = "Patient/patient-maria-santos"
* context.reference = "Encounter/encounter-prenatal-initial"
* effectiveDateTime = "2026-02-25T00:10:00Z"
* performer[+].actor.reference = "Practitioner/practitioner-elena-midwife"
* reasonReference[+].reference = "Condition/condition-severe-preeclampsia"
* dosage.text = "Standard magnesium sulfate loading dose to prevent seizures"
* dosage.route.coding[+].system = $sct
* dosage.route.coding[=].code = #47625008
* dosage.route.coding[=].display = "Intravenous route"
* note[+].text = "Administered as part of immediate treatment protocol for severe pre-eclampsia"

// =============================================================================
// SERVICE REQUEST (REFERRAL)
// =============================================================================

Instance: service-request-referral
InstanceOf: ServiceRequest
Usage: #inline
* status = #completed
* intent = #order
* priority = #stat
* category[+].coding[+].system = $sct
* category[=].coding[=].code = #103693007
* category[=].coding[=].display = "Diagnostic procedure"
* code.coding[+].system = $sct
* code.coding[=].code = #44383000
* code.coding[=].display = "Referral to specialist"
* code.text = "Emergency referral for obstetric care - severe pre-eclampsia"
* subject.reference = "patient-maria-santos"
* encounter.reference = "Encounter/encounter-prenatal-initial"
* occurrenceDateTime = "2026-02-25T00:10:00Z"
* requester.reference = "Practitioner/practitioner-elena-midwife"
* performer[+].reference = "Practitioner/practitioner-dr-rivera"
* reasonReference[+].reference = "Condition/condition-severe-preeclampsia"
* supportingInfo[+].reference = "Observation/observation-bp-severe"
* supportingInfo[+].reference = "Observation/observation-pregnancy-status"
* note[+].text = "Emergency referral alert sent via digital referral platform to Adventist Medical Center (Level II hospital) with OB-GYN specialist on duty and labor room available. Communication established within 5 minutes using SBAR protocol."

// =============================================================================
// COMMUNICATIONS
// =============================================================================

Instance: communication-referral-sbar
InstanceOf: Communication
Usage: #inline
* status = #completed
* category.coding[+].system = $communication-category
* category.coding[=].code = #alert
* category.coding[=].display = "Alert"
* payload[+].contentString = "SBAR Communication:\n\nSITUATION: Maria Santos, 28yo G3P2 at 36 weeks gestation with severe pre-eclampsia (BP 160/110 mmHg), presenting with severe headache and visual disturbances.\n\nBACKGROUND: Two previous uncomplicated pregnancies. Arrived at Barangay Tibanga Health Center for routine prenatal care.\n\nASSESSMENT: Severe pre-eclampsia with neurological symptoms. Obstetric emergency requiring specialist intervention beyond RHU capabilities.\n\nRECOMMENDATION: Immediate transfer to Level II hospital for cesarean delivery. Patient received magnesium sulfate loading dose. Requires continuous monitoring during transport."
* subject.reference = "Patient/patient-maria-santos"
* encounter.reference = "Encounter/encounter-prenatal-initial"
* sent = "2026-02-25T00:15:00Z"
* sender.reference = "Practitioner/practitioner-luz-navigator"
* recipient[+].reference = "Practitioner/practitioner-dr-rivera"
* medium[+].coding[+].system = $v3-ParticipationMode
* medium[=].coding[=].code = #ELECTRONIC
* medium[=].coding[=].display = "Electronic"
* note[+].text = "Standardized SBAR protocol communication through digital referral platform. Communication established within 5 minutes."

Instance: communication-outcome-notification
InstanceOf: Communication
Usage: #inline
* status = #completed
* category.coding[+].system = $communication-category
* category.coding[=].code = #alert
* category.coding[=].display = "Alert"
* payload[+].contentString = "REFERRAL OUTCOME NOTIFICATION:\n\nPatient: Maria Santos\nReferring Facility: Barangay Tibanga Health Center\nReceiving Facility: Adventist Medical Center\n\nProcedure: Emergency cesarean section\nOutcome: Successful - Healthy infant delivered, maternal stabilization achieved\nComplications: None\n\nReferral loop completed within 2 hours of initial presentation.\n\nPost-delivery care plan transmitted to referring facility for continuity of care."
* subject.reference = "Patient/patient-maria-santos"
* encounter.reference = "Encounter/encounter-amc-arrival"
* sent = "2026-02-25T02:00:00Z"
* sender.reference = "Practitioner/practitioner-dr-rivera"
* recipient[+].reference = "Practitioner/practitioner-elena-midwife"
* medium[+].coding[+].system = $v3-ParticipationMode
* medium[=].coding[=].code = #ELECTRONIC
* medium[=].coding[=].display = "Electronic"
* note[+].text = "Real-time notification to referring facility via eReferral system. Instant feedback to Midwife Elena completing the referral loop."

// =============================================================================
// TRANSPORT
// =============================================================================

// Instance: transport-ambulance
// InstanceOf: Transport
// Usage: #inline
// * identifier[+].use = #official
// * identifier[=].system = "http://ph-ereferral.org/transport-id"
// * identifier[=].value = "PH-TRANSPORT-2026-00078"
// * status = #completed
// * intent = #order
// * priority = #stat
// * category.coding[+].system = $sct
// * category.coding[=].code = #225358003
// * category.coding[=].display = "Ambulance transport"
// * subject.reference = "Patient/patient-maria-santos"
// * requester.reference = "Practitioner/practitioner-elena-midwife"
// * performer[+].reference = "Organization/organization-lgu-iligan"
// * performer[=].display = "Local Government Unit Ambulance Team"
// * location[+].type.coding[+].system = $transport-location-type
// * location[=].type.coding[=].code = #pickup
// * location[=].type.coding[=].display = "Pick-up location"
// * location[=].address.text = "Barangay Tibanga Health Center"
// * location[+].type.coding[+].system = $transport-location-type
// * location[=].type.coding[=].code = #dropoff
// * location[=].type.coding[=].display = "Drop-off location"
// * location[=].address.text = "Adventist Medical Center"
// * period.start = "2026-02-25T00:20:00Z"
// * period.end = "2026-02-25T00:35:00Z"
// * note[+].text = "15-minute journey. Midwife Elena accompanied patient with continuous blood pressure monitoring and magnesium sulfate infusion. Regular updates provided to receiving hospital via digital tracking system."

// =============================================================================
// PROCEDURES
// =============================================================================

Instance: procedure-cesarean-section
InstanceOf: Procedure
Usage: #inline
* status = #completed
* category.coding[+].system = $sct
* category.coding[=].code = #387713003
* category.coding[=].display = "Surgical procedure"
* code.coding[+].system = $sct
* code.coding[=].code = #11466000
* code.coding[=].display = "Cesarean section"
* code.coding[+].system = $rxnorm
* code.coding[=].code = #61863
* code.coding[=].display = "Cesarean section"
* code.text = "Emergency cesarean section"
* subject.reference = "Patient/patient-maria-santos"
* encounter.reference = "Encounter/encounter-amc-arrival"
* performedDateTime = "2026-02-25T00:45:00Z"
* performer[+].actor.reference = "Practitioner/practitioner-dr-rivera"
* performer[=].function.coding[+].system = $sct
* performer[=].function.coding[=].code = #304292004
* performer[=].function.coding[=].display = "Surgeon"
* reasonReference[+].reference = "Condition/condition-severe-preeclampsia"
* reasonReference[+].reference = "Observation/observation-fetal-distress"
* location.reference = "Location/location-adventist-operating-room"
* outcome.coding[+].system = $sct
* outcome.coding[=].code = #385669000
* outcome.coding[=].display = "Successful"
* note[+].text = "Emergency cesarean section proceeded without complications. Healthy infant delivered. Maternal stabilization achieved. Decision based on comprehensive information received during digital referral process."

Instance: procedure-birth
InstanceOf: Procedure
Usage: #inline
* status = #completed
* category.coding[+].system = $sct
* category.coding[=].code = #103693007
* category.coding[=].display = "Diagnostic procedure"
* code.coding[+].system = $sct
* code.coding[=].code = #386634004
* code.coding[=].display = "Obstetric procedure"
* code.coding[+].system = $sct
* code.coding[=].code = #395085003
* code.coding[=].display = "Birth of infant"
* subject.reference = "Patient/patient-maria-santos"
* encounter.reference = "Encounter/encounter-amc-arrival"
* performedDateTime = "2026-02-25T00:50:00Z"
* performer[+].actor.reference = "Practitioner/practitioner-dr-rivera"
* reasonReference[+].reference = "Procedure/procedure-cesarean-section"
* outcome.coding[+].system = $sct
* outcome.coding[=].code = #280413001
* outcome.coding[=].display = "Live birth"
* report[+].reference = "Patient/patient-newborn"
* report[=].display = "Healthy infant"
* note[+].text = "Healthy infant delivered via emergency cesarean section"

// =============================================================================
// CARE PLAN
// =============================================================================

Instance: care-plan-post-delivery
InstanceOf: CarePlan
Usage: #inline
* status = #active
* intent = #plan
* category[+].coding[+].system = $sct
* category[=].coding[=].code = #736378006
* category[=].coding[=].display = "Postpartum care"
* title = "Post-Delivery Care Plan - Severe Pre-eclampsia"
* description = "Post-delivery care coordination for patient with severe pre-eclampsia history"
* subject.reference = "Patient/patient-maria-santos"
* encounter.reference = "Encounter/encounter-amc-arrival"
* period.start = "2026-02-25"
* created = "2026-02-25T02:00:00Z"
* author.reference = "Practitioner/practitioner-dr-rivera"
* contributor[+].reference = "Organization/organization-adventist-medical-center"
* careTeam[+].reference = "Practitioner/practitioner-dr-rivera"
* careTeam[+].reference = "Practitioner/practitioner-elena-midwife"
* addresses[+].reference = "Condition/condition-severe-preeclampsia"
* activity[+].detail.kind = #MedicationRequest
* activity[=].detail.code.coding[+].system = $sct
* activity[=].detail.code.coding[=].code = #182840001
* activity[=].detail.code.coding[=].display = "Blood pressure management"
* activity[=].detail.status = #in-progress
* activity[=].detail.description = "Blood pressure management protocols - monitor BP every 4 hours, maintain BP < 140/90 mmHg"
* activity[+].detail.kind = #MedicationRequest
* activity[=].detail.code.coding[+].system = $sct
* activity[=].detail.code.coding[=].code = #182904002
* activity[=].detail.code.coding[=].display = "Medication management"
* activity[=].detail.status = #in-progress
* activity[=].detail.description = "Antihypertensive medication regimen as prescribed"
* activity[+].detail.kind = #ServiceRequest
* activity[=].detail.code.coding[+].system = $sct
* activity[=].detail.code.coding[=].code = #390906007
* activity[=].detail.code.coding[=].display = "Follow-up encounter"
* activity[=].detail.status = #scheduled
* activity[=].detail.scheduledTiming.repeat.boundsDuration.value = 7
* activity[=].detail.scheduledTiming.repeat.boundsDuration.unit = "days"
* activity[=].detail.scheduledTiming.repeat.boundsDuration.system = $ucum
* activity[=].detail.scheduledTiming.repeat.boundsDuration.code = #d
* activity[=].detail.description = "Follow-up scheduling - postpartum check within 7 days, then weekly for 6 weeks"
* note[+].text = "Discharge documentation transmitted electronically to referring RHU (Barangay Tibanga Health Center) for seamless continuity of care when patient returns for post-delivery monitoring. Includes blood pressure management protocols, medication regimens, and follow-up scheduling."

// =============================================================================
// DOCUMENT REFERENCE
// =============================================================================

Instance: document-reference-discharge
InstanceOf: DocumentReference
Usage: #inline
* status = #current
* type.coding[+].system = $loinc
* type.coding[=].code = #18842-5
* type.coding[=].display = "Discharge summary"
* category[+].coding[+].system = $us-core-documentreference-category
* category[=].coding[=].code = #clinical-note
* category[=].coding[=].display = "Clinical Note"
* subject.reference = "Patient/patient-maria-santos"
* date = "2026-02-25T02:00:00Z"
* author[+].reference = "Practitioner/practitioner-dr-rivera"
* custodian.reference = "Organization/organization-adventist-medical-center"
* content[+].attachment.contentType = #application/json
* content[=].attachment.title = "Post-Delivery Discharge Documentation"
* content[=].format.system = $ihe-format
// * content[=].format.code = "urn:ihe:iti:xds:2017:mimeTypeSufficient"
* content[=].format.display = "mimeType Sufficient"
* context.encounter[+].reference = "Encounter/encounter-amc-arrival"
* context.period.start = "2026-02-25T00:35:00Z"
* context.period.end = "2026-02-25T02:00:00Z"
* description = "Discharge documentation including blood pressure management protocols, medication regimens, and follow-up scheduling for continuity of care at referring facility"

// =============================================================================
// BUNDLE
// =============================================================================

Instance: bundle-obstetric-emergency-referral-20260225
InstanceOf: Bundle
* type = #transaction
* timestamp = "2026-02-25T00:00:00Z"

// Patient entries
* entry[+].fullUrl = "urn:uuid:patient-maria-santos"
* entry[=].resource = patient-maria-santos
* entry[=].request.method = #POST
* entry[=].request.url = "Patient"

* entry[+].fullUrl = "urn:uuid:patient-newborn"
* entry[=].resource = patient-newborn
* entry[=].request.method = #POST
* entry[=].request.url = "Patient"

// Practitioner entries
* entry[+].fullUrl = "urn:uuid:practitioner-elena-midwife"
* entry[=].resource = practitioner-elena-midwife
* entry[=].request.method = #POST
* entry[=].request.url = "Practitioner"

* entry[+].fullUrl = "urn:uuid:practitioner-luz-navigator"
* entry[=].resource = practitioner-luz-navigator
* entry[=].request.method = #POST
* entry[=].request.url = "Practitioner"

* entry[+].fullUrl = "urn:uuid:practitioner-dr-rivera"
* entry[=].resource = practitioner-dr-rivera
* entry[=].request.method = #POST
* entry[=].request.url = "Practitioner"

// Organization entries
* entry[+].fullUrl = "urn:uuid:organization-barangay-tibanga-hc"
* entry[=].resource = organization-barangay-tibanga-hc
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

* entry[+].fullUrl = "urn:uuid:organization-adventist-medical-center"
* entry[=].resource = organization-adventist-medical-center
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

* entry[+].fullUrl = "urn:uuid:organization-lgu-iligan"
* entry[=].resource = organization-lgu-iligan
* entry[=].request.method = #POST
* entry[=].request.url = "Organization"

// Location entries
* entry[+].fullUrl = "urn:uuid:location-barangay-tibanga-hc"
* entry[=].resource = location-barangay-tibanga-hc
* entry[=].request.method = #POST
* entry[=].request.url = "Location"

* entry[+].fullUrl = "urn:uuid:location-adventist-labor-room"
* entry[=].resource = location-adventist-labor-room
* entry[=].request.method = #POST
* entry[=].request.url = "Location"

* entry[+].fullUrl = "urn:uuid:location-adventist-operating-room"
* entry[=].resource = location-adventist-operating-room
* entry[=].request.method = #POST
* entry[=].request.url = "Location"

// Encounter entries
* entry[+].fullUrl = "urn:uuid:encounter-prenatal-initial"
* entry[=].resource = encounter-prenatal-initial
* entry[=].request.method = #POST
* entry[=].request.url = "Encounter"

* entry[+].fullUrl = "urn:uuid:encounter-amc-arrival"
* entry[=].resource = encounter-amc-arrival
* entry[=].request.method = #POST
* entry[=].request.url = "Encounter"

// Condition entries
* entry[+].fullUrl = "urn:uuid:condition-severe-preeclampsia"
* entry[=].resource = condition-severe-preeclampsia
* entry[=].request.method = #POST
* entry[=].request.url = "Condition"

// Observation entries
* entry[+].fullUrl = "urn:uuid:observation-bp-severe"
* entry[=].resource = observation-bp-severe
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"

* entry[+].fullUrl = "urn:uuid:observation-pregnancy-status"
* entry[=].resource = observation-pregnancy-status
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"

* entry[+].fullUrl = "urn:uuid:observation-fetal-distress"
* entry[=].resource = observation-fetal-distress
* entry[=].request.method = #POST
* entry[=].request.url = "Observation"

// Medication entries
* entry[+].fullUrl = "urn:uuid:medication-magnesium-sulfate"
* entry[=].resource = medication-magnesium-sulfate
* entry[=].request.method = #POST
* entry[=].request.url = "Medication"

* entry[+].fullUrl = "urn:uuid:medication-administration-magnesium"
* entry[=].resource = medication-administration-magnesium
* entry[=].request.method = #POST
* entry[=].request.url = "MedicationAdministration"

// ServiceRequest entries
* entry[+].fullUrl = "urn:uuid:service-request-referral"
* entry[=].resource = service-request-referral
* entry[=].request.method = #POST
* entry[=].request.url = "ServiceRequest"

// Communication entries
* entry[+].fullUrl = "urn:uuid:communication-referral-sbar"
* entry[=].resource = communication-referral-sbar
* entry[=].request.method = #POST
* entry[=].request.url = "Communication"

* entry[+].fullUrl = "urn:uuid:communication-outcome-notification"
* entry[=].resource = communication-outcome-notification
* entry[=].request.method = #POST
* entry[=].request.url = "Communication"

// Transport entries
// * entry[+].fullUrl = "urn:uuid:transport-ambulance"
// * entry[=].resource = transport-ambulance
// * entry[=].request.method = #POST
// * entry[=].request.url = "Transport"

// Procedure entries
* entry[+].fullUrl = "urn:uuid:procedure-cesarean-section"
* entry[=].resource = procedure-cesarean-section
* entry[=].request.method = #POST
* entry[=].request.url = "Procedure"

* entry[+].fullUrl = "urn:uuid:procedure-birth"
* entry[=].resource = procedure-birth
* entry[=].request.method = #POST
* entry[=].request.url = "Procedure"

// CarePlan entries
* entry[+].fullUrl = "urn:uuid:care-plan-post-delivery"
* entry[=].resource = care-plan-post-delivery
* entry[=].request.method = #POST
* entry[=].request.url = "CarePlan"

// DocumentReference entries
* entry[+].fullUrl = "urn:uuid:document-reference-discharge"
* entry[=].resource = document-reference-discharge
* entry[=].request.method = #POST
* entry[=].request.url = "DocumentReference"
