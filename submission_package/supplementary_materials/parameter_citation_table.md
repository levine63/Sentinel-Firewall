# Appendix Table A1. Parameter Values, Rationale, and Citations

This table is the citation-complete companion to the working parameter file used in the simulation. Where a parameter is not available from a single direct study, the table states that it is a program-design or synthesis assumption and identifies the literature used to anchor its range.

## A. Macroeconomic and life-table parameters

| Variable | Min | Mode | Max | Rationale | Citation basis |
| --- | ---: | ---: | ---: | --- | --- |
| `gdp_ppp_per_capita` | 2000 | 4000 | 8000 | Represents a conservative LMIC district-level range rather than an all-country global mean. | World Bank, GDP per capita, PPP (current international $), lower-middle-income and country comparator series. [World Bank](https://data.worldbank.org/indicator/NY.GDP.PCAP.PP.CD?locations=XN) |
| `labor_share_income` | 0.50 | 0.55 | 0.58 | Labour share of national income, used to convert PPP GDP per capita into an annual market-labour productivity anchor. This replaces labour-force participation because GDP per capita already averages across the population; multiplying by labour's share captures labour output including self-employment and informal market production while avoiding reliance on observed wage rates alone. | ILO labour income share context; Gollin's correction for self-employment and mixed income; World Bank human-capital valuation logic. [ILO WESO](https://www.ilo.org/publications/flagship-reports/world-employment-and-social-outlook-trends-2025), [Gollin](https://ideas.repec.org/a/ucp/jpolec/v110y2002i2p458-474.html), [World Bank CWON](https://www.worldbank.org/en/publication/changing-wealth-of-nations) |
| `growth` | 0.00 | 0.02 | 0.025 | Conservative long-run productivity growth assumption for LMIC decision analysis. | Program-design assumption anchored in World Bank and ILO growth context; not taken from a single causal paper. |
| `discount` | 0.01 | 0.03 | 0.05 | Standard health-economic social discount range. | Briggs, Claxton, and Sculpher (2006). |
| `p18` | 0.92 | 0.95 | 0.97 | Reflects survival to adulthood in contemporary LMIC settings. | UN child mortality context and World Bank life-table indicators. UNICEF/UN IGME child mortality; World Bank survival indicators. [UNICEF](https://data.unicef.org/topic/child-survival/under-five-mortality/) |
| `p65` | 0.68 | 0.78 | 0.85 | Captures plausible unconditional survival to age 65 across higher- and lower-survival LMIC settings. | World Bank survival to age 65 indicator. [World Bank](https://genderdata.worldbank.org/en/indicator/sp-dyn-to65-zs) |
| `k` | 1.5 | 2.0 | 3.0 | Shape parameter used to concentrate mortality later in the working life. | Structural modeling assumption; no direct empirical source. |
| `labor_entry_age` | 14 | 18 | 20 | Captures informal labor entry at the low end and delayed formal entry at the high end. | ILO child labor and youth labor-force context; program-design range. |
| `mom_age` | 18 | 25 | 35 | Plausible age range for mothers reached by ANC in LMIC settings. | DHS fertility and maternal age distributions; program-design range. |
| `gp_age` | 42 | 52 | 70 | Representative intergenerational age span for co-resident grandparents. | Household-structure and fertility-timing synthesis; program-design range. |
| `gp_coresidence_prob` | 0.20 | 0.50 | 0.70 | Captures substantial cross-setting variation in multigenerational co-residence. | DHS and household structure synthesis; program-design range. |

## B. Child cognition and earnings parameters

| Variable | Min | Mode | Max | Rationale | Citation basis |
| --- | ---: | ---: | ---: | --- | --- |
| `iq_per_bll` | 0.20 | 0.35 | 0.60 | Linear approximation to the relationship between developmentally averaged child BLL and cognition. The widened range reflects both the low-level nonlinearity in the cohort literature and the fact that this model translates shorter exposure changes into an average over a longer developmental window. | Canfield et al. (2003); Lanphear et al. (2005); Jusko et al. (2008); Schnaas et al. (2006); Crawfurd et al. (2025). [Canfield](https://pubmed.ncbi.nlm.nih.gov/12700371/), [Lanphear](https://pubmed.ncbi.nlm.nih.gov/16002379/), [Jusko](https://pubmed.ncbi.nlm.nih.gov/18288325/), [Schnaas](https://pubmed.ncbi.nlm.nih.gov/16675422/), [Crawfurd et al.](https://academic.oup.com/wbro/article/40/2/229/7734093) |
| `earn_per_iq` | 0.0030 | 0.0050 | 0.0100 | Percent earnings gain per IQ point. The minimum reflects the LMIC cognition-to-wage evidence after allowing for labor-market friction; the mode uses the lower end of the lead valuation range; the maximum aligns with developing-country cognitive-skill estimates while avoiding larger high-income-country values. | Ozawa et al. (2022); Grosse et al. (2002); Hanushek and Woessmann (2008). [Ozawa](https://pubmed.ncbi.nlm.nih.gov/34980939/), [Grosse et al.](https://hero.epa.gov/reference/25727/) |
## C. Implementation and prevalence parameters

| Variable | Min | Mode | Max | Rationale | Citation basis |
| --- | ---: | ---: | ---: | --- | --- |
| `p_att_anc` | 0.55 | 0.82 | 0.95 | ANC-1 attendance benchmark. | UNICEF antenatal care data. [UNICEF](https://data.unicef.org/topic/maternal-health/antenatal-care/) |
| `p_att_imm` | 0.50 | 0.80 | 0.95 | Reflects DTP3-style immunization platform reach in many LMIC settings. | UNICEF immunization statistics. [UNICEF](https://data.unicef.org/topic/child-health/immunization/) |
| `p_att_birth` | 0.40 | 0.65 | 0.85 | Institutional delivery range retained as a reference contact parameter. Infant kohl now uses the combined facility-delivery-or-early-immunization contact below. | UNICEF and DHS-style institutional delivery coverage context; program-design range. |
| `p_att_infant_kohl_contact` | 0.55 | 0.80 | 0.95 | Combined probability that an infant can be reached for safe kohl through either facility delivery or early immunization catch-up. The mode is a union of correlated contacts, not the sum of independent delivery and immunization probabilities. | UNICEF institutional delivery and immunization coverage benchmarks; program-design assumption requiring local validation. [UNICEF delivery](https://data.unicef.org/topic/maternal-health/delivery-care/), [UNICEF immunization](https://data.unicef.org/topic/child-health/immunization/) |
| `prev_pot` | 0.50 | 0.75 | 0.90 | Hazard prevalence among households in screened red districts. The range assumes sentinel screening can target somewhat better than a broad district average. | Pure Earth and hotspot screening logic; synthesis assumption requiring local validation. |
| `prev_kohl_maternal` | 0.40 | 0.70 | 0.85 | Maternal kohl prevalence in higher-use settings selected for intervention. The higher mode reflects that this is a conditional prevalence in screened hotspots rather than a national average. | Survey, ethnographic, and clinical synthesis of traditional eye cosmetic use; see kohl citations below. The parameter is partly endogenous to programme management because stricter hotspot screening and higher intervention thresholds will raise prevalence among those targeted. |
| `prev_kohl_infant` | 0.40 | 0.70 | 0.85 | Infant kohl prevalence among infants in high-use settings. The main model allows exposure among boys as well as girls; a separate robustness check restricts infant kohl substitution to girls only. | Survey and ethnographic synthesis; see kohl citations below. The higher mode reflects settings where infant kohl use is common across both sexes and where screening is intended to select strongly affected areas rather than marginal districts. |
| `prev_utensils` | 0.40 | 0.60 | 0.80 | Unsafe utensil prevalence in targeted hotspots. | Program-design assumption informed by lead-glazed ceramic exposure literature and sentinel targeting logic. |
| `fidelity` | 0.30 | 0.60 | 0.80 | Generic delivery fidelity for clinic-distributed components: the probability that the health system actually places the intended product and counselling in the household's hands once the relevant contact occurs. | Essential medicines availability literature and implementation synthesis; broader LMIC availability reviews. [PubMed](https://pubmed.ncbi.nlm.nih.gov/37340382/) |
| `adherence` | 0.30 | 0.50 | 0.60 | Complete use or substitution rate after receipt for non-pot components. | Behavioral and implementation synthesis; program-design range. |
| `p_voucher_issued` | 0.40 | 0.70 | 0.90 | Probability eligible ANC attendee actually receives pot voucher. | Voucher-program implementation assumption informed by health subsidy distribution literature. |
| `p_merchant_stock` | 0.60 | 0.80 | 0.95 | Probability that the approved merchant has the safe pot physically in stock when the voucher holder presents. The higher values reflect active contracting with approved retailers rather than passive clinic stock alone. | Supply chain and medicines availability literature; implementation assumption. |
| `p_redeem` | 0.60 | 0.75 | 0.90 | Voucher redemption for a high-value durable household product. | Dupas et al. (2016) and related subsidy redemption evidence; values are higher than low-value preventive products because pots are useful durable goods. [PubMed](https://pubmed.ncbi.nlm.nih.gov/27563091/) |
| `p_use_targeted_after_redemption` | 0.75 | 0.90 | 0.98 | Conditional use after redemption should be high because redemption is effortful and self-targeting. | Anchored in the self-selection logic of voucher uptake rather than a direct product-specific pot trial; see Dupas et al. (2016). [PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC5003414/) |
| `residual_unsafe_use_harm` | 0.05 | 0.15 | 0.35 | Allows for continued unsafe pot use even after redemption. | Program-design assumption representing partial switching or stacking. |
| `fetal_transfer_coeff` | 0.70 | 0.80 | 0.95 | Fraction of maternal lead reduction during pregnancy that the model treats as translating into fetal lead reduction. This is a structural bridge parameter, not a directly estimated transfer coefficient for child cognition. | Anchored in the established placental transfer of lead and the broad maternal-cord blood lead relationship, with WHO (2024) providing the biological framing, Ettinger et al. (2009) showing that maternal pregnancy BLL can be reduced, and Al-Jawadi et al. (2009) serving only as one illustrative maternal-cord paired-sample study rather than as the sole quantitative anchor. [WHO](https://www.who.int/news-room/fact-sheets/detail/lead-poisoning-and-health), [Ettinger](https://pubmed.ncbi.nlm.nih.gov/19165383/), [Al-Jawadi et al.](https://doi.org/10.1186/1756-0500-2-47) |
| `lactational_transfer_coeff` | 0.10 | 0.20 | 0.35 | Fraction of maternal lead reduction that the model treats as reaching the breastfed infant during the milk-dominated early-infancy period. Applied only to persistent maternal product pathways, not to calcium. | Structural bridge parameter motivated by evidence that maternal blood lead predicts breast-milk lead and infant exposure after birth. Used conservatively because the literature supports the pathway qualitatively more strongly than it pins down a single transportable coefficient. |
| `share_prenatal_last4m` | 0.20 | 0.30 | 0.40 | Share of total cognition-relevant developmental harm attributed to the last four months in utero. | Structural timing parameter informed by prenatal lead and neurodevelopment evidence suggesting substantial prenatal sensitivity but not exclusive prenatal determination. See Schnaas et al. (2006), Kim et al. (2013), and Bellinger et al. (1987). |
| `share_year1` | 0.20 | 0.30 | 0.40 | Share of total cognition-relevant developmental harm attributed to the first year of life. | Structural timing parameter informed by infancy and early-childhood lead evidence. The residual share is assigned to ages 2 to 5 so that the three shares sum to one. See Jusko et al. (2008), Bellinger et al. (1987), and Lanphear et al. (2005). |

## D. Product-specific blood lead reduction parameters

| Variable | Min | Mode | Max | Rationale | Citation basis |
| --- | ---: | ---: | ---: | --- | --- |
| `bll_pot_child` | 2.0 | 5.0 | 8.0 | Intended as the postnatal child BLL reduction during active use among households that fully switch from hazardous cookware to the safe replacement for the target child. It explicitly excludes any prenatal child benefit from lower maternal lead, which is modeled separately through `fetal_transfer_coeff`. The mode is kept at `5` because the broader kitchen-source literature suggests that unsafe cookware can be an important exposure source in hotspot settings, but the range remains wide because the direct intervention literature is weaker for recycled-metal cookware than for lead-glazed pottery. | Two literatures inform this parameter. First, lead-glazed pottery and ceramic foodware in Mexico are strongly associated with elevated child BLLs, including large differences in the prevalence of BLLs above `5 ug/dL` between frequent users and non-users. Second, studies of artisanal aluminum cookware show that some mixed-scrap pots can leach large amounts of lead into food, establishing biological plausibility for sizeable reductions after replacement, even though clean before-after BLL intervention estimates remain sparse. Key anchors are Rojas-Lopez et al. (1994); Romieu et al. (1994); Pure Earth/INSP summaries on lead-glazed pottery; Weidenhamer et al. (2014, 2022); and Fellows et al. (2025). |
| `bll_pot_mother` | 1.5 | 3.0 | 5.0 | Maternal BLL reduction from safer cookware, smaller in the mode than the child effect because maternal intake is less concentrated on child-feeding pathways and because adult exposure is more diffuse. | Structural extension from cookware literature. The same source evidence that motivates the child cookware parameter implies maternal benefit when pregnant or nursing women also consume food prepared in the unsafe pot, but the adult effect is likely smaller on average than the child effect because the child pathway is more concentrated and includes toddler feeding. The mode is therefore lower than `bll_pot_child`, while the range remains wide. |
| `bll_mug_child` | 1.0 | 3.0 | 5.0 | Child BLL reduction from replacing contaminated child utensils or feeding vessels during active use. | Lead-glazed food-contact studies support the pathway, but the exact effect remains an informed extrapolation. Romieu et al. (1994) linked ceramic ware use to elevated child BLLs in Mexico, and related ceramic exposure reports show that food-contact ceramics can contribute materially to ingestion. The mode is lower than the pot mode because utensils affect a narrower portion of food preparation and feeding, even though once caregivers obtain an attractive safe cup or spoon, routine use may be high. The main uncertainty is therefore the size of the exposure pathway and whether unsafe items continue to be used alongside the safer replacement. |
| `bll_calc_mother` | 0.2 | 0.4 | 1.2 | Maternal BLL reduction from calcium during pregnancy. | Ettinger et al. (2009) is the strongest causal anchor in the model: a randomized trial showing lower maternal BLL with calcium supplementation in pregnancy. The full-sample average reduction was about `0.4 ug/dL`, so that value is now the mode. The upper tail allows for larger effects among more compliant women and among women with higher bone-lead burden, while the lower tail allows for weaker population effects in lower-exposure or lower-adherence settings. [PubMed](https://pubmed.ncbi.nlm.nih.gov/19165383/) |
| `bll_maternal_kohl_mother` | 1.0 | 2.5 | 4.0 | Maternal BLL reduction from switching to lead-free kohl. The widened range reflects that most underlying studies compare users and non-users rather than directly estimating maternal change after replacement. | Kohl exposure studies and review literature imply a moderate maternal effect but leave wide uncertainty around the causal change from substitution. The mode is lower than the child kohl mode because adult use is often less frequent or less ingestive than infant hand-to-mouth exposure, but it is high enough to reflect studies linking maternal traditional eye-cosmetic use to elevated maternal and cord blood lead. Practical adherence is culturally contingent: some households may welcome a visibly safer substitute, while others may continue to trust traditional galena-based kohl. See Sadeq et al. (2021); Janjua et al. (2008); Hore et al. (2024); and related traditional cosmetic exposure studies. |
| `bll_infant_kohl_child` | 2.0 | 5.0 | 8.0 | Child BLL reduction from replacing leaded infant kohl with a safe alternative during active use. | The literature here is more direct than for most other product-specific pathways. Sadeq et al. (2021) report a pooled mean difference in blood lead of about `5.8 ug/dL` between kohl users and non-users, while user-non-user studies and case series after cessation also suggest that leaded kohl can contribute several `ug/dL` to child BLL in exposed infants and young children. The mode of `5` is therefore retained. At the same time, realized benefit depends heavily on culture and household authority: mothers may want a safer substitute, while some grandmothers or older caregivers may consider traditional galena kohl especially protective or authentic. That cultural uncertainty belongs more in the adherence parameter than in the biological mode, so the BLL mode is kept while the implementation chain absorbs uncertainty about switching. Sadeq et al. (2021); Nir et al. (1992); Keosaian et al. (2019); CDC/NMDOH (2013); Hore et al. (2024). [Meta-analysis](https://www.one-health.panafrican-med-journal.com/content/article/4/17/full), [Keosaian](https://journals.sagepub.com/doi/abs/10.1177/2164956119870988), [CDC/NMDOH](https://www.cdc.gov/mmwr/preview/mmwrhtml/mm6246a3.htm), [Hore et al.](https://pubmed.ncbi.nlm.nih.gov/39352031/) |

## E. Costs and overhead

| Variable | Min | Mode | Max | Rationale | Citation basis |
| --- | ---: | ---: | ---: | --- | --- |
| `cost_pot_direct` | 8.0 | 12.0 | 15.0 | Direct cost of safe pot before logistics and overhead. | Program-budget assumption informed by procurement and retail comparators; requires local validation before implementation. |
| `cost_utensils_direct` | 1.0 | 1.5 | 2.5 | Direct cost of utensils or cup-spoon substitute. | Program-budget assumption informed by low-cost commodity procurement comparators. |
| `cost_calcium_direct` | 1.25 | 1.75 | 3.0 | Direct cost of calcium course. | WHO calcium guideline context and UNICEF supply-style commodity pricing. [WHO](https://www.who.int/publications/i/item/9789241505376) |
| `cost_kohl_maternal_direct` | 0.4 | 0.75 | 1.25 | Direct cost of safe maternal kohl substitute. | Program-budget assumption informed by low-cost cosmetic substitution framing; local market validation needed. |
| `cost_kohl_infant_direct` | 1.2 | 1.5 | 3.0 | Direct cost of infant kohl substitute. | Program-budget assumption; local procurement validation needed. |
| `cost_explain` | 0.3 | 0.35 | 0.5 | Counseling and explanation cost per relevant contact. | Health worker time-cost assumption informed by WHO costing conventions and low-wage program delivery settings. |
| `cost_bulk_distribution_margin` | 3.0 | 4.0 | 5.0 | Bulk distribution cost plus retailer margin for pot voucher redemption. The previous bulk distribution line is increased by approximately `2` to include merchant compensation explicitly. | Program-logistics and retailer-margin assumption. |
| `cost_dist_light` | 0.25 | 0.5 | 1.0 | Distribution cost for smaller goods. | Program-logistics assumption. |
| `logistics_markup` | 0.3 | 0.6 | 1.0 | Program markup applied to direct product plus distribution costs. Because retailer margin is now included in the bulk pot distribution line, this parameter covers wastage, supply-chain overhead, shrinkage, supervision, and health-system administration. | Program-budget assumption informed by public-health supply-chain and administration experience. |
| `district_fixed_cost` | 20000 | 50000 | 100000 | Fully loaded national and district-level sentinel screening and program setup cost. | Program-design assumption informed by X-ray fluorescence (XRF) procurement, supervision, training, coordination, and district operations needs. |
| `district_births` | 4000 | 20000 | 50000 | Effective annual births per screening unit used to spread fixed programme overhead and setup cost. The mode assumes a shared-service model in which XRF assets and specialized supervision are used across multiple smaller districts or catchments. | Administrative and fertility-design assumption anchored in DHS birth rates, district heterogeneity, and capital-efficiency logic. |

## F. Maternal, neonatal, and cardiovascular valuation parameters

| Variable | Min | Mode | Max | Rationale | Citation basis |
| --- | ---: | ---: | ---: | --- | --- |
| `preeclampsia_base_prev` | 0.02 | 0.04 | 0.06 | Plausible baseline prevalence range in LMIC settings. | WHO maternal health guidance and obstetric epidemiology context; range chosen for policy modeling. |
| `preeclampsia_or` | 1.016 | 1.018 | 1.020 | Approximate increase in preeclampsia odds per `1 ug/dL` increase in blood lead. | Poropat et al. (2018) report a meta-analytic increase of about `1.6%` in preeclampsia odds per `1 ug/dL` increase in blood lead, with nearby values supporting the range used here. [PubMed](https://pubmed.ncbi.nlm.nih.gov/28938191/) |
| `preterm_base_prev` | 0.08 | 0.12 | 0.15 | Baseline preterm prevalence. | WHO estimates 4% to 16% across countries. [WHO](https://www.who.int/news-room/fact-sheets/detail/preterm-birth) |
| `preterm_or` | 1.02 | 1.025 | 1.03 | Linearized approximation to the increase in preterm risk associated with higher maternal lead exposure. | Habibian et al. (2022) support a positive association between maternal lead exposure and preterm birth, but the meta-analysis is strongest as a highest-versus-lowest exposure synthesis rather than as a clean published per-`1 ug/dL` slope. The range here is therefore a modeling calibration consistent with that evidence and the broader prenatal lead literature, including Vigeh et al. on adverse birth outcomes, not a directly reported coefficient. [PubMed](https://pubmed.ncbi.nlm.nih.gov/34210236/) |
| `preeclampsia_timing_mult` | 0.50 | 0.75 | 1.00 | Share of the full maternal BLL reduction treated as relevant to preeclampsia risk when the intervention begins around mid-pregnancy. | Structural timing parameter. Clinical disease onset after 20 weeks suggests later pregnancy matters more than a simple share of total pregnancy, but timing-specific lead estimates are limited; the wide range reflects that uncertainty. |
| `preterm_timing_mult` | 0.40 | 0.70 | 1.00 | Share of the full maternal BLL reduction treated as relevant to preterm birth risk when the intervention begins around mid-pregnancy. | Structural timing parameter. The prenatal lead and preterm literature supports an in-pregnancy effect, but trimester-specific timing is less settled than for preeclampsia; the wide range reflects that uncertainty. |
| `neonatal_daly_mult` | 0.5 | 0.75 | 1.0 | Disability-adjusted life years (DALYs) per preterm case averted in reduced-form valuation. | Reduced-form policy parameter, not a direct single-study estimate. |
| `cvd_daly_per_ug_lifetime` | 0.002 | 0.0033 | 0.005 | Lifetime adult cardiovascular disease DALYs per `1 ug/dL` sustained reduction. In the model this lifetime-oriented parameter is scaled by intervention duration as a share of adult lifetime, because the Sentinel interventions last only months or years rather than the full life course. | Anchored in the single global health-impact and economic-modeling study of Larsen and Sanchez-Triana (2023); used here as a scenario parameter rather than as a direct estimate for short-run interventions. |
| `vsly_mult` | 1.0 | 1.6 | 3.0 | Value of a statistical life year (VSLY) relative to annual productivity. | Robinson, Hammitt, and O'Keeffe (2019). [PubMed](https://pubmed.ncbi.nlm.nih.gov/32968616/) |
| `preeclampsia_daly_wt` | 0.001 | 0.003 | 0.005 | Disability-adjusted life years (DALYs) per preeclampsia case in reduced-form approximation. | Reduced-form valuation parameter. |
| `years_pot` | 2 | 4 | 5 | Duration of pot protection. | Program-duration assumption with widened uncertainty about replacement persistence. |
| `years_kohl_maternal` | 0.5 | 1 | 2 | Duration of maternal kohl protection. | Program-duration assumption with widened uncertainty about continued use of the substitute. |
| `years_kohl_infant` | 0.5 | 1 | 2 | Duration of infant kohl protection. | Program-duration assumption with widened uncertainty about how long substitute use persists. |
| `years_utensils` | 1 | 2 | 3 | Duration of child utensil protection. | Program-duration assumption with widened uncertainty. |
| `years_calcium` | 0.25 | 0.5 | 1 | Duration of calcium effect during pregnancy. | Program-duration assumption widened to better reflect a finite pregnancy course. |
| `adult_reference_years` | 65 | 65 | 65 | Reference age for discounting adult cardiovascular gains. | Structural modeling assumption. |
| `gp_pot_effect_multiplier` | 0.5 | 0.5 | 0.5 | Grandparent receives half the pot effect. | Structural modeling assumption. |

## Selected references

Briggs, Andrew, Karl Claxton, and Mark Sculpher. *Decision Modelling for Health Economic Evaluation*. Oxford: Oxford University Press, 2006.

Boardman, Anthony E., David H. Greenberg, Aidan R. Vining, and David L. Weimer. *Cost-Benefit Analysis: Concepts and Practice*. 5th ed. Cambridge: Cambridge University Press, 2018.

Bellinger, David, Alan Leviton, John Waternaux, Herbert Needleman, and C. Rabinowitz. "Longitudinal analyses of prenatal and postnatal lead exposure and early cognitive development." *New England Journal of Medicine* 316, no. 17 (1987): 1037-1043.

Canfield, Richard L., Charles R. Henderson Jr., Deborah A. Cory-Slechta, Christopher Cox, Todd A. Jusko, and Bruce P. Lanphear. "Intellectual Impairment in Children with Blood Lead Concentrations below 10 microg per Deciliter." *New England Journal of Medicine* 348, no. 16 (2003): 1517-1526. [PubMed](https://pubmed.ncbi.nlm.nih.gov/12700371/)

Crawfurd, Lee, Rory Todd, Susannah Hares, Justin Sandefur, and coauthors. "The Effect of Lead Exposure on Children's Learning in the Developing World." *World Bank Research Observer* 40, no. 2 (2025): 229-263. [Oxford Academic](https://academic.oup.com/wbro/article/40/2/229/7734093)

Dupas, Pascaline, Vivian Hoffmann, Michael Kremer, and Alix Peterson Zwane. "Targeting health subsidies through a nonprice mechanism: A randomized controlled trial in Kenya." *Science* 353, no. 6302 (2016): 889-895. [PubMed](https://pubmed.ncbi.nlm.nih.gov/27563091/)

Ettinger, Adrienne S., Hector Lamadrid-Figueroa, Martha M. Tellez-Rojo, Adriana Mercado-Garcia, Karen E. Peterson, Joel Schwartz, Howard Hu, and Mauricio Hernandez-Avila. "Effect of calcium supplementation on blood lead levels in pregnancy: a randomized placebo-controlled trial." *Environmental Health Perspectives* 117, no. 1 (2009): 26-31. [PubMed](https://pubmed.ncbi.nlm.nih.gov/19165383/)

Ericson, Bret, and Mary Jean Brown. "Lead-Attributable Productivity Losses in Low- and Middle-Income Countries." *Health Economics, Policy and Law* (2025). [PubMed](https://pubmed.ncbi.nlm.nih.gov/40605844/)

Fellows, Katie M., Shar Samy, and Stephen G. Whittaker. "Evaluating metal cookware as a source of lead exposure." *Journal of Exposure Science & Environmental Epidemiology* 35, no. 3 (2025): 342-350. [PubMed](https://pubmed.ncbi.nlm.nih.gov/38773235/)

Grosse, Scott D., and Ying Zhou. "Monetary Valuation of Children's Cognitive Outcomes in Economic Evaluations from a Societal Perspective: A Review." *International Journal of Environmental Research and Public Health* 18, no. 11 (2021): 5830.

Grosse, Scott D., Thomas D. Matte, Joel Schwartz, and Richard J. Jackson. "Economic Gains Resulting from the Reduction in Children's Exposure to Lead in the United States." *Environmental Health Perspectives* 110, no. 6 (2002): 563-569. [EPA HERO](https://hero.epa.gov/reference/25727/)

Gollin, Douglas. "Getting Income Shares Right." *Journal of Political Economy* 110, no. 2 (2002): 458-474. doi:10.1086/338747.

Hanushek, Eric A., and Ludger Woessmann. "The Role of Cognitive Skills in Economic Development." *Journal of Economic Literature* 46, no. 3 (2008): 607-668.

Hore, Paromita, Slavenka Sedlar, Jacqueline Ehrlich, and coauthors. "Traditional Eye Cosmetics and Cultural Powders as a Source of Lead Exposure." *Pediatrics* 154, Supplement 2 (2024). [PubMed](https://pubmed.ncbi.nlm.nih.gov/39352031/)

International Labour Organization. *World Employment and Social Outlook: Trends 2025*. Geneva: International Labour Organization, 2025. doi:10.54394/IZLN1673.

International Monetary Fund. *World Economic Outlook Database*. April 2026 edition. Washington DC: International Monetary Fund, 2026.

Jusko, Todd A., Charles R. Henderson Jr., Bruce P. Lanphear, Deborah A. Cory-Slechta, Patrick J. Parsons, and Richard L. Canfield. "Blood lead concentrations < 10 microg/dL and child intelligence at 6 years of age." *Environmental Health Perspectives* 116, no. 2 (2008): 243-248. [PubMed](https://pubmed.ncbi.nlm.nih.gov/18288325/)

Kim, Yeni, Eun-Hee Ha, Hyesook Park, Mina Ha, Yangho Kim, Yun-Chul Hong, Eui-Jung Kim, and Bung-Nyun Kim. "Prenatal lead and cadmium co-exposure and infant neurodevelopment at 6 months of age: the Mothers and Children's Environmental Health study." *Neurotoxicology* 35 (2013): 15-22. [PubMed](https://pubmed.ncbi.nlm.nih.gov/23220728/)

Keosaian, Julia, Thuppil Venkatesh, Salvatore D'Amico, Paula Gardiner, and Robert Saper. "Blood Lead Levels of Children Using Traditional Indian Medicine and Cosmetics: A Feasibility Study." *Global Advances in Health and Medicine* 8 (2019). [SAGE](https://journals.sagepub.com/doi/abs/10.1177/2164956119870988)

Janjua, Nadeem Zia, Shehla Nizamy, John R. Burns, and coauthors. "Health effects of kohl use in pregnancy and maternal and cord blood lead levels." *International Journal of Occupational and Environmental Health* 14, no. 4 (2008): 268-276.

Lanphear, Bruce P., Richard Hornung, Jane Khoury, Kimberly Yolton, Peter Baghurst, David C. Bellinger, Richard L. Canfield, et al. "Low-level environmental lead exposure and children's intellectual function: an international pooled analysis." *Environmental Health Perspectives* 113, no. 7 (2005): 894-899. [PubMed](https://pubmed.ncbi.nlm.nih.gov/16002379/)

Larsen, Bjorn, and Ernesto Sanchez-Triana. "Global health burden and cost of lead exposure in children and adults: a health impact and economic modelling analysis." *Lancet Planetary Health* 7, no. 10 (2023): e831-e840.

Ozawa, Sachiko, Sarah K. Laing, Colleen R. Higgins, Tatenda T. Yemeke, Christine C. Park, Rebecca Carlson, Young Eun Ko, L. Beryl Guterman, and Saad B. Omer. "Educational and economic returns to cognitive ability in low- and middle-income countries: A systematic review." *World Development* 149 (2022): 105668. [PubMed](https://pubmed.ncbi.nlm.nih.gov/34980939/)

Poropat, Arthur E., Mark A. S. Laidlaw, Bruce Lanphear, Andrew Ball, and Howard W. Mielke. "Blood lead and preeclampsia: A meta-analysis and review of implications." *Environmental Research* 160 (2018): 12-19. [PubMed](https://pubmed.ncbi.nlm.nih.gov/28938191/)

Robinson, Lisa A., James K. Hammitt, and Lucy O'Keeffe. "Valuing Mortality Risk Reductions in Global Benefit-Cost Analysis." *Journal of Benefit-Cost Analysis* 10, Supplement 1 (2019): 15-50. [PubMed](https://pubmed.ncbi.nlm.nih.gov/32968616/)

Sadeq, Mina, Touria Benamar, and Antonio Facciorusso. "Is the application of Kohl to eyes associated with increased blood lead levels in children? A meta-analysis." *PAMJ-One Health* 4 (2021): 17. [Full text](https://www.one-health.panafrican-med-journal.com/content/article/4/17/full)

Schnaas, Lourdes, Hector Lamadrid-Figueroa, Martha M. Tellez-Rojo, Sandra Hernandez-Avila, Adriana Mercado-Garcia, Howard Hu, and Mauricio Hernandez-Avila. "Reduced intellectual development in children with prenatal lead exposure." *Environmental Health Perspectives* 114, no. 5 (2006): 791-797. [PubMed](https://pubmed.ncbi.nlm.nih.gov/16675422/)

Rojas-Lopez, M., C. Santos-Burgoa, C. Rios, M. Hernandez-Avila, and I. Romieu. "Use of lead-glazed ceramics is the main factor associated to high lead in blood levels in two Mexican rural communities." *Journal of Toxicology and Environmental Health* 42, no. 1 (1994): 45-52. [PubMed](https://pubmed.ncbi.nlm.nih.gov/8169996/)

Nir, A., A. Tamir, N. Zelnik, and T. C. Iancu. "Is eye cosmetic a source of lead poisoning?" *Israel Journal of Medical Sciences* 28, no. 7 (1992): 417-421. [PubMed](https://pubmed.ncbi.nlm.nih.gov/1506164/)

Centers for Disease Control and Prevention. "Childhood lead exposure associated with the use of kajal, an eye cosmetic from Afghanistan - Albuquerque, New Mexico, 2013." *MMWR Morbidity and Mortality Weekly Report* 62, no. 46 (2013). [CDC](https://www.cdc.gov/mmwr/preview/mmwrhtml/mm6246a3.htm)

UNICEF. "Antenatal care." UNICEF Data, updated November 1, 2024. [UNICEF](https://data.unicef.org/topic/maternal-health/antenatal-care/)

UNICEF. "Vaccination and Immunization Statistics." UNICEF Data, accessed April 2026. [UNICEF](https://data.unicef.org/topic/child-health/immunization/)

Al-Jawadi, Asma A., Zina W. A. Al-Mola, and Raghad A. Al-Jomard. "Determinants of maternal and umbilical blood lead levels: a cross-sectional study, Mosul, Iraq." *BMC Research Notes* 2 (2009): 47. [DOI](https://doi.org/10.1186/1756-0500-2-47)

Habibian, Ahmad, Morteza Abyadeh, Mostafa Abyareh, Nader Rahimi Kakavandi, Atefeh Habibian, Maliheh Khakpash, and Mahmoud Ghazi-Khansari. "Association of maternal lead exposure with the risk of preterm: a meta-analysis." *Journal of Maternal-Fetal and Neonatal Medicine* 35, no. 25 (2022): 7222-7230. [PubMed](https://pubmed.ncbi.nlm.nih.gov/34210236/)

WHO. "Lead poisoning and health." World Health Organization fact sheet, September 27, 2024. [WHO](https://www.who.int/news-room/fact-sheets/detail/lead-poisoning-and-health)

WHO. "Preterm birth." World Health Organization fact sheet, May 10, 2023. [WHO](https://www.who.int/news-room/fact-sheets/detail/preterm-birth)

World Bank. "GDP per capita, PPP (current international $)." World Development Indicators, accessed April 2026. [World Bank](https://data.worldbank.org/indicator/NY.GDP.PCAP.PP.CD?locations=XN)

World Bank. *The Changing Wealth of Nations 2021: Managing Assets for the Future*. Washington DC: World Bank, 2021.

World Bank. "World Bank Country and Lending Groups, FY2026." Data Help Desk, accessed April 2026. [World Bank](https://datahelpdesk.worldbank.org/knowledgebase/articles/906519-world-bank-country-and-lending-groups)

World Bank. "Survival to age 65 (% of cohort)." Gender Data Portal / World Development Indicators, accessed April 2026. [World Bank](https://genderdata.worldbank.org/en/indicator/sp-dyn-to65-zs)

Weidenhamer, Jeffrey D., David C. Bansal, and coauthors. "Lead exposure from aluminum cookware in Cameroon." *Science of the Total Environment* 496 (2014): 339-347.

Weidenhamer, Jeffrey D., M. Chasant, and P. Gottesfeld. "Metal exposures from source materials for artisanal aluminum cookware." *International Journal of Environmental Health Research* 33, no. 4 (2023): 374-385. [DOI](https://doi.org/10.1080/09603123.2022.2029112)

Romieu, Isabelle, and coauthors. "Lead exposure in Mexican children: the effect of ceramic ware." *Journal of Pediatrics* 125, no. 1 (1994): 111-117.
