# Noise-Monkey — Sales Strategy v0 (2026-05-23)

**Bygget på:** [research](research.md) + [killer USPs deck](usps.md).

**Status:** Strategi-udkast. Benjamins verificerede facts er **ikke landet i repo'et endnu** (verificeret 2026-05-23: nul Benjamin-commits på nogen branch). Når de lander, kan denne plan revideres på 1-2 punkter — ikke hele strukturen.

**Pre-mise:** Vi har ingen kunder. Vi har ingen physical units. Vi har en hypotese, kildebelagt research, og en USP-deck. Det her er en 0-til-3 betalende-kunder-plan, ikke en skalerings-plan.

---

## 1. Den eneste insight der styrer hele strategien

**Aben sælger sig selv hvis den står på køberens bord i 60 sekunder.**

Det er et fysisk produkt med en synlig, sjov, real-time effekt. Du kan ikke sælge det med slides alene — folk forstår det først når de ser det. Konklusionen:

> **Strategien er ikke "hvordan skaber vi awareness". Strategien er "hvordan får vi flest mulige aber på flest mulige kontor-chef-borde — billigt og hurtigt".**

Alt andet (LinkedIn, Product Hunt, content) er kun et middel til at trigge en demo. Demo'en lukker salget. Det er en **demo-først, content-måske** strategi.

---

## 2. Kanaler rangeret efter forventet konvertering

| Kanal | Estimeret demo-konvertering | Estimeret demo→betalende | Indsats/lead | Skalerbart? |
| --- | --- | --- | --- | --- |
| **Office walk-in** med 1-2 aber i hånden | 40-60 % får demo | 30-50 % | Høj (1-2 timer/besøg) | Nej — manuel |
| **Cold-call → bestil demo** | 5-15 % accepterer demo | 25-40 % | Mellem (15 min/opkald) | Ja, men sælger-intensiv |
| **LinkedIn warm-DM** til office mgr/HR i 50-200-ansatte SMB | 3-8 % svarer | 20-30 % | Lav (5 min/lead) | Ja |
| **Landing-page + cal.com booking** (inbound fra LinkedIn-content) | Afhænger af content | 25-40 % | Lav løbende, høj op-front | Ja |
| **Product Hunt launch** | <1 % af views → email | 1-5 % af email → paid | Engangs-arbejde | Awareness, ikke salg |

**Konklusion:** Start med walk-in og cold-call i Uge 1-4. Det er manuelt, ikke skalerbart, men det er den **eneste** måde at lære hvilke linjer der lander før vi automatiserer noget. LinkedIn og PH skalerer dårligt på falsk-positive USP'er — invester først når vi har lukket 3 deals manuelt.

---

## 3. Konverteringstrappen (views → paying) — kanal for kanal

### A) Office walk-in
```
walk-in → samtale med reception → eskaler til office mgr → 60-sek demo → pilot-aftale → betalt
```
**Bottleneck:** at komme forbi reception. **Løsning:** Aben i hånden er din nøgle. "Jeg vil gerne vise office manager hvad det her gør" virker langt bedre end "jeg har et salgsmøde". Aben dækker munden under en demo og 9/10 receptionister henter chefen selv.

### B) Cold-call
```
dial → connect → 30-sek hook → demo-booking → pilot → betalt
```
**Bottleneck:** Connect-rate (typisk 10-20 % på switchboard). **Løsning:** Brug JesperAI eller egen sælger til at filtrere — opkald før 09:30 eller efter 16:00 rammer office managers direkte oftere. **30-sek hook:** "Hej, jeg har et produkt der reducerer kontor-støj uden at jeres medarbejdere skal shush'e hinanden — Steelcase siger I taber 86 min/dag/person. Må jeg sende en abe forbi i morgen, så I kan se den i drift i 30 dage uden at betale noget?"

