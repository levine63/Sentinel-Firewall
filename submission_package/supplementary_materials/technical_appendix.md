# Appendix: Technical Economic Model

This appendix describes the probabilistic model used to estimate the social returns to two modular Sentinel Firewall intervention packages: a `Kitchen Package` and a `Kohl Package`.

## 1. Overview

We model the economic return to reducing lead exposure among pregnant women, fetuses, infants, and young children in high-risk districts identified through sentinel screening. The analysis has two intervention packages:

- `Kitchen Package`: lead-safe pot voucher delivered through antenatal care (ANC), calcium delivered through ANC, and safe utensils delivered through immunization contacts.
- `Kohl Package`: safe maternal kohl delivered through ANC and safe infant kohl delivered through either facility delivery or early-immunization catch-up, with infant benefits applying to boys and girls in the main specification.

The model estimates:

- child cognitive and lifetime earnings gains
- maternal and neonatal health gains
- adult cardiovascular health gains for exposed adults as a secondary extension
- package-specific benefit-cost ratios under baseline uncertainty

All uncertainty analysis uses `10,000` Monte Carlo draws with PERT distributions.

## 2. Perspective and Time Horizon

The primary analysis adopts a broad social perspective. Costs are valued at the program level per mother-child pair reached through maternal and child health platforms. Benefits include:

- discounted lifetime earnings gains from improved child cognition
- monetized maternal and neonatal health gains
- monetized adult cardiovascular health gains

The model discounts future benefits to the time of birth. Earnings gains are realized over the working life. Adult cardiovascular gains are discounted according to the assumed age of the affected adult at intervention.

## 3. Present Value of Earnings

We estimate the present value of expected lifetime earnings from birth as:

`PV = productivity x x^(A_entry) x sum_t [ S_t x x^(t-1) ]`

where:

- `productivity = GDP_PPP_per_capita x labor_share_income`
- `x = (1 + growth) / (1 + discount)`
- `A_entry` is age of labor market entry
- `S_t` is unconditional survival from birth to working year `t`

The productivity anchor is intended to value market labour output, including self-employment and informal work. We therefore multiply GDP per capita at purchasing power parity by labour's share of national income rather than by the observed labour-force participation rate. This follows standard cost-benefit logic: GDP per capita captures total market output, while labour's share allocates the relevant portion of that output to labour income. Using observed wage rates alone would miss own-account and informal production that is central in many of the settings modeled here. At the same time, this approach excludes household production, subsistence output not captured in national accounts, and the intrinsic value of cognition beyond earnings, making the earnings estimates conservative on those dimensions.

The mode uses PPP GDP per capita of `4000` and a labour-share parameter of `0.55`, yielding an annual productivity anchor of `2200`. The range combines lower- and lower-middle-income settings with plausible labour-share values after correcting for self-employment and mixed income: `0.50 / 0.55 / 0.58`. The GDP range is intentionally below many middle-income national averages because the model is meant for poorer districts and countries where informal consumer-product lead exposure remains common. The labour-share range is narrower than the former labour-force-participation range because it is no longer representing employment status; it is the national-income share accruing to labour.

Following the model code, survival over the working life is approximated as:

`S_t = p18 - (p18 - p65) x ((t - 1) / 47)^k`

with `t = 1 ... T`, where `T` depends on labor entry age. This specification preserves both childhood mortality before labor-market entry and adult attrition during the working life while concentrating mortality toward older working ages when `k > 1`.

## 4. Mapping Lead Reduction to Child Earnings

The main specification uses a linear approximation from child blood lead reduction to IQ gain, but with an important timing adjustment. The epidemiologic literature links cognition to prenatal, infancy, and early-childhood lead exposure over repeated developmental windows rather than to one brief intervention month. We therefore do not treat a short prenatal or one-year infant reduction as if it changed average childhood lead exposure by the same amount for all formative years.

Instead, the model applies explicit developmental shares that sum to one:

- last four months in utero: mode `0.30`
- year 1: mode `0.30`
- years 2 to 5 combined: mode `0.40`

