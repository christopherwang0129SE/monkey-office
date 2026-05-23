# Competitor Research & USP Sharpening — 2026-05-23

**Status:** Source-of-truth synthesis. Closes Fase 1 task "Research USP → turn into a sales weapon" from [`2026-05-23-product-plan.md`](2026-05-23-product-plan.md).
**Owner:** Gustav.
**Source files** (raw, deeper detail): see Appendix.

---

## Executive summary — the five things to act on

1. **There is a real Agent360-shaped hole in the Nordic market.** No global player (Lindy, Make, Zapier, n8n, Relevance, Gumloop) ships native connectors to e-conomic, Dinero, Billy, Pleo, Fortnox, Visma — and no Nordic boutique (Webia, syv.ai, AI-Konsulenterne, Snilld, AICE) ships a productized SaaS-priced platform. Webia is closest but sells 67,500–115,000 DKK fixed-price MVPs on Business Central / SAP, not e-conomic. **This window closes when Visma group ships its cross-property agent layer — public 2026 strategy makes this a 12–18 month threat.**

2. **The single highest-leverage move is a "Connect [Tool A] to [Tool B]" page generator in Danish.** Zapier built a $5B business off ~50,000 such pages (60% of their traffic). n8n has 9,751, Make has 8,200. **Zero competition in Danish.** Target: 450 pages (top 30 tools × top 15 paired apps). Compound long-tail SEO with near-zero marginal content cost.

3. **The Lovable/Bolt "live prompt box in hero" mechanic has replaced "Sign up for free demo" as the dominant 2026 onboarding pattern.** Agent360's homepage already has the typing animation in `Hero.tsx` — turning it into a *live, working prompt input* (not just animation) is the single highest-conversion landing-page change available.

4. **JesperAI's clearest open lane is "Den danske AI-sælger" — outbound B2B cold-call SDR positioning, in Danish, with Datatilsynet-aligned GDPR.** CleverCall owns inbound receptionist + public sector. Cendo owns service-booking. Autoflows owns automotive. No one owns outbound sales-rep-as-a-service in Danish. Retell shipped Danish in 2026 (so the language moat alone is thinning) — the defensible wedge is **Danish + DK GDPR + outbound SDR motion + bundled with Agent360 platform**.

