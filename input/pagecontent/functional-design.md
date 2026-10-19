### Background

The information exchange described in this Implementation Guide is defined by:

- The Richtlijn Gegevensuitwisseling Acute Zorg versie 4 (2022) ([PDF](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf)) is the policy-level guideline that establishes which data must be exchanged between parties in acute care settings in the Netherlands. It defines the scenarios, parties, and content requirements at a clinical level. This use cases corresponds to message 23 and 24 in the guideline.

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
<br>
The image above shows that certain business activities result in a specific transaction. This transaction is performed by a system role and is part of a transaction group. The data elements exchanged between system roles as part of the transactions are specified in the "Ambulance referral to GP or GP out-of-hours service" (AMB → HAP) scenario.
The table below allows for direct access to the relevant use cases (scenarios), transaction groups, and/or transactions in ART-DECOR or other documentation. Where a link is provided, the description of the transaction(s) or transaction group(s) is available.
<br>
<br>

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