The prenatal and year-1 shares are drawn directly, and the residual share for years 2 to 5 is defined as `1 - prenatal - year1`, with rejection sampling to keep it in the target range. Postnatal pathways then receive the year-1 share plus the relevant fraction of the years-2-to-5 share according to how long the intervention lasts. IQ gains are then calculated as:

`DeltaIQ = iq_per_bll x DeltaBLL_child_cog_equiv`

The present value of child earnings gains is then:

`DeltaPV_earnings = PV x earn_per_iq x DeltaIQ`

The LMIC-centered earnings parameterization remains anchored in LMIC evidence on returns to cognitive skill, while also recognizing that the lead valuation literature often uses somewhat higher values. In the main specification:

- minimum: `0.0030`
- mode: `0.0050`
- maximum: `0.0100`

The minimum reflects the LMIC cognition-to-wage evidence in `Ozawa et al. (2022)` and allows for substantial labor-market friction in subsistence-heavy settings. The mode uses the lower end of the lead valuation range in `Grosse et al. (2002)`. The maximum is aligned with developing-country cognitive-skill estimates such as `Hanushek and Woessmann (2008)`, while avoiding the larger US-based values sometimes used in environmental valuation.

The linear `iq_per_bll` model is retained in the main analysis for transparency. Section 12.2 reports a nonlinear log-BLL robustness check, which is useful for settings where the targeted source accounts for a large or small share of total child lead exposure.

## 5. Implementation Structure

### 5.1 Kitchen package

The Kitchen Package contains three components with different implementation chains.

#### Pot pathway

The pot pathway is modeled explicitly as a multi-step voucher chain:

1. household uses an unsafe pot relevant to the pregnant woman or young child
2. woman attends ANC
3. voucher is issued
4. an approved merchant accepting the voucher has stock
5. voucher is redeemed
6. the redeemed pot is used by the pregnant woman or toddler
7. some residual unsafe pot use may still reduce the benefit

Thus:

`P_success_pot = prev_pot x p_att_anc x p_voucher_issued x p_merchant_stock x p_redeem x p_use_targeted_after_redemption`

and the realized blood lead effect is:

`DeltaBLL_pot = DeltaBLL_pot_full x P_success_pot x (1 - residual_unsafe_use_harm)`

This formulation reflects the intuition that pot uptake has more operational steps than simple clinic distribution, but also that use after redemption should be relatively high because redemption is an effortful, self-targeting act. A full switcher is a household that uses the hazardous product at baseline, receives or redeems the safer substitute, and then uses the substitute for the pregnant woman or young child without enough residual unsafe-product use to preserve the original exposure pathway.

Behaviorally, the key concern for pots is usually not whether a redeemed pot will ever be used. Safe cookware is a valuable durable good, and once a household has made the effort to redeem a voucher, it is reasonable to expect high use for the pregnant woman or toddler. The larger concern is non-exclusive use: households may continue to use the old unsafe pot alongside the safer replacement, especially for some dishes, some family members, or some cooking contexts. The model therefore places more weight on redemption, merchant stock, and residual unsafe use than on an assumption that the new pot will simply sit unused.

To avoid overstating precision, the model also adds modest positive dependence across ANC attendance, delivery fidelity, voucher issuance, merchant stock, redemption, and targeted use after redemption. This reflects the idea that some districts or facilities will systematically perform better or worse across several links in the chain rather than failing independently at random.

#### Calcium pathway

Calcium is modeled as applying to all reached pregnant women in targeted red districts:

`P_success_calcium = p_att_anc x fidelity x adherence`

and:

`DeltaBLL_calcium_mother = DeltaBLL_calcium_full x P_success_calcium`

This is a simplifying modeling choice. We do not scale calcium by a separate "maternal lead-relevant" prevalence parameter.

The practical challenge for calcium is different from the hardware pathways. Calcium tablets are clinically familiar and can be distributed through ANC, but adherence is often imperfect because supplementation requires repeated consumption over time. Women may stop early because of pill burden, side effects, stock interruptions, competing advice, or weak counselling. For that reason, the main uncertainty for calcium is not whether the product is attractive once obtained, but how much of the intended course is actually consumed.

