---
title: "2008"
---

How a housing bubble brought down the global financial system.

---

## 1. What is an MBS?

Banks used to give out mortgages and hold them for 30 years — tying up capital. Securitization changed that.

```
Bank bundles 1,000 mortgages ($300M total)
→ Sells "slices" of that pool to investors as bonds (MBS)
→ Bank gets $300M back immediately
→ Investors earn monthly mortgage payments
```

The bank offloaded the risk. Investors became the de facto lender. This is called the **originate-to-distribute model** — and it destroyed the bank's incentive to care about loan quality, since they got paid on volume and immediately sold off the risk.

---

## 2. CDOs and the Tranche System

MBS pools were further sliced into **Collateralized Debt Obligations (CDOs)** by risk level:

```
Senior tranche  (AAA) → paid first, lowest yield
Mezzanine tranche (BBB) → paid second
Equity tranche  (junk) → paid last, first to absorb losses
```

Rating agencies blessed senior tranches as AAA — as safe as US government debt. The logic: even if some mortgages default, losses hit bottom tranches first and senior tranches stay protected.

This logic was wrong.

They also created **CDO²** — repackaging the hard-to-sell mezzanine tranches into _new_ CDOs. Nobody knew what was inside these things anymore.

---

## 3. The ARM Time Bomb

Most subprime borrowers had **Adjustable Rate Mortgages (ARMs)** — a low teaser rate for 2 years, then a sharp reset:

```
Years 1-2:  pay 4% teaser rate → $1,200/month
Year 3+:    resets to 9% market rate → $2,400/month
```

Most borrowers couldn't afford the reset. The plan was never to pay it — the plan was to **refinance into a new teaser rate** before the reset hit.

Refinancing requires equity. Equity requires rising prices. The entire model depended on housing prices going up forever.

---

## 4. Why People Defaulted When Prices Fell

Two simultaneous forces drove defaults:

**Force 1 — The ARM trap (can't pay)**

```
Prices stop rising
→ Can't refinance out of ARM reset
→ Monthly payments double
→ Can't afford payments → DEFAULT
```

**Force 2 — Strategic default (won't pay)**

```
House bought at $300k, now worth $200k
You owe more than the house is worth ("underwater")
→ Rational to just walk away
```

People also did **cash-out refinancing** on the way up — extracting home equity as cash. This meant when prices fell even slightly, many were immediately deep underwater.

```
House worth $400k → cash-out refi → now owe $350k
Prices drop 20% → house worth $320k
You're $30k underwater immediately → walk away
```

---

## 5. Why the Ratings Were Wrong

CDO models assumed regional housing markets were uncorrelated — if Florida crashed, California would be fine. Diversification would protect senior tranches.

But this was a **coordinated nationwide bubble**. When it popped, defaults rose everywhere simultaneously. Losses were so large they wiped through all tranches — including the "safe" AAA ones.

---

## 6. AIG and Credit Default Swaps

AIG sold insurance on CDOs called **Credit Default Swaps (CDS)**. If a CDO defaulted, AIG would pay out.

AIG wrote hundreds of billions in CDS with no reserves — treating it as free money since "housing never crashes nationally." When it did, AIG faced catastrophic losses and required a **$180B government bailout**.

---

## 7. How It Became a System-Wide Crisis

### The repo market freeze

Banks were using MBS as collateral in overnight repo loans. When MBS values became uncertain, banks stopped trusting each other's collateral. Nobody knew who was holding how much toxic debt.

```
Normal:  Bank A posts MBS as collateral → gets overnight loan ✓
Crisis:  "Is that MBS worth $1B or $600M?"
         "I don't know who's solvent"
         → Banks stop lending to each other
```

Banks couldn't value each other's portfolios because CDO complexity made it genuinely impossible — not even the banks themselves knew what was inside their own CDOs.

This froze everything downstream: hedge funds couldn't fund positions, money market funds broke the buck, commercial paper markets seized, corporations couldn't make payroll.

### The cascade

```
2007: Subprime defaults rise → MBS values fall
2008: Bear Stearns collapses (couldn't roll over repo funding)
2008: Lehman Brothers bankrupts ($600B in assets, massively leveraged)
2008: Reserve Primary Fund "breaks the buck" (held Lehman paper)
2008: Commercial paper freezes → corporations can't make payroll
2008: Credit markets seize globally
```

The losses had been sold to pension funds, European banks, and sovereign wealth funds worldwide. Nobody was isolated.

---

## 8. The Bailout

- **TARP** — $700B to buy toxic assets and recapitalize banks
- **Fed emergency lending** — became lender of last resort to the entire system
- **AIG bailout** — $180B, effectively bailing out Goldman Sachs and others holding AIG's CDS
- **Fannie/Freddie conservatorship** — government takeover of the two biggest mortgage agencies

---

## Key Terms

| Term              | Definition                                                                    |
| ----------------- | ----------------------------------------------------------------------------- |
| **MBS**           | Mortgage-Backed Security — a bond backed by a pool of mortgages               |
| **CDO**           | Collateralized Debt Obligation — MBS sliced into risk tranches                |
| **ARM**           | Adjustable Rate Mortgage — low teaser rate that resets sharply after 2 years  |
| **Repo**          | Repurchase Agreement — short-term collateralized loan for overnight liquidity |
| **CDS**           | Credit Default Swap — insurance contract on a bond defaulting                 |
| **Underwater**    | Owing more on a mortgage than the house is currently worth                    |
| **Cash-out refi** | Refinancing a mortgage to extract equity as cash                              |
| **Tranche**       | A slice of a CDO with a specific risk/return profile                          |

---

## The Core Lesson

> Complexity + leverage + misaligned incentives + correlated risk = catastrophic failure.
>
> Everyone at every level had incentive to ignore the risk: brokers got paid per loan, banks sold off the risk immediately, rating agencies got fees for AAA ratings, and investors chased yield. When the foundational assumption — _prices only go up_ — proved false, the entire chain unwound simultaneously.