### C) LinkedIn DM (warm)
```
profil-besøg/like → connection req → tak-for-connect besked → soft-pitch → demo-call → pilot → betalt
```
**Bottleneck:** Svar-rate på første DM (~3-5 %). **Løsning:** Lead med USP #1 og **video af aben der dækker munden** indlejret i DM. Video > tekst med 4x på reply rate (anekdotisk industri-standard for B2B-hardware). CTA i DM: "Hvis du arbejder på et åbent kontor, send mig din adresse — jeg sender en abe forbi i 30 dage. Hvis støj-klagerne ikke falder, sender du den tilbage."

### D) Product Hunt launch
```
PH view → upvote → website-visit → email-signup → nurture → demo → pilot → betalt
```
**Bottleneck:** **PH konverterer dårligt til betalende B2B-hardware-kunder** — det er en awareness-platform. Forvent 5 000-20 000 views, 1-3 % til email, sub-5 % af email til betalende = realistisk 5-30 betalende kunder, 90 dage efter launch.

**Hvad PH ER godt til:**
- LinkedIn-content for de næste 12 måneder ("vi var #2 Product of the Day…")
- Press & creator-pickup (vi er en gadget med kant — det egner sig til Awwwards, design-blogs, Wired-tier)
- Referrals fra international developer/founder-publikum
- Hardware-press kontakter for senere

**Konklusion:** Brug PH som **PR-event efter** vi har 5-10 betalende kunder. Ikke før. Vi skal have social proof at vise på PH-siden.

---

## 4. Pricing strategi — anti-friktion, ikke max-marginal

Tre tiers, designet til at fjerne købs-friktion på første salg, ikke at maksimere ARPU:

| Tier | Pris | Hvad | Hvorfor |
| --- | --- | --- | --- |
| **Single Monkey** | €99 | 1 abe, ingen dashboard | Impulse-køb. Founder-CEO eller office mgr betaler personligt. Får os ind ad døren. |
| **Office Pack** | €499 (5 aber) | 5 aber + basic dashboard | **Sweet spot.** Under godkendelses-grænse hos 95 % af offices <100 ansatte. Wellness-budget-fit. |
| **Office Pro** | €999 (10 aber) + €29/mo | 10 aber + dashboard + ESG-rapport-eksport + custom threshold-zoner | Til 50-200-ansatte offices der vil bruge dashboard'et i compliance/ESG-flow |
| **Enterprise / Coworking** | Custom | Hvidmærket, volume rabat, on-site setup | WeWork, Mindspace, store ejendoms-administrationer |

**Hardware-økonomi (estimat — verificeres ved prototype):**
- BOM: 3D-print + mikrofon + servo + ESP32 ≈ €15-35 ved low-volume
- Assembly + QA (Gustav + 3D-printer) ≈ €15-30
- Total cost per unit ≈ €30-65
- **Office Pack margin:** €499 - 5×€50 = €249 ≈ 50 % gross margin
- **Single Monkey margin:** €99 - €50 = €49 ≈ 50 %

50 % margin er sundt nok til at finansiere skalering uden ekstern kapital. Bekræft når første batch er bygget.

---

## 5. Det ene tilbud der konverterer (uanset kanal)

> **30-dages risk-free pilot. Vi sender 5 aber. Hvis støj-klagerne ikke falder mærkbart, sender du dem tilbage. Du betaler intet før dag 31.**

Hvorfor dette virker:
1. **Risikoen er på os, ikke køberen.** Eneste indvending vi har umuligt at modgå er pris-frygt. Det her fjerner den.
2. **Aben er sin egen sælger.** Vi *vil* have den ud at stå på kontoret. 80 % af kontorer vil ikke kunne sige farvel efter 30 dage.
3. **Procurement-friktion = nul.** Køberen skriver under på en pilot-aftale, ikke en købskontrakt. Det er en juridisk anden ting.
4. **Sticky default.** Auto-fakturering på dag 31 medmindre de aktivt returnerer. Behavioral-economics 101.
5. **Social proof loop.** Hver pilot er en case study i opbygning. Bed om feedback dag 14 + 28 — første halvdelen af kunderne giver dig dine testimonials og LinkedIn-content.

