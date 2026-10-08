### Background

The information exchange described in this Implementation Guide is defined by:

- The Richtlijn Gegevensuitwisseling Acute Zorg versie 4 (2022) ([PDF](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf)) is the policy-level guideline that establishes which data must be exchanged between parties in acute care settings in the Netherlands. It defines the scenarios, parties, and content requirements at a clinical level. This use cases corresponds to message 23 and 24 inthe guideline.

In the autumn of 2023, AZN and InEen merged the 2017 agreements on resource allocation and the HAP+RAV cooperation framework into a single national guideline for collaboration between HAPs (GP out-of-hours services) and RAVs (regional ambulance services):
- Samenwerking HAP-RAV [Guideline](https://www.ambulancezorg.nl/themas/kwaliteit-van-zorg/ketensamenwerking/samenwerking-hap-rav)

### Position in the Nictiz five-layer model

Interoperability requires agreements on five layers - the Nictiz [vijflagenmodel](https://www.nictiz.nl/wat-we-doen/zorginformatiestelsel/interoperabiliteit/lagenmodel-3/) - with *wet- en regelgeving* (legislation) and *beveiliging* (security) as conditions across all of them. This Implementation Guide mainly specifies the Informatie and Applicatie layers; the layers above and below it are established elsewhere.

<table class="grid">
  <thead>
    <tr><th>Layer</th><th>For this transaction</th><th>Where in this IG</th></tr>
  </thead>
  <tbody>
    <tr>
      <td style="background-color:#c1178c;color:#fff;font-weight:600;text-align:center;white-space:nowrap;">Organisatiebeleid</td>
      <td>Governance and agreements between the parties (ambulance/RAV, HAP), the <a href="https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf">Richtlijn Gegevensuitwisseling Acute Zorg</a>, and the national release policy. Largely outside this technical IG.</td>
      <td><a href="index.html">Home</a>, Functional design (this page)</td>
    </tr>
    <tr>
      <td style="background-color:#29abe2;color:#fff;font-weight:600;text-align:center;white-space:nowrap;">Zorgproces</td>
      <td>The handover itself: an ambulance professional refers a patient to the HAP after on-scene care, one-directional PUSH.</td>
      <td><a href="use-cases.html">Use cases</a>, <a href="workflow.html">Workflow</a></td>
    </tr>
    <tr>
      <td style="background-color:#e4670a;color:#fff;font-weight:600;text-align:center;white-space:nowrap;">Informatie</td>
      <td>What is exchanged: the ART-DECOR dataset, the zibs and nl-core, and the dataset mappings.</td>
      <td><a href="data-model.html">Data model</a>, this page</td>
    </tr>
    <tr>
      <td style="background-color:#95c11f;color:#fff;font-weight:600;text-align:center;white-space:nowrap;">Applicatie</td>
      <td>How systems exchange it: the FHIR R4 profiles, the message structure (MessageHeader/Bundle), CapabilityStatements and ActorDefinitions.</td>
      <td><a href="artifacts.html">Artifacts</a>, <a href="data-model.html">Data model</a></td>
    </tr>
    <tr>
      <td style="background-color:#009b3e;color:#fff;font-weight:600;text-align:center;white-space:nowrap;">IT-infrastructuur</td>
      <td>The transport: the exchange paradigm (FHIR Messaging, RESTful or FHIR Document), not yet chosen.</td>
      <td><a href="data-exchange.html">Data exchange</a></td>
    </tr>
  </tbody>
</table>

The two conditional columns, *wet- en regelgeving* and *beveiliging*, apply across every layer and are out of scope of this IG.

### ART-DECOR dataset

The functional design is formalized in a machine-readable dataset in [ART-DECOR](https://decor.nictiz.nl/ad/#/hg-), the standard Dutch platform for defining healthcare information datasets.


There are two distinct ART-DECOR artefacts relevant to this IG:

Dataset - the shared catalog of data element definitions. Element identifiers (`hg-dataelement-NNNN`) are allocated here once and reused across transactions.

OID: `2.16.840.1.113883.2.4.3.11.60.103.1.1`, effective date 2020-10-19 - [view in ART-DECOR](https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39)

Transaction - the AMB-HAP-specific transaction definition (which elements are used, cardinalities, constraints). This is the published view to read when implementing or reviewing the exchange.

OID: `2.16.840.1.113883.2.4.3.11.60.103.4.145`, effective date 2025-06-10 - [view published transaction](https://decor.nictiz.nl/pub/eerstelijnszorg/hg-html-20260317T103425/tr-2.16.840.1.113883.2.4.3.11.60.103.4.145-2025-06-10T000000.html)

Each profile in this IG carries `Mapping` entries that trace FHIR elements back to their corresponding dataset element identifiers (`hg-dataelement-NNNN`). These mappings are visible on the Mappings tab of each profile page. See the [Design Decisions](design-decisions.html#dataset-traceability) page for the mapping conventions used.

### Systems & System Roles

The ambulance service and out-of-hours GP service each use their own information system: the Ambulance Information System (AMBS) and Out-of-Hours GP Information System (HAPIS). Each system has different system roles that enable data exchange between these systems in the context of an ambulance referral. In ART-DECOR, these system roles are described as Actors.

The AMBS fulfils the following system role:
- Acute Zorg Proces - Ambulanceverwijzing Sturend [AZP-AVS] System.

The HIS fulfils the following system role:
- Acute Zorg Proces - Ambulanceverwijzing Ontvangend [AZP-AVO] System.

The HAPIS fulfils the following system role:
- Acute Zorg Proces - Ambulanceverwijzing Ontvangend [AZP-AVO] Systeem.


<div class="diagram-row">
  <div>{% include systemrolesAMBS.svg %}</div>
  <div>{% include systemrolesHAPIS.svg %}</div>
  <div>{% include systemrolesHIS.svg %}</div>
</div>
<br clear="all"/>
Figure: System Roles for ambulance referral to GP and GP out-of-hours service

<style>
  .diagram-row {
    display: flex;
    align-items: flex-start;
    gap: 20px;
    margin-bottom: 20px;
  }

  .diagram-row > div {
    flex: 1;
  }

  .diagram-row svg {
    max-width: 100%;
    height: auto;
  }
</style>

### Transactions & Transaction Groups
The image below shows the interrelationships between the processes, business roles, systems, system roles, transactions, and transaction group involved in ambulance referrals to a general practitioner or out-of-hours GP service.

 <div>{% include transaction.svg %}</div>
<br clear="all"/>
Figure: Transaction for ambulance referral to GP and GP out-of-hours service
<br>
The image above shows that certain business activities result in a specific transaction. This transaction is performed by a system role and is part of a transaction group. The data elements exchanged between system roles as part of the transactions are specified in the "Ambulance referral to GP or GP out-of-hours service" (AMB → HAP) scenario.
The table below allows for direct access to the relevant use cases (scenarios), transaction groups, and/or transactions in ART-DECOR or other documentation. Where a link is provided, the description of the transaction(s) or transaction group(s) is available.

<table class="grid">
  <thead>
    <tr>
      <th>Use Case(s) (Scenario's)</th>
      <th>Transaction group</th>
      <th>Transaction</th>
      <th>Systeem rol(es)</th>
      <th>Systems</th>
      <th>Business roles</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Ambulance transfer to GP ot GP out-of-hours service (AMB → HA of HAP)</td>
      <td>Referral (PUSH)</td>
      <td>Sending Ambulance referral</td>
      <td>AZP-AVS</td>
      <td>AMBS</td>
      <td>Ambulance</td>
    </tr>
    <tr>
      <td>Ambulance transfer to GP or GP out-of-hours (AMB → HA of HAP)</td>
      <td>Referral (PUSH)</td>
      <td>Receiving Ambulance referral</td>
      <td>AZP-AVO</td>
      <td>HIS</td>
      <td>GP</td>
    </tr>
    <tr>
      <td>Ambulance transfer to GP or GP out-of-hours (AMB → HA of HAP)</td>
      <td>Referral (PUSH)</td>
      <td>Receiving Ambulance referral</td>
      <td>AZP-AVO</td>
      <td>HAPIS</td>
      <td>GP out-of-hours service</td>
    </tr>
  </tbody>
</table>
Table Ambulance transfer to GP or GP out-of-hours

### Specification of the document within the ambulance referral to the out-of-hours GP service
The specifications regarding the document's content are presented in the table below.
<table class="grid">
  <thead>
    <tr>
      <th>Ambulance Referral Categories</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <ul>
          <li>BSN</li>
          <li>Naamgegevens</li>
          <li>Geslacht</li>
          <li>Geboortedatum</li>
          <li>Adresgegevens</li>
          <li>Overige contactgegevens</li>
          <li>Reden/hulpvraag</li>
          <li>
            Conclusie
            <ul>
              <li>Toestandsbeeld</li>
              <li>Toelichting Toestandsbeeld</li>
              <li>Tijdstip overlijden patiënt</li>
            </ul>
          </li>
          <li>Behandelingen</li>
          <li>
            Afspraken met de patiënt
            <ul>
              <li>Huisarts ingelicht</li>
              <li>Afspraken met patiënt</li>
            </ul>
          </li>
          <li>Behandelgrenzen</li>
          <li>Toelichting algemeen</li>
          <li>Meldingsgegevens</li>
          <li>Reden geen patiënt vervoerd</li>
          <li>Anamnese</li>
          <li>Handelingen</li>
          <li>Lichamelijk onderzoek</li>
          <li>Meetwaarden</li>
          <li>Intercollegiale consulten</li>
        </ul>
      </td>
    </tr>
  </tbody>
</table>

The following ambulance data can be included within the sections. If a specific data item has no entry in the run report, it will not appear in the document. The green text always appears in the document, even if there is no value.


<table class="grid">
<thead>
  <tr>
    <th>Section and ambulance details</th>
    <th> CDA-template 2.4.0</th>
    <th>CDA-template 2.5.0</th>
    <th> Remark</th>
  </tr>
  <tr>
    <td>Persoonsgegevens</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>BSN:  &lt;id&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.101 (CDA recordTarget) bij &lt;id extension="999910589" root="2.16.840.1.113883.2.4.6.3"/&gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Naamgegevens:  &lt;name&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.101 (CDA recordTarget) bij element: &lt;patient&gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Geslacht:  man/vrouw/onbepaald/onbekend</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.101 (CDA recordTarget) bij element: &lt;administrativeGenderCode &gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Geboortedatum:  &lt;birthTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.101 (CDA recordTarget) bij element: &lt;birthTime&gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Adres:  &lt;addr&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.101 (CDA recordTarget) bij element:  &lt;addr&gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Overige contactgegevens:  &lt;telecom&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.101 (CDA recordTarget) bij element: &lt;telecom&gt;</td>
    <td></td>
    <td>vrijheidsgraad, niet verplicht voor kwalificatie. Telefoonnummer van patient is zeer wenselijk, anders kan patient niet teruggebeld worden.</td>
  </tr>
  <tr>
    <td>Reden</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Conclusie</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Toestandsbeeld:  &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.425 (MedicalCondition). meerdere waarden zijn mogelijk, dus ook zo tonen gesepareerd met een komma.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Toelichting toestandsbeeld: &lt;text&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.425 (MedicalCondition)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijdstip overlijden patiënt: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1174 (DateOfDeath) en in het format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Behandelingen</td>
    <td></td>
    <td>V2.4.0 parent node template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1129 (TreatmentSection)versie 2016‑11‑21; V2.5.0 parent node template ID:2.16.840.1.113883.2.4.3.11.60.55.10.1129 (TreatmentSection) versie 2024‑11‑11</td>
    <td></td>
  </tr>
  <tr>
    <td>Handeling luchtweg management:&lt; code &gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1134 (AirwayManagement) De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.100 (Handelingen luchtweg management SNOMED), meerdere waarden zijn mogelijk dus ook zo tonen gesepareerd met een komma</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Moeizame intubatie?</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1135 (DifficultIntubation) ja/nee &lt;observation&gt; negationInd</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9037. De waarde van @code MOET komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.124 Moeizame intubatie.</td>
    <td></td>
  </tr>
  <tr>
    <td>Handelingen oxygenatie en ventilatie : &lt; code &gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1136 (OxygenationAndVentilation)  De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.106 (Handelingen oxygenatie en ventilatie SNOMED)), meerdere waarden zijn mogelijk dus ook zo tonen gesepareerd met een komma</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Beademing machine Fi O2: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1137 (BreathingMachineFiO2) Deze is alleen aanwezig wanneer van 'Handelingen oxygenatie en ventilatie' gevuld is met code 'kunstmatige beademing (verrichting) (40617009).</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Beademing machine AMV: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1138 (BreathingMachineAMV). Deze is alleen aanwezig wanneer van 'Handelingen oxygenatie en ventilatie' gevuld is met code 'kunstmatige beademing (verrichting)' (40617009). Geef de waarde van machine AMV in l/min.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Beademing machine Freq: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1139 (BreathingMachineFreq). Deze is alleen aanwezig wanneer van 'Handelingen oxygenatie en ventilatie' gevuld is met code 'kunstmatige beademing (verrichting)' (40617009). Geeft waarde Freq per min.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Beademing machine Peep: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1140 (BreathingMachinePeep). Deze is alleen aanwezig wanneer van 'Handelingen oxygenatie en ventilatie' gevuld is met code 'kunstmatige beademing (verrichting)' (40617009). Geef de waarde peep in cm[H2O]</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Hoeveelheid zuurstof : &lt;value&gt; value en unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1141 (OxygenAmount)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Handelingen circulatie : &lt; code &gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1142 (CirculationTherapeutic). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.101 (Handelingen circulatie SNOMED), meerdere waarden zijn mogelijk dus ook zo tonen gesepareerd met een komma</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Cardioversies aantal: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1146 (Cardioversion)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Cardioversie maximale energie: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1147 (CardioversionMaxEnergy) Deze is voorwaardelijk voor '250980009 cardioversie (verrichting)' van de handelingen circulatie. Geeft de maximale energie bij cardioversie in Joule.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Defibrillaties aantal: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1148 (DefiblirationsNumber)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Defibrillatie energie: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9005 (DefibrillationEnergie). Deze is voorwaardelijk voor '308842001 defibrillatie met gelijkstroom (verrichting)'  van de handelingen circulatie.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Return Of Spontaneous Circulation (ROSC)? ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1149 (ReturnOfSpontaneousCirculation). De waarde van attribut @negationInd kan "false" of "true" zijn. Indien @negationInd="false" dan is er wel Return Of Spontaneous Circulation van toepassing, het antwoord is dan ja. De optionele waarde is "false". Indien @negationInd="true" dan is er geen Return Of Spontaneous Circulation van toepassing, het antwoord is dan nee</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>AED aangesloten voor aankomst: ja/nee</td>
    <td>Template ID: 	2.16.840.1.113883.2.4.3.11.60.55.10.1150 (AED). Indien @negationInd="true" dan is er geen AED aangesloten voor aankomst, het antwoord is dan 'nee'. Indien @negationInd="false" dan is er wel AED aangesloten, het antwoord is dan 'ja'</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>AED-schokken aantal: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1150 (AED) bij element: code="67508-2"</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Pacemaker frequentie: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1143 (Pacemaker Frequency)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Pacemaker stroomsterkte: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1144 (Pacemaker Current)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Pacemaker modus: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1145 (Pacemaker Modus). De waarde van @code MOET komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.77 Pacemaker modus</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Handelingen traumatologie : &lt; code &gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1151 (Traumatology). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.102 (Handelingen traumatologie SNOMED), meerdere waarden zijn mogelijk dus ook zo tonen gesepareerd met een komma</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Koelen tijdsduur: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1152 (CoolingTime). Deze is voorwaardelijk bij Handelingen traumatologie = '105382002 koelen van patiënt (verrichting)'.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Handelingen obstetrie:&lt; code &gt; displayName</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1153 (HandelingenObstetrieSNOMED). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.103 Handelingen Obstetrie SNOMED, meerdere waarden zijn mogelijk dus ook zo tonen gesepareerd met een komma</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Handelingen isolatie: &lt; code &gt; displayName</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1155 (IsolationKind). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.104 Handelingen Isolatie SNOMED, meerdere waarden zijn mogelijk dus ook zo tonen gesepareerd met een komma</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Medicatie toegediend?  ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1156 (MedicationUsed). Indien @negationInd="true" dan is 'medicatie toegediend?' - nee. Indien @negationInd="false" dan is 'medicatie toegediend?' - ja.</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9041 (MedicationUsed 2025) Indien @negationInd="true" dan is  'medicatie toegediend?' - nee. Indien @negationInd="false" dan is 'medicatie toegediend?' - ja.</td>
    <td></td>
  </tr>
  <tr>
    <td>Medicatienaam: &lt; code &gt; displayname</td>
    <td>Template ID:2.16.840.1.113883.2.4.3.11.60.55.10.1157 (MedicationName). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.18 (Medicatieoverzicht), meerdere waarden zijn mogelijk, dus ook zo tonen. In combinatie met toegediende hoeveelheid medicatie, tijd medicatietoediening en medicatie toedieningsvorm.</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1157 (MedicationName). De waarde van @code MOET komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.126 Generieke Product Kenmerk (2023‑11‑16 14:31:25)</td>
    <td></td>
  </tr>
  <tr>
    <td>Toegediende hoeveelheid medicatie: &lt;doseQuantity&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1156 (MedicationUsed). Alleen aanwezig als Medicatie toegediend = 'Ja' (substanceAdministration/@negationInd = false). Bij element doseQuantity</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9041 (MedicationUsed 2025)</td>
    <td></td>
  </tr>
  <tr>
    <td>Tijd medicatietoediening:  &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1156 (MedicationUsed). Alleen aanwezig als Medicatie toegediend = 'Ja' . Bij element: effectiveTime</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9041 (MedicationUsed 2025)</td>
    <td></td>
  </tr>
  <tr>
    <td>Medicatie toedieningsvorm: &lt;value&gt; displayName</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1158 (MedicationAdministartionProcedure). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.48 Medicatie handelingen SNOMED</td>
    <td>niet meer aanwezig in 2.5.0</td>
    <td></td>
  </tr>
  <tr>
    <td>Extra informatie behandeling : &lt;text&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1164 (ExtraInformationTreatments)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>colspan=2 Afspraken met de patiënt</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Afspraken met patiënt: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9004 (AgreementsWithPatient)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Huisarts ingelicht: ja/nee &lt;observation&gt; negationInd</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9003(GPInformed) De waarde van attribut @negationInd kan "false" of "true" zijn. Indien @negationInd="true" dan is de huisarts niet geïnformeerd. Indien @negationInd="false" dan is huisarts geïnformeerd.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Behandelgrenzen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Niet-reanimeer verklaring aanwezig? ja/nee &lt;observation&gt; negationInd</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1175(NoReanimationStatement). De waarde van attribute @negationInd kan "false" of "true" zijn. Indien @negationInd="true" dan is "Niet Reanimieren VerklaringAanwezig ?" = nee. Indien @negationInd="false" dan is "Niet Reanimieren VerklaringAanwezig ?" =  ja.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Toelichting algemeen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Toelichting algemeen: &lt;text&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.202 (CommentSection).</td>
    <td></td>
  </tr>
  <tr>
    <td>Meldingsgegevens</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Medisch kladblok meldkamer: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.409 (MedicalNote)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Datum/tijd incident: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.405 (DateOfEvent) in format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
  </tr>
  <tr>
    <td>Datum/tijd melding: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.408 (Notification) in format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Meldkamerurgentie: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1170 (Urgency)/ De waarde van @value moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.123 (Urgentie)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Reden geen patiënt vervoerd</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Reden geen patiënt vervoerd: &lt;value&gt; displayName</td>
    <td>Template ID: template 2.16.840.1.113883.2.4.3.11.60.55.10.1172 (Reason No Transportation)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Anamnese</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Allergie: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.464 (Ample).  Meerdere &lt; code &gt; &lt; value &gt; pairs mogelijk en dus ook zo tonen. De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.105 Anamnese SNOMED</td>
    <td>Risico op kruisinfectie komt niet meer voor in V2.5.0</td>
    <td></td>
  </tr>
  <tr>
    <td>Toelichting anamnese: &lt;text&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.423 (Annotation Comment Ambulance)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verdenking infectieziekte?  ja/nee &lt;observation&gt; negationInd</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.465 (Infection Risk). De waarde "false" betekent dat de verdenking voor infectieziekten aanwezig is, het antwoord is dan ja</td>
    <td>Besmettingsrisico: &lt;value&gt; uit Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9033 Infection Risk (2024). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.128 Besmettingsrisico SNOMED (BSA)</td>
    <td></td>
  </tr>
  <tr>
    <td>Toelichting infectierisico: &lt;text&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.465 (Infection Risk) bevat template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.423 (AnnotationCommentAmbulance)</td>
    <td>Toelichting besmettingsrisico: &lt;text&gt; uit Template ID:2.16.840.1.113883.2.4.3.11.60.55.10.9033 Infection Risk (2024) bevat template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.423 (AnnotationCommentAmbulance)</td>
    <td></td>
  </tr>
  <tr>
    <td>Handelingen</td>
    <td></td>
    <td>V2.4.0 parent node template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1129 (TreatmentSection) versie 2016‑11‑21; V2.5.0 parent node template ID:2.16.840.1.113883.2.4.3.11.60.55.10.1129 (TreatmentSection) versie 2024‑11‑11</td>
    <td></td>
  </tr>
  <tr>
    <td>Handelingen Ademhaling en beademing: &lt; code &gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1131 (Breathing And Ventilation). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.97 (Handelingen ademhaling en beademing SNOMED), meerdere waarden zijn mogelijk dus ook zo tonen gesepareerd met een komma</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Handelingen Bewustzijn en neurologische status: &lt; code &gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1132 (Counsciousness And Neurological Status). Alleen de waarden 170692007 eerste neurologische beoordeling en 291000146106 pupilreactie-onderzoek bij @code uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.98 (Handelingen bewustzijn en neurologische status SNOMED)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Overige diagnostische handelingen: &lt; code &gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1133. De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.99 Handelingen overig diagnostisch SNOMED, meerdere waarden zijn mogelijk dus ook zo tonen gesepareerd met een komma</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Lichamelijk onderzoek</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Airway vrij?  ja/nee &lt;observation&gt; negationInd</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.446 (Airway). Geeft aan of de luchtweg vrij is. De waarde "false" betekend dat de luchtweg vrij is, en het antwoord 'ja'. De waarde "true" geeft het antwoord 'nee'</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9035. De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.117 Airway vrij</td>
    <td></td>
  </tr>
  <tr>
    <td>Stridor: &lt;value&gt; displayName</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.446 (Airway). Indien negotionInd waarde true.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Breathing sufficient? ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.447 (BreathingSufficient). Geeft aan of het "breathing" sufficiënt is. De waarde "false" betekend dat het "breathing" sufficiënt is, en dus het antwoord 'ja'.  De waarde "true" geeft het antwoord 'nee'.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Breathing observaties: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.448 (BreathingObservations). Meerdere antwoorden mogelijk, dus ook zo tonen.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Circulation sufficiënt? ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.450 (Circulation) bevat 2.16.840.1.113883.2.4.3.11.60.55.10.451 (CirculationSufficient). Geeft aan of het "circulation" sufficiënt is. De waarde "false" betekend dat het "circulation" sufficiënt is, en het antwoord 'ja'.  De waarde "true" geeft het antwoord 'nee'.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Capillaire refill &gt; 2 seconden? ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.452 (CapillaireRefill). Geeft aan of de capillaire refill &gt; 2 seconde is. De waarde "false" betekend dat de capillaire refill grooter is dan 2 seconde, het antwoord is 'ja'. De waarde "true" geeft het antwoord 'nee'.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Huid observatie: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.453 (SkinObservation). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.38 Huidskleur SNOMED, meerdere antwoorden mogelijk, ook zo tonen.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>AVPU: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.455 (AVPU). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.39 AVPU SNOMED.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Duur buiten bewustzijn: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.456 (UnconsciousnessTime)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Neurologische observaties: &lt; code &gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1132 (Counsciousness And Neurological Status). Alleen de waarden 26544005 spierzwakte, 77743009coördinatiestoornis, 52931000146103 sensibiliteitsstoornis van huid, 63102001 visuele stoornis, 33561000146106 acute duizeligheid, 33571000146100 acute evenwichtsstoornis bij @code uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.98 (Handelingen bewustzijn en neurologische status SNOMED)</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9044. De waarde van @code MOET komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.131 Neurologie SNOMED.</td>
    <td></td>
  </tr>
  <tr>
    <td>Pupil: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.457 (pupil_observation). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.87 Pupillen SNOMED, meerdere antwoorden mogelijk, ook zo tonen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>FAST symptomen aanwezig? ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.458 (FAST Symptoms). FAST symptomen aanwezig?: ja/nee; De waarde van attribut @negationInd kan "false" of "true" zijn. De waarde "false" betekent dat de FAST symptomen aanwezig zijn, dus is het antwoord JA.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Mogelijk trombolyse/trombectomie? ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9026 (Thrombolysis). Mogelijk trombolyse/trombectomie? ja/nee; Geeft aan of trombolyse of trombectomie geïndiceerd is. NegationInd = 'true' geeft aan dat er geen sprake van is, dus is het antwoord 'nee'; 'false' dat het wel geïndiceerd is, en dus het antwoord 'ja'</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Intoxicatie: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.459 (Intoxication). Type intoxicatie moet hier worden geduid. De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.93 Intoxicatie SNOMED (DYNAMISCH), meerdere antwoorden mogelijk, dus ook zo tonen.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Toelichting Primary Survey: &lt;text&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.445 (Primary Survey Exam') bevat 2.16.840.1.113883.2.4.3.11.60.55.10.423 (AnnotationCommentAmbulance)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Hoofd en gelaat</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Hoofd en gelaat observaties: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.467 (Head And Face Observations). Bevat de observaties aan hoofd en gelaat; De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.70 Hoofd en gelaat SNOMED (DYNAMISCH), meerdere antwoorden mogelijk, dus ook zo tonen.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Bloedverlies: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.468 (Loss Of Blood). Geeft gedetailleerde omschrijving van bloedverlies aan; De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.59 Bloedverlies SNOMED (DYNAMISCH), meerdere antwoorden mogelijk, dus ook zo tonen.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Liquorverlies: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.469 (Loss Of Liquor). Geeft gedetailleerde omschrijving van liquorverlies aan; De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.51 Liquorverlies SNOMED (DYNAMISCH). meerdere antwoorden mogelijk, dus ook zo tonen.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Pijnlocatie: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.470 (Pain Location). Meerdere antwoorden mogelijk, dus ook zo tonen.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.466 (HeadAndFace) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.471 (Wound). Geeft het type van de wond aan; De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED (DYNAMISCH)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Nek, hals, CWK</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Nek, hals, CWK observaties: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.472 (NeckThroatCWK) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.473 (NeckThroatCWKObservations). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.88 Nek, Hals, CWK SNOMED, meerdere antwoorden mogelijk, dus ook zo tonen.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.472 (NeckThroatCWK) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.471 (Wound). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED, meerdere antwoorden mogelijk, dus ook zo tonen.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Thorax</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Thorax observaties: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.474 (Thorax) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.475 (ThoraxObservations). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.66 Borst SNOMED , meerdere antwoorden mogelijk, dus ook zo tonen.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Pijn bij compressie: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.476 (PainByCompression). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.66 Borst SNOMED , meerdere antwoorden mogelijk, dus ook zo tonen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.474 (Thorax) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.471(Wound). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED, meerdere antwoorden mogelijk, dus ook zo tonen.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Rug</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Rug observaties: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.480 (BackObservations). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.89 Rug SNOMED , meerdere antwoorden mogelijk, dus ook zo tonen.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.479 (Back) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.471(Wound). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED, meerdere antwoorden mogelijk, dus ook zo tonen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Abdomen</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Abdomen observaties: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.482 (Abdomen Observations). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.64 Abdomen SNOMED, meerdere antwoorden mogelijk, dus ook zo tonen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Locatie druk-/ loslaatpijn: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.484 (AbdomenLocation). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.91 Locatie op lichaam(sdeel) SNOMED, meerdere antwoorden mogelijk, dus ook zo tonen</td>
    <td></td>
    <td>Locatie zwelling / oedeem en Locatie pulserende zwelling afwezig in het document</td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.481 (Abdomen) bevat template ID:  2.16.840.1.113883.2.4.3.11.60.55.10.471 (Wound), De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED, meerdere antwoorden mogelijk, dus ook zo tonen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Bekken</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Bekken observaties: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.487 (PelvisObservations). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.65 Bekken SNOMED, meerdere antwoorden mogelijk, dus ook zo tonen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.486 (Pelvis) bevat Template ID:2.16.840.1.113883.2.4.3.11.60.55.10.471 (Wound). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED , meerdere antwoorden mogelijk, dus ook zo tonen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Extremiteiten armen</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Observaties over een enkele arm</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Bevinding betreffende bovenste extremiteit: &lt;value&gt; displayname</td>
    <td>Template ID:2.16.840.1.113883.2.4.3.11.60.55.10.9028 (ArmSingleExtremity) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.489 (Arm Extremity Observation). De arm waar het over gaat bevat 2.16.840.1.113883.2.4.3.11.60.55.10.9029 Laterality, en deze gecombineerd met De observatie(s) over deze arm in 2.16.840.1.113883.2.4.3.11.60.55.10.489 Arm Extremity Observation en Wound, meerdere antwoorden mogelijk, dus ook zo tonen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Lateraliteit: &lt;value&gt; displayname</td>
    <td>Template ID:2.16.840.1.113883.2.4.3.11.60.55.10.9028 (ArmSingleExtremity) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9029 (Laterality)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.488 (ArmsExtremity) bevat Template ID:2.16.840.1.113883.2.4.3.11.60.55.10.471 (Wound). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED , meerdere antwoorden mogelijk, dus ook zo tonen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Extremiteiten benen</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Observaties over een enkele arm</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Bevinding betreffende onderste extremiteit:  &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9030 (LegSingleExtremity) bevat Bevat 2.16.840.1.113883.2.4.3.11.60.55.10.491 Leg Extremity Observation. Het been waar het over gaat, bevat  2.16.840.1.113883.2.4.3.11.60.55.10.9029 Laterality, en deze gecombineerd met de observatie(s) over dit been uit 2.16.840.1.113883.2.4.3.11.60.55.10.491 Leg Extremity Observation en wound, meerdere antwoorden mogelijk, dus ook zo tonen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Lateraliteit: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9030 (LegSingleExtremity) bevat  Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9029 (Laterality)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9030 (LegSingleExtremity) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.471 (Wound). Indien Extremiteit Observaties is gelijk aan 416462003 verwonding (aandoening). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Uitscheiding observaties: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.493 (ExcretionObservations). Meerdere antwoorden mogelijk, dus ook zo tonen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Braken: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.494 (Vormiting). Indien Uitscheiding observaties = 'braken (aandoening). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.67 Braken SNOMED</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Incontinent: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.495 (Incontinent). Indien Uitscheiding observaties = 'incontinentie (bevinding). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.92 Incontinent SNOMED</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verloskunde/Gynaecologie</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verloskunde/Gynaecologie observaties: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.497 (ObstetricsObservations). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.49 Verloskunde / gynaecologie SNOMED, meerdere antwoorden mogelijk, dus ook zo tonen</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Vruchtwaterverlies: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.498 (AmnioticFluidLeaking). Als Gynaecologie observaties gelijk is aan lekken van vruchtwater (aandoening). bij element:code="371380006" displayName="lekken van vruchtwater (aandoening)" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT"/&gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijdsduur tussen weeën: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.499 (Contractions). Geeft de tijdsduur tussen weeën (om de hoeveel minuten) aan. bij element: code code="251681003" displayName="Interval between uterine contractions (observable entity)" codeSystem="2.16.840.1.113883.6.96"codeSystemName="SNOMED CT"</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Meetwaarden</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>bloedglucoseconcentratie: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1128 (BloodSugarLevel)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1128 (BloodSugarLevel). In het format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Hartritme: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1126 (HeartRhythm). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.47 Hartritmes SNOMED (DYNAMISCH)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1126 (HeartRhythm). In het format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Toelichting hartritme/ECG: &lt;text&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1127 (AnnotationCommentHeartRhythm)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>SpO2Waarde: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1102 (Saturation)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1102 (Saturation). In het format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>CO2Waarde: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1103 (Capnometry)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1103 (Capnometry). in het format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>HartfrequentieWaarde: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1104 (HeartRate)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1104 (HeartRate). In het format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>SystolischeBloeddruk: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1105 (BloodPressure) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1106 (SystolicBloodPressure)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>DiastolischeBloeddruk: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1105 (BloodPressure) bevat template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1107 (DiastolicBloodPressure)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1105 (BloodPressure). In het format DD-MM-YYYY, HH:MM:SS.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>TemperatuurWaarde: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1108 (BodyTemperature). Bij element: &lt; code code="386725007" displayName="lichaamstemperatuur (waarneembare entiteit)" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT"/&gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1108 (BodyTemperature). In het format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Ademfrequentie: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1109 (Respiration)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1109 (Respiration). In het format DD-MM-YYYY, HH:MM:SS.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>GlasgowComaScaleDatumTijd</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1110 (GlasgowComaScale). In het format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>GCS_Eyes</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1110 (GlasgowComaScale) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1111 (GCSEyes). Een combinatie van code en display om te tonen zou mooi zijn. De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.40.2.12.8.1 GCS_EyesCodelijst</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>GCS_Motor</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1110 (GlasgowComaScale) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1112 (GCSMotor). Een combinatie van code en display om te tonen zou mooi zijn. De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.40.2.12.8.2 GCS_MotorCodelijst (DYNAMISCH)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>GCS_Verbal</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1110 (GlasgowComaScale) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1113 (GCSVerbal). Een combinatie van code en display om te tonen zou mooi zijn. De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.40.2.12.8.3 GCS_VerbalCodelijst (DYNAMISCH) of De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.40.2.12.8.4 GCS_VerbalCodelijstKleuter (DYNAMISCH) of De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.40.2.12.8.5 GCS_VerbalCodelijstBaby (DYNAMISCH), afhankelijk van de geboortedatum van patient</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>TotaalScore</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1110 (GlasgowComaScale) bevat Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1114 (TotalScore). Bij element:  &lt; code code="444323003" displayName="Modified Glasgow coma score (observable entity)" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT"/&gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>RevisedTraumaScore Waarde: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1115 (RevisedTraumaScore).</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>RevisedTraumaScore Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1115 (RevisedTraumaScore). In het format DD-MM-YYYY, HH:MM:SS.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>PediatricTraumaScore Waarde: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1116 (PediatricTraumaScore).</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>PediatricTraumaScore Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1116 (PediatricTraumaScore). In het format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Pijnschaal Waarde: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1117 (Pain).</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Pijnschaal Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1117 (Pain). In het format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>APGAR-1: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1119 (APGAR-1).</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>APGAR-5: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1120 (APGAR-5).</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Intercollegiale consulten</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Initialen Achternaam: &lt;name&gt;</td>
    <td>Template ID 2.16.840.1.113883.2.4.3.11.60.55.10.438 (ConsultingExternalProfessionalSection) bevat 2.16.840.1.113883.2.4.3.11.60.55.10.441 (ConsultationGiverName)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Telefoonnummer: &lt;telecom&gt;</td>
    <td>Template ID 2.16.840.1.113883.2.4.3.11.60.55.10.438 (ConsultingExternalProfessionalSection) bevat 2.16.840.1.113883.2.4.3.11.60.55.10.440 (ConsultationGiver)</td>
    <td></td>
    <td>vrijheidsgraad, niet verplicht voor kwalificatie</td>
  </tr>
  <tr>
    <td>Type consultgever: &lt; code &gt; displayname</td>
    <td>Template ID 2.16.840.1.113883.2.4.3.11.60.55.10.438 (ConsultingExternalProfessionalSection) bevat 2.16.840.1.113883.2.4.3.11.60.55.10.440 (ConsultationGiver). De waarde van @code moet komen uit waardelijst 2.16.840.1.113883.2.4.3.11.60.55.11.15 Consultgever op afstand</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Toelichting/Afspraken met consultgever</td>
    <td>Template ID 2.16.840.1.113883.2.4.3.11.60.55.10.442 (AgreementsWithExternalProfessional).</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
  </tr>
</thead>
</table>