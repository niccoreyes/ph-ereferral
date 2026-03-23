Instance: ExampleERefReferringFacility
InstanceOf: PHCoreOrganization
Usage: #example
Title: "Example Referring Facility"
Description: "Example referring healthcare facility for eReferral workflow. Demonstrates REF-5 (Initiating Facility Name), REF-6 (Initiating Facility NHFR Code), REF-7 (Initiating Facility Address), and REF-8 (Initiating Facility Contact Number)."

* identifier[0].system = "https://nhfr.doh.gov.ph/facility"
* identifier[0].value = "DOH000000000001234"  // NHFR hfhudcode format
* identifier[0].type = $v2-0203#FI "Facility ID"
* active = true
* name = "Manila General Hospital - Barangay 143 Health Center"
* type = $v3-roleCode#HOSP "Hospital"
* telecom[0].system = #phone
* telecom[0].value = "+63 2 8123 4567"
* telecom[0].use = #work
* telecom[1].system = #email
* telecom[1].value = "contact@manilagenhosp.ph"
* telecom[1].use = #work
* address.use = #work
* address.type = #both
* address.text = "123 Rizal Avenue, Barangay 143, Manila, Philippines"
* address.line = "123 Rizal Avenue"
* address.city = "Manila"
* address.district = "Barangay 143"
* address.state = "Metro Manila"
* address.postalCode = "1000"
* address.country = "PH"
