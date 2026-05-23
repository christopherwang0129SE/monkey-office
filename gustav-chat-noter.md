# Chat-noter — 2026-05-23

Noter fra chat-session om visuel design af noise-monkey produktet.

## Spørgsmål fra Gustav

> "Kan du se planning for the office monkey hvordan den skal være? Skal vi prøve at lave et billede af den med nano banana for at backward-engineere?"

## Hvad findes (kortlagt i chatten)

Planning ligger i `agent360-jesperai/agent360/docs/planning/`:

- `2026-05-23-product-plan.md` — koncept låst: 3D-printet desk-abe, hænder-over-mund når dB-tærskel brydes, solgt per-desk/per-zone + dB-dashboard
- `2026-05-23-noise-monkey-research.md` — business outcome research (66% produktivitetstab, 86 min/dag, 23 min refokus, etc.)
- `2026-05-23-noise-monkey-killer-usps-deck.md` — USP-deck
- `2026-05-23-noise-monkey-sales-strategy.md` — sales-strategi
- `2026-05-23-competitor-research-and-usp.md` — konkurrent-research

I dette repo (`office-monkey-hackaton`):
- `Mokey-product-plan.md`, `Research.md`, `PRINT.md`, `design-v1.md`, `design-critique.md`
- `cad/`, `stl/`, `prints/`

## Gap

**Visuel / industriel design-spec eksisterer ikke endnu.** Fase 1 "Product design" i `product-plan.md:21` er stadig uafkrydset. Vi har funktionel beskrivelse, men ingen "sådan skal den se ud"-dokument.

## Beslutning

Brug **nano banana** (Google Gemini 2.5 Flash Image i AI Studio) til at backward-engineere den visuelle identitet:
generer billede først → afled 3D-printbar spec, kulturel-fit-beslutning (åbent spørgsmål i `product-plan.md:54`), og cold-call collateral derfra. Billigere end design-loops.

## Starter-prompt til nano banana

```
A small 3D-printed desk figurine of a stylized monkey, sitting on a modern
office desk next to a laptop and coffee cup. The monkey is in a clear
"hands-over-mouth" pose — both palms pressed firmly over its mouth, eyes
wide, slightly embarrassed expression. Matte finish, single-color resin
(warm off-white), roughly 8-10cm tall. Clean low-poly aesthetic suitable
for a Scandinavian office (think Hay / Muuto desk accessories — not toy,
not childish). A subtle dB-sensor microphone-grille on the chest, almost
hidden. Soft daylight from a window, shallow depth of field, product-shot
style. No text, no logos.
```

## Foreslåede næste skridt

1. Skriv 3-4 prompt-varianter (Scandi / japansk kawaii / brutalist / plush-toy) til A/B i nano banana
2. Lav design-spec doc (`2026-05-23-noise-monkey-design-spec.md`) som placeholder der udfyldes når valgt billede er låst
3. Afklar åbne spørgsmål i `product-plan.md:50-54` — særligt kulturel fit af "hænder-over-mund" gesten (DE/FR/US/JP)

## Status

Ingen kode ændret. Ingen filer skrevet udover denne note. Næste handling = generer billeder med nano banana.
