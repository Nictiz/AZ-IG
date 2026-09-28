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
    <th colspan=2>Envelop</th>
    <tr>
      <th>
        Gegevenselement
      </th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Patiëntgegevens.Patient</td>
      <td> onbekend</td>
    </tr>
    <tr>
      <td>Verzender.Zorgverlener.ZorgverlenerIdentificatienummer</td>
      <td>567891234 (in identificerend systeem: UZI Personen)</td>
    </tr>
    <tr>
      <td>Verzender.ZorgaanbiederZorgaanbiederIdentificatienummer</td>
      <td>
        25 (in identificerend systeem:
        2.16.840.1.113883.2.4.3.11.60.55.15.1)
      </td>
    </tr>
    <tr>
      <td>Ontvanger.Zorgaanbieder.ZorgaanbiederIdentificatienummer</td>
      <td>06020806 (in identificerend systeem: AGB-Z)</td>
    </tr>
    <tr>
      <td>Ontvanger.Zorgaanbieder.OrganisatieType</td>
      <td>
        Huisartsenpost (t.b.v. dienstwaarneming)
        (code =N6 in codeSystem HL7 RoleCodeNL Care provider type (organizations))
      </td>
    </tr>
    <tr>
      <td>Bestemmingsgegevens.Bestemmingsstatus</td>
      <td>
        completed (code = completed in codeSystem HL7 ActStatus)
      </td>
    </tr>
    <tr>
      <td>Bestemmingsgegevens.Ritnummer</td>
      <td>
        25-2020-11-1 (in identificerend systeem:
        2.16.840.1.113883.2.4.3.32.5)
      </td>
    </tr>
    <tr>
      <td>Bestemmingsgegevens.Datum en tijd</td>
      <td>T</td>
    </tr>
  </tbody>
</table>


<table class="grid">
  <thead>
      <th colspan=2>Kern</th>
    <tr>
      <th>Gegevenselement</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>RedenBericht.Context</td>
      <td>
        Patiënt is vanuit acute ambulancezorg voor verdere zorg doorverwezen
        naar de huisartsenspoedpost
      </td>
    </tr>
  </tbody>
</table>
 

 <table class="grid">
  <thead>
    <th colspan=2>Dossiergegevens</th>
    <tr>
      <th>Gegevenselement</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>CommunicatieItem.Document.DocumentIdentificatie</td>
      <td>9068 (in identificerend systeem: 2.25)</td>
    </tr>
    <tr>
      <td>CommunicatieItem.Document.DocumentSetIdentificatie</td>
      <td>12 (in identificerend systeem: 2.25)</td>
    </tr>
    <tr>
      <td>CommunicatieItem.Document.DocumentVersienummer</td>
      <td>1</td>
    </tr>
    <tr>
      <td>CommunicatieItem.Document.DocumentBestandtype</td>
      <td>application/pdf</td>
    </tr>
    <tr>
      <td>CommunicatieItem.Document.DocumentInhoud</td>
      <td>voorbeeldbericht minimaal</td>
    </tr>
    <tr>
      <td>CommunicatieItem.Document.DocumentNaam</td>
      <td>minimale overdracht</td>
    </tr>
    <tr>
      <td>CommunicatieItem.Document.DocumentType</td>
      <td>
        intern rapport/overdracht
        (code = 006 in codeSystem 2.16.840.1.113883.2.4.3.11.60.55.5.16)
      </td>
    </tr>
  </tbody>
</table>