#### Utensils pathway

Safe utensils are modeled through immunization contacts:

`P_success_utensils = prev_utensils x p_att_imm x fidelity x adherence`

and:

`DeltaBLL_utensils_child = DeltaBLL_utensils_full x P_success_utensils`

### 5.2 Kohl package

The Kohl Package has separate maternal and infant pathways.

Maternal kohl:

`P_success_kohl_maternal = prev_kohl_maternal x p_att_anc x fidelity x adherence`

Infant kohl:

`P_success_kohl_infant = prev_kohl_infant x p_att_infant_kohl_contact x fidelity x adherence`

The infant contact parameter is the probability that an infant can be reached either through facility delivery or through an early immunization contact. The model uses this union directly, rather than adding institutional delivery and immunization coverage as independent events, because these contacts are positively correlated within households and health systems. The modal value is `0.80`, with a range of `0.55` to `0.95`.

The main model applies infant kohl effects to boys and girls. This reflects evidence that kohl may be applied during infancy for perceived protective or ritual reasons, even where use continues longer among girls. The code also retains a `50/50` Bernoulli sex draw for a robustness check in which infant kohl substitution is restricted to mothers and girls only.

Adherence to safer kohl is more culturally contingent than adherence to a safe pot. In some households, mothers may welcome a visibly safer substitute if it preserves the protective or ritual meaning of kohl. In other households, older relatives may believe that traditional galena-based kohl is the most protective or authentic option, which could reduce switching or increase continued dual use. The appendix therefore treats kohl adherence as plausible but uncertain, and this uncertainty should be resolved locally wherever possible through formative work and pilot measurement rather than assumed away.

The prevalence parameters for maternal and infant kohl should also be read as conditional on programme targeting rather than as unconditional population averages. In the current version we use `0.40 / 0.70 / 0.85` for both maternal and infant kohl prevalence. That higher mode is intended to represent screened hotspot settings, especially where infant kohl use extends to boys as well as girls. In that sense, prevalence is partly endogenous to programme management: stricter hotspot screening and a higher threshold for triggering the package should increase the prevalence of kohl use among those actually targeted.

## 6. Maternal-Fetal Transfer and Developmental Timing

The model includes an explicit prenatal transfer channel from maternal to fetal exposure.

We define:

`DeltaBLL_prenatal_child = fetal_transfer_coeff x DeltaBLL_maternal_pregnancy`

where `fetal_transfer_coeff` represents the fraction of maternal blood lead reduction during pregnancy that translates into reduced fetal exposure. This is an inferred parameter motivated by the strong maternal-cord blood lead relationship in the literature, not a direct estimate of child-IQ-relevant fetal lead transfer.

In the Kitchen Package:

`DeltaBLL_prenatal_child = fetal_transfer_coeff x (DeltaBLL_pot_mother + DeltaBLL_calcium_mother)`

In the Kohl Package:

`DeltaBLL_prenatal_child = fetal_transfer_coeff x DeltaBLL_maternal_kohl_mother`

For child cognition, this prenatal reduction receives the prenatal developmental share rather than being spread mechanically over all early-childhood years.

The total child cognitive exposure reduction is then calculated as a weighted combination of:

- the prenatal pathway, using the last-four-months-in-utero share
- postnatal pathways operating in year 1
- postnatal pathways operating in years 2 to 5

In the kitchen package, `bll_pot_child` is defined as the postnatal child effect of switching cookware. Any prenatal child benefit from lower maternal lead due to the pot is modeled separately through `bll_pot_mother` and `fetal_transfer_coeff`. This avoids double counting the pot effect across prenatal and postnatal child pathways.

## 7. Maternal and Neonatal Outcomes

We include two additional maternal and neonatal pathways:

- preeclampsia
- preterm birth

These are modeled using baseline prevalence and a per-`1 ug/dL` odds ratio. For each outcome:

1. convert baseline prevalence to baseline odds
2. reduce odds according to the modeled maternal lead reduction
3. convert the new odds back to risk
4. compute the absolute risk difference

In notation:

