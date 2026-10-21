Mapping the ambulance handover to the SEH (CDA) to the ambulance referral to the out-of-hours GP service (FHIR). The FHIR profile is based on ZIB2020.

The mappings between the data elements are shown in the table below. Data elements shown in red are <b>not</b> relevant to the exchange. Data elements shown in blue require special attention because the terminology differs.

<table class="grid">
  <thead>
    <tr>
      <th>AMB-SEH data element</th>
      <th>AMB-HAP data element</th>
      <th>Remark</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>Persoonsgegevens</td><td>Patient</td><td></td></tr>
    <tr><td>Persoonsidentificatie</td><td>Identificatienummer</td><td>Patient identification is transmitted from the ambulance using the BSN. It has not yet been determined whether multiple types of identification can be sent or received. In principle, it is mandatory to provide a BSN (citizen service number); however, you may deviate from this requirement if it is necessary for the provision of emergency care to a client. If the BSN is unknown, another unique identifier must be submitted.</td></tr>
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