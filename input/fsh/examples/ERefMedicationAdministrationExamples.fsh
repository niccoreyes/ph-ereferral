Instance: ExampleERefMedicationAdministrationAntibiotic
InstanceOf: ERefMedicationAdministration
Usage: #example
Title: "Example Antibiotic Administration"
Description: "Example IV antibiotic administration for a patient with suspected infection. Demonstrates REF-39 Treatment Given data element."

* status = #completed
* medicationReference = Reference(ExampleERefMedicationAntibiotic)
* subject = Reference(ExampleERefPatient)
* effectivePeriod.start = "2025-03-15T08:00:00+08:00"
* effectivePeriod.end = "2025-03-15T08:30:00+08:00"
* performer.actor = Reference(ExampleERefPractitioner)
* performer.function = $sct#158965000 "Medical practitioner"
* dosage.site = $sct#49852007 "Structure of median cubital vein"
* dosage.route = $sct#47625008 "Intravenous route"
* dosage.dose = 750 'mg' "mg"
* note.text = "Administered as part of pre-referral treatment for suspected sepsis. Patient to continue oral antibiotics at receiving facility."

Instance: ExampleERefMedicationAdministrationChronic
InstanceOf: ERefMedicationAdministration
Usage: #example
Title: "Example Chronic Medication Administration"
Description: "Example chronic medication administration (antihypertensive) demonstrating routine medication given to patient. Part of clinical summary (REF-15)."

* status = #completed
* medicationReference = Reference(ExampleERefMedicationTwinact)
* subject = Reference(ExampleERefPatient)
* effectiveDateTime = "2025-03-15T07:00:00+08:00"
* context = Reference(ExampleERefEncounter)
* performer.actor = Reference(ExampleERefPractitioner)
* performer.function = $sct#158965000 "Medical practitioner"
* dosage.route = $sct#26643006 "Oral route"
* dosage.dose = 1 '{tablet}' "tablet"
* note.text = "Patient's regular morning antihypertensive medication given before referral. Patient has been compliant with daily dosing."

// === SUPPORTING RESOURCES (Self-Contained) ===

Instance: ExampleERefPatient
InstanceOf: PHCorePatient
Usage: #example
Title: "Example eReferral Patient"
Description: "Example patient for MedicationAdministration demonstration."

* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.3.2"
* identifier.value = "PH-123456789"
* name.family = "Dela Cruz"
* name.given[0] = "Juan"
* gender = #male
* birthDate = "1965-07-20"

Instance: ExampleERefPractitioner
InstanceOf: PHCorePractitioner
Usage: #example
Title: "Example Referring Practitioner"
Description: "Example practitioner for MedicationAdministration demonstration."

* identifier.system = "urn:oid:2.16.840.1.113883.2.9.4.3.3"
* identifier.value = "MD-98765"
* name.family = "Santos"
* name.given[0] = "Maria"
* name.prefix = "Dr."
* gender = #female

Instance: ExampleERefMedicationAntibiotic
InstanceOf: PHCoreMedication
Usage: #example
Title: "Example Cefuroxime Medication"
Description: "Example antibiotic medication resource for IV administration."

* code = $sct#105590001 "Substance"
* code.text = "Cefuroxime 750mg IV (antibiotic)"
* status = #active

Instance: ExampleERefMedicationTwinact
InstanceOf: PHCoreMedication
Usage: #example
Title: "Example Twinact Medication"
Description: "Example medication resource for Twinact (Telmisartan + Amlodipine) used in chronic medication administration example."

* code = $sct#105590001 "Substance"
* code.text = "Twinact (Telmisartan 80mg + Amlodipine 5mg) - antihypertensive"
* status = #active

Instance: ExampleERefEncounter
InstanceOf: PHCoreEncounter
Usage: #example
Title: "Example Referral Encounter"
Description: "Example ambulatory encounter context for medication administration during the referral visit."

* status = #finished
* class = $v3-ActCode#AMB "ambulatory"
* type = $sct#308335008 "Patient encounter procedure"
* subject = Reference(ExampleERefPatient)
* period.start = "2025-03-15T07:30:00+08:00"
* period.end = "2025-03-15T09:30:00+08:00"