5. **Pricing positioning: flat DKK/mo, sub-300 DKK entry, "no surprise bills" framing.** Every credit/per-minute model in this category gets user-rage reviews (Lindy credits, Make.com Operations→Credits, Zapier tasks, Bland's $299–499 platform fee). Sub-$25 USD is the SMB winning zone (Make $9, Bardeen $10, MindStudio $20, Zapier $19.99). Lindy at $49.99 is the outlier. Flat-rate + transparent + DKK + Danish is real differentiation.

---

## The three USPs Agent360 should own

Each USP is positioned, sourced from research, and given a one-line "sales weapon" formulation a cold-caller can lead with.

### USP 1: "Made for Nordic business. By default."

**The claim:** Agent360 is the only productized AI automation platform with first-party connectors to the Nordic SaaS stack — e-conomic, Dinero, Billy, Pleo, Visma, Fortnox, Lønadministration, Bokio — built in from day one, not duct-taped via HTTP nodes.

**Why it's defensible:** Zero global competitor has any of these. Zapier shows some shallow Visma/Fortnox; Make has none. Webia (Aalborg) targets Business Central/SAP, not e-conomic. Boutique consultancies don't productize integrations. **Every new Nordic connector compounds the moat** — global players will never bother to build them.

**Sales weapon:** *"I bruger e-conomic, ikke QuickBooks. Vi byggede platformen til dig — ikke til Y Combinator-batchen i San Francisco."*

**Verification:** Confirmed in all 4 research streams (global, voice, Nordic, GTM). Not a single competitor lists Nordic accounting natively. Dinero is currently *educating the market* on AI agents — Agent360 can out-publish them on their own keywords.

---

### USP 2: "Skriv én prompt. Få et team — i chat, mail, og telefon."

**The claim:** Agent360 + JesperAI is the only product where one prompt builds both a backend automation *and* a voice-callable agent. Every competitor has either chat-to-automation (Lindy, MindStudio, Relevance) *or* voice (Bland, Vapi, Retell, Synthflow), never both natively.

**Why it's defensible:** Bardeen's Magic Box is browser-tied (chat-to-automation only). Lindy has "added-on" voice that requires separate Twilio plumbing. Vapi/Bland/Retell are voice-only infra without integration breadth. **The bundle is product, not feature** — JesperAI standalone vs. JesperAI-in-Agent360 = upsell ladder no US competitor can match.

**Sales weapon:** *"Beskriv jeres salgsproces én gang. Vi bygger CRM-logikken, faktura-flowet — og giver dig en AI-sælger der ringer leads samme dag."*

**Verification:** Global research confirms zero overlap (chat platforms vs. voice platforms are distinct vendors). Voice research confirms no voice vendor has Agent360's integration breadth. The cross-sell ladder is uniquely available.

---

### USP 3: "Det er dine flows. Du tager dem med dig."

**The claim:** Agent360 is anti-lock-in for Nordic SMBs. Portable agents, exportable workflows, BYO API keys, EU-only hosting, optionally self-hostable. Zapier's "AI automation, governed" tagline *governs for you*; Relevance/Stack AI/Sema4 wrap you in enterprise lock-in.

**Why it's defensible:** Agent360's own positioning ("laget der binder dem sammen — og som I ejer selv") already says this. Pair with:
- **EU-only data residency** with named DK/EU hosting (Hetzner Falkenstein / Scaleway / DO Frankfurt) + public sub-processor list
- **Datatilsynet/Danish DPA-aligned DPA template** downloadable from site
- **AI Act Article-50 transparency notice template** (be first DK voice-AI to publish one)
- **BYO API key option** (Lindy/Gumloop/Vapi/Synthflow all offer this — it's the trust signal that converts skeptical buyers)

**Sales weapon:** *"Jeres data forlader aldrig EU. Jeres flows kan eksporteres. Jeres API-keys er jeres egne. Hvis I vil væk fra os i morgen — så kan I."*

**Verification:** Webia owns "Danish servers, no US/UK transfer" loudest in the SMV segment. Netcompany owns "European sovereignty" for public sector. Microsoft will increasingly capture this for enterprise post-Denmark East datacenter (March 2026). **Agent360 cannot win on sovereignty alone — must combine with integration breadth + SaaS pricing.** But sovereignty is table stakes — *not* publishing it is a deal-killer for procurement-conscious DK SMBs.

---

## Competitive landscape — one-page map

### Tier 1: Direct global platform competitors (chat-to-automation / AI agents)

| Player | Type | Entry $/mo | Killer feature | Why Agent360 wins |
|---|---|---|---|---|
| **Lindy.ai** | AI employee per seat | $49.99 | iMessage delegation, persona-templates | No Nordic accounting, $49 entry too high |
| **Relevance AI** | Enterprise agent platform | Sales-only | Bosh named-agent BDR | Enterprise-only, English-only, SMB hostile |
| **Gumloop** | Visual workflow + AI | $37 | Multi-model, Gumstack Gateway | Visual builder not chat-first, no Nordic |
| **Stack AI** | Enterprise compliance | Custom | HIPAA/SOC2/ISO27001 basket | Free→Enterprise gap, no Nordic, no SMB |
| **n8n** | OSS workflow for devs | €20 | 8,300+ templates, self-host | "For technical teams" — non-devs bounce |
| **Make.com** | Visual SMB | $9 | 3,000+ apps, EU hosting | Credit/Ops pricing rage, no Nordic depth |
| **Zapier + Agents** | The OG, 9,000+ apps | $19.99 / Agents $33.33 | Integration empire | Task-pricing balloons, English, generic |
| **Sema4.ai** | Enterprise (Robocorp) | ~$15/agent/day | Document Intelligence, MCP | Python-first, Snowflake-anchored |
| **MindStudio** | No-code AI builder | $20 | 200+ models, weekly workshops | Bridged integrations, English-only |
| **Bardeen** | GTM-prospecting browser | $10 | Magic Box (chat-to-automation) | Browser-tied, GTM-only, no Nordic |

### Tier 2: Direct voice AI competitors (JesperAI's space)

| Player | Type | Pricing | Danish? | Why JesperAI wins |
|---|---|---|---|---|
| **Bland.ai** | Enterprise infra | $0.11–$0.14/min + $299–499 plat | No DK pos | DK SMB can't afford platform fee |
| **Vapi** | Dev infra | $0.05/min orch + pass-through | Via ElevenLabs only | BYO-everything = friction for sales mgrs |
| **Retell** | Sales/CS infra | $0.07–$0.31/min | **Shipped 2026** | No DK pos, no DK case studies, no DPA |
| **Synthflow** | No-code enterprise | $0.15–$0.24/min | Unproven Nordic quality | White-label $2K/mo is too rich for DK |
| **Air.ai** | DEAD — FTC settled Mar 2026 | n/a | n/a | Use as cautionary tale "why not US" |
| **ElevenLabs Agents** | Voice quality king | $0.08–$0.12/min | **Best DK TTS** | Infra only — no CRM, no flow builder. **Partner not compete** |
| **Phonely** | SMB inbound | ~$0.05–$0.10/min | Via models | Inbound-first DNA, weak on outbound |
| **PolyAI** | Enterprise | ~$150K/yr | **Yes (DK/SE/NO/FI/IS)** | Six-figure contracts, 4-wk deployment |
| **CleverCall (DK)** | Public + inbound | €200–530/mo | Yes, first-class | Owns inbound + public sector — **doesn't own outbound SDR** |
| **Cendo (DK)** | Service-booking | Quote | Yes | Vertical-locked (automotive/service) |
| **Autocalls.ai (DK voices)** | General | Quote | Yes (12 voices) | No-code, no specific outbound positioning |
| **Autoflows (EU)** | Automotive vertical | Quote | Yes (DK voice "Sissel") | Locked to automotive |
| **Brightcall.ai (SE)** | Outbound sales | Quote | Swedish-primary | **Closest threat** — English-primary mktg leaves DK open |
| **Telavox AI (SE/NO)** | Telco-bundled | Bundled w/ PBX | Yes | Inbound only — but distribution threat if bundles AI into DK SMB phone plans |

### Tier 3: Nordic boutique consultancies (delivery-partner material, not competitors)

Webia (Aalborg, 67.5–115k DKK MVP, BC/SAP focus) · syv.ai (CPH, DanskGPT, enterprise) · AI-Konsulenterne (SMV-focused, no productization) · Snilld (training-led, EU AI Act framing) · AICE (advisors/agencies vertical) · AI-Agenten (keynote brand) · Combine · Kvalifik · Better Developers · NobleProg DK · DataFix · Northfive (new 2026, sovereignty-positioned, ex-Devoteam)

### Tier 4: Big-4 / SI tier (parallel universe — complementary or referrers)

Capgemini DK · NNIT (Alera, Lumina) · Devoteam (AI Agent Lab CPH) · BDO · EY DK · Sopra Steria · PwC DK · Implement · KMD+Netcompany · Aeven · Atea · Pioneer AI

### Tier 5: Nordic SaaS adding agent features (the existential threats)

| Player | Threat level | Why |
|---|---|---|
| **Visma group** (owns e-conomic) | 🔴 **Highest** | Public 2026 strategy = "move all products to agentic experiences." 12–18 month window. |
| **Pleo** | 🟡 Watch | Sells "automation" hard, avoids "agent" framing. Stays inside expense lane — for now. |
| **Dixa (Mim)** | 🟢 Vertical | Owns CS vertical only |
| **Templafy (Document Agents)** | 🟢 Vertical | Owns compliance-doc generation only |
| **HubSpot Breeze in DK** | 🟢 Channel-limited | DK Platinum Partners (Avidly, Obsidian, MCB, Radiant) push it but most DK SMBs aren't HubSpot |
| **Salesforce Agentforce in DK** | 🟢 Enterprise-only | Outside Agent360 SMV target |
| **Microsoft Copilot Studio in DK** | 🟡 Enterprise threat | DK East datacenter (Mar 2026) = sovereignty narrative captured for enterprise |
| **Pipedrive AI** | 🟡 Sales-vertical | Estonian, big in Nordic, hiring "Principal PM Agentic" — collision risk if Agent360 plays in sales |
| **Spektr** | 🟡 Watch | DK no-code AI Agent Builder for compliance flows. Closest "agent builder" narrative locally. |
| **Go Autonomous** | 🟡 Watch | Unstructured data → ERP/CRM actions. Direct adjacent. |

---

## Pricing benchmark — where Agent360 should land

### Platform pricing (chat-to-automation)

| Tier | Range | Examples | Agent360 recommendation |
|---|---|---|---|
| Free | Credit-reset, no CC | Lindy 400, Gumloop 2k, Make 1k, n8n 200 (or self-host unlim) | **5,000 credits/mo, no CC, BYO API key option** |
| SMB entry | $9–$20 | Make $9, Bardeen $10, Zapier $19.99, MindStudio $20 | **DKK 149/mo (~$22)** — match band, premium-feel-cheap |
| Pro/team | $29–$50 | Gumloop $37, Make Teams $29, Bardeen $50 | **DKK 449/mo (~$65)** — undercut Lindy's $49.99 in USD-perception, premium in DKK |
| Enterprise | "Custom" | Universal | **Custom — never publish** |

### Voice pricing (JesperAI)

| Model | Used by | Pros | Cons | JesperAI fit |
|---|---|---|---|---|
| Pure per-minute | Vapi, Retell | Aligned with cost | Unpredictable bills, user rage | Avoid |
| Per-min + platform fee | Bland ($299–499) | Predictable infra cost | DK SMBs reject | **Strong avoid** |
| Flat monthly | CleverCall (€200–530) | Predictable, DK-pragmatic | Caps usage | **Win here** |
| Hybrid: flat + free-minutes | Phonely (500 min free), Retell ($10 credit) | Onboards new users | Mid-complexity | **Combine: flat DKK + first 200–500 min free** |

**Recommendation:** Flat DKK monthly tiers with first 200–500 minutes free, no per-minute roulette, "Fast pris i DKK. Ingen overraskelser. Ingen pass-through." This is the strongest possible counter to the entire US voice-AI category.

---

## The five GTM tactics to steal immediately

Ranked by `effort × impact` for solo-Gustav. Detailed Month-by-month plan below.

### 1. Live prompt box in hero (replacing the typing animation) — `effort 2, impact 5`

The Lovable/Bolt/Lindy mechanic. The homepage IS the product. Your current `Hero.tsx` already has the typing animation with prompt suggestions ("Byg mig et CRM der ringer leads automatisk", etc.) — convert it from animation to **working input**: the user types, sees a live preview of what would get built, hits "Byg det" → soft-paywall at "save/deploy" step. Highest single-change conversion lift in the 2026 category.

### 2. Programmatic SEO: "Forbind [A] til [B]" page generator in Danish — `effort 3, impact 5`

Zapier's $5B mechanic. ~450 pages: top 30 Danish-relevant tools (e-conomic, Dinero, Billy, Pleo, Lunar Erhverv, TimeLog, Planday, M365, Gmail, Slack, Pipedrive, HubSpot, Salesforce, Holded, Calendly, Cal.com, Stripe, Shopify, Mailchimp, Klaviyo, etc.) × top 15 paired apps. Mirror n8n URL: `/integrationer/[app1]/og/[app2]/`. **Zero Danish competition; SEO whitespace on "AI agent e-conomic", "automatisering Dinero Pleo", "AI til danske SMV bogføring".**

### 3. Template gallery + "Bliv Template Creator" program — `effort 3, impact 5`

20 hand-built templates at launch with **persona-named agents** (Bosh/Magic Box/Sissel mechanic). Don't ship "invoice automation" — ship *"Jesper bogholderen"*, *"Anna e-conomic-koncierge"*, *"Lars Stripe-afstemningen"*. Each template page = landing page = SEO real estate. Open community submissions at month 3 — n8n got 9,751 templates this way at zero marginal content cost. URL: `/skabeloner/[kategori]/[slug]`.

### 4. Founder-led X build-in-public + Danish LinkedIn — `effort 1, impact 4`

Flo Crivello (Lindy CEO) repositioned publicly from "AI employee" → "Zapier of AI" → grew 5.5x to high-7-figure ARR. Cost: $0. Daily-ish posts: shipped X, learned Y, screenshot, ARR. English for category reach, Danish for local SEO. Crucially: **pivot narrative repositioning in public**. (Note: even if "platform" is officially parked in code per [`v0.1-services-plan.md`](v0.1-services-plan.md), the *narrative* still says platform — this is investor-pitch fuel, not lying.)

### 5. Cal.com inline embed everywhere + "Fast pris i DKK" pricing badge — `effort 1, impact 3`

Replace every "kontakt os" with inline Cal.com (`cal.com/agent360/intro`), prefill via UTM. Plus add a "Fast pris i DKK — ingen overraskelser" badge next to the free CTA. Universal-pattern among credit-tier platforms is "No credit card required" — Agent360's twist is the *anti-credit-rage* angle, which is sharper because every competitor in this category has user-rage reviews about unpredictable bills.

### Honorable mentions (also steal)

- **Free Nordic Academy + certification** (Make Academy is the asymmetric weapon in this category — creates evangelist army)
- **Changelog page + RSS** (Linear/Vercel: ships 4–8 entries/week, the changelog IS the newsletter)
- **Quantified customer-logo wall with DKK outcomes** ("Sparer 40 timer/uge", "200k DKK i automatiseret faktura-flow")
- **Comparison/alternative SEO pages** in Danish (own `/sammenligning/zapier-alternativ`, `/sammenligning/make-alternativ`, `/sammenligning/n8n-dansk`)
- **Phone-in-browser live demo** for JesperAI ("Tal med Jesper lige nu på dansk" — Synthflow/Retell/Vapi pattern, none ship it in Danish)

---

## The deepest threats and how to neutralize each

### Threat 1: Visma group ships cross-property agent layer in 12–18 months

**Why it's the existential threat:** Visma owns e-conomic, plus other Nordic accounting/HR/payroll. Public 2026 strategy explicitly = "move products from traditional UI to intelligent, agentic experiences." Rasmus Bendtsen leads AI Native Workforce Transformation. If Visma ships, they smother third-party SMV automation platforms with native distribution.

**Neutralization:**
- **Ship integration depth and customer love faster than Visma's roadmap.** Visma is a slow corporate; you're a solo founder shipping daily.
- **Pursue e-conomic App Marketplace listing as priority-one distribution.** Once you're in their marketplace, customer acquisition cost ~ €0 and Visma can't easily de-list you.
- **Build cross-Nordic-platform connectors Visma won't.** A flow that touches e-conomic *and* Dinero *and* Pleo *and* Pipedrive in one agent is inherently cross-vendor — Visma will never build that.
- **Lock in 100+ paying customers in the next 12 months** so even if Visma launches, the cost of switching is real.

### Threat 2: Retell (and others) shipping Danish

Retell shipped Danish in 2026. Vapi/Synthflow/Phonely/ElevenLabs all *technically* support Danish via underlying models. The language moat alone is thinning.

**Neutralization:**
- **Compete on Danish-tuned quality**, not "has Danish." Nordic compound-word/declension issues are real on general platforms.
- **Compete on DK GTM motion** — Danish-language sales pages, Danish case studies with DKK numbers, Danish phone numbers, Danish DPA template.
- **Compete on GDPR-as-positioning** — none of the US players publish ISAE/Datatilsynet alignment.
- **Compete on bundling** — JesperAI inside Agent360 is something no voice-only vendor can match.

### Threat 3: Microsoft Copilot Studio (post-DK East datacenter)

Microsoft opened Denmark East (Høje Taastrup/Køge/Roskilde) in March 2026. They will increasingly own the "Danish AI sovereignty" narrative for enterprise — Devoteam, Capgemini, KMD, Netcompany all push it. Plus Wave 1 2026 release added "agent governance, intelligent workflows."

**Neutralization:**
- **Don't compete on sovereignty alone** — Webia owns the SMV sovereignty narrative, Microsoft will own enterprise. Agent360 differentiates on *integration breadth × productized SaaS pricing × SMV target*.
- **DK SMBs not in M365 are largely outside MS reach** — that's most of Agent360's TAM.
- **Position MS as a peer integration**, not a competitor: "Forbind Microsoft Copilot til e-conomic via Agent360."

### Threat 4: Brightcall (Stockholm) — closest Nordic outbound-voice competitor

Founded 2018, real estate + sales teams, Nordic CRM integrations (Upsales, Lime), Speed-To-Lead 1-min response, Multi-Line Dialer 100 calls/hr. Most directly comparable to JesperAI.

**Neutralization:**
- Brightcall is English-primary marketing — Danish landing pages and DK case studies leave them flat-footed.
- JesperAI bundled in Agent360 is a product Brightcall doesn't have.
- DPA-aligned GDPR — Brightcall doesn't publish a Danish DPA template.

### Threat 5: CleverCall (Copenhagen) — DK direct competitor

EU's largest voice-assistant supplier claim, 15+ DK municipalities, ISAE 3000 GDPR audit, 40+ languages, €200–530/mo flat pricing, public-sector + inbound focus.

**Neutralization:**
- They own inbound receptionist + public sector. **JesperAI owns outbound B2B sales-rep-as-a-service.** Plant the flag.
- Their pricing model (flat €/mo) is actually validation of the flat-DKK-monthly strategy — copy it.
- For accounts where CleverCall is already in place doing inbound, JesperAI can sell *outbound as add-on* without competing for the same workload.

---

## 90-day execution plan

### Month 1 (Jun 2026) — Programmatic foundation

**Landing-page changes:**
- [ ] Convert `Hero.tsx` typing animation to live working prompt input with preview
- [ ] Add "Fast pris i DKK — ingen overraskelser" badge to pricing
- [ ] Add integration logo strip (22 logos) to homepage
- [ ] Inline Cal.com embed replacing all "kontakt" CTAs
- [ ] "No credit card required" badge on free CTA

**Programmatic SEO:**
- [ ] Build template gallery infrastructure: `/skabeloner/[kategori]/[slug]`
- [ ] Hand-build 20 templates with persona-named agents (Jesper bogholderen, Anna e-conomic-koncierge, Lars Stripe-afstemningen, Mette inbound, etc.)
- [ ] Generate first 50 "Forbind X til Y" pages (top 10 DK tools × top 5 categories)
- [ ] Set up Plausible analytics, Loops email, Loom for demos, Arcade free tier for interactive tour

**Content:**
- [ ] Start daily Danish-language LinkedIn build-in-public + English X presence
- [ ] Write 4 "Sådan automatiserer du [task] i din danske virksomhed" long-form blogs

### Month 2 (Jul 2026) — Community + Voice demo

**Voice:**
- [ ] Ship "Tal med Jesper lige nu på dansk" browser demo (WebRTC mic-permission call) on JesperAI page — Synthflow/Retell pattern, none in Danish
- [ ] Publish Danish DPA template + sub-processor list + AI Act Article-50 transparency notice
- [ ] Provision DK Twilio numbers for trial users
- [ ] Ship in-call GDPR consent flow (steal Autoflows pattern): "Denne samtale optages med kunstig intelligens. Tryk 1 for at acceptere."

**Community:**
- [ ] Launch "Bliv Template Creator" page — let power users submit templates with attribution
- [ ] Ship Discord/Slack community (seed with first 20 invites from email list)
- [ ] Ship `/changelog` page + RSS — 2 entries/week minimum

**Distribution:**
- [ ] Submit to e-conomic App Marketplace (priority-1 distribution channel)
- [ ] Submit to Dinero / Billy / Pleo marketplaces if they have them
- [ ] Publish 2 Danish "Agent360 vs [competitor]" comparison pages

### Month 3 (Aug 2026) — Distribution flywheel + TechBBQ

**Distribution:**
- [ ] Attend TechBBQ + European AI Summit (26–27 Aug, Bella Center) — must-attend
- [ ] Reach out to top 5 Danish SMV YouTubers / LinkedIn voices — free Pro accounts + co-create tutorial
- [ ] Submit to Product Hunt with launch coordination
- [ ] Submit to OpenStartup.dk, Trustpilot SaaS, Danish startup directories
- [ ] Sponsor 1 Danish founder newsletter (~$200–500) — first paid distribution test

**Original research moat:**
- [ ] Launch "State of AI in Danish SMVs: Bogføring & automatisering 2026" survey
- [ ] Publish report = link-bait for backlinks (slots into Wolters Kluwer / CAISA / Dansk Erhverv pattern)

**Voice GTM:**
- [ ] Land first 2 paying JesperAI standalone customers (target: small DK sales teams, 5–20 ppl)
- [ ] Get first Danish case study with named DKK numbers ("Lukker 30% flere kundeemner", "200k DKK i automatiseret faktura-flow")

---

## Bootstrapped tool stack (under $60/mo total)

| Function | Tool | Cost |
|---|---|---|
| Email (marketing + transactional) | Loops.so | Free → $49 |
| Analytics | Plausible (or PostHog free) | $9 / free |
| Booking | Cal.com | Free |
| Async video demos | Loom | Free (25 vids, 5 min) |
| Interactive product tour | Arcade | Free (3 Arcades) |
| Changelog | Self-built page + RSS | $0 |
| CRM for manual outbound | Attio free / Notion DB | $0 |
| Status page | Instatus free | $0 |
| Docs site | Mintlify free | $0 |

**Total: $9–60/mo for a complete SaaS GTM stack.**

---

## What was deliberately NOT covered (and why)

- **ForbrugerAgenten / FA partner-dashboard competitors** (Pricerunner, Bilka-app, ShopBack, Honey, Rakuten, Klarna deals, Coop365). The active V0.1 deliverable per [`v0.1-services-plan.md`](v0.1-services-plan.md) includes the partner-dashboard, but this research is about the *Agent360 platform positioning* per the 2026-05-23 product plan brief. FA-side competitor research is a separate document if needed.
- **Enterprise/services-page consulting competitors** (Implement, Devoteam, Capgemini AI consulting). Covered briefly in the Nordic deep-dive (Big-4 / SI tier) as complementary — they sell hours, Agent360 sells product. Not directly competitive in V0.1 services positioning, which is pull-only.
- **App-builder competitors** (Lovable, Bolt, Replit Agent, Manus, Cursor, Claude Code). These are *one-shot app generators*, not connected ongoing automation layers. Different product category. Their **GTM mechanics** (live prompt box, daily-reset free tier) are stolen above; their feature set is not competitive overlap.

---

## Appendix — full source reports

The detailed research is in four separate files (~9,000 words total) at:

- [`/tmp/competitor-research-global-platforms.md`](file:///tmp/competitor-research-global-platforms.md) — 10 global platform deep-dives with verbatim taglines, full pricing tiers, GTM weapons, exploit angles (~4,500 words)
- [`/tmp/competitor-research-voice-ai.md`](file:///tmp/competitor-research-voice-ai.md) — 9 voice-AI competitors + Nordic voice landscape + GDPR positioning + browser-demo pattern (~2,400 words)
- [`/tmp/competitor-research-nordic.md`](file:///tmp/competitor-research-nordic.md) — Nordic boutiques, Big-4 SIs, first-party Nordic SaaS threats (Visma group), DK SEO whitespace, event calendar (~1,950 words)
- [`/tmp/competitor-research-gtm-playbooks.md`](file:///tmp/competitor-research-gtm-playbooks.md) — GTM mechanics deep-dive: onboarding flows, template flywheels, integration SEO, pricing tactics, build-in-public, changelog-as-marketing, bootstrapped tool stack (~2,800 words)

**Recommendation:** Move these into `agent360/docs/planning/competitor-research/` if you want them version-controlled with the master plan. Currently they live in `/tmp` and will be cleaned by the OS.

---

## Sign-off

This document closes the "Research USP → turn into a sales weapon" deliverable from Fase 1 of [`2026-05-23-product-plan.md`](2026-05-23-product-plan.md). The three USPs above are ready to lead cold-calls with. The 90-day plan above is ready to start Monday.

Next plan-side deliverables outstanding from the 2026-05-23 brief:
- **Business outcome research facts** (owner: Benjamin) — TBD
- **Pure product plan** (owner: Gustav) — TBD; should now incorporate the USP framing above
- **Open questions resolution**: 3D printer literal/figurative, "cold office" role definition, LinkedIn outreach in/out