`odds_0 = p / (1 - p)`

`odds_1 = odds_0 / OR^(DeltaBLL_maternal)`

`risk_1 = odds_1 / (1 + odds_1)`

`Deltarisk = risk_0 - risk_1`

The model does not assume that the full maternal BLL reduction applies across the entire pregnancy. Instead, maternal lead reductions are multiplied by timing parameters before being entered into the preeclampsia and preterm equations. For preeclampsia, this reflects the fact that the clinical risk window is mainly after `20` weeks, so an intervention beginning around month `4` may still cover much of the relevant period. For preterm birth, the literature supports an in-pregnancy effect but is less clear about the exact trimester weighting. We therefore use:

- `preeclampsia_timing_mult = 0.50 / 0.75 / 1.00`
- `preterm_timing_mult = 0.40 / 0.70 / 1.00`

These are structural timing parameters rather than direct epidemiologic estimates.

Maternal and neonatal health benefits are monetized using reduced-form DALY equivalents:

- preeclampsia cases averted x `preeclampsia_daly_wt`
- preterm cases averted x `neonatal_daly_mult`

This is intentionally simple and should be read as a tractable first-pass valuation rather than a full natural-history model.

## 8. Adult Cardiovascular Benefits

The model includes a supplemental adult cardiovascular disease (CVD) pathway. We treat this as a secondary extension rather than part of the core child-cognition case because the parameterization is more aggregated and less directly identified than the child earnings pathway. Benefits are valued as:

`Benefit_CVD = DeltaBLL_effective x cvd_daly_per_ug_lifetime x duration x VSLY x discount_factor`

In the Kitchen Package:

- mothers receive benefits from pot and calcium lead reductions
- co-resident grandparents receive a fraction of the pot effect

In the Kohl Package:

- mothers receive benefits from the maternal kohl pathway

Adult benefits are discounted according to the distance between age at intervention and the adult reference year (`65` in the code).

## 9. Costing

Total program cost per mother-child pair equals:

- district fixed cost per birth
- counseling costs at relevant contacts
- distribution costs
- product costs
- program markup for wastage, supply-chain overhead, supervision, and health-system administration

Intervention costs are expressed in `2026` US dollars. By contrast, the
productivity anchor for lifetime earnings is based on PPP GDP per
capita multiplied by labour's share of national income, as described in
Section 3.

The district overhead is modeled as:

`fixed_cost_per_birth = district_fixed_cost / district_births`

The fixed-cost numerator should be interpreted as fully loaded national and district overhead for sentinel screening and program setup, including XRF assets, training, supervision, coordination, and market-screening capacity. The modal denominator, `20,000` births, is an effective screening-unit cohort rather than a claim that every administrative district has exactly that many births. It reflects a shared-service model in which XRF equipment and specialized supervision can serve multiple smaller districts or catchments, improving capital efficiency.

The model treats demographic survival parameters (`p18` and `p65`) and lead-source prevalence parameters (`prev_pot`, `prev_kohl_maternal`, `prev_kohl_infant`, and `prev_utensils`) as independent. Survival affects the present value of future earnings. Product-specific lead prevalence reflects local contamination from informal consumer-product supply chains. The model therefore does not assume that higher childhood mortality mechanically predicts higher or lower prevalence of contaminated pots, kohl, or utensils.

For the pot, the variable redeemed-pot cost is:

`(cost_pot_direct + cost_bulk_distribution_margin) x (1 + logistics_markup)`

where `cost_bulk_distribution_margin` includes bulk distribution and an explicit retailer margin. This combined variable cost is conditioned on ANC attendance, voucher issuance, merchant stock, and voucher redemption. For other delivered items, the model applies the program markup to direct product plus light distribution costs when the relevant health contact occurs and the item is delivered. For infant kohl, the product cost is incurred for infants reached through either facility delivery or early-immunization catch-up in the main model. In the mothers-and-girls-only robustness check, infant kohl benefits and costs are multiplied by the simulated daughter indicator.

## 10. Outputs

For each package, the model reports:

