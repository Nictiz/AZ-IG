### Background

The information exchange described in this Implementation Guide is defined by:

- The Richtlijn Gegevensuitwisseling Acute Zorg versie 4 (2022) ([PDF](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf)) is the policy-level guideline that establishes which data must be exchanged between parties in acute care settings in the Netherlands. It defines the scenarios, parties, and content requirements at a clinical level. This use cases corresponds to message 23 and 24 in the guideline.

In the autumn of 2023, AZN and InEen merged the 2017 agreements on resource allocation and the HAP+RAV cooperation framework into a single national guideline for collaboration between HAPs (GP out-of-hours services) and RAVs (regional ambulance services):
- Samenwerking HAP-RAV [Guideline](https://www.ambulancezorg.nl/themas/kwaliteit-van-zorg/ketensamenwerking/samenwerking-hap-rav)

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


