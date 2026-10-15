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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.101 (CDA recordTarget) at &lt;id extension="999910589" root="2.16.840.1.113883.2.4.6.3"/&gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Naamgegevens:  &lt;name&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.101 (CDA recordTarget) at the element: &lt;patient&gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Geslacht:  man/vrouw/onbepaald/onbekend</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.101 (CDA recordTarget) at the element: &lt;administrativeGenderCode &gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Geboortedatum:  &lt;birthTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.101 (CDA recordTarget) at the element: &lt;birthTime&gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Adres:  &lt;addr&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.101 (CDA recordTarget) at the element:  &lt;addr&gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Overige contactgegevens:  &lt;telecom&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.101 (CDA recordTarget) at the element: &lt;telecom&gt;</td>
    <td></td>
    <td>Degree of flexibility; not mandatory for qualification. The patient's telephone number is highly desirable; otherwise, it is not possible to call the patient back.</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.425 (MedicalCondition). Multiple values ​​are possible, so display them separated by a comma..</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1174 (DateOfDeath) and in the format DD-MM-YYYY, HH:MM:SS</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1134 (AirwayManagement) The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.100 (Handelingen luchtweg management SNOMED), Multiple values ​​are possible, so display them separated by a comma.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Moeizame intubatie?</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1135 (DifficultIntubation) ja/nee &lt;observation&gt; negationInd</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9037. The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.124 Moeizame intubatie.</td>
    <td></td>
  </tr>
  <tr>
    <td>Handelingen oxygenatie en ventilatie : &lt; code &gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1136 (OxygenationAndVentilation)  The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.106 (Handelingen oxygenatie en ventilatie SNOMED)), Multiple values ​​are possible, so display them separated by a comma.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Beademing machine Fi O2: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1137 (BreathingMachineFiO2) This is only present when the 'Handelingen oxygenatie en ventilatie' field is populated with the code 'kunstmatige beademing'. (verrichting) (40617009).</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Beademing machine AMV: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1138 (BreathingMachineAMV). This is only present when the 'Handelingen oxygenatie en ventilatie' field is populated with the code 'kunstmatige beademing'. (verrichting)' (40617009). Enter the value of machine AMV inl/min.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Beademing machine Freq: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1139 (BreathingMachineFreq). This is only present when the 'Handelingen oxygenatie en ventilatie' field is populated with the code 'kunstmatige beademing'. (verrichting)' (40617009). Provides the frequency value per minute</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Beademing machine Peep: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1140 (BreathingMachinePeep). This is only present when the 'Handelingen oxygenatie en ventilatie' field is populated with the code 'kunstmatige beademing'. (verrichting)' (40617009). Provides the value peep in cm[H2O]</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1142 (CirculationTherapeutic). The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.101 (Handelingen circulatie SNOMED), Multiple values ​​are possible, so display them separated by a comma.</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1147 (CardioversionMaxEnergy) This is conditional upon '250980009 cardioversie (verrichting)' within the 'handelingen circulatie'. It specifies the maximum energy for cardioversion, in Joules.</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9005 (DefibrillationEnergie). This is conditional upon '308842001 defibrillatie met gelijkstroom (verrichting)' within the 'handelingen circulatie'.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Return Of Spontaneous Circulation (ROSC)? ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1149 (ReturnOfSpontaneousCirculation). The value of the attribute @negationInd can be "false" or "true". If @negationInd="false", then Return Of Spontaneous Circulation is applicable; the answer is therefore "yes". The optional value is "false". If @negationInd="true", then Return Of Spontaneous Circulation is not applicable; the answer is therefore "no".</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>AED aangesloten voor aankomst: ja/nee</td>
    <td>Template ID: 	2.16.840.1.113883.2.4.3.11.60.55.10.1150 (AED). 
