# Office Monkey — Aben

3D-printet Bojesen-tribute-abe der lytter til kontorets støj og **dækker sin egen mund** ("Tys-aben", Iwazaru-tribute) når det bliver for højt for længe — en stille social-signal til rummet om at tale lavere.

**Status (2026-05-23):** V1.1 fuldt klar til print + samling. 17 STL'er (15 wall body + 2 hub) watertight ✓. Firmware-skellet skrevet. Komplet samlings-guide. Nul fysiske aber bygget endnu, nul betalende kunder.

---

## Hvor er hvad?

### [`product/`](product/) — forretning
| Fil | Indhold |
|---|---|
| [plan.md](product/plan.md) | Fase 1/2 plan, låst produkt-definition, åbne spørgsmål |
| [research.md](product/research.md) | Business outcome research (~25 kilder, 5 hovedtal) |
| [usps.md](product/usps.md) | 5 rangerede USP'er til pitch |
| [sales-strategy.md](product/sales-strategy.md) | 12-ugers 0-til-30-kunder plan |

### [`design/`](design/) — visuelt & industrielt
| Fil | Indhold |
|---|---|
| [brief.md](design/brief.md) | Industrial design brief (Bojesen-tribute) |
| [critique.md](design/critique.md) | Ærlig vurdering: V0.2 → generationelt design |
| [visual-overview.md](design/visual-overview.md) | Destilleret visuelt overblik (TL;DR) |
| [image-spec.md](design/image-spec.md) | GPT Image 2 prompt-kanon |

### [`hardware/`](hardware/) — print & elektronik
| Fil | Indhold |
|---|---|
| [PRINT.md](hardware/PRINT.md) | Bambu Lab print-guide, settings, BOM |
| [ASSEMBLY.md](hardware/ASSEMBLY.md) | Komplet samlings-guide trin-for-trin |
| [dev-brief.md](hardware/dev-brief.md) | Firmware/hardware dev-handoff |
| [wall-variant.md](hardware/wall-variant.md) | V1.1-wall (6-timers print) |
| [components/](hardware/components/) | Reference-STL'er for hardware-komponenter |

### [`firmware/`](firmware/) — Arduino-ESP32 sketch
| Fil | Indhold |
|---|---|
| [tys-aben.ino](firmware/tys-aben.ino) | I2S mic + servo control + state machine |
| [README.md](firmware/README.md) | Build/upload + tuning-guide |

### Tekniske assets
- [`cad/`](cad/) — OpenSCAD parametric source (`monkey.scad`, `monkey-wall.scad`, `hub.scad`)
- [`stl/`](stl/) — desktop variant STLs; [`stl/wall/`](stl/wall/) — wall variant (15 parts); [`stl/hub/`](stl/hub/) — external hub (2 parts)
- **[`stl/tys-aben-wall-complete.stl`](stl/tys-aben-wall-complete.stl)** — all 17 wall+hub parts on ONE plate, ready to slice & print
- **[`stl/tys-aben-desktop-complete.stl`](stl/tys-aben-desktop-complete.stl)** — all 13 desktop parts on ONE plate, ready to slice & print
- [`prints/`](prints/) — Bambu Studio project files (`.3mf`)
- [`design/cad-atech-prompt.md`](design/cad-atech-prompt.md) — hyper-detailed prompt for AI-CAD tools

### [`chat-notes/`](chat-notes/) — historiske chat-sessioner
- [2026-05-23-sessions.md](chat-notes/2026-05-23-sessions.md) — visual design + business research sessions

---

## Hurtigt at komme i gang

**Vil du printe + samle?**
- **Hurtigste vej:** download én komplet print-file og åbn i Bambu Studio:
  - **Wall variant (anbefalet):** [stl/tys-aben-wall-complete.stl](stl/tys-aben-wall-complete.stl) — 17 parts, ~64g, ~6h print, hænger på væg
  - **Desktop variant:** [stl/tys-aben-desktop-complete.stl](stl/tys-aben-desktop-complete.stl) — 13 parts, ~167g, ~21h print, står på rektangulær base
- Læs derefter [hardware/PRINT.md](hardware/PRINT.md) for slicer-settings + [hardware/ASSEMBLY.md](hardware/ASSEMBLY.md) for samling

**Vil du flashe firmware?** Læs [firmware/README.md](firmware/README.md), åbn [firmware/tys-aben.ino](firmware/tys-aben.ino) i Arduino IDE.

**Vil du sælge?** Læs [product/usps.md](product/usps.md) + [product/sales-strategy.md](product/sales-strategy.md).

**Vil du forstå hvordan den ser ud?** Læs [design/visual-overview.md](design/visual-overview.md).
