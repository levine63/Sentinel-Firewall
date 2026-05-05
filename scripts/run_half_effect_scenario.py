from __future__ import annotations

import importlib.util
from pathlib import Path

import pandas as pd


ROOT = Path(r"C:\Users\levine\Dropbox\PC (2)\Documents\Codex\Sentinel-Firewall")
MODEL_PATH = ROOT / "submission_package" / "public_code_and_data" / "sentinel_firewall_model.py"
OUTPUT_DIR = ROOT / "outputs" / "half_effect_scenario_20260505"

SCENARIO_PARAMS = [
    "bll_pot_child",
    "bll_pot_mother",
    "bll_mug_child",
    "bll_maternal_kohl_mother",
    "bll_infant_kohl_child",
]
SCALE = 0.5


def load_model():
    spec = importlib.util.spec_from_file_location("sentinel_firewall_model", MODEL_PATH)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


def summarize_case(model, name, df):
    cog = model.summarize_results(df, "bcr_cog")
    total = model.summarize_results(df, "bcr_total")
    return {
        "package_case": name,
        "bcr_cog_median": cog["median"],
        "bcr_cog_p5": cog["p5"],
        "bcr_cog_p95": cog["p95"],
        "bcr_cog_fail_pct": cog["fail_pct"],
        "bcr_total_median": total["median"],
        "bcr_total_p5": total["p5"],
        "bcr_total_p95": total["p95"],
        "bcr_total_fail_pct": total["fail_pct"],
    }


def scale_param_block(param_table: pd.DataFrame, names: list[str], scale: float) -> pd.DataFrame:
    updated = param_table.copy(deep=True)
    for name in names:
        for col in ["min", "mode", "max"]:
            updated.loc[name, col] = float(updated.loc[name, col]) * scale
    return updated


def main():
    model = load_model()
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    baseline_rows = []
    kitchen_base = model.simulate_kitchen(model.draw_params(seed=model.RNG_SEED))
    kohl_base = model.simulate_kohl(model.draw_params(seed=model.RNG_SEED + 2))
    baseline_rows.append(summarize_case(model, "Kitchen Baseline", kitchen_base))
    baseline_rows.append(summarize_case(model, "Kohl Baseline", kohl_base))

    original_params = model.PARAMS.copy(deep=True)
    scenario_params = scale_param_block(model.PARAMS, SCENARIO_PARAMS, SCALE)
    model.PARAMS = scenario_params

    scenario_rows = []
    kitchen_half = model.simulate_kitchen(model.draw_params(seed=model.RNG_SEED))
    kohl_half = model.simulate_kohl(model.draw_params(seed=model.RNG_SEED + 2))
    scenario_rows.append(summarize_case(model, "Kitchen Half Pot-Utensil Effect", kitchen_half))
    scenario_rows.append(summarize_case(model, "Kohl Half Kohl Effect", kohl_half))

    model.PARAMS = original_params

    baseline = pd.DataFrame(baseline_rows).set_index("package_case")
    scenario = pd.DataFrame(scenario_rows).set_index("package_case")

    comparison = pd.DataFrame(
        [
            {
                "package": "Kitchen",
                "baseline_bcr_cog_median": baseline.loc["Kitchen Baseline", "bcr_cog_median"],
                "scenario_bcr_cog_median": scenario.loc["Kitchen Half Pot-Utensil Effect", "bcr_cog_median"],
                "pct_change_bcr_cog_median": (
                    scenario.loc["Kitchen Half Pot-Utensil Effect", "bcr_cog_median"]
                    / baseline.loc["Kitchen Baseline", "bcr_cog_median"]
                    - 1
                )
                * 100,
                "baseline_bcr_total_median": baseline.loc["Kitchen Baseline", "bcr_total_median"],
                "scenario_bcr_total_median": scenario.loc["Kitchen Half Pot-Utensil Effect", "bcr_total_median"],
                "pct_change_bcr_total_median": (
                    scenario.loc["Kitchen Half Pot-Utensil Effect", "bcr_total_median"]
                    / baseline.loc["Kitchen Baseline", "bcr_total_median"]
                    - 1
                )
                * 100,
                "baseline_fail_pct_total": baseline.loc["Kitchen Baseline", "bcr_total_fail_pct"],
                "scenario_fail_pct_total": scenario.loc["Kitchen Half Pot-Utensil Effect", "bcr_total_fail_pct"],
            },
            {
                "package": "Kohl",
                "baseline_bcr_cog_median": baseline.loc["Kohl Baseline", "bcr_cog_median"],
                "scenario_bcr_cog_median": scenario.loc["Kohl Half Kohl Effect", "bcr_cog_median"],
                "pct_change_bcr_cog_median": (
                    scenario.loc["Kohl Half Kohl Effect", "bcr_cog_median"]
                    / baseline.loc["Kohl Baseline", "bcr_cog_median"]
                    - 1
                )
                * 100,
                "baseline_bcr_total_median": baseline.loc["Kohl Baseline", "bcr_total_median"],
                "scenario_bcr_total_median": scenario.loc["Kohl Half Kohl Effect", "bcr_total_median"],
                "pct_change_bcr_total_median": (
                    scenario.loc["Kohl Half Kohl Effect", "bcr_total_median"]
                    / baseline.loc["Kohl Baseline", "bcr_total_median"]
                    - 1
                )
                * 100,
                "baseline_fail_pct_total": baseline.loc["Kohl Baseline", "bcr_total_fail_pct"],
                "scenario_fail_pct_total": scenario.loc["Kohl Half Kohl Effect", "bcr_total_fail_pct"],
            },
        ]
    )

    scenario_inputs = scenario_params.loc[SCENARIO_PARAMS, ["min", "mode", "max"]].copy()
    scenario_inputs.insert(0, "scaled_by", SCALE)
    baseline_inputs = original_params.loc[SCENARIO_PARAMS, ["min", "mode", "max"]].copy()
    baseline_inputs.columns = [f"baseline_{c}" for c in baseline_inputs.columns]
    scenario_inputs.columns = ["scaled_by", "scenario_min", "scenario_mode", "scenario_max"]
    parameter_compare = baseline_inputs.join(scenario_inputs)

    pd.DataFrame(baseline_rows + scenario_rows).to_csv(OUTPUT_DIR / "summary_table_with_half_effect_scenario.csv", index=False)
    comparison.to_csv(OUTPUT_DIR / "half_effect_scenario_comparison.csv", index=False)
    parameter_compare.to_csv(OUTPUT_DIR / "half_effect_scenario_parameters.csv")

    print("Saved:")
    print(OUTPUT_DIR / "summary_table_with_half_effect_scenario.csv")
    print(OUTPUT_DIR / "half_effect_scenario_comparison.csv")
    print(OUTPUT_DIR / "half_effect_scenario_parameters.csv")
    print()
    print(pd.DataFrame(baseline_rows + scenario_rows).to_string(index=False))
    print()
    print(comparison.to_string(index=False))


if __name__ == "__main__":
    main()