If @negationInd="true", then no AED was connected prior to arrival; in this case, the answer is 'no'. If @negationInd="false", then an AED was connected; in this case, the answer is 'yes'.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>AED-schokken aantal: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1150 (AED) at the element: code="67508-2"</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1145 (Pacemaker Modus). The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.77 Pacemaker modus</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Handelingen traumatologie : &lt; code &gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1151 (Traumatology).The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.102 (Handelingen traumatologie SNOMED), Multiple values ​​are possible, so display them separated by a comma.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Koelen tijdsduur: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1152 (CoolingTime). This is conditional uponHandelingen traumatologie = '105382002 koelen van patiënt (verrichting)'.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Handelingen obstetrie:&lt; code &gt; displayName</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1153 (HandelingenObstetrieSNOMED). The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.103 Handelingen Obstetrie SNOMED, Multiple values ​​are possible, so display them separated by a comma.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Handelingen isolatie: &lt; code &gt; displayName</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1155 (IsolationKind).The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.104 Handelingen Isolatie SNOMED, Multiple values ​​are possible, so display them separated by a comma.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Medicatie toegediend?  ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1156 (MedicationUsed). In case @negationInd="true" dan is 'medicatie toegediend?' - nee. In case @negationInd="false" dan is 'medicatie toegediend?' - ja.</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9041 (MedicationUsed 2025) In case @negationInd="true" dan is  'medicatie toegediend?' - nee. In case @negationInd="false" dan is 'medicatie toegediend?' - ja.</td>
    <td></td>
  </tr>
  <tr>
    <td>Medicatienaam: &lt; code &gt; displayname</td>
    <td>Template ID:2.16.840.1.113883.2.4.3.11.60.55.10.1157 (MedicationName). The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.18 (Medicatieoverzicht), Multiple values ​​are possible, so display them as such. In combination with 'toegediende hoeveelheid medicatie', 'tijd medicatietoediening'en 'medicatie toedieningsvorm'.</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1157 (MedicationName). The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.126 Generieke Product Kenmerk (2023‑11‑16 14:31:25)</td>
    <td></td>
  </tr>
  <tr>
    <td>Toegediende hoeveelheid medicatie: &lt;doseQuantity&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1156 (MedicationUsed).Only present if Medication administered = 'Yes'(substanceAdministration/@negationInd = false). at the element doseQuantity</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9041 (MedicationUsed 2025)</td>
    <td></td>
  </tr>
  <tr>
    <td>Tijd medicatietoediening:  &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1156 (MedicationUsed).Only present if Medication administered = 'Yes'. at the element: effectiveTime</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9041 (MedicationUsed 2025)</td>
    <td></td>
  </tr>
  <tr>
    <td>Medicatie toedieningsvorm: &lt;value&gt; displayName</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1158 (MedicationAdministartionProcedure). The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.48 Medicatie handelingen SNOMED</td>
    <td>no longer present in 2.5.0</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9003(GPInformed) The value of the @negationInd attribute can be "false" or "true". If @negationInd="true", the general practitioner has not been informed. If @negationInd="false", the general practitioner has been informed.</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1175(NoReanimationStatement). The value of the attribute @negationInd can be "false" or "true". If @negationInd="true", then "Niet reanimeren verklaring aanwezig?" = no. If @negationInd="false", then "Niet reanimeren verklaring aanwezig?" = yes.</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1170 (Urgency)/ The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.123 (Urgentie)</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.464 (Ample).  Multiple &lt; code &gt; &lt; value &gt; pairs are possible, and should therefore be displayed as such. The value of @code MUST come from the value list  2.16.840.1.113883.2.4.3.11.60.55.11.105 Anamnese SNOMED</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.465 (Infection Risk). The value "false" means that there is a suspicion of infectious diseases; in that case, the answer is yes.</td>
    <td>Besmettingsrisico: &lt;value&gt; uit Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9033 Infection Risk (2024). The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.128 Besmettingsrisico SNOMED (BSA)</td>
    <td></td>
  </tr>
  <tr>
    <td>Toelichting infectierisico: &lt;text&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.465 (Infection Risk) contains template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.423 (AnnotationCommentAmbulance)</td>
    <td>Toelichting besmettingsrisico: &lt;text&gt; uit Template ID:2.16.840.1.113883.2.4.3.11.60.55.10.9033 Infection Risk (2024) contains template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.423 (AnnotationCommentAmbulance)</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1131 (Breathing And Ventilation). The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.97 (Handelingen ademhaling en beademing SNOMED), Multiple values ​​are possible, so display them separated by a comma.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Handelingen Bewustzijn en neurologische status: &lt; code &gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1132 (Counsciousness And Neurological Status). Only the values ​​170692007 eerste neurologische beoordeling and 291000146106 pupilreactie-onderzoek by @code from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.98 (Handelingen bewustzijn en neurologische status SNOMED)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Overige diagnostische handelingen: &lt; code &gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1133. The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.99 Handelingen overig diagnostisch SNOMED, Multiple values ​​are possible, so display them separated by a comma.</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.446 (Airway). Indicates whether the airway is clear. A value of "false" means the airway is clear (the answer is "yes"), while a value of "true" means the answer is "no."</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9035. The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.117 Airway vrij</td>
    <td></td>
  </tr>
  <tr>
    <td>Stridor: &lt;value&gt; displayName</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.446 (Airway). In case negotionInd waarde true.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Breathing sufficient? ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.447 (BreathingSufficient). Indicates whether the "breathing" is sufficient. A value of "false" means that the "breathing" is sufficient—corresponding to an answer of "yes"—while a value of "true" corresponds to an answer of "no."</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Breathing observaties: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.448 (BreathingObservations). multiple answers possible, so display accordingly.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Circulation sufficiënt? ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.450 (Circulation) contains 2.16.840.1.113883.2.4.3.11.60.55.10.451 (CirculationSufficient). Indicates whether "circulation" is sufficient. A value of "false" means that "circulation" is sufficient—the answer is "yes." A value of "true" corresponds to the answer "no."</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Capillaire refill &gt; 2 seconden? ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.452 (CapillaireRefill). Indicates whether the capillary refill time is > 2 seconds. A value of "false" means that the capillary refill time is greater than 2 seconds—the answer is 'yes'. A value of "true" corresponds to the answer 'no'. </td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Huid observatie: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.453 (SkinObservation). The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.38 Huidskleur SNOMED, multiple answers possible, so display accordingly.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>AVPU: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.455 (AVPU). The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.39 AVPU SNOMED.</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1132 (Counsciousness And Neurological Status). Only the values 26544005 spierzwakte, 77743009 coördinatiestoornis, 52931000146103 sensibiliteitsstoornis van huid, 63102001 visuele stoornis, 33561000146106 acute duizeligheid, 33571000146100 acute evenwichtsstoornis by @code from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.98 (Handelingen bewustzijn en neurologische status SNOMED)</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9044. The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.131 Neurologie SNOMED.</td>
    <td></td>
  </tr>
  <tr>
    <td>Pupil: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.457 (pupil_observation). The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.87 Pupillen SNOMED, multiple answers possible, so display accordingly</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>FAST symptomen aanwezig? ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.458 (FAST Symptoms). FAST symptomen aanwezig?: ja/nee; The value of the attribute @negationInd can be "false" or "true". The value "false" means that the FAST symptoms are present, so the answer is YES.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Mogelijk trombolyse/trombectomie? ja/nee</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9026 (Thrombolysis). 'Mogelijk trombolyse/trombectomie?' yes/no; Indicates whether thrombolysis or thrombectomy is indicated. NegationInd = 'true' indicates that it is not indicated, so the answer is 'no'; 'false' indicates that it is indicated, so the answer is 'yes'. </td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Intoxicatie: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.459 (Intoxication). The type of intoxication must be specified here. The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.93 Intoxicatie SNOMED (DYNAMISCH), multiple answers possible, so display accordingly.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Toelichting Primary Survey: &lt;text&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.445 (Primary Survey Exam') contains 2.16.840.1.113883.2.4.3.11.60.55.10.423 (AnnotationCommentAmbulance)</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.467 (Head And Face Observations). contains the observations of the head and face; The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.70 Hoofd en gelaat SNOMED (DYNAMISCH), multiple answers possible, so display accordingly.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Bloedverlies: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.468 (Loss Of Blood). Provides a detailed description of blood loss;The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.59 Bloedverlies SNOMED (DYNAMISCH), multiple answers possible, so display accordingly.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Liquorverlies: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.469 (Loss Of Liquor). Provides a detailed description of liquor loss; The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.51 Liquorverlies SNOMED (DYNAMISCH). multiple answers possible, so display accordingly.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Pijnlocatie: &lt;value&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.470 (Pain Location). multiple answers possible, so display accordingly.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.466 (HeadAndFace) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.471 (Wound). Indicates the type of wound; The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED (DYNAMISCH)</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.472 (NeckThroatCWK) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.473 (NeckThroatCWKObservations). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.88 Nek, Hals, CWK SNOMED, multiple answers possible, so display accordingly.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.472 (NeckThroatCWK) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.471 (Wound). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED, multiple answers possible, so display accordingly.</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.474 (Thorax) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.475 (ThoraxObservations). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.66 Borst SNOMED , multiple answers possible, so display accordingly.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Pijn bij compressie: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.476 (PainByCompression). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.66 Borst SNOMED , multiple answers possible, so display accordingly</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.474 (Thorax) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.471(Wound). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED, multiple answers possible, so display accordingly.</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.480 (BackObservations). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.89 Rug SNOMED , multiple answers possible, so display accordingly.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.479 (Back) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.471(Wound). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED, multiple answers possible, so display accordingly</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.482 (Abdomen Observations). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.64 Abdomen SNOMED, multiple answers possible, so display accordingly</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Locatie druk-/ loslaatpijn: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.484 (AbdomenLocation). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.91 Locatie op lichaam(sdeel) SNOMED, multiple answers possible, so display accordingly</td>
    <td></td>
    <td>Locatie zwelling / oedeem and Locatie pulserende zwelling absent in the document</td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.481 (Abdomen) contains template ID:  2.16.840.1.113883.2.4.3.11.60.55.10.471 (Wound), The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED, multiple answers possible, so display accordingly</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.487 (PelvisObservations). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.65 Bekken SNOMED, multiple answers possible, so display accordingly</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.486 (Pelvis) contains Template ID:2.16.840.1.113883.2.4.3.11.60.55.10.471 (Wound). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED , multiple answers possible, so display accordingly</td>
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
    <td>Template ID:2.16.840.1.113883.2.4.3.11.60.55.10.9028 (ArmSingleExtremity) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.489 (Arm Extremity Observation).The arm in question contains 2.16.840.1.113883.2.4.3.11.60.55.10.9029 Laterality, and this combined with the observation(s) of this arm in 2.16.840.1.113883.2.4.3.11.60.55.10.489 Arm Extremity Observation en Wound, multiple answers possible, so display accordingly</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Lateraliteit: &lt;value&gt; displayname</td>
    <td>Template ID:2.16.840.1.113883.2.4.3.11.60.55.10.9028 (ArmSingleExtremity) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9029 (Laterality)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.488 (ArmsExtremity) contains Template ID:2.16.840.1.113883.2.4.3.11.60.55.10.471 (Wound). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED , multiple answers possible, so display accordingly</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9030 (LegSingleExtremity) contains contains 2.16.840.1.113883.2.4.3.11.60.55.10.491 Leg Extremity Observation. The leg in question contains 2.16.840.1.113883.2.4.3.11.60.55.10.9029 Laterality, and this combined with the observation(s) of this leg in 2.16.840.1.113883.2.4.3.11.60.55.10.491 Leg Extremity Observation en wound, multiple answers possible, so display accordingly</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Lateraliteit: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9030 (LegSingleExtremity) contains  Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9029 (Laterality)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Verwonding: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.9030 (LegSingleExtremity) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.471 (Wound). In case Extremiteit Observaties is gelijk aan 416462003 verwonding (aandoening). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.53 Wond SNOMED.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Uitscheiding observaties: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.493 (ExcretionObservations). multiple answers possible, so display accordingly</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Braken: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.494 (Vormiting). In case Uitscheiding observaties = 'braken (aandoening). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.67 Braken SNOMED</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Incontinent: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.495 (Incontinent). In case Uitscheiding observaties = 'incontinentie (bevinding). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.92 Incontinent SNOMED</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.497 (ObstetricsObservations). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.49 Verloskunde / gynaecologie SNOMED, multiple answers possible, so display accordingly</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Vruchtwaterverlies: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.498 (AmnioticFluidLeaking). When gynecological observations is equel to 'lekken van vruchtwater (aandoening)'. at the element:code="371380006" displayName="lekken van vruchtwater (aandoening)" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT"/&gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijdsduur tussen weeën: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.499 (Contractions). Indicate the time interval between contractions (how many minutes apart). at the element: code code="251681003" displayName="Interval between uterine contractions (observable entity)" codeSystem="2.16.840.1.113883.6.96"codeSystemName="SNOMED CT"</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1128 (BloodSugarLevel). in the format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Hartritme: &lt;value&gt; displayname</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1126 (HeartRhythm). The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.55.11.47 Hartritmes SNOMED (DYNAMISCH)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1126 (HeartRhythm). in the format DD-MM-YYYY, HH:MM:SS</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1102 (Saturation). in the format DD-MM-YYYY, HH:MM:SS</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1103 (Capnometry). in the format DD-MM-YYYY, HH:MM:SS</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1104 (HeartRate). in the format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>SystolischeBloeddruk: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1105 (BloodPressure) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1106 (SystolicBloodPressure)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>DiastolischeBloeddruk: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1105 (BloodPressure) contains template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1107 (DiastolicBloodPressure)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1105 (BloodPressure). in the format DD-MM-YYYY, HH:MM:SS.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>TemperatuurWaarde: &lt;value&gt; value met unit</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1108 (BodyTemperature). at the element: &lt; code code="386725007" displayName="lichaamstemperatuur (waarneembare entiteit)" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT"/&gt;</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Tijd: &lt;effectiveTime&gt;</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1108 (BodyTemperature). in the format DD-MM-YYYY, HH:MM:SS</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1109 (Respiration). in the format DD-MM-YYYY, HH:MM:SS.</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>GlasgowComaScaleDatumTijd</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1110 (GlasgowComaScale). in the format DD-MM-YYYY, HH:MM:SS</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>GCS_Eyes</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1110 (GlasgowComaScale) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1111 (GCSEyes). A combination of code and a display would be nice. The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.40.2.12.8.1 GCS_EyesCodelijst</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>GCS_Motor</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1110 (GlasgowComaScale) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1112 (GCSMotor). A combination of code and a display would be nice. The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.40.2.12.8.2 GCS_MotorCodelijst (DYNAMISCH)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>GCS_Verbal</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1110 (GlasgowComaScale) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1113 (GCSVerbal). A combination of code and a display would be nice. The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.40.2.12.8.3 GCS_VerbalCodelijst (DYNAMISCH) of The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.40.2.12.8.4 GCS_VerbalCodelijstKleuter (DYNAMISCH) of The value of @code MUST come from the value list. 2.16.840.1.113883.2.4.3.11.60.40.2.12.8.5 GCS_VerbalCodelijstBaby (DYNAMISCH), depending on the patient's date of birth</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>TotaalScore</td>
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1110 (GlasgowComaScale) contains Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1114 (TotalScore). at the element:  &lt; code code="444323003" displayName="Modified Glasgow coma score (observable entity)" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED CT"/&gt;</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1115 (RevisedTraumaScore). in the format DD-MM-YYYY, HH:MM:SS.</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1116 (PediatricTraumaScore). in the format DD-MM-YYYY, HH:MM:SS</td>
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
    <td>Template ID: 2.16.840.1.113883.2.4.3.11.60.55.10.1117 (Pain). in the format DD-MM-YYYY, HH:MM:SS</td>
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
    <td>Template ID 2.16.840.1.113883.2.4.3.11.60.55.10.438 (ConsultingExternalProfessionalSection) contains 2.16.840.1.113883.2.4.3.11.60.55.10.441 (ConsultationGiverName)</td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Telefoonnummer: &lt;telecom&gt;</td>
    <td>Template ID 2.16.840.1.113883.2.4.3.11.60.55.10.438 (ConsultingExternalProfessionalSection) contains 2.16.840.1.113883.2.4.3.11.60.55.10.440 (ConsultationGiver)</td>
    <td></td>
    <td>degree of flexibility, not mandatory for qualification
 </td>
  </tr>
  <tr>
    <td>Type consultgever: &lt; code &gt; displayname</td>
    <td>Template ID 2.16.840.1.113883.2.4.3.11.60.55.10.438 (ConsultingExternalProfessionalSection) contains 2.16.840.1.113883.2.4.3.11.60.55.10.440 (ConsultationGiver). The value of @code MUST come from the value list 2.16.840.1.113883.2.4.3.11.60.55.11.15 Consultgever op afstand</td>
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

### Mapping the ambulance handover to the SEH (CDA) to the ambulance referral to the out-of-hours GP service (FHIR), and mapping to the zibs

The mappings between the data elements are shown in the table below. Data elements shown in red are <b>not</b> relevant to the exchange. Data elements shown in blue require special attention because the terminology differs.

<table class="grid">
  <thead>
    <tr>
      <th>AMB-SEH gegevenselement</th>
      <th>AMB-HAP gegevenselement</th>
      <th>Opmerking</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>Persoonsgegevens</td><td>Patient</td><td></td></tr>
    <tr><td>Persoonsidentificatie</td><td>Identificatienummer</td><td>Patient identification is transmitted from the ambulance using the BSN. It has not yet been determined whether multiple types of identification can be sent or received. Receiving the BSN is highly valuable for the out-of-hours GP service. If the BSN is missing from the emergency care data, the data-absent reason "unknown" is used for the exchange.</td></tr>
    <tr><td>Naamgegevens</td><td>Naamgegevens</td><td></td></tr>
    <tr><td></td><td>Voornamen</td><td></td></tr>
    <tr><td>Initialen</td><td>Initialen</td><td></td></tr>
    <tr><td></td><td>Roepnaam</td><td></td></tr>
    <tr><td>Soort naam</td><td>Naamgebruik</td><td>Support for a subset of the value list is permitted: surname, partner's surname. The HIS retrieves only the birth surname based on the BSN..</td></tr>
    <tr><td>Achternaam</td><td>Geslachtsnaam/GeslachtsnaamPartner</td><td>For the out-of-hours GP service, the surname is sufficient.</td></tr>
    <tr><td>Voorvoegsel</td><td>Voorvoegsels/VoorvoegselsPartner</td><td></td></tr>
    <tr><td>Achternaam</td><td>Achternaam/AchternaamPartner</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Titels</span></td><td>not relevant for the use case AMB-HAP: no added value of name and address detailss</td></tr>
    <tr><td>Adresgegevens</td><td>Adresgegevens</td><td></td></tr>
    <tr><td>Straat</td><td>Straat</td><td></td></tr>
    <tr><td>Huisnummer</td><td>Huisnummer</td><td></td></tr>
    <tr><td>Huisletter</td><td>Huisnummerletter</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">AanduidingBijNummer</span></td><td>not relevant for the use case AMB-HAP: no added value </td></tr>
    <tr><td>Huisnummertoevoeging</td><td>Huisnummertoevoeging</td><td>not required for out-of-hours GP service. </td></tr>
    <tr><td>Postcode</td><td>Postcode</td><td></td></tr>
    <tr><td>Locatiebeschrijving</td><td><span style="color: #0000ff">AdditioneleInformatie</span></td><td> </td></tr>
    <tr><td>Woonplaats</td><td>Woonplaats</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Gemeente</span></td><td>not relevant for the use case AMB-HAP: no added value; can be found using postcode/house number</td></tr>
    <tr><td>Land</td><td>Land</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Adressoort</span></td><td>not relevant for the use case AMB-HAP: When it concerns public space, the responsibility always lies with the ambulance service, not the out-of-hours GP service.</td></tr>
    <tr><td>Overige contactgegevens</td><td>Contactgegevens</td><td></td></tr>
    <tr><td>Telefoonnummers</td><td>Telefoonnummers</td><td></td></tr>
    <tr><td>Telefoonnummer</td><td>Telefoonnummer</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">TelecomType</span></td><td>not relevant for the use case AMB-HAP: As long as a callback number is provided, the rest offers no added value.</td></tr>
    <tr><td></td><td><span style="color: #db1304">NummerSoort</span></td><td>not relevant for the use case AMB-HAP: As long as a callback number is provided, the rest offers no added value.</td></tr>
    <tr><td></td><td><span style="color: #db1304">Toelichting</span></td><td>not relevant for the use case AMB-HAP: Useful to know whether the phone number belongs to the patient or someone else.</td></tr>
    <tr><td>E-mailadressen</td><td>EmailAdressen</td><td></td></tr>
    <tr><td>E-mailadres</td><td>EmailAdres</td><td>not necessary at the out-of-hours GP service</td></tr>
    <tr><td></td><td><span style="color: #db1304">EmailSoort</span></td><td>not relevant for the use case AMB-HAP: not necessary at the out-of-hours GP service </td></tr>
    <tr><td>Geboortedatum</td><td>Geboortedatum</td><td></td></tr>
    <tr><td>Geslacht</td><td>Geslacht</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">MeerlingIndicator</span></td><td>not relevant for the use case AMB-HAP: 
Less relevant for the out-of-hours GP service. Currently not recorded by ambulance services. If a need for this information is indicated, it should be discussed for a future version of the message.</td></tr>
    <tr><td></td><td><span style="color: #db1304">OverlijdensIndicator</span></td><td>not relevant for the use case AMB-HAP: 
Natural deaths are handled by the out-of-hours GP service, while non-natural deaths are dealt with by a forensic physician. The ambulance service does not register the death in the patient's records, though the time of death is included in the attachment..</td></tr>
    <tr><td></td><td><span style="color: #db1304">DatumOverlijden</span></td><td>not relevant for the use case AMB-HAP: 
Natural deaths are handled by the out-of-hours GP service, while non-natural deaths are dealt with by a forensic physician. The ambulance service does not register the death in the patient's records, though the time of death is included in the attachment.</td></tr>
    <tr><td>Contactpersoon patiënt</td><td>Contactpersoon</td><td></td></tr>
    <tr><td></td><td>Naamgegevens</td><td></td></tr>
    <tr><td>Achternaam</td><td><span style="color: #0000ff">Volledige naam</span></td><td>Data from AMBIS systems show that the full name is recorded in an unstructured format.</td></tr>
    <tr><td></td><td><span style="color: #db1304">Voornamen</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Initialen</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Roepnaam</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Naamgebruik</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Geslachtsnaampartner.VoorvoegselPartner</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Geslachtsnaampartner.AchternaamPartner</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Titels</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td>Adresgegevens</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Straat</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Huisnummer</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Huisnummerletter</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Huisnummertoevoeging</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">AanduidingbijNummer</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Postcode</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Woonplaats</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Gemeente</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Land</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">AdditionaleInformatie</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">AdresSoort</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td>Contactgegevens.Telefoonnummers</td><td></td></tr>
    <tr><td>Telefoonnummer</td><td>Telefoonnummer</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Telecomtype</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">NummerSoort</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Toelichting</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td>Contactgegevens.Emailadressen</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Emailadres</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">EmailadresSoort</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td>Relatie tot patiënt</td><td>Relatie</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Rol</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Toelichting</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td>Ritgegevens Ambulance</td><td>Verzendende Zorgverlener</td><td></td></tr>
    <tr><td>Ambulanceverpleegkundige Identificatie</td><td>Zorgverleneridentificatienummer</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Naamgegevens</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #0000ff">Specialisme</span></td><td>UZI value 30.000 Nurse or
Vektis AGB medical specialties value 9100 Nurses, not further specified</td></tr>
    <tr><td></td><td><span style="color: #db1304">Geslacht</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Adresgegevens</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td>Telefoon ambulance</td><td><span style="color: #0000ff">Contactgegevens.Telefoonnummers.Telefoonnummer</span></td><td>To reach the healthcare provider, the ambulance service's telephone number is used </td></tr>
    <tr><td></td><td><span style="color: #db1304">Contactgegevens.Emailadressen</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Zorgverlenerrol</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td>Ambulance</td><td>Verzendende Zorgaanbieder</td><td></td></tr>
    <tr><td>Ambulancevoorziening</td><td>ZorgaanbiederIdentificatienummer</td><td></td></tr>
    <tr><td></td><td><span style="color: #0000ff">OrganisatieNaam</span></td><td>RAV-name</td></tr>
    <tr><td></td><td>OrganisatieLocatie</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Locatienaam</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Locatienummer</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td>Adresgegevens</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Straat</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Huisnummer</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Huisnummerletter</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Huisnummertoevoeging</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">AanduidingbijNummer</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Postcode</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Woonplaats</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Gemeente</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Land</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">AdditionaleInformatie</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">AdresSoort</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td>Contactgegevens.Telefoonnummers</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Telefoonnummers</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Telecomtype</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">NummerSoort</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Toelichting</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td>Contactgegevens.Emailadressen</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Emailadres</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">EmailadresSoort</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td>Bestemmingsgegevens</td><td>Ontvangende zorgaanbieder</td><td></td></tr>
    <tr><td>Bestemmingscode</td><td>ZorgaanbiederIdentificatienummer</td><td>Mapping from LSDV using LSP-ID: https://nictiz.atlassian.net/wiki/spaces/POB/pages/930938881/Bestemmingscode+-+ketenafspraak</td></tr>
    <tr><td>Locatie of afdeling</td><td><span style="color: #0000ff">OrganisatieNaam</span></td><td> HAP name. Known from the LSDV list. The OID of the LSDV list is included in the CDA XML. This is currently being investigated in https://nictiz.atlassian.net/browse/AZ-1133</td></tr>
    <tr><td></td><td><span style="color: #db1304">AfdelingSpecialisme</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">OrganisatieType</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td>OrganisatieLocatie</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Locatienaam</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Locatienummer</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td>Adresgegevens</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Straat</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Huisnummer</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Huisnummerletter</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Huisnummertoevoeging</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">AanduidingbijNummer</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Postcode</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Woonplaats</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Gemeente</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Land</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">AdditionaleInformatie</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">AdresSoort</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td>Contactgegevens.Telefoonnummers</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Telefoonnummers</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Telecomtype</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">NummerSoort</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">Toelichting</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td>Contactgegevens.Emailadressen</td><td></td></tr>
    <tr><td></td><td><span style="color: #db1304">Emailadres</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td></td><td><span style="color: #db1304">EmailadresSoort</span></td><td>not relevant for the use case AMB-HAP</td></tr>
    <tr><td>Bestemmingsgegevens</td><td>Bestemmingsgegevens</td><td></td></tr>
    <tr><td>Bestemmingsstatus</td><td>Bestemmingsstatus</td><td>The 'bestemmingsstatus overgedragen' is mapped to servicerequest.status=completed</td></tr>
    <tr><td></td><td>Datum en tijd</td><td>Date and time of sending</td></tr>
    <tr><td>Ritnummer</td><td>Ritnummer</td><td>'Ritnummer' of the ambulance</td></tr>
    <tr><td></td><td>Kern</td><td></td></tr>
    <tr><td>Reden bericht (vanaf V2.5.0)</td><td><span style="color: #0000ff">Reden bericht.Context</span></td><td>When a patient is referred from acute ambulance care to the out-of-hours GP service (HAP) and specific destination details—such as the 'Reden bericht' (only operational in V2.5.0)—are missing from the handover, the system automatically generates a standard text: "Patient referred from acute ambulance care to the out-of-hours GP service for further care. </td></tr>
    <tr><td>Behandeling</td><td>Ingestelde Behandeling</td><td>Each treatment in a seperate 'Ingestelde behandeling' section</td></tr>
    <tr><td>Luchtweg management (therapeutisch)</td><td><span style="color: #0000ff">Ingestelde Behandeling</span></td><td></td></tr>
    <tr><td>Oxygenatie en ventilatie (therapeutisch)</td><td><span style="color: #0000ff">Ingestelde Behandeling</span></td><td></td></tr>
    <tr><td>Circulatie (therapeutisch)</td><td><span style="color: #0000ff">Ingestelde Behandeling</span></td><td></td></tr>
    <tr><td>Traumatologie (therapeutisch)</td><td><span style="color: #0000ff">Ingestelde Behandeling</span></td><td></td></tr>
    <tr><td>Obstetrie (therapeutisch)</td><td><span style="color: #0000ff">Ingestelde Behandeling</span></td><td></td></tr>
    <tr><td>Wijze van isolatie</td><td><span style="color: #0000ff">Ingestelde Behandeling</span></td><td></td></tr>
    <tr><td>Medicatie</td><td><span style="color: #0000ff">Ingestelde Behandeling</span></td><td></td></tr>
    <tr><td>Extra informatie behandeling</td><td><span style="color: #0000ff">Ingestelde Behandeling</span></td><td></td></tr>
    <tr><td>Toestandsbeelden/Werkdiagnosen</td><td>Diagnose/Conclusie</td><td>'Toestandsbeelden/werkdiagnose weergavenamen' and 'toelichting toestandsbeeld'</td></tr>
    <tr><td>Toestandsbeeld titel</td><td><span style="color: #0000ff">Diagnose/Conclusie</span></td><td></td></tr>
    <tr><td>Toelichting Toestandsbeeld</td><td><span style="color: #0000ff">Diagnose/Conclusie</span></td><td></td></tr>
    <tr><td>Afspraken met patiënt</td><td>AfgesprokenMetPatient</td><td></td></tr>
    <tr><td>Bijlage</td><td>Dossiergegevens.CommunicatieItem.Document</td><td></td></tr>
    <tr><td>Bijlage id</td><td>DocumentIdentificatie</td><td></td></tr>
    <tr><td>Bijlageset id</td><td>DocumentSetIdentificatie</td><td></td></tr>
    <tr><td>Versie</td><td>DocumentVersienummer</td><td>How the version is to be mapped from CDA to FHIR is currently under analysis by the HL7 Community https://nictiz.atlassian.net/browse/AZ-1158</td></tr>
    <tr><td>Media Type</td><td>DocumentBestandtype</td><td></td></tr>
    <tr><td>Bijlage inhoud</td><td>DocumentInhoud</td><td></td></tr>
    <tr><td>Bestandsnaam</td><td>DocumentNaam</td><td></td></tr>
    <tr><td>Creatiedatum</td><td>DocumentCreatieDatumTijd</td><td></td></tr>
    <tr><td>Type bijlage</td><td>DocumentType</td><td></td></tr>
  </tbody>
</table>