#### Example document handover minimal
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

    .datum {
      text-align: right;
      margin-bottom: 30px;
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

    .ondertekening {
      margin-top: 35px;
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
        <p class="datum">
        <time datetime="2026-09-27">Amsterdam, 27 september 2026</time>
        </p>
        <p class="onderwerp">
        <strong>Reden/hulpvraag:</strong> Patiënt is vanuit acute ambulancezorg voor 
verdere zorg doorverwezen naar de 
huisartsenspoedpost 
      </p>
    </header>
    <main>
      <p>Conclusie  </p>
      <p>Toestandsbeeld:</p>
      <p>Behandelingen</p>
      <p>Meldingsgegevens</p>
      <p>Anamnese</p>
      <p>Handelingen</p>
      <p>Lichamelijk onderzoek</p>
      <p>Meetwaarden</p>
      <div class="ondertekening">
      <p>Met vriendelijke groet, </p>
        <strong>RAV</strong><br>
        <i>Deze brief is elektronisch opgesteld en daarom niet ondertekend</i><br>
      </div>
    </main>
  </article>

### Scenario Maximal
<table class="grid">
  <thead>
    <th colspan=2>Bouwstenen</th>
    <tr>
      <th>Gegevenselement</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tbody>
      <td>Naamgegevens</td>
      <td></td>
    <tr>
      <td>Initialen</td>
      <td>J.H.M.</td>
    </tr>
    <tr>
      <td>Naamgebruik</td>
      <td>
        Geslachtsnaam partner (code = NL2 in codeSystem ZIB Naamgebruik)
      </td>
    </tr>
    <tr>
      <td>GeslachtsnaamPartner</td>
      <td></td>
    </tr>
    <tr>
      <td>VoorvoegselsPartner</td>
      <td>van</td>
    </tr>
    <tr>
      <td>AchternaamPartner</td>
      <td>XXX_Baatenburg</td>
    </tr>
    <tr>
      <td>Adresgegevens</td>
      <td></td>
    </tr>
    <tr>
      <td>Straat</td>
      <td>Knolweg</td>
    </tr>
    <tr>
      <td>Huisnummer</td>
      <td>1003</td>
    </tr>
    <tr>
      <td>Postcode</td>
      <td>9999ZA</td>
    </tr>
    <tr>
      <td>Woonplaats</td>
      <td>Stitswerd</td>
    </tr>
    <tr>
      <td>Land</td>
      <td>
        Nederland (code = NL in codeSystem ISO 3166-1 (alpha-2))
      </td>
    </tr>
    <tr>
      <td>AdditioneleInformatie</td>
      <td>naast de derde brug rechts</td>
    </tr>
    <tr>
      <td>Contactgegevens</td>
      <td></td>
    </tr>
    <tr>
      <td>Telefoonnummers</td>
      <td></td>
    </tr>
    <tr>
      <td>Telefoonnummer</td>
      <td>611234567</td>
    </tr>
    <tr>
      <td>EmailAdressen</td>
      <td></td>
    </tr>
    <tr>
      <td>EmailAdres</td>
      <td>giesput@myweb.nl</td>
    </tr>
    <tr>
      <td>Identificatienummer</td>
      <td>
        999910589 (in identificerend systeem:
        2.16.840.1.113883.2.4.3.11.60.103.2.36)
      </td>
    </tr>
    <tr>
      <td>Geboortedatum</td>
      <td>6 aug 1954</td>
    </tr>
    <tr>
      <td>Geslacht</td>
      <td>
        Vrouw (code = F in codeSystem HL7 AdministrativeGender)
      </td>
    </tr>
    <tr>
      <td>Contactpersoon</td>
      <td></td>
    </tr>
    <tr>
      <td>Naamgegevens</td>
      <td></td>
    </tr>
    <tr>
      <td>VolledigeNaam</td>
      <td>Putten</td>
    </tr>
    <tr>
      <td>Contactgegevens</td>
      <td></td>
    </tr>
    <tr>
      <td>Telefoonnummers</td>
      <td></td>
    </tr>
    <tr>
      <td>Telefoonnummer</td>
      <td>0611234567</td>
    </tr>
    <tr>
      <td>Relatie</td>
      <td>
        Anders (code = OTH in codeSystem HL7 NullFlavor): FAMMEMB
      </td>
    </tr>
  </tbody>
</table>

<table class="grid">
  <thead>
    <th colspan=2>Envelop</th>
    <tr>
      <th>Gegevenselement</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Patiëntgegevens</td>
      <td></td>
    </tr>
    <tr>
      <td>Patient</td>
      <td>
        Zie <a href="#XXX_Baatenburg">Patient: XXX_Baatenburg</a>
      </td>
    </tr>
    <tr>
      <td>Verzender</td>
      <td></td>
    </tr>
    <tr>
      <td>Zorgverlener</td>
      <td></td>
    </tr>
    <tr>
      <td>ZorgverlenerIdentificatienummer</td>
      <td>123456789 (in identificerend systeem: UZI Personen)</td>
    </tr>
    <tr>
      <td>Specialisme</td>
      <td>
        Verpleegkundige (code = 30.000 in codeSystem RoleCodeNL - zorgverlenertype (personen))
      </td>
    </tr>
    <tr>
      <td>Contactgegevens</td>
      <td></td>
    </tr>
    <tr>
      <td>Telefoonnummers</td>
      <td></td>
    </tr>
    <tr>
      <td>Telefoonnummer</td>
      <td>0612345678</td>
    </tr>
    <tr>
      <td>Zorgaanbieder</td>
      <td></td>
    </tr>
    <tr>
      <td>ZorgaanbiederIdentificatienummer</td>
      <td>
        25 (in identificerend systeem:
        2.16.840.1.113883.2.4.3.11.60.55.15.1)
      </td>
    </tr>
    <tr>
      <td>OrganisatieNaam</td>
      <td>RAV</td>
    </tr>
    <tr>
      <td>Zorgaanbieder</td>
      <td></td>
    </tr>
    <tr>
      <td>ZorgaanbiederIdentificatienummer</td>
      <td>
        25 (in identificerend systeem:
        2.16.840.1.113883.2.4.3.11.60.55.15.1)
      </td>
    </tr>
    <tr>
      <td>OrganisatieNaam</td>
      <td>RAV</td>
    </tr>
    <tr>
      <td>Ontvanger</td>
      <td></td>
    </tr>
    <tr>
      <td>Zorgaanbieder</td>
      <td></td>
    </tr>
    <tr>
      <td>ZorgaanbiederIdentificatienummer</td>
      <td>6010860 (in identificerend systeem: AGB-Z)</td>
    </tr>
    <tr>
      <td>OrganisatieNaam</td>
      <td>HAP</td>
    </tr>
    <tr>
      <td>OrganisatieType</td>
      <td>
        Huisartsenpost (t.b.v. dienstwaarneming)
        (code = N6 in codeSystem HL7 RoleCodeNL Care provider type (organizations))
      </td>
    </tr>
    <tr>
      <td>Bestemmingsgegevens</td>
      <td></td>
    </tr>
    <tr>
      <td>Bestemmingsstatus</td>
      <td>
        completed (code = completed in codeSystem HL7 ActStatus)
      </td>
    </tr>
    <tr>
      <td>Ritnummer</td>
      <td>
        25-2020-10-1 (in identificerend systeem:
        2.16.840.1.113883.2.4.3.32.5)
      </td>
    </tr>
    <tr>
      <td>Datum en tijd</td>
      <td>T</td>
    </tr>
  </tbody>
</table>


<table class="grid">
  <thead>
    <th colspan=2>Kern</th>
    <tr>
      <th>Gegevenselement</th>
      <th>Waarde</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>RedenBericht.Context</td>
      <td>
        Patiënt is vanuit acute ambulancezorg voor verdere zorg doorverwezen
        naar de huisartsenspoedpost
      </td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Handelingen luchtweg management: intubatie van trachea</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Moeizame intubatie? Ja</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Handelingen oxygenatie en ventilatie: kunstmatige beademing</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Beademing machine Fi O2: 0.50</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Beademing machine AMV: 6L/min</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Beademing machine Freq.: 10/min</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Beademing machine Peep: 3cm[H2O]</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Hoeveelheid zuurstof: 3L/min</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Handelingen oxygenatie en ventilatie: handmatige beademing</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Handelingen circulatie: cardioversie</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Cardioversies aantal: 2</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Cardioversie maximale energie: 600 Joule</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Return Of Spontaneous Circulation (ROSC): Nee</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>AED aangesloten voor aankomst: Ja</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>AED-schokken aantal: 5</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Handelingen circulatie: transthoracale cardiale pacing</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Pacemaker frequentie: 60 /min</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Pacemaker stroomsterkte: 5 mA</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Pacemaker modus: fixed rate</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Handelingen circulatie: defibrillatie met gelijkstroom</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Defibrillaties aantal: 3</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Defibrillatie energie: 200 Joule</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Handelingen traumatologie: koelen van patiënt</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Koelen tijdsduur: 10 minuten</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Handelingen obstetrie: afklemmen van navelstreng</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Handelingen isolatie: contactisolatie</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Medicatie toegediend? Ja</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Medicatienaam: Acetylsalicylzuur</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Toegediende hoeveelheid medicatie: 2 stuk</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Medicatie toedieningsvorm: oraal toedienen van medicatie</td>
    </tr>
    <tr>
      <td>IngesteldeBehandeling</td>
      <td>Extra informatie behandeling: Normale behandeling</td>
    </tr>
    <tr>
      <td>Diagnose / Conclusie</td>
      <td>
        letsel van aangezicht. Moeilijk observeren door weersomstandigheden
      </td>
    </tr>
    <tr>
      <td>AfgesprokenMetPatient</td>
      <td>Huisarts nog inlichten</td>
    </tr>
  </tbody>
</table>


<table class="grid">
  <thead>
    <th colspan=2>Dossiergegevens</th>
    <tr>
      <th>Gegevenselement</th>
      <th>Waarde</th>
    </tr>
  </thead>
<tbody>
    <tr>
    <td>CommunicatieItem</td>
    <td></td>
    </tr>
    <tr>
    <td>Document</td>
    <td></td>
    </tr>
    <tr>
    <td>DocumentIdentificatie</td>
    <td>
        9068 (in identificerend systeem:
        2.16.840.1.113883.2.4.3.11.999.103.3)
    </td>
    </tr>
    <tr>
    <td>DocumentSetIdentificatie</td>
    <td>
        12 (in identificerend systeem:
        2.16.840.1.113883.2.4.3.11.999.103.3)
    </td>
    </tr>
    <tr>
    <td>DocumentVersienummer</td>
    <td>1</td>
    </tr>
    <tr>
    <td>DocumentBestandtype</td>
    <td>application/pdf</td>
    </tr>
    <tr>
    <td>DocumentInhoud</td>
    <td>voorbeeldbericht maximaal</td>
    </tr>
    <tr>
    <td>DocumentNaam</td>
    <td>ambulance verslag</td>
    </tr>
    <tr>
    <td>DocumentCreatieDatumTijd</td>
    <td>T</td>
    </tr>
    <tr>
    <td>DocumentType</td>
    <td>
        intern rapport/overdracht
        (code = 006 in codeSystem 2.16.840.1.113883.2.4.3.11.60.55.5.16)
    </td>
    </tr>
</tbody>
</table>

#### Example document handover maximal

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
        <p class="datum">
        <time datetime="2026-09-27">Amsterdam, 27 september 2026</time>
        </p>
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
      <div class="ondertekening">
      <p>Met vriendelijke groet, </p>
        <strong>RAV</strong><br>
        <i>Deze brief is elektronisch opgesteld en daarom niet ondertekend</i><br>
      </div>
    </main>
  </article>