# Overblik — hvordan kommer aben til at se ud?

> Chat-note, 2026-05-23 (sen-eftermiddag). Følger op på den tidligere `gustav-chat-noter.md` "noise-monkey visual design discussion" — dengang fandtes design-spec ikke, og planen var at backward-engineere via nano banana. Designdokumenterne **eksisterer nu** (`design-v1.md`, `design-critique.md`, `PRINT.md`, opdateret `Mokey-product-plan.md`), så denne note destillerer faktisk visuelt overblik fra dem. Hvis dokumenterne ændres, er kilden sandheden.

---

## TL;DR i én sætning

En ~220 mm høj, 3D-printet **Bojesen-tribute-abe** i wood-fill PLA + linolie, der sidder/står på skrivebordet, lytter via skjult I2S-mik, og **dækker langsomt sine øjne med hænderne** når støj er for høj for længe — drevet af én SG90-servo via skjulte sener.

(Bemærk: gesten er nu **hænder-over-øjne** — "hør-ikke-abe" — ikke længere hænder-over-mund som tidligere chat-note antog. Skift sket i `design-v1.md`.)

---

## Form & udtryk

- **Reference:** Kay Bojesens teak-abe fra 1951. *"Linjen skal smile."* Ikke en kopi — en tribute der tilføjer én ting Bojesen aldrig gjorde: **den bevæger sig selv.**
- **Højde:** 220 mm (lidt højere end Bojesen "small" 200 mm, så mekanikken kan gemmes uden at ødelægge silhuet).
- **Materialefølelse:** wood-fill PLA slebet 240→400→600 grit, derefter to lag kogt linolie. Skal læses som *træ*, ikke som 3D-print.
- **Palet:** lys "birk/limba" som krop, mørk "valnød/teak" som indlæg til øjenbræt + snude, sorte glasperler (Ø6 mm) som øjne.

### Aktuel status (V0.2) vs. ambition (Bojesen-niveau)

V0.2 er **kompetent organisk figurin** — over hobby-print, men ikke generationelt design endnu. `design-critique.md` navngiver gabet ærligt:

| Punkt | V0.2 nu | Skal være |
|---|---|---|
| Pose | Siddende, ben spredt fremad (læses som "mid-shrug") | **Stående**, lange ben, bred fod-base, ~10° tå-ud |
| Arme | ~110 mm (~50% af højde) | **~135 mm (~60% af højde)** — den ikoniske Bojesen-signatur |
| Skuldre | Cylinder møder kugle i ret vinkel ("pølser boltet på tønde") | Flydende `hull()` — torsoen *svulmer* ud i armen |
| Hænder | Kugler | **Skålede håndflader**, håndled vippet let indad — møder ansigtet som *cuppede palms* |
| Ansigt | Glat kugle uden indlæg | Skulpteret pandebryn + kindplaner + defineret hage |
| Tech-afsløring | Bag-luge + USB-C synlig | Alt service skjult i aftagelig **træbase-skive**; krop = ét forseglet skulpturelt objekt |
| Hvilepositur | Slap | "Vågent" — hænder lidt fremme, arme let foran kroppen, blik fremad |

Top-5 til V0.3: rejs den op, arme til 135 mm, flydende skulder, træbase-skive, alert hvilepositur. 5 parametriske ændringer uden ny mekanisk kompleksitet.

---

## Proportioner (Bojesen "small")

| Del | Andel | Note |
|---|---|---|
| Hoved | ~31% | Nær-perfekt kugle, fladskåret hage, ingen hals |
| Torso | ~37% | Æg-snit, bredest ved skuldre, krummet rygsøjle-søm |
| Ben (stående) | ~35% | Cylindrisk, subtil taper |
| **Arme** | **~60%** | Lange — det vigtigste enkeltvise designtræk |

---

## Hvordan bevægelsen ser ud