- `BCR_Cog`: earnings-only benefit-cost ratio
- `BCR_Plus_MN`: benefit-cost ratio including maternal and neonatal benefits
- `BCR_Total`: benefit-cost ratio including earnings, maternal/neonatal, and adult CVD benefits
- probability that each BCR falls below `1`
- trial-level exports

The code also writes compressed trial-level outputs, a small validation table, and, where plotting libraries are available, a comparison figure across packages.

## 11. Parameters

Table A1 (companion file) reports the final parameter values used in the code. The working parameter file and citation-complete parameter table will be made available with the public model files described in the manuscript Data availability statement.

The citation-complete version of Table A1 is the companion file `parameter_citation_table.md`. For each parameter, that file provides either a direct citation, a cited synthesis basis, or an explicit program-design justification when the literature does not yield a single transportable estimate.

The parameters fall into six groups:

- macroeconomic and life-table parameters
- lead-to-cognition and cognition-to-earnings parameters
- implementation and prevalence parameters
- product-specific blood lead reduction parameters
- maternal/neonatal and adult CVD valuation parameters
- costing and district-overhead parameters

## 12. Extended Notes on Three Influential Parameters

### 12.1 Pot to child BLL

The pot-to-BLL parameter is one of the most influential quantities in the model and also one of the least directly identified. The underlying literature is strong on contamination, leaching, and plausibility of exposure, but much weaker on the exact blood lead decline that would follow a clean product swap in a routine public-health program. For that reason, the parameter is intentionally kept broad at `2 / 5 / 8 ug/dL` for the postnatal child effect among households that switch fully from hazardous cookware to the safe replacement for the target child. The lower end allows for settings in which cookware is only one contributor among several lead sources. The upper end is reserved for settings where contaminated cookware or pottery is a dominant exposure source and the safer replacement sharply reduces exposure.

Three strands of evidence support that wide but nontrivial range. First, studies from Mexico show that lead-glazed ceramic foodware is strongly associated with elevated child BLL, including large differences in the prevalence of BLLs above `5 ug/dL` between frequent users and non-users (Rojas-Lopez et al., 1994; Romieu et al., 1994; Pure Earth/INSP summaries). Second, studies from Cameroon, Afghanistan, and other settings show that artisanal aluminum cookware can contain and leach substantial lead, in some cases at levels far above health-based thresholds (Weidenhamer et al., 2014; Weidenhamer et al., 2022; Fellows, Samy, and Whittaker, 2025). Third, because the main available studies document contamination, user-non-user contrasts, and exposure plausibility rather than randomized product replacement with child BLL follow-up, we treat the parameter as a synthesis assumption anchored in the literature rather than as a directly estimated treatment effect.

The implementation logic is also important. For cookware, the main behavioral uncertainty is usually not whether a redeemed safe pot will ever be used. A new durable pot is attractive and useful, so conditional use after redemption may be high. The larger concern is non-exclusive use: households may continue using the old unsafe pot for some dishes, some family members, or some occasions. The parameter therefore belongs together with the redemption and residual-use parameters rather than being read as a stand-alone biological constant.

### 12.2 BLL to IQ

The baseline model uses a linear `iq_per_bll` parameter for transparency, but the supporting literature is nonlinear. Canfield, Lanphear, Jusko, and Schnaas all point in the same direction: there is no clear safe threshold, and the marginal cognitive loss per unit of blood lead is larger at lower BLLs than at higher ones. The linear range of `0.20` to `0.60` IQ points per `1 ug/dL` reduction in developmentally averaged child BLL, with a mode of `0.35`, should therefore be understood as a practical approximation to a low-level nonlinear relationship rather than as a literal claim that every `1 ug/dL` reduction has the same cognitive value at every starting point.

To make that point concrete, we also report a nonlinear robustness exercise based on a log-BLL formulation. Under a Crump-style parameterization with `beta = 3.246`, lowering BLL from `12` to `7 ug/dL` yields an IQ gain of roughly `1.58` points, whereas lowering BLL from `7` to `2 ug/dL` yields about `3.18` points. This is exactly the intuition the main text highlights: the same absolute decline in BLL is worth more when it occurs at lower exposure levels or when the targeted source accounts for a larger share of total exposure. The linear main model is therefore easier to read, but the nonlinear robustness check is more faithful to the shape of the epidemiologic literature.

