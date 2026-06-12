CodeSystem: HgMessageEvent
Id: hg-message-event
Title: "hg message events"
Description: "Message event codes for the Acute Zorg referral PUSH transactions."
* ^caseSensitive = true
* ^content = #complete
* #ambulance-referral-to-hap "Ambulance referral to HAP"

ValueSet: HgMessageEvents
Id: hg-message-events
Title: "hg message events"
Description: "Message event codes for the Acute Zorg referral PUSH transactions."
* include codes from system HgMessageEvent