**Risici ved denne model:**
- Returforsendelser bliver bøvlede (forventet 20-30 % på første 50 pilots — falder til <10 % når USP er sliben)
- Cash-flow: vi finansierer hardware før betaling. På 50 pilots × 5 aber × €50 = **€12 500 capital-binding** maks. Skal kunne tåles.

---

## 6. Sekvensering — 12 ugers plan

### Uge 1-2: Build & prep
- 10-20 prototype-aber bygget (3D-printer skal stå klar)
- Landing-page med USP-deck-essens + cal.com booking + pilot-aftale-formular
- LinkedIn-profil opdateret + 3 forhåndsskrevne content-posts
- Target-list: 30 navngivne offices i Storkøbenhavn (50-200 ansatte, åbent kontor, helst tech/scale-up)
- Cold-call script + walk-in script trænet

### Uge 3-6: Manual outreach (de afgørende 4 uger)
- **Daglig:** 10 cold-calls + 5 LinkedIn DM'er + 2 office walk-ins (1-2 dage/uge i bil med aber)
- **KPI:** Bog 15 demos pr. uge. 5 piloter started pr. uge.
- **Læring:** Hvilke linjer fra USP-deck'en lander? Hvilke prisspring giver friktion? Hvilke segmenter konverterer hurtigst?
- **Endemål uge 6:** 20-30 piloter løbende. **3-5 betalende kunder** (dvs. de første der ikke returnerer).

### Uge 7-10: Iteration + indirect channel test
- Slib USP-deck baseret på faktiske invendinger fra uge 3-6
- Test **én** indirect kanal seriøst:
  - **A:** LinkedIn-content (1 post/dag, 3 video-demos/uge)
  - **B:** Coworking-space partnership (WeWork, Mindspace, Talent Garden) — wholesale-aftale på 50-200 units
  - **C:** Office-design konsulent partnerships (de der rådgiver om kontor-indretning)
- **Endemål uge 10:** 15-20 betalende kunder. Pris-tier bekræftet.

### Uge 11-12: PH launch + presse-bølge
- Product Hunt launch med video, 5+ testimonials, og BTC ("built this in 90 days, here's what we learned")
- Dansk presse: Børsen, Berlingske Business — vinkel: "Dansk founder bygger niche-hardware mens platform-fonde stagnerer"
- **Endemål uge 12:** 30+ betalende kunder. Beslutning om skalering / fundraise / cofounder-search baseret på data, ikke håb.

---

## 7. KPI'er — hvad vi måler hver uge

| Stage | KPI | Target uge 6 | Target uge 12 |
| --- | --- | --- | --- |
| Outreach | Cold-calls/dag | 10 | 10 (auto-DM hvis vi finder god kanal) |
| Outreach | LinkedIn DMs/dag | 5 | 10 |
| Outreach | Walk-ins/uge | 2 | 0-2 (lavere når demos kommer inbound) |
| Funnel | Demos bookede/uge | 15 | 25 |
| Funnel | Demos afholdt/uge | 10 | 20 |
| Funnel | Piloter startet/uge | 5 | 8 |
| Funnel | Pilot→paying konverterings-rate | 50 % | 75 % |
| Result | Betalende kunder | 5 | 30 |
| Cash | Capital-binding i hardware | <€8 000 | <€25 000 |
| Cash | Månedlig run-rate | ~€2 500 | ~€15 000 |

**Hvis vi rammer uge-6 målene:** Den her er en business. Gå videre med uge 7+ planen.
**Hvis vi rammer 50-80 % af uge-6 målene:** Iterer på USP/pricing før vi skalerer. Mest sandsynligt udfald.
**Hvis vi rammer <30 % af uge-6 målene:** Stop. Pivot eller park. Indrøm tidligt at fysisk produkt + cold outreach er sværere end vi troede.

---

## 8. Hvor Benjamin (eller en cofounder) flytter nålen

Når/hvis Benjamin engagerer sig, er disse hans naturlige områder:

1. **Cold-call ejerskab** — JesperAI-erfaring + relationer i SMB-segmentet. Kan skalere cold-call-volumen 3-5x.
2. **Verifikation af de fem hovedtal** — kunderne er ikke dumme; én CFO der kan finde 66 %-tallet er en summary og ikke en primær studie, kan dræbe et deal. Verificering før Q3 er kritisk.
3. **DK-target-listen** — relations-baserede intros til de første 30 prospects. Hver intro er værd 5-10 cold-calls.