### 12.3 IQ to earnings

The IQ-to-earnings mapping is the third key multiplier. Here the literature is broad but mixed, and the relevant question is not simply "what is the return to IQ?" but "what is the return to a one-point cognitive gain in LMIC labor markets?" The LMIC-focused review by Ozawa et al. (2022) supports a low-end estimate near `0.003` per IQ point after mapping a standard deviation of cognitive skill to roughly `15` IQ points. Older lead valuation work by Grosse et al. (2002) used values around `0.5%` to `1.0%` per IQ point, and Hanushek and Woessmann (2008) provide a broader developing-country cognitive-skill anchor consistent with an upper bound around `1.0%` per point.

We therefore use `0.003 / 0.005 / 0.010` as the minimum, mode, and maximum. This range avoids the high-income bias that would come from using US-based estimates such as `1.5%` to `2.5%` per IQ point as the main LMIC specification. The parameter remains intentionally bounded below the highest values in the broader literature because many LMIC labor markets may not fully monetize cognitive gains through formal wages.

## 13. Test-Triggered Provision versus Sentinel-Area Universal Provision

Experience in Adjara, Georgia illustrates that ANC systems can support
universal biomonitoring with follow-up for women found to have elevated
blood lead levels.36 37 The Sentinel Firewall instead emphasizes
universal provision of safe substitutes to the relevant target group
within sentinel-identified high-risk areas. The trade-off can be
summarized with a simple comparison.

Let `C_T` denote the per-person cost of biomonitoring, including blood
collection, laboratory testing, communicating results, follow-up
administration, and the prorated fixed costs of the testing system. Let
`C_I` denote the per-household cost of the intervention itself, such as
a lead-safe pot, safe utensils, or a safe kohl substitute. Let
`p_high` denote the share of the vulnerable cohort that would test above
the clinical BLL threshold under a test-triggered strategy, and let
`p_risk` denote the share of households in a sentinel-identified
hotspot that would in fact benefit from the intervention. Let
`beta_T` denote the expected health benefit per treated high-BLL
household under test-triggered provision, and let `beta_U` denote the
expected health benefit per treated at-risk household under universal
sentinel-based provision.

Test-triggered provision is preferred when its expected benefit-cost
ratio exceeds that of universal sentinel-based provision:

`(p_high x beta_T) / (C_T + p_high x C_I) > (p_risk x beta_U) / C_I`

This expression highlights the central trade-off. Individual
biomonitoring is favored when testing costs are low, elevated BLL is
concentrated in a relatively small but identifiable subgroup, and
receiving a salient clinical result materially increases adherence or
follow-up. Universal sentinel-based provision is favored when safe
substitutes are inexpensive, hazardous products are widespread within
identified hotspots, testing and follow-up are costly or slow, and
delay risks missing critical developmental windows. In practice, hybrid
strategies may dominate either pure approach, for example by using
sentinel surveillance to identify high-risk districts and then combining
selective biomonitoring with rapid universal provision to the highest-
risk households.

## 14. Remaining Modeling Choices

Several choices are acceptable for this analysis but may warrant revision as better evidence becomes available. These decisions are documented in the project materials that accompany the public model files.

The most important are:

- whether calcium should eventually be scaled by a lead-risk subgroup
- whether the main model should move from linear `iq_per_bll` to a nonlinear/log-BLL formulation
- whether maternal and neonatal DALY shortcuts should be replaced with a more explicit disease model
- whether the current positive dependence structure across implementation steps is strong enough

## References

1.  Luby SP, Forsyth JE, Fatmi Z, et al. Removing lead from the global
    economy. Lancet Planet Health 2024;8:e966-72.
    doi:10.1016/S2542-5196(24)00244-4
2.  World Health Organization. Lead poisoning. 2024. Available:
    https://www.who.int/news-room/fact-sheets/detail/lead-poisoning-and-health
    \[Accessed 16 Apr 2026\].