Én SG90-servo lodret i torso trækker to braided fishing-line "sener" symmetrisk op gennem PTFE-fôrede kanaler ud til skuldrene. Returfjedre (eller én elastik på tværs af brystet, Bojesen-stil) trækker armene tilbage.

| Fase | Varighed | Detalje |
|---|---|---|
| Trigger | ≥800 ms over tærskel | Filtrerer enkelt-klap fra |
| Raise | 1.2 s | Cosinus-ease (ALDRIG lineær) |
| Hold | min. 4 s, så længe støj > tærskel − 6 dB hysterese | Ingen flicker på kanten |
| Lower | 1.8 s | Endnu langsommere — som modvilligt til at kigge igen |
| Cooldown | 8 s mindst | Social signal, ikke støjmåler |

Servoen er **lydløs ved hold** (end-of-travel mod bløde fjedre = ingen aktiv drift). Strømsvigt → fjedre trækker armene roligt ned: failure mode = "ro".

---

## Hardware (BOM under $25 for V1)

ESP32-S3 (USB-C) • I2S MEMS-mik (INMP441/SPH0645) peger op gennem hals-kavitet, lyd-port skjult bag øjenbrættet • SG90 servo • 6 mm sorte glasperler ×2 (øjne) • 3 mm stålpinde ×2 (skulder-pivot) • 60 cm braided fishing line (sener) • returfjeder / 2 mm sy-elastik • 5×2 mm neodym-magneter ×4 (bundplade) • USB-C breakout via hak i base-skive • USB-C kabel + 5V (intet batteri i V1).

---

## Print-overblik

- **13 parts**, ~21 timer, ~310 g filament.
- 3-fase: (1) valider mekanik på servo-bracket + yoke + bundplade — 1 t. (2) Valider torso-kavitet — 5 t. (3) Færdiggør body — 15 t.
- **Lemmer printes lodret** → lag-linjer langs lemmet → efter oliering læses som *træåre*.
- 0.4 mm hærdet stål-dyse. Maks 60 mm/s på wood-fill, ellers klogger.
- Bambu Studio profile i `PRINT.md`. Renders ligger i `stl/`: `_assembly_front.png`, `_assembly_iso.png`, `_assembly_side.png`, `_triggered.png`.

---

## Hvorfor produktet eksisterer (fra `Research.md`)

- Kognitiv ydeevne -14% i open-plan vs. stille rum
- Op til -66% produktivitet ved forståelig baggrundssamtale
- Kun 32% tilfredse med kontorets støj (Leesman, 800k+)
- Akustisk tilfredshed falder skarpt over 45 dB
- → Trig på samtale-toppe, ikke gennemsnit. Visuel nudge ved 45–50 dB

---

## Hvad aben *ikke* er

Ikke støjmåler/dashboard. Ingen batteri i V1. Ingen hale. Ingen synlige skruer/kabler/LED'er/mærker/tekst. Ingen tegneserie-ansigt. Ingen taleinput i V1 (V2). Ingen multi-monkey-koordination. Ingen sky/app/analytics.

---

## Det vigtigste enkelte skift (fra `design-critique.md`)

> Hædr motion-øjeblikket som hele grunden til at objektet eksisterer.

Generationsversionen: den statiske form *venter synligt* på bevægelsen. Hænderne i hvile er ikke slappe — de er *poiseret*. Blikket er fremad, ikke nedad. Det er ikke en CAD-ændring — det er en *holdnings*-ændring.

---

## Bilag — denne chats forløb

1. Du bad om "et overblik over hvordan denne monkey kommer til at se ud" — jeg vidste ikke hvad "monkey" refererede til.
2. Du sagde "se office monkey" — jeg ledte lokalt under `/Users/gl/` og fandt intet.
3. Du klargjorde repoet hedder `Agent360dk/monkey-office`. Klonet til `/tmp/monkey-office`.
4. Læste alle design-docs og skrev denne destillation.
5. Push til eksisterende `gustav-chat-noter` branch (ovenpå tidligere noter fra dagen).