**Hvis Benjamin ikke engagerer sig inden uge 4** (dvs. 2026-06-20), så håndterer Gustav alle 3 ovenstående selv. Det er muligt, men 2-3x langsommere.

---

## 9. Indvendinger vi *ikke* har dækket endnu

Disse er ikke i USP-deck'en og kan dræbe deals hvis vi ikke prepper:

1. **"Vi har home-office option — folk arbejder hjemmefra hvis det er for støjende."**
   Svar: Det er problemet. Du betaler for et kontor hvor de bedste medarbejdere ikke kan koncentrere sig. Vi gør kontoret brugbart igen.

2. **"Jeg vil gerne, men vi flytter om 6 måneder."**
   Svar: Perfekt — tag aben med. Vi sender dig nye thresholds når I har målt det nye kontor i den første uge.

3. **"Hvad hvis folk bare ignorerer den?"**
   Svar: Vi har ikke data endnu, men nudge-forskning siger ~70 % adfærdsændring i 2-3 uger. Hvis I er i de 30 % der ikke skifter, sender I den tilbage. Du har ingen risiko.

4. **"Det her ligner en gimmick."**
   Svar: Gimmicks dækker ikke munden ved 65 dB med to-sekunders forsinkelse fordi en algoritme har målt et mønster over 5 min. Det her er et instrument forklædt som en gimmick. Det er hele pointen.

5. **"Hvad sker der hvis den går i stykker?"**
   Svar: 24-måneders garanti. Vi sender en ny inden for 5 arbejdsdage. 3D-print betyder reservedele er billige og hurtige for os at producere.

6. **"Hvad med GDPR / privacy?"**
   Svar: Aben måler dB. Den optager ikke, gemmer ikke, eller transmitterer ikke lyd-indhold. Du kan validere det selv ved at åbne enheden. Det er et akustisk instrument, ikke en mikrofon.

---

## 10. Beslutninger der skal træffes nu (denne uge)

- [ ] **Beslut target-segment for uge 3-6:** København tech/scale-up (50-200 ansatte) ← anbefalet ← eller dansk service-virksomhed eller coworking-operators
- [ ] **Beslut hardware-leverandør:** Lave selv på 3D-printer (langsomt, billigt) eller outsource print til Sculpteo/Shapeways (hurtigt, dyrere) for første 30 units
- [ ] **Beslut pris-anchor i pitch:** Lead med €99/single eller €499/office pack? (Anbefaling: €499 office pack — det er hvor pengene er, og det er under godkendelse)
- [ ] **Beslut hvem der bygger landing-page:** Gustav på agent360.dk/aben (rekommanderet — du har systemet) eller separat .dk-domæne
- [ ] **Beslut om Benjamin får ejerskab af cold-call eller om Gustav kører solo:** Afhænger af hans status — afklar inden uge 2

---

## 11. Hvad denne plan IKKE løser

Vær ærlig om det:

1. **Hardware-supply ved skalering.** 30 kunder er Gustav-i-garage-skalerbart. 300 kunder kræver enten ekstern produktion eller en hardware-cofounder. Den beslutning kommer i uge 10.
2. **International ekspansion.** DK først. EU senere. US måske aldrig direkte — sælges via importør.
3. **Dashboard-software roadmap.** v1 er dB-graf over tid + email-rapport. Hvis kunderne vil have integration til Slack/Teams/Looker, er det v2.
4. **Brand-identity.** Aben skal have et navn. Vi har 4 uger til at finde et. "Hush Monkey", "Quiet Ape", "Shhmpanzee", "MonkeyMute". Test mod 5 kontor-chefer.

---

**Status:** Draft v0 — 2026-05-23. Built solo by Gustav + Claude. **Test mod første 5 cold-opkald i Uge 1 — denne plan er forkert i mindst tre punkter. Vi ved bare ikke hvilke endnu.**