3.  Sargsyan A, Nash E, Binkhorst G, et al. Rapid market screening to
    assess lead concentrations in consumer products across 25 low-income
    and middle-income countries. Sci Rep 2024;14:9713.
    doi:10.1038/s41598-024-59519-0
4.  Weidenhamer JD, Kobunski PA, Kuepouo G, et al. Lead exposure from
    aluminum cookware in Cameroon. Sci Total Environ 2014;496:339-47.
    doi:10.1016/j.scitotenv.2014.07.016
5.  Weidenhamer JD, Chasant M, Gottesfeld P. Metal exposures from source
    materials for artisanal aluminum cookware. Int J Environ Health Res
    2023;33:374-85. doi:10.1080/09603123.2022.2029112
6.  Romieu I, Palazuelos E, Hernandez-Avila M, et al. Lead exposure in
    Mexican children: the effect of lead-glazed ceramic ware. J Pediatr
    1994;125:111-7.
7.  Hore P, Sedlar S, Ehrlich J. Lead poisoning in a mother and her four
    children using a traditional eye cosmetic - New York City,
    2012-2023. MMWR Morb Mortal Wkly Rep 2024;73:667-71.
    doi:10.15585/mmwr.mm7330a2
8.  Ettinger AS, Tellez-Rojo MM, Amarasiriwardena C, et al. Effect of
    calcium supplementation on blood lead levels in pregnancy: a
    randomized placebo-controlled trial. Environ Health Perspect
    2009;117:26-31. doi:10.1289/ehp.11868
9.  UNICEF. Antenatal care. 2024. Available:
    https://data.unicef.org/topic/maternal-health/antenatal-care/
    \[Accessed 16 Apr 2026\].
10. UNICEF. Delivery care. 2024. Available:
    https://data.unicef.org/topic/maternal-health/delivery-care/
    \[Accessed 16 Apr 2026\].
11. UNICEF. Vaccination and immunization statistics. 2025. Available:
    https://data.unicef.org/topic/child-health/immunization/ \[Accessed
    16 Apr 2026\].
12. World Bank. World Development Indicators. 2024. Available:
    https://data.worldbank.org/ \[Accessed 16 Apr 2026\].
13. International Labour Organization. World Employment and Social
    Outlook: Trends 2025. Geneva: International Labour Organization,
    2025. doi:10.54394/IZLN1673
14. Briggs A, Claxton K, Sculpher M. Decision modelling for health
    economic evaluation. Oxford: Oxford University Press, 2006.
15. Canfield RL, Henderson CR Jr, Cory-Slechta DA, et al. Intellectual
    impairment in children with blood lead concentrations below 10 ug
    per deciliter. N Engl J Med 2003;348:1517-26.
    doi:10.1056/NEJMoa022848
16. Lanphear BP, Hornung R, Khoury J, et al. Low-level environmental
    lead exposure and children’s intellectual function: an international
    pooled analysis. Environ Health Perspect 2005;113:894-9.
    doi:10.1289/ehp.7688
17. Jusko TA, Henderson CR Jr, Lanphear BP, et al. Blood lead
    concentrations \<10 ug/dL and child intelligence at 6 years of age.
    Environ Health Perspect 2008;116:243-8. doi:10.1289/ehp.10424
18. Schnaas L, Rothenberg SJ, Flores MF, et al. Reduced intellectual
    development in children with prenatal lead exposure. Environ Health
    Perspect 2006;114:791-7. doi:10.1289/ehp.8552
19. Crawfurd L, Todd R, Hares S. The effect of lead exposure on
    children’s learning in the developing world. World Bank Res Obs
    2025;40:229-63. doi:10.1093/wbro/lkae010
20. Ozawa S, Laing SK, Higgins CR, et al. Educational and economic
    returns to cognitive ability in low- and middle-income countries: a
    systematic review. World Dev 2022;149:105668.
    doi:10.1016/j.worlddev.2021.105668
21. Grosse SD, Matte TD, Schwartz J, et al. Economic gains resulting
    from the reduction in children’s exposure to lead in the United
    States. Environ Health Perspect 2002;110:563-9.
    doi:10.1289/ehp.02110563
