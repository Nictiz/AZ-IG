Extension: HgExtTextValue
Id: hg-ext-TextValue
Title: "HG Referral text value"
Description: "Carries the free-text content of a referral rubriek (a Composition section)."
* ^context[+].type = #element
* ^context[=].expression = "Composition.section"
* value[x] only string
* valueString 1..1
