CodeSystem: HgMessageEventCS
Id: hg-message-event
Title: "HG message events"
Description: "Message event codes for the acute-zorg referral PUSH transactions."
* ^caseSensitive = true
* ^content = #complete
* #ambulance-referral-to-gp "Ambulance referral to GP/HAP"

ValueSet: HgMessageEventVS
Id: hg-message-event
Title: "HG message events"
Description: "Message event codes for the acute-zorg referral PUSH transactions."
* include codes from system HgMessageEventCS
