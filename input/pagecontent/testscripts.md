### Introduction
#### General information
This test script has been prepared by Nictiz. Wherever possible, the components are linked to clinical information building blocks (*zorginformatiebouwstenen*). Testing provides an opportunity to verify the technical exchange. It is recommended that all relevant scenarios be tested. The test materials are subject to supplementation and modification.

#### Target audience
The target audience for this test script is the supplier wishing to prepare for qualification regarding the exchange of ambulance referrals to the out-of-hours GP service within the Acute Care domain. This test material has been developed for the following system role:
-  Sending/Receiving

This document describes the script to be followed during qualification testing for the system role:

- The AMBIS fulfills the system role: Acute Care Process – Ambulance Referral Sending System [AZP-AVS]
- The HAPIS fulfills the system role: Acute Care Process – Ambulance Referral Receiving System [AZP-AVO]

#### Testing conditions

The general Nictiz terms and conditions for testing and qualification apply when performing this test. The following specific conditions also apply:

- Knowledge of the infrastructure or network used for the exchange and how to access it, including authentication, authorization, and related matters.
- Knowledge and understanding of, and compliance with, the points for attention described in this document.
- The test documentation contains the data entered by the testing party.
- Knowledge and understanding of the Acute Care Information Standard.

#### Glossary

Nictiz uses certain abbreviations and terms. More information is available in the [general glossary](https://nictiz.nl/standaarden/begrippen/). A [thesaurus](https://thesauruszorgenwelzijn.multites.net/) is also available for looking up terms.

### Test information

Nictiz offers suppliers the opportunity to test whether their products and services correctly implement information standards in preparation for qualification. Screenshots are not required when performing these tests, but they can be helpful when correcting errors. Testing infrastructure requirements is not part of this test script.

#### Test approach

Keep a record of the findings from the tests performed. Analyse the findings, correct any errors where necessary, and test again.

#### Testing and Qualification Tools

##### ConformanceLab

Nictiz provides the ConformanceLab test system for testing system roles and their associated information standards in preparation for the qualification process. Prospective and current participants can also use ConformanceLab during the development and testing phases to test and/or validate FHIR messages at an early stage.

A [separate guide is available](https://informatiestandaarden.nictiz.nl/wiki/kwalificatie:V1.0_Handleiding_Conformancelab "Qualification: V1.0 ConformanceLab Guide") for connecting to ConformanceLab.

For suppliers acting as an intermediary for the transformation from CDA to FHIR, [ART-DECOR](https://informatiestandaarden.nictiz.nl/wiki/HL7v3_kwalificatiesimulator) is used as the source of information.

### Test Script

#### Step by step

Perform the following steps for each scenario:

**Sending**

1. Create the test patient using the test data.
2. Send the test patient to the test simulator (ConformanceLab), as described in the scenario.
3. The test simulator (ConformanceLab) will receive and process the test patient.

**Receiving**

1. Create the healthcare professional and healthcare provider in the XIS, as described in the test data.
2. Register the test patient’s personal details in the XIS, as specified in the test data.
3. Take screenshots of the entered data.
4. Initiate the transmission of the test data from the test simulator (ConformanceLab).
5. Receive and process the messages in the XIS, storing them in a structured format in the database.
6. Take screenshots of the data received in the XIS.

**Transformation Service**

1. Initiate the transmission of the test data from the ART-DECOR test simulator.
2. Receive the message and transform it into a FHIR message for the ConformanceLab test system.
3. Send the test patient to the test simulator (ConformanceLab).
4. The test simulator (ConformanceLab) will receive and process the test patient.

#### Overview of Test Scenarios

| No. | Scenario | Test Objective | Expected Result | Test Data |
| ---: | --- | --- | --- | --- |
| 1 | Minimum message | Verify that all mandatory fields are processed, sent, and received correctly. | The message is sent successfully and accepted and processed by the receiving system in accordance with the information standard. | [Scenario - Minimal](#scenario-minimal) |
| 2 | Maximum message | Verify that all mandatory and optional fields are processed, sent, and received correctly. | The message is sent successfully and accepted and processed by the receiving system in accordance with the information standard. | [Scenario - Maximal](#scenario-maximal) |

#### Test Data for Registering Parties Based on the Functional Mapping

The registration of the test data is based on the functional mapping described in [functional design](functional-design.html). This mapping describes how the data used in the exchange from the Ambulance to the Emergency Department (CDA V2.4.0) is converted into the elements of the Ambulance referral to a GP out-of-hours service (FHIR). It therefore forms the basis for the test scenarios.

The [specification of the document within the ambulance referral to the out-of-hours GP service](functional-design.html) describes the structure of the ambulance handover.

#### Personal Data

The personal data includes a fictional Dutch citizen service number (fBSN) for testing purposes. It is intended only for use in the XIS when registering the test patient. A transformation service can use the fBSN to retrieve the source information from the ART-DECOR qualification simulator.

#### Variable T-Date

Test and qualification scenarios often use relative dates to prevent them from becoming outdated. For example, a date specified as “next week” will always remain in the future. The T-date is used to convert these relative dates into specific dates for testing and qualification.

For ConformanceLab, the T-date is always the Monday of the week in which the tests in this script are performed. For example, `T-100` means 100 days before that Monday.

For the ART-DECOR qualification server, `T – 10D` means 10 days before the agreed date and time. The format is `yyyy-mm-ddThh:mm:ss`.

### Scenario Minimal

<table class="grid">
  <thead>
    <tr>
      <th colspan="7">Envelop</th>
    </tr>
    <tr>
      <th colspan="6">Gegevenselement</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tr>
    <td colspan="7">Patiëntgegevens</td>
  </tr>
  <tr>
    <td rowspan="2"></td>
  </tr>
  <tr>
    <td colspan="5">Patient</td>
    <td>onbekend</td>
  </tr>
  <tr>
    <td colspan="7">Verzender</td>
  </tr>
  <tr>
    <td rowspan="9"></td>
  </tr>
  <tr>
    <td colspan="6">Zorgverlener</td>
  </tr>
  <tr>
    <td rowspan="7"></td>
  </tr>
  <tr>
    <td colspan="4">ZorgverlenerIdentificatienummer</td>
    <td>567891234 (in identificerend systeem: UZI Personen)</td>
  </tr>
  <tr>
    <td colspan="5">Zorgaanbieder</td>
  </tr>
  <tr>
    <td rowspan="4"></td>
  </tr>
  <tr>
    <td colspan="4">Zorgaanbieder</td>
  </tr>
  <tr>
    <td rowspan="2"></td>
  </tr>
  <tr>
    <td colspan="2">ZorgaanbiederIdentificatienummer</td>
    <td>25 (in identificerend systeem: 2.16.840.1.113883.2.4.3.11.60.55.15.1)</td>
  </tr>
  <tr>
    <td colspan="7">Ontvanger</td>
  </tr>
  <tr>
    <td rowspan="5"></td>
  </tr>
  <tr>
    <td colspan="6">Zorgaanbieder</td>
  </tr>
  <tr>
    <td rowspan="3"></td>
  </tr>
  <tr>
    <td colspan="4">ZorgaanbiederIdentificatienummer</td>
    <td>06020806 (in identificerend systeem: AGB-Z)</td>
  </tr>
  <tr>
    <td colspan="4">OrganisatieType</td>
    <td>
      Huisartsenpost (t.b.v. dienstwaarneming) (code = 'N6' in codeSystem
      '<span title="2.16.840.1.113883.2.4.15.1060">HL7 RoleCodeNL Care provider type (organizations)</span>')
    </td>
  </tr>
  <tr>
    <td colspan="7">Bestemmingsgegevens</td>
  </tr>
  <tr>
    <td rowspan="2"></td>
  </tr>
  <tr>
    <td colspan="6">Ritnummer</td>
    <td>25-2020-11-1 (in identificerend systeem: 2.16.840.1.113883.2.4.3.32.5)</td>
  </tr>
  <tr>
    <td colspan="6">Datum en tijd</td>
    <td>T</td>
  </tr>
</table>

<table class="grid">
  <thead>
    <tr>
      <th colspan="4">Kern</th>
    </tr>
    <tr>
      <th colspan="3">Gegevenselement</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tr>
    <td colspan="4">RedenBericht</td>
  </tr>
  <tr>
    <td rowspan="2"></td>
  </tr>
  <tr>
    <td colspan="2">Context</td>
    <td>Patiënt is vanuit acute ambulancezorg voor verdere zorg doorverwezen naar de huisartsenspoedpost</td>
  </tr>
</table>

<table class="grid">
  <thead>
    <tr>
      <th colspan="5">Dossiergegevens</th>
    </tr>
    <tr>
      <th colspan="4">Gegevenselement</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tr>
    <td colspan="5">CommunicatieItem</td>
  </tr>
  <tr>
    <td rowspan="10"></td>
  </tr>
  <tr>
    <td colspan="4">Document</td>
  </tr>
  <tr>
    <td rowspan="8"></td>
  </tr>
  <tr>
    <td colspan="2">DocumentIdentificatie</td>
    <td>9068 (in identificerend systeem: 2.25)</td>
  </tr>
  <tr>
    <td colspan="2">DocumentSetIdentificatie</td>
    <td>12 (in identificerend systeem: 2.25)</td>
  </tr>
  <tr>
    <td colspan="2">DocumentVersienummer</td>
    <td>1</td>
  </tr>
  <tr>
    <td colspan="2">DocumentBestandtype</td>
    <td>application/pdf</td>
  </tr>
  <tr>
    <td colspan="2">DocumentInhoud</td>
    <td>voorbeeldbericht</td>
  </tr>
  <tr>
    <td colspan="2">DocumentNaam</td>
    <td>Bijlage.pdf</td>
  </tr>
  <tr>
    <td colspan="2">DocumentType</td>
    <td>intern rapport/overdracht (code = '006' in codeSystem '2.16.840.1.113883.2.4.3.11.60.55.5.16')</td>
  </tr>
</table>

#### Example document handover minimal
This is an example of a handover from the ambulance. This example sets out the end-user requirements and makes no statements regarding technical realization or implementation. Following a careful process analysis with healthcare providers, the end users determined the sequence of chapters and the content of the medical information.
  <style>
    * {
      box-sizing: border-box;
    }

    .brief {
      width: 100%;
      max-width: 210mm;
      min-height: 297mm;
      margin: 0 auto;
      padding: 25mm;
      background: white;
      box-shadow: 0 4px 20px rgb(0 0 0 / 15%);
    }

    .briefhoofd {
      margin-bottom: 20px;
    }

    .afzender {
      margin-bottom: 35px;
    }

    .onderwerp {
      margin-bottom: 25px;
    }

    caption {
    text-align:left;
    }

  </style>


  <article class="brief">
    <header class="briefhoofd">
      <div class="afzender">
        <strong>Betreft</strong><br>
        Geslacht Naamgegevens<br>
        Adres<br>
        <strong>BSN</strong> onbekend<br>  
        <strong>Geboortedatum</strong><br>
        <strong>Contactgegevens</strong><br>  
      </div>
        <p class="onderwerp">
        <strong>Reden/hulpvraag:</strong> Patiënt is vanuit acute ambulancezorg voor 
verdere zorg doorverwezen naar de 
huisartsenspoedpost 
      </p>
    </header>
    <main>
      <p><strong>Conclusie</strong>  </p>
      <p>Toestandsbeeld:</p>
      <p><strong>Behandelingen</strong></p>
      <p><strong>Meldingsgegevens</strong></p>
      <p><strong>Anamnese</strong></p>
      <p><strong>Handelingen</strong></p>
      <p><strong>Lichamelijk onderzoek</strong></p>
      <p><strong>Meetwaarden</strong></p>
      </div>
    </main>
  </article>

### Scenario Maximal

<table class="grid">
  <thead> 
    <tr>
      <th colspan="6">Bouwstenen</th>
    </tr>
    <tr>
      <th colspan="5">Gegevenselement</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tr>
    <td colspan="6">
      <span id="XXX_Baatenburg" title="Intern ID = XXX_Baatenburg">Patient XXX_Baatenburg</span>
    </td>
  </tr>
  <tr>
    <td rowspan="28"></td>
  </tr>
  <tr>
    <td colspan="5">Naamgegevens</td>
  </tr>
  <tr>
    <td rowspan="7"></td>
  </tr>
  <tr>
    <td colspan="3">Initialen</td>
    <td>J.H.M.</td>
  </tr>
  <tr>
    <td colspan="3">Naamgebruik</td>
    <td>
      Geslachtsnaam partner (code = 'NL2' in codeSystem
      '<span title="2.16.840.1.113883.2.4.3.11.60.101.5.4">ZIB Naamgebruik</span>')
    </td>
  </tr>
  <tr>
    <td colspan="4">GeslachtsnaamPartner</td>
  </tr>
  <tr>
    <td rowspan="3"></td>
  </tr>
  <tr>
    <td colspan="2">VoorvoegselsPartner</td>
    <td>van</td>
  </tr>
  <tr>
    <td colspan="2">AchternaamPartner</td>
    <td>XXX_Baatenburg</td>
  </tr>
  <tr>
    <td colspan="5">Adresgegevens</td>
  </tr>
  <tr>
    <td rowspan="7"></td>
  </tr>
  <tr>
    <td colspan="3">Straat</td>
    <td>Knolweg</td>
  </tr>
  <tr>
    <td colspan="3">Huisnummer</td>
    <td>1003</td>
  </tr>
  <tr>
    <td colspan="3">Postcode</td>
    <td>9999ZA</td>
  </tr>
  <tr>
    <td colspan="3">Woonplaats</td>
    <td>Stitswerd</td>
  </tr>
  <tr>
    <td colspan="3">Land</td>
    <td>Nederland (code = 'NL' in codeSystem 'ISO 3166-1 (alpha-2)')</td>
  </tr>
  <tr>
    <td colspan="3">AdditioneleInformatie</td>
    <td>naast de derde brug rechts</td>
  </tr>
  <tr>
    <td colspan="5">Contactgegevens</td>
  </tr>
  <tr>
    <td rowspan="7"></td>
  </tr>
  <tr>
    <td colspan="4">Telefoonnummers</td>
  </tr>
  <tr>
    <td rowspan="2"></td>
  </tr>
  <tr>
    <td colspan="2">Telefoonnummer</td>
    <td>611234567</td>
  </tr>
  <tr>
    <td colspan="4">EmailAdressen</td>
  </tr>
  <tr>
    <td rowspan="2"></td>
  </tr>
  <tr>
    <td colspan="2">EmailAdres</td>
    <td>giesput@myweb.nl</td>
  </tr>
  <tr>
    <td colspan="4">Identificatienummer</td>
    <td>999910589 (in identificerend systeem: 2.16.840.1.113883.2.4.3.11.60.103.2.36)</td>
  </tr>
  <tr>
    <td colspan="4">Geboortedatum</td>
    <td>6 aug 1954</td>
  </tr>
  <tr>
    <td colspan="4">Geslacht</td>
    <td>
      Vrouw (code = 'F' in codeSystem
      '<span title="2.16.840.1.113883.5.1">HL7 AdministrativeGender</span>')
    </td>
  </tr>
  <tr>
    <td colspan="6">Contactpersoon</td>
  </tr>
  <tr>
    <td rowspan="10"></td>
  </tr>
  <tr>
    <td colspan="5">Naamgegevens</td>
  </tr>
  <tr>
    <td rowspan="2"></td>
  </tr>
  <tr>
    <td colspan="3">VolledigeNaam</td>
    <td>Putten</td>
  </tr>
  <tr>
    <td colspan="5">Contactgegevens</td>
  </tr>
  <tr>
    <td rowspan="4"></td>
  </tr>
  <tr>
    <td colspan="4">Telefoonnummers</td>
  </tr>
  <tr>
    <td rowspan="2"></td>
  </tr>
  <tr>
    <td colspan="2">Telefoonnummer</td>
    <td>0611234567</td>
  </tr>
  <tr>
    <td colspan="4">Relatie</td>
    <td>
      Anders (code = 'OTH' in codeSystem
      '<span title="2.16.840.1.113883.5.1008">HL7 NullFlavor</span>'): FAMMEMB
    </td>
  </tr>
</table>

<table class="grid">
  <thead>
    <tr>
      <th colspan="7">Envelop</th>
    </tr>
    <tr>
      <th colspan="6">Gegevenselement</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tr>
    <td colspan="7">Patiëntgegevens</td>
  </tr>
  <tr>
    <td rowspan="2"></td>
  </tr>
  <tr>
    <td colspan="5">Patient</td>
    <td>Zie <a href="#XXX_Baatenburg">Patient: XXX_Baatenburg</a></td>
  </tr>
  <tr>
    <td colspan="7">Verzender</td>
  </tr>
  <tr>
    <td rowspan="20"></td>
  </tr>
  <tr>
    <td colspan="6">Zorgverlener</td>
  </tr>
  <tr>
    <td rowspan="14"></td>
  </tr>
  <tr>
    <td colspan="4">ZorgverlenerIdentificatienummer</td>
    <td>123456789 (in identificerend systeem: UZI Personen)</td>
  </tr>
  <tr>
    <td colspan="4">Specialisme</td>
    <td>Verpleegkundige (code = '30.000' in codeSystem 'RoleCodeNL - zorgverlenertype (personen)')</td>
  </tr>
  <tr>
    <td colspan="5">Contactgegevens</td>
  </tr>
  <tr>
    <td rowspan="4"></td>
  </tr>
  <tr>
    <td colspan="4">Telefoonnummers</td>
  </tr>
  <tr>
    <td rowspan="2"></td>
  </tr>
  <tr>
    <td colspan="2">Telefoonnummer</td>
    <td>0612345678</td>
  </tr>
  <tr>
    <td colspan="5">Zorgaanbieder</td>
  </tr>
  <tr>
    <td rowspan="5"></td>
  </tr>
  <tr>
    <td colspan="4">Zorgaanbieder</td>
  </tr>
  <tr>
    <td rowspan="3"></td>
  </tr>
  <tr>
    <td colspan="2">ZorgaanbiederIdentificatienummer</td>
    <td>25 (in identificerend systeem: 2.16.840.1.113883.2.4.3.11.60.55.15.1)</td>
  </tr>
  <tr>
    <td colspan="2">OrganisatieNaam</td>
    <td>RAV</td>
  </tr>
  <tr>
    <td colspan="6">Zorgaanbieder</td>
  </tr>
  <tr>
    <td rowspan="3"></td>
  </tr>
  <tr>
    <td colspan="4">ZorgaanbiederIdentificatienummer</td>
    <td>25 (in identificerend systeem: 2.16.840.1.113883.2.4.3.11.60.55.15.1)</td>
  </tr>
  <tr>
    <td colspan="4">OrganisatieNaam</td>
    <td>RAV</td>
  </tr>
  <tr>
    <td colspan="7">Ontvanger</td>
  </tr>
  <tr>
    <td rowspan="6"></td>
  </tr>
  <tr>
    <td colspan="6">Zorgaanbieder</td>
  </tr>
  <tr>
    <td rowspan="4"></td>
  </tr>
  <tr>
    <td colspan="4">ZorgaanbiederIdentificatienummer</td>
    <td>6010860 (in identificerend systeem: AGB-Z)</td>
  </tr>
  <tr>
    <td colspan="4">OrganisatieNaam</td>
    <td>HAP</td>
  </tr>
  <tr>
    <td colspan="4">OrganisatieType</td>
    <td>
      Huisartsenpost (t.b.v. dienstwaarneming) (code = 'N6' in codeSystem
      '<span title="2.16.840.1.113883.2.4.15.1060">HL7 RoleCodeNL Care provider type (organizations)</span>')
    </td>
  </tr>
  <tr>
    <td colspan="7">Bestemmingsgegevens</td>
  </tr>
  <tr>
    <td rowspan="2"></td>
  </tr>
  <tr>
    <td colspan="6">Ritnummer</td>
    <td>25-2020-10-1 (in identificerend systeem: 2.16.840.1.113883.2.4.3.32.5)</td>
  </tr>
  <tr>
    <td colspan="6">Datum en tijd</td>
    <td>T</td>
  </tr>
</table>

<table class="grid">
  <thead>
    <tr>
      <th colspan="4">Kern</th>
    </tr>
    <tr>
      <th colspan="3">Gegevenselement</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tr>
    <td colspan="4">RedenBericht</td>
  </tr>
  <tr>
    <td rowspan="2"></td>
  </tr>
  <tr>
    <td colspan="2">Context</td>
    <td>Patiënt is vanuit acute ambulancezorg voor verdere zorg doorverwezen naar de huisartsenspoedpost</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Handelingen luchtweg management: intubatie van trachea</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Moeizame intubatie? Ja</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Handelingen oxygenatie en ventilatie: kunstmatige beademing</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Beademing machine Fi O2: 0.50</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Beademing machine AMV: 6L/min</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Beademing machine Freq.: 10/min</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Beademing machine Peep: 3cm[H2O]</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Hoeveelheid zuurstof: 3L/min</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Handelingen oxygenatie en ventilatie: handmatige beademing</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Handelingen circulatie: cardioversie</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Cardioversies aantal: 2</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Cardioversie maximale energie: 600 Joule</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Return Of Spontaneous Circulation (ROSC): Nee</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>AED aangesloten voor aankomst: Ja</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>AED-schokken aantal: 5</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Handelingen circulatie: transthoracale cardiale pacing</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Pacemaker frequentie: 60 /min</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Pacemaker stroomsterkte: 5 mA</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Pacemaker modus: fixed rate</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Handelingen circulatie:defibrillatie met gelijkstroom</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Defibrillaties aantal: 3</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Defibrillatie energie: 200 Joule</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Handelingen traumatologie: koelen van patiënt</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Koelen tijdsduur: 10 minuten</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Handelingen obstetrie: afklemmen van navelstreng</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Handelingen isolatie: contactisolatie</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Medicatie toegediend? Ja</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Medicatienaam: Acetylsalicylzuur</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Toegediende hoeveelheid medicatie: 2 stuk</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Medicatie toedieningsvorm: oraal toedienen van medicatie</td>
  </tr>
  <tr>
    <td colspan="3">IngesteldeBehandeling</td>
    <td>Extra informatie behandeling: Normale behandeling</td>
  </tr>
  <tr>
    <td colspan="3">Diagnose / Conclusie</td>
    <td>letsel van aangezicht. Moeilijk observeren door weersomstandigheden</td>
  </tr>
  <tr>
    <td colspan="3">AfgesprokenMetPatient</td>
    <td>Huisarts nog inlichten</td>
  </tr>
</table>

<table class="grid">
  <thead>
    <tr>
      <th colspan="5">Dossiergegevens</th>
    </tr>
    <tr>
      <th colspan="4">Gegevenselement</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tr>
    <td colspan="5">CommunicatieItem</td>
  </tr>
  <tr>
    <td rowspan="11"></td>
  </tr>
  <tr>
    <td colspan="4">Document</td>
  </tr>
  <tr>
    <td rowspan="9"></td>
  </tr>
  <tr>
    <td colspan="2">DocumentIdentificatie</td>
    <td>9068 (in identificerend systeem: 2.16.840.1.113883.2.4.3.11.999.103.3)</td>
  </tr>
  <tr>
    <td colspan="2">DocumentSetIdentificatie</td>
    <td>12 (in identificerend systeem: 2.16.840.1.113883.2.4.3.11.999.103.3)</td>
  </tr>
  <tr>
    <td colspan="2">DocumentVersienummer</td>
    <td>1</td>
  </tr>
  <tr>
    <td colspan="2">DocumentBestandtype</td>
    <td>application/pdf</td>
  </tr>
  <tr>
    <td colspan="2">DocumentInhoud</td>
    <td>voorbeeldbericht</td>
  </tr>
  <tr>
    <td colspan="2">DocumentNaam</td>
    <td>ambulance verslag</td>
  </tr>
  <tr>
    <td colspan="2">DocumentCreatieDatumTijd</td>
    <td>T</td>
  </tr>
  <tr>
    <td colspan="2">DocumentType</td>
    <td>intern rapport/overdracht (code = '006' in codeSystem '2.16.840.1.113883.2.4.3.11.60.55.5.16')</td>
  </tr>
</table>


#### Example document handover maximal
This is an example of a handover from the ambulance. This example sets out the end-user requirements and makes no statements regarding technical realization or implementation. Following a careful process analysis with healthcare providers, the end users determined the sequence of chapters and the content of the medical information.

<article class="brief">
    <header class="briefhoofd">
      <div class="afzender">
        <strong>Betreft</strong><br>
        Mw J.H.M. XXX_Baatenburg <br>
        Knolweg 1003  <br>
        9999ZA<br>
        Stitswerd, Nederland <br>
        <strong>BSN</strong> 999910589<br>  
        <strong>Geboortedatum</strong> 06-08-1954 <br>
        <strong>Contactgegevens</strong> 611234567 <br>  
      </div>
        <p class="onderwerp">
        <strong>Reden/hulpvraag:</strong> Patiënt is vanuit acute ambulancezorg voor 
verdere zorg doorverwezen naar de 
huisartsenspoedpost 
      </p>
    </header>
    <main>
      <p><strong>Conclusie</strong></p>
      Toestandsbeeld: Letsel van aangezicht <br>
Toelichting toestandsbeeld: Moeilijk observeren door weersomstandigheden <br>
Tijdstip overlijden patiënt: 8-05-2026 12:15 <br>
<br>
      <p><strong>Behandelingen</strong></p>
      Handeling luchtwegmanagement: Moeizame intubatie<br> 
Intubatie van trachea: Ja <br>
Handelingen oxygenatie en ventilatie: kunstmatige beademing, handmatige beademing <br>
Beademing machine FiO2: 0.50 <br>
Beademing machine AMV: 6 L/min <br>
Beademing machine Freq: 10/min <br>
Beademing machine Peep: 3 cm[H2O] <br>
Hoeveelheid zuurstof: 3 L/min  <br>
Handelingen circulatie: Cardioversie, transthoracale cardiale pacing, defibrillatie met gelijkstroom <br>
Pacemaker frequentie: 60/min  <br>
Pacemaker stroomsterkte: 5 mA <br>
Pacemaker modus: fixed rate <br>
Cardioversies aantal: 2 <br>
Cardioversie maximale energie: 600 Joule  <br>
Defibrillatie aantal: 3 <br>
Defibrillatie energie: 200 Joules <br>
Return Of Spontaneous Circculation (ROSC): Nee <br>
AED aangesloten voor aankomst: Ja <br>
AED-schokken aantal: 5 <br>
Handelingen traumatologie: Koelen van patiënt <br>
Koelen tijdsduur: 10 minuten <br>
Handelingen obstetrie: Afklemmen van navelstreng <br>
Handelingen isolatie: Contactisolatie <br>
Medicatie toegediend? Ja <br>
Medicatienaam: Acetylsalicylzuur <br>
Toegediende hoeveelheid medicatie 2 stuks <br>
Tijd medicatietoediening: 12:05 <br>
Medicatie toedieningsvorm: oraal toedienen van medicatie <br>
Extra informatie behandeling: Normale behandeling<br>
<br>
    <p><strong>Afspraken met de patiënt</strong></p>  
Afspraken met patiënt: Huisarts nog inlichten <br>
Huisarts ingelicht: Nee <br>
<br>
    <p><strong>Behandelgrenzen </strong></p>
Niet-reanimeerverklaring aanwezig: Nee <br>
<br>
    <p><strong>Toelichting algemeen  </strong></p>
 Lorem ipsum dolor sit amet, consectetuer 
adipiscing elit. Aenean commodo ligula 
eget dolor. Aenean massa. Cum sociis 
natoque penatibus et magnis dis parturient 
montes, nascetur ridiculus mus. Donec 
quam felis, ultricies nec, pellentesque eu, 
pretium quis, sem. Nulla consequat massa 
quis enim. Donec pede justo, fringilla vel, 
aliquet nec, vulputate <br>
<br>
      <p><strong>Meldingsgegevens</strong></p>
      Medische kladblok meldkamer: Lorem ipsum dolor sit amet, consectetuer
adipiscing elit. Aenean commodo ligula 
eget dolor. Aenean massa. Cum sociis 
natoque penatibus et magnis dis parturient 
montes, nascetur ridiculus mus. Donec 
quam felis, ultricies nec, pellentesque eu, 
pretium quis, sem. Nulla consequat massa 
quis enim. Donec pede justo, fringilla vel, 
aliquet nec, vulputate <br>
Datum/tijd incident: 25-05-2026 12:00 <br>
Datum/tijd melding: 25-05-2026 12:01 <br>
Meldkamerurgentie: B1 Hoog complexe zorg bij planbare 
ambulancezorg <br>
<br>
      <p><strong>Anamnese</strong></p>
      Allergie: Pinda’s <br>
Medicatie: Geen medicatie <br>
Medische voorgeschiedenis: Nooit eerder opgenomen geweest <br> 
Tijdstip aanvang klachten: 1 uur geleden <br>
Gebeurtenis: Geen bijzonderheden <br>
Risico op kruisinfectie  <br>
Toelichting: Lastig vanwege weersomstandigheden<br>
<br>
<p><strong>Infectierisico  </strong></p>
Verdenking infectieziekten? Ja  <br>
Toelichting infectierisico: Afgelopen maanden in een ziekenhuis in 
India geweest <br>
<br>
      <p><strong>Handelingen</strong></p>
      Handelingen ademhaling en beademing: meten van ademhalingsfrequentie <br>
Handelingen bewustzijn en neurologische 
status: pupilreactie-onderzoek <br>
Handelingen overige diagnostisch: lichamelijk onderzoek <br>
<br>
      <p><strong>Lichamelijk onderzoek</strong></p>
      Airway vrij?  Nee <br>
Stridor: Inspiratoire stridor <br>
Breathing sufficient? Nee <br>
Breathing observaties: Asymmetrische thoraxbeweging  <br>
Circulation sufficient? Nee<br>
Capillaire refill > 2 seconde? Ja<br> 
Huid observatie: Klam zweet <br>
AVPU: Alert <br>
Duur buiten bewustzijn: 5 min<br> 
Neurologische observaties  <br>
Pupil onderzoek:Normal size pupil  <br>
FAST symptomen aanwezig: Ja <br>
Mogelijke trombolyse/trombectomie: Ja <br>  
Intoxicatie: Intoxicatie door alcohol <br>
Toelichting Primary Survey: Nee <br>
<br>
<u>Hoofd en gelaat</u> <br> 
Hoofd en gelaat: Beet in eigen tong <br>
Bloeding uit mond: Bloedverlies <br>
Liquorverlies: Nasale liquorroe <br> 
Pijnlocatie: Kaaklijn, achterhoofd <br>
Verwondingen hoofd: Steekwond, abrasie <br>
<u>Nek, hals, CWK</u>  <br>
Bevinding betreffende Nek, hals, CWK: Pijn in cervicale wervelkolom <br>
Verwonding: Steekwond <br>
<u>Thorax</u>  <br>
Bevinding betreffende thorax: Asymmetrische thorax  <br>
Pijn bij compressie: Pijn van sternum bij compressie tijdens lichamelijk onderzoek<br>
Verwonding: Brandwond <br>
<u>Rug</u>  <br>
Bevinding betreffende rug, inclusief nek: Hematoom<br>
Verwonding: Abrasie <br>   
<u>Abdomen</u>  <br>
Bevinding betreffende abdomen: Bloeding van huid<br>
Drukpijn en/of loslaatpijn: Drukpijn en/of loslaatpijn rechtsboven in abdomen bij lichamelijk onderzoek  <br>
Verwonding: Luchtaanzuigende thoraxverwonding <br>
<u>Bekken</u>  <br>
Bevinding betreffende bekken: Instabiliteit van gewricht <br>
Verwonding: Letsel door afgevuurd projectiel <br>
<u>Extremiteiten armen</u>  <br>
Observaties over een enkele arm  <br>
Lateraliteit:Links <br>
Bevinding betreffende bovenste extremiteit: Verwonding <br>
Verwonding: Abrasie <br>
Observaties over een enkele arm  <br>
Lateraliteit: Rechts <br>
Bevinding betreffende bovenste extremiteit: Pijn <br>
<u>Extremiteiten benen</u>  <br>
Observaties over een enkele been  <br>
Lateraliteit: Rechts <br>
Bevinding betreffende onderste extremiteit: Pijn  <br>
Bevinding betreffende onderste extremiteit: Zwelling of oedeem  <br>
<u>Uitscheiding</u>   <br>
Bevinding betreffende uitscheidingspatroon: Braken, Incontinentie  <br>
Braken: Hematemese  <br>
Incontinentie: Incontinentie voor feces  <br>
  <br>
<u>Verloskunde/Gynaecologie </u> <br>
Bevinding betreffende zwangerschap: Postpartumbloeding <br>
Vruchtwaterverlies: Helder vruchtwater <br>
Tijdsduur tussen weeën: 2 min<br>
<br>
      <p><strong>Meetwaarden</strong></p>
<table>
  <thead>
    <tr>
      <th>Tijd</th>
      <th>Omschrijving</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>08:44:44</td>
      <td>O2 Saturatie</td>
      <td>98 %</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>CO2 Capnometrie</td>
      <td>5.6 kPa</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>Hartslagfrequentie</td>
      <td>76 /min</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>Kenmerk van hartritme</td>
      <td>asystolie (aandoening)</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>Toelichting hartritme/ECG</td>
      <td>Niet normaal</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>Bloedglucoseconcentratie</td>
      <td>7.1 mmol/L</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>Lichaamstemperatuur</td>
      <td>37.3 °C</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>Ademhalingsfrequentie</td>
      <td>15 /min</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>Gereviseerde traumascore</td>
      <td>11</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>Pediatrische traumascore</td>
      <td>7</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>Pijnniveau</td>
      <td>5</td>
    </tr>
  </tbody>
</table>

<table>
  <caption>Bloeddruk</caption>
  <thead>
    <tr>
      <th>Tijd</th>
      <th>Meting</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>08:44:44</td>
      <td>Systolische bloeddruk</td>
      <td>155 mm[Hg]</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>Diastolische bloeddruk</td>
      <td>70 mm[Hg]</td>
    </tr>
  </tbody>
</table>

<table>
  <caption>Glasgow Coma Scale</caption>
  <thead>
    <tr>
      <th>Tijd</th>
      <th>Omschrijving</th>
      <th>Score</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>08:44:44</td>
      <td>GCS Ogen</td>
      <td>Bij aanspreken of aanroepen (E3)</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>GCS Bewegingsreactie</td>
      <td>Terugtrekken (M4)</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>GCS Verbaal</td>
      <td>Inadequaat (V3)</td>
    </tr>
    <tr>
      <td>08:44:44</td>
      <td>Gemodificeerde GCS</td>
      <td>10</td>
    </tr>
  </tbody>
</table>

<table>
  <caption>APGAR</caption>
  <thead>
    <tr>
      <th>Tijd</th>
      <th>Omschrijving</th>
      <th>Score</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>08:44:44</td>
      <td>1-minute</td>
      <td>8</td>
    </tr>
    <tr>
      <td>08:44:49</td>
      <td>5-minute</td>
      <td>10</td>
    </tr>
  </tbody>
</table>
    <p><strong>Intercollegiale consulten</strong></p>
Naam: huisarts J.T Test <br>
Toelichting/afspraken: terugbellen<br>
<br>
  </main>
</article>