22. Grosse SD, Zhou Y. Monetary valuation of children’s cognitive
    outcomes in economic evaluations from a societal perspective: a
    review. Children (Basel) 2021;8:352. doi:10.3390/children8050352
23. Hanushek EA, Woessmann L. The role of cognitive skills in economic
    development. J Econ Lit 2008;46:607-68. doi:10.1257/jel.46.3.607
24. Al-Jawadi AA, Al-Mola ZWA, Al-Jomard RA. Determinants of maternal
    and umbilical blood lead levels: a cross-sectional study, Mosul,
    Iraq. BMC Res Notes 2009;2:47. doi:10.1186/1756-0500-2-47
25. Vigeh M, Sahebi L, Yokoyama K. Prenatal blood lead levels and birth
    weight: a meta-analysis study. J Environ Health Sci Eng
    2023;21:1-10. doi:10.1007/s40201-022-00843-w
26. Bellinger D, Leviton A, Waternaux C, et al. Longitudinal analyses of
    prenatal and postnatal lead exposure and early cognitive
    development. N Engl J Med 1987;316:1037-43.
27. Dupas P, Hoffmann V, Kremer M, et al. Targeting health subsidies
    through a nonprice mechanism: a randomized controlled trial in
    Kenya. Science 2016;353:889-95. doi:10.1126/science.aaf6288
28. Poropat AE, Laidlaw MAS, Lanphear B, et al. Blood lead and
    preeclampsia: a meta-analysis and review of implications. Environ
    Res 2018;160:12-9. doi:10.1016/j.envres.2017.09.014
29. Habibian A, Abyadeh M, Abyareh M, et al. Association of maternal
    lead exposure with the risk of preterm: a meta-analysis. J Matern
    Fetal Neonatal Med 2022;35:7222-30.
    doi:10.1080/14767058.2021.1946780
30. World Health Organization. Preterm birth. 2023. Available:
    https://www.who.int/news-room/fact-sheets/detail/preterm-birth
    \[Accessed 16 Apr 2026\].
31. Blencowe H, Lee ACC, Cousens S, et al. Preterm birth–associated
    neurodevelopmental impairment estimates at regional and global
    levels for 2010. *Pediatric Research* 2013;74(Suppl 1):17–34.
    doi:10.1038/pr.2013.204
32. Global Burden of Disease Collaborative Network. *Global Burden of
    Disease Study 2019 (GBD 2019) Disability Weights*. Seattle, United
    States of America: Institute for Health Metrics and Evaluation
    (IHME), 2020. Available at:
    <https://ghdx.healthdata.org/record/ihme-data/gbd-2019-disability-weights>
33. GBD 2019 Diseases and Injuries Collaborators. Global burden of 369
    diseases and injuries in 204 countries and territories, 1990–2019: a
    systematic analysis for the Global Burden of Disease Study 2019.
    *Lancet* 2020;396:1204–1222. doi:10.1016/S0140-6736(20)30925-9
34. Larsen B, Sanchez-Triana E. Global health burden and cost of lead
    exposure in children and adults: a health impact and economic
    modelling analysis. Lancet Planet Health 2023;7:e831-40.
    doi:10.1016/S2542-5196(23)00166-3
35. Robinson LA, Hammitt JK, O’Keeffe L. Valuing mortality risk
    reductions in global benefit-cost analysis. J Benefit Cost Anal
    2019;10(S1):15-50.
36. Tsetskhladze N. Evidence and sustained leadership help reduce lead
    exposure for women and children. UNICEF Georgia 2024. Available:
    https://www.unicef.org/georgia/evidence-and-sustained-leadership-help-reduce-lead-exposure-women-and-children
    [Accessed 29 Apr 2026].
37. Ugreshelidze D, Khachidze N, Chakhnashvili N, et al. Association
    between blood lead levels, haemoglobin and anaemia in pregnant
    women: a register-based cohort study from the Autonomous Republic
    of Adjara, Georgia. J Public Health 2026.
    doi:10.1007/s10389-026-02482-x
